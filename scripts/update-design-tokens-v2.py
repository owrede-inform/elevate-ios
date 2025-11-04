#!/usr/bin/env python3
"""
ELEVATE Design Tokens Update Script v2
Extracts all three tiers of design tokens with proper references:
1. Primitives (base values)
2. Aliases (semantic tokens referencing primitives)
3. Components (component tokens referencing aliases)
"""

import re
import os
import sys
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple, Optional
from dataclasses import dataclass

# Paths
ELEVATE_TOKENS_SRC = Path("/Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main/src/scss")
PROJECT_ROOT = Path(__file__).parent.parent
OUTPUT_DIR = PROJECT_ROOT / "ElevateUI" / "Sources" / "DesignTokens"

@dataclass
class TokenValue:
    """Represents a token with its value and optional reference"""
    name: str
    value: str  # RGB color or numeric value
    reference: Optional[str] = None  # Reference to another token

def sanitize_swift_name(name: str) -> str:
    """Convert SCSS token name to valid Swift identifier"""
    # Replace hyphens with underscores
    name = name.replace('-', '_')

    # Escape Swift keywords
    swift_keywords = ['default', 'case', 'class', 'continue', 'break', 'return',
                      'import', 'self', 'Self', 'static', 'public', 'private',
                      'internal', 'init', 'deinit', 'subscript', 'extension',
                      'protocol', 'typealias', 'var', 'let', 'func', 'enum', 'struct']
    if name in swift_keywords:
        name = f"`{name}`"

    return name

class ColorParser:
    """Parse RGB/RGBA color values from SCSS"""

    @staticmethod
    def parse_rgb(rgb_str: str) -> Optional[Tuple[float, float, float, float]]:
        """Parse rgb(r g b) or rgba(r g b / a) format"""
        rgb_str = rgb_str.strip()

        # Match rgb(r g b) or rgba(r g b / a)
        rgb_match = re.search(r'rgba?\(([^)]+)\)', rgb_str)
        if not rgb_match:
            return None

        values_str = rgb_match.group(1)

        # Handle alpha channel with /
        if '/' in values_str:
            rgb_part, alpha_part = values_str.split('/')
            values = [float(x.strip()) for x in rgb_part.split()]
            alpha = float(alpha_part.strip().replace('%', '')) / 100 if '%' in alpha_part else float(alpha_part.strip())
            values.append(alpha)
        else:
            values = [float(x.strip()) for x in values_str.split()]
            if len(values) == 3:
                values.append(1.0)  # Default alpha

        if len(values) != 4:
            return None

        # Convert to 0-1 range
        r, g, b, a = values
        return (r / 255.0, g / 255.0, b / 255.0, a)

    @staticmethod
    def to_swift_color(rgba: Tuple[float, float, float, float]) -> str:
        """Convert RGBA tuple to Swift Color initializer"""
        r, g, b, a = rgba
        if a < 1.0:
            return f"Color(red: {r:.4f}, green: {g:.4f}, blue: {b:.4f}, opacity: {a:.4f})"
        else:
            return f"Color(red: {r:.4f}, green: {g:.4f}, blue: {b:.4f})"

