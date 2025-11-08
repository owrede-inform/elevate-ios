#!/usr/bin/env python3
"""
ELEVATE Design Token Extraction Script v4.0
===========================================

Complete token extraction system supporting:
- Colors (light/dark mode)
- Spacing/Dimensions (rem → CGFloat)
- Typography tokens
- Component-specific tokens (colors + spacing)
- MD5 caching for performance
- Theme composition support

Key improvements over v3.2:
- Parses ALL token types (not just colors)
- Handles rem/px units → CGFloat conversion
- Generates complete component token files (colors + spacing)
- MD5 caching to avoid unnecessary regeneration
- Support for custom theme overlays

Usage:
    python3 scripts/update-design-tokens-v4.py

    # With custom theme overlay
    python3 scripts/update-design-tokens-v4.py --theme custom-theme.scss

    # Force regeneration (ignore cache)
    python3 scripts/update-design-tokens-v4.py --force
"""

import re
import os
import sys
import hashlib
import json
from dataclasses import dataclass
from typing import Optional, Dict, Tuple, Union, List
from pathlib import Path
from enum import Enum

# ELEVATE design tokens source path
ELEVATE_TOKENS_PATH = Path(
    os.environ.get(
        "ELEVATE_TOKENS_PATH",
        "/Users/wrede/Documents/GitHub/elevate-ios/.elevate-src/Elevate-2025-11-04/elevate-design-tokens-main/src/scss"
    )
)
LIGHT_MODE_FILE = ELEVATE_TOKENS_PATH / "values" / "_light.scss"
DARK_MODE_FILE = ELEVATE_TOKENS_PATH / "values" / "_dark.scss"
COMPONENT_TOKENS_PATH = ELEVATE_TOKENS_PATH / "tokens" / "component"

# iOS theme path (for extend and overwrite tokens)
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
THEME_PATH = PROJECT_ROOT / ".elevate-themes" / "ios"
THEME_EXTEND_FILE = THEME_PATH / "extend.css"
THEME_OVERWRITE_FILE = THEME_PATH / "overwrite.css"
THEME_OVERWRITE_DARK_FILE = THEME_PATH / "overwrite-dark.css"

# Output paths
OUTPUT_BASE = PROJECT_ROOT / "ElevateUI" / "Sources" / "DesignTokens"
GENERATED_DIR = OUTPUT_BASE / "Generated"
CACHE_FILE = OUTPUT_BASE / ".token_cache.json"


class TokenType(Enum):
    """Type of token value"""
    COLOR = "color"
    SPACING = "spacing"
    DIMENSION = "dimension"
    TYPOGRAPHY = "typography"
    SHADOW = "shadow"
    UNKNOWN = "unknown"


@dataclass
class TokenValue:
    """Represents a token value with type information"""
    type: TokenType
    value: Union[str, float, Tuple[float, float, float, float]]
    unit: Optional[str] = None  # rem, px, pt, etc.

    def to_swift_value(self) -> str:
        """Convert to Swift value representation"""
        if self.type == TokenType.COLOR:
            if isinstance(self.value, tuple):
                r, g, b, a = self.value
                return f"Color(red: {r:.4f}, green: {g:.4f}, blue: {b:.4f}, opacity: {a:.4f})"
            return str(self.value)
        elif self.type in [TokenType.SPACING, TokenType.DIMENSION]:
            if self.unit == "rem":
                # Convert rem to points (1rem = 16pt)
                return f"{self.value * 16:.1f}"
            elif self.unit == "px":
                # px = pt on @1x
                return f"{self.value:.1f}"
            return str(self.value)
        return str(self.value)


@dataclass
class TokenReference:
    """Represents a token with its reference and fallback"""
    name: str
    reference: Optional[str]  # The token it references
    fallback: TokenValue
    token_type: TokenType


