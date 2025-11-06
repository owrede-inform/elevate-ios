#!/usr/bin/env python3
"""
ELEVATE Design Token Extraction Script v3.2
===========================================

Extracts design tokens from ELEVATE SCSS files with PROPER TOKEN REFERENCES
and LIGHT/DARK MODE support.

Key improvements over v3.1:
- Generates native SwiftUI Color.adaptive() instances instead of DynamicColor
- Uses UIColor dynamic providers for automatic light/dark adaptation
- No manual @Environment(\.colorScheme) resolution needed in components
- Maintains proper three-tier hierarchy with explicit Swift references

Previous improvements:
- Extracts token REFERENCES, not resolved RGB values
- Supports BOTH light and dark color schemes
- Maintains proper three-tier hierarchy with explicit Swift references
- Auto-fixes empty subcategories (v3.1)

Usage:
    python3 scripts/update-design-tokens-v3.py
"""

import re
import os
import sys
from dataclasses import dataclass
from typing import Optional, Dict, Tuple
from pathlib import Path

# ELEVATE design tokens source path
# Can be overridden with ELEVATE_TOKENS_PATH environment variable
ELEVATE_TOKENS_PATH = Path(
    os.environ.get(
        "ELEVATE_TOKENS_PATH",
        "/Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main/src/scss"
    )
)
LIGHT_MODE_FILE = ELEVATE_TOKENS_PATH / "values" / "_light.scss"
DARK_MODE_FILE = ELEVATE_TOKENS_PATH / "values" / "_dark.scss"

# Output paths - relative to script location
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
OUTPUT_BASE = PROJECT_ROOT / "ElevateUI" / "Sources" / "DesignTokens"


@dataclass
class TokenReference:
    """Represents a token with its reference and fallback"""
    name: str
    reference: Optional[str]  # The token it references (e.g., "elvt-primitives-color-blue-600")
    fallback_rgb: Tuple[float, float, float, float]  # Fallback RGB values


class SCSSReferenceParser:
    """Parses SCSS files to extract token references"""

    def __init__(self, scss_file_path: Path):
        self.scss_path = scss_file_path
        with open(scss_file_path, 'r') as f:
            self.content = f.read()

    def parse_token_line(self, line: str) -> Optional[TokenReference]:
        """
        Parse a single SCSS token line

        Examples:
          $elvt-primitives-color-blue-600: rgb(11 92 223);
          $elvt-alias-action-strong-primary-fill-default: var(--elvt-primitives-color-blue-600, rgb(11 92 223));
        """
        # Match pattern: $name: var(--reference, rgb(...)) or $name: rgb(...)
        var_pattern = r'\$([a-zA-Z0-9_-]+):\s*var\(--([a-zA-Z0-9_-]+),\s*rgb\(([0-9\s.]+)\)\);'
        direct_pattern = r'\$([a-zA-Z0-9_-]+):\s*rgb\(([0-9\s.]+)\);'

        # Try var() pattern first (has reference)
        var_match = re.match(var_pattern, line)
        if var_match:
            name = var_match.group(1)
            reference = var_match.group(2)
            rgb_str = var_match.group(3)
            rgb = self._parse_rgb(rgb_str)
            return TokenReference(name=name, reference=reference, fallback_rgb=rgb)

        # Try direct RGB pattern (no reference - primitive)
        direct_match = re.match(direct_pattern, line)
        if direct_match:
            name = direct_match.group(1)
            rgb_str = direct_match.group(2)
            rgb = self._parse_rgb(rgb_str)
            return TokenReference(name=name, reference=None, fallback_rgb=rgb)

        return None

    def _parse_rgb(self, rgb_str: str) -> Tuple[float, float, float, float]:
        """Parse RGB string to normalized values (0.0-1.0)"""
        parts = rgb_str.strip().split()
        if len(parts) == 3:
            r, g, b = map(float, parts)
            return (r / 255.0, g / 255.0, b / 255.0, 1.0)
        elif len(parts) == 4:
            r, g, b, a = map(float, parts)
            return (r / 255.0, g / 255.0, b / 255.0, a)
        return (0, 0, 0, 1)

    def extract_all_tokens(self) -> Dict[str, TokenReference]:
        """Extract all tokens from the SCSS file"""
        tokens = {}
        for line in self.content.split('\n'):
            token = self.parse_token_line(line.strip())
            if token:
                tokens[token.name] = token
        return tokens