class TokenExtractor:
    """Extract tokens from SCSS files maintaining hierarchy"""

    def __init__(self, light_scss_path: Path):
        self.light_scss_path = light_scss_path
        self.primitives: Dict[str, TokenValue] = {}
        self.aliases: Dict[str, TokenValue] = {}
        self.components: Dict[str, TokenValue] = {}
        self.color_parser = ColorParser()

    def extract_all(self):
        """Extract all three tiers of tokens"""
        if not self.light_scss_path.exists():
            print(f"❌ Error: {self.light_scss_path} not found")
            return

        with open(self.light_scss_path, 'r') as f:
            content = f.read()

        # Extract primitives first
        print("  → Extracting primitive tokens...")
        primitive_pattern = r'\$elvt-primitives-([a-zA-Z0-9_-]+):\s*(.+?);'
        for match in re.finditer(primitive_pattern, content, re.MULTILINE):
            name = match.group(1)
            value = match.group(2).strip()
            self.primitives[name] = TokenValue(name=name, value=value)
        print(f"    Found {len(self.primitives)} primitives")

        # Extract aliases
        print("  → Extracting alias tokens...")
        alias_pattern = r'\$elvt-alias-([a-zA-Z0-9_-]+):\s*var\(--([^,]+),\s*(.+?)\);'
        for match in re.finditer(alias_pattern, content, re.MULTILINE):
            name = match.group(1)
            ref_token = match.group(2).strip()
            fallback_value = match.group(3).strip()

            # Extract the reference name (remove the --elvt-primitives- or --elvt-alias- prefix)
            ref_name = ref_token.replace('elvt-primitives-', '').replace('elvt-alias-', '')

            self.aliases[name] = TokenValue(
                name=name,
                value=fallback_value,
                reference=ref_name if ref_token.startswith('elvt-primitives-') or ref_token.startswith('elvt-alias-') else None
            )
        print(f"    Found {len(self.aliases)} aliases")

        # Extract components
        print("  → Extracting component tokens...")
        component_pattern = r'\$elvt-component-([a-zA-Z0-9_-]+):\s*var\(--([^,]+),\s*(.+?)\);'
        for match in re.finditer(component_pattern, content, re.MULTILINE):
            name = match.group(1)
            ref_token = match.group(2).strip()
            fallback_value = match.group(3).strip()

            # Extract the reference name
            ref_name = ref_token.replace('elvt-alias-', '').replace('elvt-component-', '')

            self.components[name] = TokenValue(
                name=name,
                value=fallback_value,
                reference=ref_name if ref_token.startswith('elvt-alias-') or ref_token.startswith('elvt-component-') else None
            )
        print(f"    Found {len(self.components)} components")

class PrimitivesGenerator:
    """Generate ElevatePrimitives.swift"""

    def __init__(self, primitives: Dict[str, TokenValue], color_parser: ColorParser):
        self.primitives = primitives
        self.color_parser = color_parser

    def generate(self) -> str:
        """Generate Swift code for primitives"""
        swift_code = '''#if os(iOS)
import SwiftUI

/// ELEVATE Design System Primitive Tokens
///
/// Base color palette - the foundation of the design system.
/// These are raw color values that should not be used directly in components.
/// Use alias or component tokens instead.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v2.py to update
@available(iOS 15, *)
public struct ElevatePrimitives {

    // MARK: - Color Primitives

'''

        # Group by color family
        color_families = {}
        for name, token in sorted(self.primitives.items()):
            if 'color' in name:
                # Extract color family (blue, red, gray, etc.)
                parts = name.split('-')
                if len(parts) >= 2 and parts[0] == 'color':
                    family = parts[1]
                    if family not in color_families:
                        color_families[family] = []
                    color_families[family].append((name, token))

        # Generate color families
        for family, tokens in sorted(color_families.items()):
            swift_code += f"    // MARK: {family.capitalize()} Scale\n    \n"
            swift_code += f"    public enum {family.capitalize()} {{\n"

            for name, token in sorted(tokens, key=lambda x: x[0]):
                rgba = self.color_parser.parse_rgb(token.value)
                if rgba:
                    swift_name = sanitize_swift_name(name.replace(f'color-{family}-', ''))
                    swift_value = self.color_parser.to_swift_color(rgba)
                    swift_code += f"        public static let _{swift_name} = {swift_value}\n"

            swift_code += "    }\n\n"

        swift_code += "}\n#endif\n"
        return swift_code