class SCSSUniversalParser:
    """Universal SCSS parser for all token types"""

    def __init__(self, scss_file_path: Path):
        self.scss_path = scss_file_path
        with open(scss_file_path, 'r') as f:
            self.content = f.read()

    def parse_token_line(self, line: str) -> Optional[TokenReference]:
        """
        Parse any type of SCSS token line

        Examples:
          $elvt-primitives-color-blue-600: rgb(11 92 223);
          $elvt-component-button-gap-m: var(--elvt-component-button-gap-m, 0.5rem);
          $height-l: var(--elvt-component-button-height-l, 3rem);
        """
        # Pattern: $name: var(--reference, fallback) or $name: fallback
        # Updated to handle rgb() in fallback values
        var_pattern = r'\$([a-zA-Z0-9_-]+):\s*var\(--([a-zA-Z0-9_-]+),\s*(.+)\);'
        direct_pattern = r'\$([a-zA-Z0-9_-]+):\s*([^;]+);'

        # Try var() pattern first
        var_match = re.match(var_pattern, line)
        if var_match:
            name = var_match.group(1)
            reference = var_match.group(2)
            fallback_str = var_match.group(3).strip()
            fallback = self._parse_value(fallback_str)
            token_type = self._infer_type(name, fallback)
            return TokenReference(
                name=name,
                reference=reference,
                fallback=fallback,
                token_type=token_type
            )

        # Try direct pattern
        direct_match = re.match(direct_pattern, line)
        if direct_match:
            name = direct_match.group(1)
            value_str = direct_match.group(2).strip()
            fallback = self._parse_value(value_str)
            token_type = self._infer_type(name, fallback)
            return TokenReference(
                name=name,
                reference=None,
                fallback=fallback,
                token_type=token_type
            )

        return None

    def _parse_value(self, value_str: str) -> TokenValue:
        """Parse value string into TokenValue"""
        value_str = value_str.strip()

        # RGB/RGBA color
        rgb_match = re.match(r'rgba?\(([0-9\s./]+)\)', value_str)
        if rgb_match:
            rgb_str = rgb_match.group(1)
            rgb = self._parse_rgb(rgb_str)
            return TokenValue(type=TokenType.COLOR, value=rgb)

        # Dimension with rem unit
        rem_match = re.match(r'([0-9.]+)rem', value_str)
        if rem_match:
            value = float(rem_match.group(1))
            return TokenValue(type=TokenType.DIMENSION, value=value, unit="rem")

        # Dimension with px unit
        px_match = re.match(r'([0-9.]+)px', value_str)
        if px_match:
            value = float(px_match.group(1))
            return TokenValue(type=TokenType.DIMENSION, value=value, unit="px")

        # Plain number
        try:
            value = float(value_str)
            return TokenValue(type=TokenType.DIMENSION, value=value)
        except ValueError:
            pass

        # Unknown - store as string
        return TokenValue(type=TokenType.UNKNOWN, value=value_str)

    def _parse_rgb(self, rgb_str: str) -> Tuple[float, float, float, float]:
        """Parse RGB string to normalized values"""
        parts = rgb_str.strip().split()
        if len(parts) == 3:
            r, g, b = map(float, parts)
            return (r / 255.0, g / 255.0, b / 255.0, 1.0)
        elif len(parts) == 4:
            # Handle "/ 0%" alpha syntax
            if '/' in rgb_str:
                rgb_part, alpha_part = rgb_str.split('/')
                rgb_values = list(map(float, rgb_part.strip().split()))
                alpha_str = alpha_part.strip().replace('%', '')
                alpha = float(alpha_str) / 100.0 if '%' in alpha_part else float(alpha_str)
                return (rgb_values[0] / 255.0, rgb_values[1] / 255.0, rgb_values[2] / 255.0, alpha)
            else:
                r, g, b, a = map(float, parts)
                return (r / 255.0, g / 255.0, b / 255.0, a)
        return (0, 0, 0, 1)

    def _infer_type(self, name: str, fallback: TokenValue) -> TokenType:
        """Infer token type from name and fallback"""
        if fallback.type != TokenType.UNKNOWN:
            return fallback.type

        # Infer from name
        name_lower = name.lower()
        if any(keyword in name_lower for keyword in ['color', 'fill', 'border', 'text', 'label', 'icon']):
            return TokenType.COLOR
        if any(keyword in name_lower for keyword in ['gap', 'padding', 'margin', 'spacing']):
            return TokenType.SPACING
        if any(keyword in name_lower for keyword in ['height', 'width', 'size', 'radius']):
            return TokenType.DIMENSION

        return TokenType.UNKNOWN

    def extract_all_tokens(self) -> Dict[str, TokenReference]:
        """Extract all tokens from the SCSS file"""
        tokens = {}
        for line in self.content.split('\n'):
            token = self.parse_token_line(line.strip())
            if token:
                tokens[token.name] = token
        return tokens