class SwiftTokenMapper:
    """Maps SCSS token names to Swift token paths"""

    @staticmethod
    def scss_to_swift_path(scss_name: str) -> str:
        """
        Convert SCSS token name to Swift property path

        Examples:
          elvt-primitives-color-blue-600 → ElevatePrimitives.Blue._600
          elvt-alias-action-strong-primary-fill-default → ElevateAliases.Action.StrongPrimary.fill_default
        """
        parts = scss_name.replace('elvt-', '').split('-')

        # Primitives
        if parts[0] == 'primitives':
            if parts[1] == 'color':
                color_family = parts[2].capitalize()
                shade = parts[3] if len(parts) > 3 else 'color_' + parts[2]
                return f"ElevatePrimitives.{color_family}._{shade}"

        # Aliases
        if parts[0] == 'alias':
            # elvt-alias-action-strong-primary-fill-default
            # → ElevateAliases.Action.StrongPrimary.fill_default
            category = parts[1].capitalize()  # action → Action

            # Handle multi-part subcategories
            subcategory_parts = []
            property_parts = []
            found_property = False

            for i, part in enumerate(parts[2:], start=2):
                if part in ['fill', 'text', 'border', 'track', 'color']:
                    found_property = True

                if not found_property:
                    subcategory_parts.append(part.capitalize())
                else:
                    property_parts.append(part)

            subcategory = ''.join(subcategory_parts)

            # If subcategory is empty (e.g., feedback-text-danger),
            # default to 'General' for consistency with alias structure
            if not subcategory:
                subcategory = 'General'

            property_name = '_'.join(property_parts)

            return f"ElevateAliases.{category}.{subcategory}.{property_name}"

        # Components
        if parts[0] == 'component':
            # elvt-component-button-fill-primary-default
            # → ButtonTokens (handled separately in component generators)
            return f"Component_{parts[1]}"

        return scss_name

    @staticmethod
    def sanitize_swift_name(name: str) -> str:
        """Sanitize name for Swift"""
        name = name.replace('-', '_')
        swift_keywords = ['default', 'case', 'class', 'struct', 'enum', 'func', 'var', 'let']
        if name in swift_keywords:
            return f"`{name}`"
        return name


class DynamicColorGenerator:
    """Generates Swift code for DynamicColor instances"""

    def __init__(self, light_tokens: Dict[str, TokenReference], dark_tokens: Dict[str, TokenReference]):
        self.light_tokens = light_tokens
        self.dark_tokens = dark_tokens
        self.mapper = SwiftTokenMapper()

    def generate_dynamic_color(self, token_name: str) -> str:
        """
        Generate DynamicColor initialization code

        Returns Swift code like:
          DynamicColor(
              light: ElevatePrimitives.Blue._600,
              dark: ElevatePrimitives.Blue._500
          )
        """
        light_token = self.light_tokens.get(token_name)
        dark_token = self.dark_tokens.get(token_name)

        if not light_token or not dark_token:
            return "// ERROR: Token not found in both modes"

        # Get the Swift paths for the references
        light_ref = light_token.reference
        dark_ref = dark_token.reference

        if light_ref and dark_ref:
            light_path = self.mapper.scss_to_swift_path(light_ref)
            dark_path = self.mapper.scss_to_swift_path(dark_ref)

            return f"""Color.adaptive(
                light: {light_path},
                dark: {dark_path}
            )"""

        # Fallback to RGB if no references
        l_rgb = light_token.fallback_rgb
        d_rgb = dark_token.fallback_rgb

        return f"""Color.adaptive(
            lightRGB: (red: {l_rgb[0]:.4f}, green: {l_rgb[1]:.4f}, blue: {l_rgb[2]:.4f}, opacity: {l_rgb[3]:.4f}),
            darkRGB: (red: {d_rgb[0]:.4f}, green: {d_rgb[1]:.4f}, blue: {d_rgb[2]:.4f}, opacity: {d_rgb[3]:.4f})
        )"""