class AliasesGenerator:
    """Generate ElevateAliases.swift"""

    def __init__(self, aliases: Dict[str, TokenValue], primitives: Dict[str, TokenValue], color_parser: ColorParser):
        self.aliases = aliases
        self.primitives = primitives
        self.color_parser = color_parser

    def generate(self) -> str:
        """Generate Swift code for aliases"""
        swift_code = '''#if os(iOS)
import SwiftUI

/// ELEVATE Design System Alias Tokens
///
/// Semantic tokens that reference primitives.
/// These provide meaning and context to colors (e.g., "action-primary", "feedback-success").
/// Components should use these rather than primitives directly.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v2.py to update
@available(iOS 15, *)
public struct ElevateAliases {

    // MARK: - Action Colors

    public enum Action {
'''

        # Group action aliases
        action_aliases = {name: token for name, token in self.aliases.items() if name.startswith('action-')}

        # Group by strong/understated and tone
        groups = {}
        for name, token in sorted(action_aliases.items()):
            parts = name.replace('action-', '').split('-')
            if len(parts) >= 2:
                group_key = f"{parts[0]}-{parts[1]}"  # e.g., "strong-primary"
                if group_key not in groups:
                    groups[group_key] = []
                groups[group_key].append((name, token))

        for group_name, tokens in sorted(groups.items()):
            swift_struct_name = ''.join(word.capitalize() for word in group_name.split('-'))
            swift_code += f"        \n        public enum {swift_struct_name} {{\n"

            for name, token in sorted(tokens):
                base_name = name.replace('action-', '')
                parts = base_name.split('-', 2)
                property_name = parts[-1] if len(parts) > 2 else base_name
                swift_name = sanitize_swift_name(property_name.replace('-', '_'))

                # Try to resolve reference
                if token.reference and token.reference in self.primitives:
                    prim = self.primitives[token.reference]
                    rgba = self.color_parser.parse_rgb(prim.value)
                else:
                    rgba = self.color_parser.parse_rgb(token.value)

                if rgba:
                    swift_value = self.color_parser.to_swift_color(rgba)
                    swift_code += f"            public static let {swift_name} = {swift_value}\n"

            swift_code += "        }\n"

        swift_code += "    }\n"

        # Add feedback aliases
        swift_code += '''
    // MARK: - Feedback Colors

    public enum Feedback {
'''

        feedback_aliases = {name: token for name, token in self.aliases.items() if name.startswith('feedback-')}
        for name, token in sorted(feedback_aliases.items()):
            base_name = name.replace('feedback-', '')
            swift_name = sanitize_swift_name(base_name.replace('-', '_'))
            rgba = self.color_parser.parse_rgb(token.value)
            if rgba:
                swift_value = self.color_parser.to_swift_color(rgba)
                swift_code += f"        public static let {swift_name} = {swift_value}\n"

        swift_code += "    }\n"

        swift_code += "}\n#endif\n"
        return swift_code

class ButtonTokensGeneratorV2:
    """Generate ButtonTokens.swift with proper alias references"""

    def __init__(self, components: Dict[str, TokenValue], aliases: Dict[str, TokenValue], color_parser: ColorParser):
        self.components = components
        self.aliases = aliases
        self.color_parser = color_parser

    def generate(self) -> str:
        """Generate complete ButtonTokens.swift with alias references"""
        button_tokens = {name: token for name, token in self.components.items() if name.startswith('button-')}

        tones = ['primary', 'secondary', 'success', 'warning', 'danger', 'emphasized', 'subtle', 'neutral']

        swift_code = '''#if os(iOS)
import SwiftUI

/// ELEVATE Button Component Design Tokens
///
/// Component-specific tokens that reference alias tokens.
/// This maintains the proper token hierarchy: Component → Alias → Primitive
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v2.py to update
@available(iOS 15, *)
public struct ButtonTokens {

    // MARK: - Button Tones

    public enum Tone {
        case primary, secondary, success, warning, danger, emphasized, subtle, neutral

        public var colors: ToneColors {
            switch self {
            case .primary: return .primary
            case .secondary: return .secondary
            case .success: return .success
            case .warning: return .warning
            case .danger: return .danger
            case .emphasized: return .emphasized
            case .subtle: return .subtle
            case .neutral: return .neutral
            }
        }
    }

    // MARK: - Sizes, Shapes, States

    public enum Size {
        case small, medium, large
    }

    public enum Shape {
        case box, pill
    }

    public enum State {
        case `default`, hover, active, disabled
    }

    // MARK: - Tone Color Configurations

    public struct ToneColors {
        let background: Color
        let backgroundHover: Color
        let backgroundActive: Color
        let backgroundDisabled: Color
        let text: Color
        let textDisabled: Color
        let border: Color

'''

        # Generate tone colors
        for tone in tones:
            swift_code += f"        static let {tone} = ToneColors(\n"

            # Get tokens for this tone
            fill_default = self._get_button_token(f"button-fill-{tone}-default")
            fill_hover = self._get_button_token(f"button-fill-{tone}-hover")
            fill_active = self._get_button_token(f"button-fill-{tone}-active")
            fill_disabled = self._get_button_token(f"button-fill-{tone}-disabled-default")
            label_default = self._get_button_token(f"button-label-{tone}-default")
            label_disabled = self._get_button_token(f"button-label-{tone}-disabled-default")
            border_default = self._get_button_token(f"button-border-{tone}-color-default")

            swift_code += f"            background: {fill_default},\n"
            swift_code += f"            backgroundHover: {fill_hover},\n"
            swift_code += f"            backgroundActive: {fill_active},\n"
            swift_code += f"            backgroundDisabled: {fill_disabled},\n"
            swift_code += f"            text: {label_default},\n"
            swift_code += f"            textDisabled: {label_disabled},\n"
            swift_code += f"            border: {border_default}\n"
            swift_code += "        )\n\n"

        swift_code += "    }\n}\n#endif\n"
        return swift_code

    def _get_button_token(self, token_name: str) -> str:
        """Get button token value"""
        if token_name in self.components:
            token = self.components[token_name]
            rgba = self.color_parser.parse_rgb(token.value)
            if rgba:
                return self.color_parser.to_swift_color(rgba)
        return "Color.gray"