class TokenCacheManager:
    """Manages MD5 cache for incremental builds"""

    def __init__(self, cache_file: Path):
        self.cache_file = cache_file
        self.cache = self._load_cache()

    def _load_cache(self) -> Dict:
        """Load cache from disk"""
        if self.cache_file.exists():
            try:
                with open(self.cache_file, 'r') as f:
                    return json.load(f)
            except Exception:
                return {}
        return {}

    def _save_cache(self):
        """Save cache to disk"""
        self.cache_file.parent.mkdir(exist_ok=True, parents=True)
        with open(self.cache_file, 'w') as f:
            json.dump(self.cache, f, indent=2)

    def compute_file_hash(self, file_path: Path) -> str:
        """Compute MD5 hash of file"""
        if not file_path.exists():
            return ""
        with open(file_path, 'rb') as f:
            return hashlib.md5(f.read()).hexdigest()

    def needs_regeneration(self, source_files: List[Path], output_file: Path) -> bool:
        """Check if output needs regeneration based on source file changes"""
        if not output_file.exists():
            return True

        cache_key = str(output_file)
        if cache_key not in self.cache:
            return True

        cached_hashes = self.cache[cache_key]

        # Check if any source file changed
        for source_file in source_files:
            current_hash = self.compute_file_hash(source_file)
            source_key = str(source_file)
            if cached_hashes.get(source_key) != current_hash:
                return True

        return False

    def update_cache(self, source_files: List[Path], output_file: Path):
        """Update cache after generation"""
        cache_key = str(output_file)
        self.cache[cache_key] = {}

        for source_file in source_files:
            source_key = str(source_file)
            self.cache[cache_key][source_key] = self.compute_file_hash(source_file)

        self._save_cache()


class SwiftTokenMapper:
    """Maps SCSS token names to Swift paths"""

    @staticmethod
    def scss_to_swift_path(scss_name: str, is_reference: bool = True) -> str:
        """Convert SCSS token name to Swift property path"""
        parts = scss_name.replace('elvt-', '').split('-')

        # Primitives
        if parts[0] == 'primitives':
            if len(parts) > 1 and parts[1] == 'color':
                color_family = parts[2].capitalize()
                shade = parts[3] if len(parts) > 3 else 'color_' + parts[2]
                return f"ElevatePrimitives.{color_family}._{shade}"

        # Aliases
        if parts[0] == 'alias':
            category = parts[1].capitalize()
            subcategory_parts = []
            property_parts = []
            found_property = False

            for part in parts[2:]:
                if part in ['fill', 'text', 'border', 'track', 'color', 'outline']:
                    found_property = True

                if not found_property:
                    subcategory_parts.append(part.capitalize())
                else:
                    property_parts.append(part)

            # If no property keyword found, use last part as property
            # This handles tokens like: layout-layer-ground → Layout.Layer.ground
            if not property_parts and subcategory_parts:
                property_parts = [subcategory_parts.pop().lower()]

            subcategory = ''.join(subcategory_parts) if subcategory_parts else 'General'
            property_name = '_'.join(property_parts) if property_parts else 'value'

            # Return None if property name is still incomplete
            if not property_parts:
                return None

            return f"ElevateAliases.{category}.{subcategory}.{property_name}"

        # Components
        if parts[0] == 'component':
            component_name = parts[1].capitalize()
            property_parts = parts[2:]
            property_name = '_'.join(property_parts)
            return f"{component_name}ComponentTokens.{property_name}"

        return None

    @staticmethod
    def sanitize_swift_name(name: str) -> str:
        """Sanitize name for Swift"""
        name = name.replace('-', '_')
        swift_keywords = ['default', 'case', 'class', 'struct', 'enum', 'func', 'var', 'let']
        if name in swift_keywords:
            return f"`{name}`"
        return name


def merge_theme_tokens(
    base_tokens: Dict[str, TokenReference],
    extend_file: Path,
    overwrite_file: Path
) -> Dict[str, TokenReference]:
    """
    Merge theme tokens with base ELEVATE tokens.

    Args:
        base_tokens: Base tokens from ELEVATE (light or dark)
        extend_file: Path to extend.css (adds missing tokens)
        overwrite_file: Path to overwrite.css (overrides existing tokens)

    Returns:
        Merged token dictionary

    Strategy:
        1. Start with base ELEVATE tokens
        2. Add tokens from extend.css (only if not already present)
        3. Override with tokens from overwrite.css (replace if present)
    """
    merged = base_tokens.copy()

    # Parse extend tokens (add missing)
    if extend_file.exists():
        extend_parser = SCSSUniversalParser(extend_file)
        extend_tokens = extend_parser.extract_all_tokens()

        for name, token in extend_tokens.items():
            if name not in merged:
                # Add token if it doesn't exist in base ELEVATE
                merged[name] = token

    # Parse overwrite tokens (replace existing)
    if overwrite_file.exists():
        overwrite_parser = SCSSUniversalParser(overwrite_file)
        overwrite_tokens = overwrite_parser.extract_all_tokens()

        for name, token in overwrite_tokens.items():
            # Override token (replace if exists, add if not)
            merged[name] = token

    return merged