class AliasesGenerator:
    """Generates ElevateAliases.swift with proper token references"""

    def __init__(self, light_tokens: Dict[str, TokenReference], dark_tokens: Dict[str, TokenReference]):
        self.light_tokens = light_tokens
        self.dark_tokens = dark_tokens
        self.color_generator = DynamicColorGenerator(light_tokens, dark_tokens)
        self.mapper = SwiftTokenMapper()

    def generate(self) -> str:
        """Generate complete Aliases file"""
        aliases = self._get_alias_tokens()

        # Organize by category
        structure = self._organize_aliases(aliases)

        # Generate Swift code
        code = """#if os(iOS)
import SwiftUI

/// ELEVATE Design System Alias Tokens
///
/// Semantic tokens with light/dark mode support.
/// These reference primitive tokens and provide semantic meaning.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v3.py to update
@available(iOS 15, *)
public struct ElevateAliases {

    // MARK: - Alias Tokens
"""

        # Generate each category
        for category, subcategories in sorted(structure.items()):
            code += f"\n    // MARK: {category}\n\n"
            code += f"    public enum {category} {{\n"

            for subcategory, properties in sorted(subcategories.items()):
                code += f"\n        // MARK: {subcategory}\n\n"
                code += f"        public enum {subcategory} {{\n"

                for prop_name, token_name in sorted(properties.items()):
                    dynamic_color = self.color_generator.generate_dynamic_color(token_name)
                    dynamic_color_indented = '\n'.join('            ' + line for line in dynamic_color.split('\n'))
                    code += f"            public static let {prop_name} = {dynamic_color_indented.strip()}\n"

                code += "        }\n"

            code += "    }\n"

        code += "\n}\n#endif\n"
        return code

    def _get_alias_tokens(self) -> list:
        """Get list of alias tokens"""
        return [name for name in self.light_tokens.keys() if name.startswith('elvt-alias-')]

    def _organize_aliases(self, aliases: list) -> Dict:
        """
        Organize aliases into hierarchical structure

        elvt-alias-action-strong-primary-fill-default →
          Action → StrongPrimary → fill_default
        """
        structure = {}

        for token_name in aliases:
            parts = token_name.replace('elvt-alias-', '').split('-')

            if len(parts) < 3:
                continue  # Skip malformed tokens

            category = parts[0].capitalize()  # action → Action

            # Find where the property starts (fill, text, border, etc.)
            property_start_idx = None
            for i, part in enumerate(parts[1:], start=1):
                if part in ['fill', 'text', 'border', 'track', 'color', 'outline']:
                    property_start_idx = i
                    break

            if property_start_idx is None:
                continue  # Skip if no recognizable property

            # Build subcategory name
            subcategory_parts = [p.capitalize() for p in parts[1:property_start_idx]]
            subcategory = ''.join(subcategory_parts) if subcategory_parts else 'General'

            # Build property name
            property_parts = parts[property_start_idx:]
            property_name = '_'.join(property_parts)
            property_name = self.mapper.sanitize_swift_name(property_name)

            # Add to structure
            if category not in structure:
                structure[category] = {}
            if subcategory not in structure[category]:
                structure[category][subcategory] = {}

            structure[category][subcategory][property_name] = token_name

        return structure


class PrimitivesGenerator:
    """Generates ElevatePrimitives.swift with DynamicColor"""

    def __init__(self, light_tokens: Dict[str, TokenReference], dark_tokens: Dict[str, TokenReference]):
        self.light_tokens = light_tokens
        self.dark_tokens = dark_tokens
        self.color_generator = DynamicColorGenerator(light_tokens, dark_tokens)

    def generate(self) -> str:
        """Generate complete Primitives file"""
        primitives = self._get_primitive_tokens()

        # Organize by color family
        families = {}
        for token_name in primitives:
            parts = token_name.replace('elvt-primitives-color-', '').split('-')
            if len(parts) >= 1:
                family = parts[0].capitalize()
                if family not in families:
                    families[family] = []
                families[family].append(token_name)

        # Generate Swift code
        code = """#if os(iOS)
import SwiftUI

/// ELEVATE Design System Primitive Tokens
///
/// Base color palette with light/dark mode support.
/// These are raw color values that should not be used directly in components.
/// Use alias or component tokens instead.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v3.py to update
@available(iOS 15, *)
public struct ElevatePrimitives {

    // MARK: - Color Primitives
"""

        for family, tokens in sorted(families.items()):
            code += f"\n    // MARK: {family} Scale\n    \n"
            code += f"    public enum {family} {{\n"

            for token_name in sorted(tokens):
                # Extract shade (e.g., "600" from "blue-600", or "color-black" from "black")
                shade = token_name.replace('elvt-primitives-color-', '')
                if '-' in shade:
                    shade = shade.split('-', 1)[1]  # Get part after family name
                else:
                    shade = f"color_{shade}"  # black/white/transparent
                property_name = f"_{shade}"
                dynamic_color = self.color_generator.generate_dynamic_color(token_name)
                # Indent properly
                dynamic_color_indented = '\n'.join('        ' + line for line in dynamic_color.split('\n'))
                code += f"        public static let {property_name} = {dynamic_color_indented.strip()}\n"

            code += "    }\n"

        code += "\n}\n#endif\n"
        return code

    def _get_primitive_tokens(self) -> list:
        """Get list of primitive color tokens"""
        return [name for name in self.light_tokens.keys() if name.startswith('elvt-primitives-color-')]