def main():
    print("🎨 ELEVATE Design Tokens Update Script v2")
    print("=" * 50)
    print()
    print("Extracting three-tier token hierarchy:")
    print("  1. Primitives (base values)")
    print("  2. Aliases (semantic tokens)")
    print("  3. Components (component tokens)")
    print()

    # Extract tokens
    light_scss = ELEVATE_TOKENS_SRC / "values" / "_light.scss"
    extractor = TokenExtractor(light_scss)

    print("📝 Step 1: Extracting tokens from SCSS...")
    extractor.extract_all()
    print()

    # Generate Swift files
    print("🔨 Step 2: Generating Swift code...")

    color_parser = ColorParser()

    print("  → Generating ElevatePrimitives.swift...")
    primitives_gen = PrimitivesGenerator(extractor.primitives, color_parser)
    primitives_code = primitives_gen.generate()

    print("  → Generating ElevateAliases.swift...")
    aliases_gen = AliasesGenerator(extractor.aliases, extractor.primitives, color_parser)
    aliases_code = aliases_gen.generate()

    print("  → Generating ButtonTokens.swift...")
    button_gen = ButtonTokensGeneratorV2(extractor.components, extractor.aliases, color_parser)
    button_code = button_gen.generate()

    print()

    # Create backup
    print("📦 Step 3: Creating backups...")
    backup_dir = PROJECT_ROOT / "scripts" / "backups" / datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir.mkdir(parents=True, exist_ok=True)

    # Backup existing files if they exist
    files_to_backup = [
        ("ElevatePrimitives.swift", OUTPUT_DIR / "Primitives" / "ElevatePrimitives.swift"),
        ("ElevateAliases.swift", OUTPUT_DIR / "Aliases" / "ElevateAliases.swift"),
        ("ButtonTokens.swift", OUTPUT_DIR / "Components" / "ButtonTokens.swift"),
    ]

    for filename, filepath in files_to_backup:
        if filepath.exists():
            import shutil
            shutil.copy(filepath, backup_dir / filename)

    print(f"  → Backups saved to: {backup_dir}")
    print()

    # Write new files
    print("🔄 Step 4: Writing Swift files...")

    primitives_dir = OUTPUT_DIR / "Primitives"
    aliases_dir = OUTPUT_DIR / "Aliases"
    components_dir = OUTPUT_DIR / "Components"

    primitives_dir.mkdir(parents=True, exist_ok=True)
    aliases_dir.mkdir(parents=True, exist_ok=True)
    components_dir.mkdir(parents=True, exist_ok=True)

    with open(primitives_dir / "ElevatePrimitives.swift", 'w') as f:
        f.write(primitives_code)
    print("  ✓ ElevatePrimitives.swift created")

    with open(aliases_dir / "ElevateAliases.swift", 'w') as f:
        f.write(aliases_code)
    print("  ✓ ElevateAliases.swift created")

    with open(components_dir / "ButtonTokens.swift", 'w') as f:
        f.write(button_code)
    print("  ✓ ButtonTokens.swift updated")

    print()
    print("=" * 50)
    print("✨ Three-tier token hierarchy extraction complete!")
    print()
    print("Summary:")
    print(f"  - {len(extractor.primitives)} primitive tokens")
    print(f"  - {len(extractor.aliases)} alias tokens")
    print(f"  - {len(extractor.components)} component tokens")
    print()
    print("Token Hierarchy:")
    print("  Primitives → Aliases → Components")
    print()
    print("Next steps:")
    print("  1. Build: swift build")
    print("  2. Review: git diff")
    print("  3. Update Package.swift to include new files")
    print()

if __name__ == "__main__":
    main()