class ComprehensiveComponentGenerator:
    """Generates complete component token files (colors + spacing + dimensions)"""

    def __init__(self,
                 light_tokens: Dict[str, TokenReference],
                 dark_tokens: Dict[str, TokenReference],
                 component_file: Path,
                 component_name: str):
        self.light_tokens = light_tokens
        self.dark_tokens = dark_tokens
        self.component_file = component_file
        self.component_name = component_name.lower()
        self.mapper = SwiftTokenMapper()

        # Parse component-specific tokens from component SCSS file
        parser = SCSSUniversalParser(component_file)
        self.component_tokens = parser.extract_all_tokens()

        # Also include theme tokens from light_tokens that match this component
        # This allows extend.css to add missing tokens for components
        component_pattern = f"elvt-component-{self.component_name}-"
        for token_name in light_tokens.keys():
            if component_pattern in token_name and token_name not in self.component_tokens:
                # Use light mode as the canonical token (dark mode handled separately)
                self.component_tokens[token_name] = light_tokens[token_name]

    def generate(self) -> str:
        """Generate complete component tokens file"""
        if not self.component_tokens:
            return ""

        # Convert hyphenated names to CamelCase for struct names
        # e.g., "breadcrumb-item" → "BreadcrumbItem"
        class_name = ''.join(word.capitalize() for word in self.component_name.split('-')) + "ComponentTokens"

        code = f"""#if os(iOS)
import SwiftUI

/// ELEVATE {self.component_name.capitalize()} Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct {class_name} {{

"""

        # Organize tokens by type and category
        color_tokens = {}
        spacing_tokens = {}
        dimension_tokens = {}

        # Filter out duplicate long-form tokens (elvt-component-{name}-*)
        # Keep only short-form tokens to eliminate 33% duplication
        duplicate_prefix = f"elvt-component-{self.component_name}-"

        for token_name, token_ref in self.component_tokens.items():
            # Skip long-form duplicates that have corresponding short-form versions
            if token_name.startswith(duplicate_prefix):
                # Check if short-form equivalent exists
                short_name = token_name.replace(duplicate_prefix, '')
                if short_name in self.component_tokens:
                    continue  # Skip this duplicate

            if token_ref.token_type == TokenType.COLOR:
                color_tokens[token_name] = token_ref
            elif token_ref.token_type == TokenType.SPACING:
                spacing_tokens[token_name] = token_ref
            elif token_ref.token_type == TokenType.DIMENSION:
                dimension_tokens[token_name] = token_ref

        # Generate color tokens
        if color_tokens:
            code += "    // MARK: - Colors\n\n"
            for token_name, token_ref in sorted(color_tokens.items()):
                property_name = self.mapper.sanitize_swift_name(token_name.replace('-', '_'))
                color_code = self._generate_color_token(token_ref)
                code += f"    public static let {property_name} = {color_code}\n"
            code += "\n"

        # Generate spacing tokens
        if spacing_tokens:
            code += "    // MARK: - Spacing\n\n"
            for token_name, token_ref in sorted(spacing_tokens.items()):
                property_name = self.mapper.sanitize_swift_name(token_name.replace('-', '_'))
                value = token_ref.fallback.to_swift_value()
                code += f"    public static let {property_name}: CGFloat = {value}\n"
            code += "\n"

        # Generate dimension tokens
        if dimension_tokens:
            code += "    // MARK: - Dimensions\n\n"
            for token_name, token_ref in sorted(dimension_tokens.items()):
                property_name = self.mapper.sanitize_swift_name(token_name.replace('-', '_'))
                value = token_ref.fallback.to_swift_value()
                code += f"    public static let {property_name}: CGFloat = {value}\n"
            code += "\n"

        code += "}\n#endif\n"
        return code

    def _generate_color_token(self, token_ref: TokenReference) -> str:
        """Generate color token with light/dark mode support"""
        # Get the full token name from light/dark mode files
        # Component SCSS files have short names like "fill-danger-active"
        # But light/dark mode files have full names like "elvt-component-button-fill-danger-active"

        # Convert token name: "fill-danger-active" → "fill_danger_active"
        token_name_dashes = token_ref.name.replace('_', '-')
        full_token_name = f"elvt-component-{self.component_name}-{token_name_dashes}"

        light_token = self.light_tokens.get(full_token_name)
        dark_token = self.dark_tokens.get(full_token_name)

        if not light_token or not dark_token:
            # Fallback to static color from token_ref
            if isinstance(token_ref.fallback.value, tuple) and len(token_ref.fallback.value) == 4:
                r, g, b, a = token_ref.fallback.value
                return f"Color(red: {r:.4f}, green: {g:.4f}, blue: {b:.4f}, opacity: {a:.4f})"
            else:
                # Placeholder color for unparseable tokens
                return "Color.clear"

        # Generate dynamic color
        if light_token.reference and dark_token.reference:
            light_path = self.mapper.scss_to_swift_path(light_token.reference)
            dark_path = self.mapper.scss_to_swift_path(dark_token.reference)

            # Skip if reference path is incomplete/invalid
            if light_path and dark_path:
                return f"Color.adaptive(light: {light_path}, dark: {dark_path})"

        # Fallback RGB values
        l_rgb = light_token.fallback.value
        d_rgb = dark_token.fallback.value

        # Ensure RGB values are tuples
        if (isinstance(l_rgb, tuple) and len(l_rgb) == 4 and
            isinstance(d_rgb, tuple) and len(d_rgb) == 4):
            return (
                f"Color.adaptive(\n"
                f"            lightRGB: (red: {l_rgb[0]:.4f}, green: {l_rgb[1]:.4f}, blue: {l_rgb[2]:.4f}, opacity: {l_rgb[3]:.4f}),\n"
                f"            darkRGB: (red: {d_rgb[0]:.4f}, green: {d_rgb[1]:.4f}, blue: {d_rgb[2]:.4f}, opacity: {d_rgb[3]:.4f})\n"
                f"        )"
            )

        # Last resort fallback
        if isinstance(token_ref.fallback.value, tuple) and len(token_ref.fallback.value) == 4:
            r, g, b, a = token_ref.fallback.value
            return f"Color(red: {r:.4f}, green: {g:.4f}, blue: {b:.4f}, opacity: {a:.4f})"

        return "Color.clear"