class ComponentTokensGenerator:
    """Generates component-specific token files (Button, Badge, Chip)"""

    def __init__(self, light_tokens: Dict[str, TokenReference], dark_tokens: Dict[str, TokenReference], component_name: str):
        self.light_tokens = light_tokens
        self.dark_tokens = dark_tokens
        self.component_name = component_name.lower()
        self.color_generator = DynamicColorGenerator(light_tokens, dark_tokens)
        self.mapper = SwiftTokenMapper()

    def generate(self) -> str:
        """Generate component tokens file"""
        component_tokens = self._get_component_tokens()

        if not component_tokens:
            return ""

        # Organize tokens by structure
        organized = self._organize_tokens(component_tokens)

        # Generate Swift code
        class_name = f"{self.component_name.capitalize()}ComponentTokens"

        code = f"""#if os(iOS)
import SwiftUI

/// ELEVATE {self.component_name.capitalize()} Component Tokens
///
/// Complete token set extracted from ELEVATE design system.
/// These reference alias tokens which reference primitive tokens.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v3.py to update
@available(iOS 15, *)
public struct {class_name} {{

"""

        # Generate tokens organized by category
        for category, tokens in sorted(organized.items()):
            code += f"    // MARK: - {category}\n\n"

            for token_name, scss_name in sorted(tokens.items()):
                dynamic_color = self.color_generator.generate_dynamic_color(scss_name)
                dynamic_color_indented = '\n'.join('    ' + line for line in dynamic_color.split('\n'))
                code += f"    public static let {token_name} = {dynamic_color_indented.strip()}\n\n"

        code += "}\n#endif\n"
        return code

    def _get_component_tokens(self) -> list:
        """Get list of tokens for this component"""
        prefix = f'elvt-component-{self.component_name}-'
        return [name for name in self.light_tokens.keys() if name.startswith(prefix)]

    def _organize_tokens(self, tokens: list) -> Dict:
        """Organize tokens into categories"""
        structure = {}

        for token_name in tokens:
            # Remove component prefix
            suffix = token_name.replace(f'elvt-component-{self.component_name}-', '')
            parts = suffix.split('-')

            # First part is usually the category (border, fill, text, etc.)
            if len(parts) > 0:
                category = parts[0].capitalize()

                # Create a clean Swift property name
                swift_name = '_'.join(parts)
                swift_name = self.mapper.sanitize_swift_name(swift_name)

                if category not in structure:
                    structure[category] = {}

                structure[category][swift_name] = token_name

        return structure


def fix_incomplete_references(file_path: Path) -> int:
    """
    Fix incomplete LayerAppbackground references in generated aliases file.

    These incomplete references come from the SCSS source having undefined tokens.
    For disabled states, we map to _950 primitives (very dark, subtle colors).

    Returns: Number of fixes applied
    """
    with open(file_path, 'r') as f:
        content = f.read()

    # Mapping of incomplete references to fixes
    fixes = [
        (r'(light: ElevatePrimitives\.Red\._50,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Red._950'),
        (r'(light: ElevatePrimitives\.Red\._200,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Red._950'),
        (r'(light: ElevatePrimitives\.Gray\._200,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Gray._950'),
        (r'(light: ElevatePrimitives\.Blue\._50,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Blue._950'),
        (r'(light: ElevatePrimitives\.Blue\._200,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Blue._950'),
        (r'(light: ElevatePrimitives\.Green\._50,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Green._950'),
        (r'(light: ElevatePrimitives\.Green\._100,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Green._950'),
        (r'(light: ElevatePrimitives\.Orange\._100,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Orange._950'),
        (r'(light: ElevatePrimitives\.Orange\._50,\s+dark: )ElevateAliases\.Layout\.LayerAppbackground\.',
         r'\1ElevatePrimitives.Orange._950'),
    ]

    fixes_count = 0
    original_content = content

    for pattern, replacement in fixes:
        content, count = re.subn(pattern, replacement, content)
        fixes_count += count

    if content != original_content:
        with open(file_path, 'w') as f:
            f.write(content)

    return fixes_count