class PrimitivesGenerator:
    """Extracts Primitive tokens from ELEVATE SCSS and generates Swift code"""

    def __init__(self, light_tokens: Dict[str, TokenReference], dark_tokens: Dict[str, TokenReference]):
        self.light_tokens = light_tokens
        self.dark_tokens = dark_tokens
        self.mapper = SwiftTokenMapper()

    def generate(self) -> str:
        """Generate ElevatePrimitives.swift from SCSS source"""
        primitives = self._get_primitive_tokens()

        if not primitives:
            return ""

        # Organize by color family
        families = {}
        for token_name in primitives:
            parts = token_name.replace('elvt-primitives-color-', '').split('-')
            if len(parts) >= 1:
                family = parts[0].capitalize()
                if family not in families:
                    families[family] = []
                families[family].append(token_name)

        code = """#if os(iOS)
import SwiftUI

/// ELEVATE Design System Primitive Tokens
///
/// Base color palette EXTRACTED from ELEVATE SCSS source.
/// These are raw color values - use Alias or Component tokens instead.
///
/// ⚠️  DO NOT USE DIRECTLY IN COMPONENTS
/// ✅  Use Component Tokens or Alias Tokens instead
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ElevatePrimitives {

    // MARK: - Color Primitives
"""

        for family, tokens in sorted(families.items()):
            code += f"\n    // MARK: {family} Scale\n\n"
            code += f"    public enum {family} {{\n"

            for token_name in sorted(tokens):
                light_token = self.light_tokens.get(token_name)
                dark_token = self.dark_tokens.get(token_name)

                if not light_token or not dark_token:
                    continue

                # Extract shade name
                shade = token_name.replace('elvt-primitives-color-', '')
                if '-' in shade:
                    shade = shade.split('-', 1)[1]
                else:
                    shade = f"color_{shade}"

                property_name = f"_{shade}"

                # Generate adaptive color
                if isinstance(light_token.fallback.value, tuple) and isinstance(dark_token.fallback.value, tuple):
                    l_rgb = light_token.fallback.value
                    d_rgb = dark_token.fallback.value

                    code += f"        public static let {property_name} = Color.adaptive(\n"
                    code += f"            lightRGB: (red: {l_rgb[0]:.4f}, green: {l_rgb[1]:.4f}, blue: {l_rgb[2]:.4f}, opacity: {l_rgb[3]:.4f}),\n"
                    code += f"            darkRGB: (red: {d_rgb[0]:.4f}, green: {d_rgb[1]:.4f}, blue: {d_rgb[2]:.4f}, opacity: {d_rgb[3]:.4f})\n"
                    code += f"        )\n"

            code += "    }\n"

        code += "\n}\n#endif\n"
        return code

    def _get_primitive_tokens(self) -> list:
        """Get list of primitive color tokens"""
        return [name for name in self.light_tokens.keys() if name.startswith('elvt-primitives-color-')]