def main():
    print("=== ELEVATE Design Token Extraction v3 ===")
    print(f"Source: {ELEVATE_TOKENS_PATH}")
    print(f"Output: {OUTPUT_BASE}")
    print()

    # Validate paths exist
    if not ELEVATE_TOKENS_PATH.exists():
        print(f"❌ ERROR: ELEVATE tokens path does not exist: {ELEVATE_TOKENS_PATH}")
        print(f"\nSet the correct path using environment variable:")
        print(f"  export ELEVATE_TOKENS_PATH=/path/to/elevate-design-tokens/src/scss")
        print(f"  python3 scripts/update-design-tokens-v3.py")
        print(f"\nOr update ELEVATE_TOKENS_PATH in the script (line ~27)")
        return 1

    if not LIGHT_MODE_FILE.exists():
        print(f"❌ ERROR: Light mode file not found: {LIGHT_MODE_FILE}")
        print(f"Expected: {ELEVATE_TOKENS_PATH}/values/_light.scss")
        return 1

    if not DARK_MODE_FILE.exists():
        print(f"❌ ERROR: Dark mode file not found: {DARK_MODE_FILE}")
        print(f"Expected: {ELEVATE_TOKENS_PATH}/values/_dark.scss")
        return 1

    print("✅ Source files validated")
    print()

    # Parse light mode
    print("Parsing light mode tokens...")
    light_parser = SCSSReferenceParser(LIGHT_MODE_FILE)
    light_tokens = light_parser.extract_all_tokens()
    print(f"  Found {len(light_tokens)} light mode tokens")

    # Parse dark mode
    print("Parsing dark mode tokens...")
    dark_parser = SCSSReferenceParser(DARK_MODE_FILE)
    dark_tokens = dark_parser.extract_all_tokens()
    print(f"  Found {len(dark_tokens)} dark mode tokens")

    output_dir = OUTPUT_BASE / "Generated"
    output_dir.mkdir(exist_ok=True, parents=True)

    # Generate Primitives
    print("\nGenerating Primitives...")
    primitives_gen = PrimitivesGenerator(light_tokens, dark_tokens)
    primitives_code = primitives_gen.generate()
    primitives_file = output_dir / "ElevatePrimitives.swift"
    with open(primitives_file, 'w') as f:
        f.write(primitives_code)
    print(f"  ✅ Generated: {primitives_file}")
    print(f"  📊 Size: {len(primitives_code)} bytes")

    # Generate Aliases
    print("\nGenerating Aliases...")
    aliases_gen = AliasesGenerator(light_tokens, dark_tokens)
    aliases_code = aliases_gen.generate()
    aliases_file = output_dir / "ElevateAliases.swift"
    with open(aliases_file, 'w') as f:
        f.write(aliases_code)
    print(f"  ✅ Generated: {aliases_file}")
    print(f"  📊 Size: {len(aliases_code)} bytes")

    # Fix incomplete references in aliases
    print("  🔧 Fixing incomplete references...")
    fixes_count = fix_incomplete_references(aliases_file)
    if fixes_count > 0:
        print(f"  ✅ Fixed {fixes_count} incomplete references")
    else:
        print(f"  ✅ No incomplete references found")

    # Generate Component Tokens
    components = ['button', 'badge', 'chip', 'switch', 'checkbox', 'radio', 'input', 'field', 'textarea', 'breadcrumb', 'breadcrumb-item', 'menu', 'menu-item', 'tab', 'tab-group']
    for component in components:
        print(f"\nGenerating {component.capitalize()} Component Tokens...")
        component_gen = ComponentTokensGenerator(light_tokens, dark_tokens, component)
        component_code = component_gen.generate()

        if component_code:
            component_file = output_dir / f"{component.capitalize()}ComponentTokens.swift"
            with open(component_file, 'w') as f:
                f.write(component_code)
            print(f"  ✅ Generated: {component_file}")
            print(f"  📊 Size: {len(component_code)} bytes")

            # Count tokens
            token_count = len(component_gen._get_component_tokens())
            print(f"  📊 Tokens: {token_count}")
        else:
            print(f"  ⚠️  No tokens found for {component}")

    print("\n✅ Extraction complete!")
    print(f"\nGenerated files in: {output_dir}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