class AliasesGenerator:
    """Extracts Alias tokens from ELEVATE SCSS and generates Swift code"""

    def __init__(self, light_tokens: Dict[str, TokenReference], dark_tokens: Dict[str, TokenReference]):
        self.light_tokens = light_tokens
        self.dark_tokens = dark_tokens
        self.mapper = SwiftTokenMapper()

    def generate(self) -> str:
        """Generate ElevateAliases.swift from SCSS source"""
        aliases = self._get_alias_tokens()

        if not aliases:
            return ""

        # Organize by category
        structure = self._organize_aliases(aliases)

        code = """#if os(iOS)
import SwiftUI

/// ELEVATE Design System Alias Tokens
///
/// Semantic tokens EXTRACTED from ELEVATE SCSS source.
/// These reference Primitive tokens and provide semantic meaning.
/// Automatically handle light/dark mode.
///
/// ✅  USE THESE when no Component Token exists
/// ⚠️  Component Tokens are preferred over Aliases
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
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
                    dynamic_color = self._generate_adaptive_color(token_name)
                    if dynamic_color:
                        code += f"            public static let {prop_name} = {dynamic_color}\n"

                code += "        }\n"

            code += "    }\n"

        code += "\n}\n#endif\n"
        return code

    def _get_alias_tokens(self) -> list:
        """Get list of alias tokens"""
        return [name for name in self.light_tokens.keys() if name.startswith('elvt-alias-')]

    def _organize_aliases(self, aliases: list) -> Dict:
        """Organize aliases into hierarchical structure"""
        structure = {}

        for token_name in aliases:
            parts = token_name.replace('elvt-alias-', '').split('-')

            if len(parts) < 3:
                continue

            category = parts[0].capitalize()

            # Find where property starts
            property_start_idx = None
            for i, part in enumerate(parts[1:], start=1):
                if part in ['fill', 'text', 'border', 'track', 'color', 'outline']:
                    property_start_idx = i
                    break

            # If no property keyword found, use last part as property
            # This handles tokens like: layout-layer-ground
            if property_start_idx is None:
                if len(parts) >= 2:
                    property_start_idx = len(parts) - 1
                else:
                    continue

            # Build subcategory
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

    def _generate_adaptive_color(self, token_name: str) -> Optional[str]:
        """Generate adaptive color for alias token"""
        light_token = self.light_tokens.get(token_name)
        dark_token = self.dark_tokens.get(token_name)

        if not light_token or not dark_token:
            return None

        # If token references primitives, use them
        if light_token.reference and dark_token.reference:
            light_path = self.mapper.scss_to_swift_path(light_token.reference)
            dark_path = self.mapper.scss_to_swift_path(dark_token.reference)

            if light_path and dark_path:
                return f"Color.adaptive(light: {light_path}, dark: {dark_path})"

        # Fallback to RGB values
        if isinstance(light_token.fallback.value, tuple) and isinstance(dark_token.fallback.value, tuple):
            l_rgb = light_token.fallback.value
            d_rgb = dark_token.fallback.value

            return (
                f"Color.adaptive(\n"
                f"                lightRGB: (red: {l_rgb[0]:.4f}, green: {l_rgb[1]:.4f}, blue: {l_rgb[2]:.4f}, opacity: {l_rgb[3]:.4f}),\n"
                f"                darkRGB: (red: {d_rgb[0]:.4f}, green: {d_rgb[1]:.4f}, blue: {d_rgb[2]:.4f}, opacity: {d_rgb[3]:.4f})\n"
                f"            )"
            )

        return None


def generate_color_adaptive_extension() -> str:
    """Generate Color.adaptive() extension for SwiftUI"""
    return """#if os(iOS)
import SwiftUI
import UIKit

extension Color {
    /// Creates an adaptive color that changes between light and dark mode
    public static func adaptive(light: Color, dark: Color) -> Color {
        return Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
    }

    /// Creates an adaptive color from RGB tuples
    public static func adaptive(
        lightRGB: (red: Double, green: Double, blue: Double, opacity: Double),
        darkRGB: (red: Double, green: Double, blue: Double, opacity: Double)
    ) -> Color {
        let lightColor = Color(red: lightRGB.red, green: lightRGB.green, blue: lightRGB.blue, opacity: lightRGB.opacity)
        let darkColor = Color(red: darkRGB.red, green: darkRGB.green, blue: darkRGB.blue, opacity: darkRGB.opacity)
        return adaptive(light: lightColor, dark: darkColor)
    }
}
#endif
"""


def main():
    import argparse

    parser = argparse.ArgumentParser(description='Extract ELEVATE design tokens to Swift')
    parser.add_argument('--force', action='store_true', help='Force regeneration (ignore cache)')
    parser.add_argument('--theme', type=str, help='Custom theme overlay file')
    args = parser.parse_args()

    print("=== ELEVATE Design Token Extraction v4.0 ===")
    print(f"Source: {ELEVATE_TOKENS_PATH}")
    print(f"Output: {GENERATED_DIR}")
    print()

    # Validate paths
    if not ELEVATE_TOKENS_PATH.exists():
        print(f"❌ ERROR: ELEVATE tokens path does not exist: {ELEVATE_TOKENS_PATH}")
        return 1

    # Initialize cache manager
    cache_manager = TokenCacheManager(CACHE_FILE)

    # Parse light/dark mode tokens
    print("Parsing light mode tokens...")
    light_parser = SCSSUniversalParser(LIGHT_MODE_FILE)
    light_tokens = light_parser.extract_all_tokens()
    print(f"  Found {len(light_tokens)} ELEVATE tokens")

    print("Parsing dark mode tokens...")
    dark_parser = SCSSUniversalParser(DARK_MODE_FILE)
    dark_tokens = dark_parser.extract_all_tokens()
    print(f"  Found {len(dark_tokens)} ELEVATE tokens")

    # Merge iOS theme tokens
    print("\nMerging iOS theme tokens...")
    if THEME_EXTEND_FILE.exists() or THEME_OVERWRITE_FILE.exists() or THEME_OVERWRITE_DARK_FILE.exists():
        # Light mode: use extend.css + overwrite.css
        light_tokens = merge_theme_tokens(light_tokens, THEME_EXTEND_FILE, THEME_OVERWRITE_FILE)

        # Dark mode: use extend.css + overwrite-dark.css (or overwrite.css if overwrite-dark.css doesn't exist)
        dark_overwrite_file = THEME_OVERWRITE_DARK_FILE if THEME_OVERWRITE_DARK_FILE.exists() else THEME_OVERWRITE_FILE
        dark_tokens = merge_theme_tokens(dark_tokens, THEME_EXTEND_FILE, dark_overwrite_file)

        extend_count = 0
        if THEME_EXTEND_FILE.exists():
            extend_parser = SCSSUniversalParser(THEME_EXTEND_FILE)
            extend_count = len(extend_parser.extract_all_tokens())
            print(f"  + {extend_count} extend tokens from {THEME_EXTEND_FILE.name}")

        overwrite_count = 0
        if THEME_OVERWRITE_FILE.exists():
            overwrite_parser = SCSSUniversalParser(THEME_OVERWRITE_FILE)
            overwrite_count = len(overwrite_parser.extract_all_tokens())
            print(f"  + {overwrite_count} overwrite tokens from {THEME_OVERWRITE_FILE.name}")

        print(f"  Total: {len(light_tokens)} tokens (ELEVATE + iOS theme)")
    else:
        print(f"  No iOS theme files found - using 100% ELEVATE tokens")

    # Create output directory
    GENERATED_DIR.mkdir(exist_ok=True, parents=True)

    # Determine source files (ELEVATE + theme)
    base_source_files = [LIGHT_MODE_FILE, DARK_MODE_FILE]
    theme_source_files = []
    if THEME_EXTEND_FILE.exists():
        theme_source_files.append(THEME_EXTEND_FILE)
    if THEME_OVERWRITE_FILE.exists():
        theme_source_files.append(THEME_OVERWRITE_FILE)
    if THEME_OVERWRITE_DARK_FILE.exists():
        theme_source_files.append(THEME_OVERWRITE_DARK_FILE)
    all_source_files = base_source_files + theme_source_files

    # Generate Color.adaptive() extension
    adaptive_file = GENERATED_DIR / "ColorAdaptive.swift"

    if args.force or cache_manager.needs_regeneration(all_source_files, adaptive_file):
        print("\nGenerating Color.adaptive() extension...")
        with open(adaptive_file, 'w') as f:
            f.write(generate_color_adaptive_extension())
        print(f"  ✅ {adaptive_file.name}")
        cache_manager.update_cache(all_source_files, adaptive_file)
    else:
        print(f"  ⏭️  ColorAdaptive.swift (cached)")

    # Generate Primitives
    primitives_file = GENERATED_DIR / "ElevatePrimitives.swift"

    if args.force or cache_manager.needs_regeneration(all_source_files, primitives_file):
        print("\nExtracting Primitive tokens from ELEVATE SCSS...")
        primitives_gen = PrimitivesGenerator(light_tokens, dark_tokens)
        primitives_code = primitives_gen.generate()

        if primitives_code:
            with open(primitives_file, 'w') as f:
                f.write(primitives_code)
            print(f"  ✅ {primitives_file.name}")
            print(f"  📊 {len(primitives_code)} bytes")

            # Count primitive families
            primitive_count = len(primitives_gen._get_primitive_tokens())
            print(f"  📊 {primitive_count} primitive tokens")

            cache_manager.update_cache(all_source_files, primitives_file)
        else:
            print("  ⚠️  No primitive tokens found")
    else:
        print(f"  ⏭️  ElevatePrimitives.swift (cached)")

    # Generate Aliases
    aliases_file = GENERATED_DIR / "ElevateAliases.swift"

    if args.force or cache_manager.needs_regeneration(all_source_files, aliases_file):
        print("\nExtracting Alias tokens from ELEVATE SCSS...")
        aliases_gen = AliasesGenerator(light_tokens, dark_tokens)
        aliases_code = aliases_gen.generate()

        if aliases_code:
            with open(aliases_file, 'w') as f:
                f.write(aliases_code)
            print(f"  ✅ {aliases_file.name}")
            print(f"  📊 {len(aliases_code)} bytes")

            # Count aliases
            alias_count = len(aliases_gen._get_alias_tokens())
            print(f"  📊 {alias_count} alias tokens")

            cache_manager.update_cache(all_source_files, aliases_file)
        else:
            print("  ⚠️  No alias tokens found")
    else:
        print(f"  ⏭️  ElevateAliases.swift (cached)")

    # Generate component tokens
    print("\nScanning component token files...")
    component_files = list(COMPONENT_TOKENS_PATH.glob("_*.scss"))
    print(f"  Found {len(component_files)} component files")

    for component_file in component_files:
        component_name = component_file.stem.replace('_', '')  # Remove leading underscore
        output_file = GENERATED_DIR / f"{component_name.capitalize()}ComponentTokens.swift"

        # Check cache (include theme files so changes trigger regeneration)
        component_source_files = all_source_files + [component_file]
        if not args.force and not cache_manager.needs_regeneration(component_source_files, output_file):
            print(f"  ⏭️  {component_name} (cached)")
            continue

        print(f"\nGenerating {component_name} tokens...")
        generator = ComprehensiveComponentGenerator(
            light_tokens, dark_tokens, component_file, component_name
        )
        code = generator.generate()

        if code:
            with open(output_file, 'w') as f:
                f.write(code)
            print(f"  ✅ {output_file.name}")
            print(f"  📊 {len(code)} bytes")

            # Update cache
            cache_manager.update_cache(component_source_files, output_file)
        else:
            print(f"  ⚠️  No tokens found")

    print("\n✅ Token extraction complete!")
    print(f"\nGenerated files: {GENERATED_DIR}")

    # Show cache stats
    cache_hits = len([f for f in GENERATED_DIR.glob("*.swift")
                      if not cache_manager.needs_regeneration([LIGHT_MODE_FILE], f)])
    total_files = len(list(GENERATED_DIR.glob("*.swift")))
    print(f"Cache efficiency: {cache_hits}/{total_files} files cached")

    return 0


if __name__ == "__main__":
    sys.exit(main())
