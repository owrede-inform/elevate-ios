#!/usr/bin/env python3
"""
Typography Token Generator
===========================

Auto-generates ElevateTypography.swift from iOS primitives CSS file.
This ensures typography values are always in sync with the design token source of truth.

Usage:
    python3 scripts/generate-typography-tokens.py

Source:
    .elevate-themes/ios/primitives.css

Output:
    ElevateUI/Sources/DesignTokens/Typography/ElevateTypography.swift
"""

import re
from pathlib import Path
from typing import Dict, Optional

# Paths
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
PRIMITIVES_CSS = PROJECT_ROOT / ".elevate-themes" / "ios" / "primitives.css"
OUTPUT_FILE = PROJECT_ROOT / "ElevateUI" / "Sources" / "DesignTokens" / "Typography" / "ElevateTypography.swift"


class TypographyTokenParser:
    """Parses typography tokens from iOS primitives CSS"""

    def __init__(self, css_file: Path):
        self.css_file = css_file
        with open(css_file, 'r') as f:
            self.content = f.read()

    def extract_scale_factor(self) -> float:
        """Extract the $ios-typography-scale value"""
        pattern = r'\$ios-typography-scale:\s*([0-9.]+);'
        match = re.search(pattern, self.content)
        if match:
            return float(match.group(1))
        return 1.25  # Default fallback

    def extract_typography_tokens(self) -> Dict[str, float]:
        """Extract all $elvt-typography-* tokens"""
        tokens = {}
        pattern = r'\$elvt-typography-([a-z-]+):\s*([0-9.]+)px;'

        for match in re.finditer(pattern, self.content):
            token_name = match.group(1)  # e.g., "display-large"
            value_px = float(match.group(2))
            tokens[token_name] = value_px

        return tokens

    def calculate_web_values(self, ios_tokens: Dict[str, float], scale: float) -> Dict[str, float]:
        """Calculate original web values by dividing iOS values by scale factor"""
        web_tokens = {}
        for name, ios_value in ios_tokens.items():
            web_value = ios_value / scale
            web_tokens[name] = web_value
        return web_tokens


class SwiftTypographyGenerator:
    """Generates Swift typography file from parsed tokens"""

    def __init__(self, ios_tokens: Dict[str, float], web_tokens: Dict[str, float], scale_factor: float):
        self.ios_tokens = ios_tokens
        self.web_tokens = web_tokens
        self.scale_factor = scale_factor

    def token_to_swift_name(self, token_name: str) -> str:
        """Convert token name to Swift camelCase"""
        # display-large → displayLarge
        # heading-xsmall → headingXSmall (X capitalized, Small capitalized)
        parts = token_name.split('-')
        result = parts[0]
        for p in parts[1:]:
            # Special case: xsmall → XSmall (both letters capitalized)
            if p == 'xsmall':
                result += 'XSmall'
            else:
                # Normal camelCase: capitalize first letter
                result += p.capitalize()
        return result

    def generate_size_enum(self, category: str, tokens: Dict[str, float]) -> str:
        """Generate a size enum for a category (Display, Heading, etc.)"""
        lines = []
        for token_name in sorted(tokens.keys()):
            if token_name.startswith(category.lower()):
                swift_name = self.token_to_swift_name(token_name)
                value = tokens[token_name]
                lines.append(f"        public static let {swift_name}: CGFloat = {value:.1f}")
        return '\n'.join(lines)

    def generate_web_sizes_enum(self) -> str:
        """Generate the WebSizes enum with comments"""
        categories = {
            'Display': ['display-large', 'display-medium', 'display-small'],
            'Headings': ['heading-large', 'heading-medium', 'heading-small', 'heading-xsmall'],
            'Titles': ['title-large', 'title-medium', 'title-small'],
            'Body': ['body-large', 'body-medium', 'body-small'],
            'Labels': ['label-large', 'label-medium', 'label-small', 'label-xsmall'],
            'Monospace': ['code', 'code-small']
        }

        lines = [
            "    // MARK: - Base Sizes (ELEVATE Core UI Web Defaults)",
            "",
            "    /// Typography base sizes from ELEVATE design tokens (web/desktop)",
            "    /// These represent the original ELEVATE Core UI sizes before iOS scaling",
            f"    /// iOS sizes are calculated by applying iosScaleFactor ({self.scale_factor}×)",
            "    ///",
            "    /// **AUTO-GENERATED** from `.elevate-themes/ios/primitives.css`",
            "    /// Do NOT edit manually - run `scripts/generate-typography-tokens.py`",
            "    public enum WebSizes {"
        ]

        for category, token_names in categories.items():
            if any(name in self.web_tokens for name in token_names):
                lines.append(f"        // {category}")
                for token_name in token_names:
                    if token_name in self.web_tokens:
                        swift_name = self.token_to_swift_name(token_name)
                        web_value = self.web_tokens[token_name]
                        ios_value = self.ios_tokens.get(token_name, web_value * self.scale_factor)
                        lines.append(f"        public static let {swift_name}: CGFloat = {web_value:.1f}  // iOS: {ios_value:.2f}pt")
                lines.append("")

        lines.append("    }")
        return '\n'.join(lines)

    def generate_swift_file(self) -> str:
        """Generate complete Swift file"""
        return f'''import SwiftUI

/// ELEVATE Typography Design Tokens
///
/// **AUTO-GENERATED** from `.elevate-themes/ios/primitives.css`
///
/// This file is automatically generated by `scripts/generate-typography-tokens.py`
/// to ensure typography values stay in sync with ELEVATE design tokens.
///
/// DO NOT EDIT THIS FILE MANUALLY - your changes will be overwritten!
///
/// To update typography:
/// 1. Edit `.elevate-themes/ios/primitives.css` (the source of truth)
/// 2. Run: `python3 scripts/generate-typography-tokens.py`
/// 3. Rebuild the ElevateUI package
///
/// Token Cascade:
/// - Layer 1: ELEVATE Core UI (WebSizes below - {self.scale_factor:.2f}x smaller)
/// - Layer 2: iOS Adaptation (WebSizes × iosScaleFactor = iOS optimized)
/// - Layer 3: Components (Use Sizes enum, which can be themed)
@available(iOS 15, macOS 12, *)
public struct ElevateTypography {{

{self.generate_web_sizes_enum()}

    // MARK: - Themeable Sizes

    /// Themeable typography sizes that can be overridden by custom themes.
    /// Defaults to WebSizes but can be changed for theme customization.
    ///
    /// Example theme override:
    /// ```swift
    /// ElevateTypography.Sizes.displayLarge = 60  // Custom theme
    /// ```
    public enum Sizes {{
        // Display
        public static var displayLarge: CGFloat = WebSizes.displayLarge
        public static var displayMedium: CGFloat = WebSizes.displayMedium
        public static var displaySmall: CGFloat = WebSizes.displaySmall

        // Headings
        public static var headingLarge: CGFloat = WebSizes.headingLarge
        public static var headingMedium: CGFloat = WebSizes.headingMedium
        public static var headingSmall: CGFloat = WebSizes.headingSmall
        public static var headingXSmall: CGFloat = WebSizes.headingXSmall

        // Titles
        public static var titleLarge: CGFloat = WebSizes.titleLarge
        public static var titleMedium: CGFloat = WebSizes.titleMedium
        public static var titleSmall: CGFloat = WebSizes.titleSmall

        // Body
        public static var bodyLarge: CGFloat = WebSizes.bodyLarge
        public static var bodyMedium: CGFloat = WebSizes.bodyMedium
        public static var bodySmall: CGFloat = WebSizes.bodySmall

        // Labels
        public static var labelLarge: CGFloat = WebSizes.labelLarge
        public static var labelMedium: CGFloat = WebSizes.labelMedium
        public static var labelSmall: CGFloat = WebSizes.labelSmall
        public static var labelXSmall: CGFloat = WebSizes.labelXSmall

        // Monospace
        public static var code: CGFloat = WebSizes.code
        public static var codeSmall: CGFloat = WebSizes.codeSmall
    }}

    // MARK: - Font Family

    /// Primary font family for ELEVATE typography
    public static let fontFamilyPrimary = "Inter"

    /// Monospace font family for code
    public static let fontFamilyMono = "RobotoMono"

    // MARK: - Font Weights

    public enum FontWeight {{
        public static let regular: Font.Weight = .regular
        public static let medium: Font.Weight = .medium
        public static let semibold: Font.Weight = .semibold
        public static let bold: Font.Weight = .bold
    }}

    // MARK: - Typography Styles (Web/Desktop)

    // Display
    public static let displayLarge = Font.custom(fontFamilyPrimary, size: Sizes.displayLarge)
    public static let displayMedium = Font.custom(fontFamilyPrimary, size: Sizes.displayMedium)
    public static let displaySmall = Font.custom(fontFamilyPrimary, size: Sizes.displaySmall)

    // Headings
    public static let headingLarge = Font.custom(fontFamilyPrimary, size: Sizes.headingLarge).weight(.bold)
    public static let headingMedium = Font.custom(fontFamilyPrimary, size: Sizes.headingMedium).weight(.bold)
    public static let headingSmall = Font.custom(fontFamilyPrimary, size: Sizes.headingSmall).weight(.semibold)
    public static let headingXSmall = Font.custom(fontFamilyPrimary, size: Sizes.headingXSmall).weight(.semibold)

    // Titles
    public static let titleLarge = Font.custom(fontFamilyPrimary, size: Sizes.titleLarge).weight(.semibold)
    public static let titleMedium = Font.custom(fontFamilyPrimary, size: Sizes.titleMedium).weight(.medium)
    public static let titleSmall = Font.custom(fontFamilyPrimary, size: Sizes.titleSmall).weight(.medium)

    // Body
    public static let bodyLarge = Font.custom(fontFamilyPrimary, size: Sizes.bodyLarge)
    public static let bodyMedium = Font.custom(fontFamilyPrimary, size: Sizes.bodyMedium)
    public static let bodySmall = Font.custom(fontFamilyPrimary, size: Sizes.bodySmall)

    // Labels
    public static let labelLarge = Font.custom(fontFamilyPrimary, size: Sizes.labelLarge).weight(.medium)
    public static let labelMedium = Font.custom(fontFamilyPrimary, size: Sizes.labelMedium).weight(.medium)
    public static let labelSmall = Font.custom(fontFamilyPrimary, size: Sizes.labelSmall).weight(.medium)
    public static let labelXSmall = Font.custom(fontFamilyPrimary, size: Sizes.labelXSmall).weight(.medium)

    // Monospace
    public static let code = Font.custom(fontFamilyMono, size: Sizes.code)
    public static let codeSmall = Font.custom(fontFamilyMono, size: Sizes.codeSmall)
}}
'''


def main():
    """Main generation function"""
    print("📝 Typography Token Generator")
    print("=" * 50)

    # Parse CSS tokens
    print(f"\n1. Parsing iOS primitives: {PRIMITIVES_CSS}")
    parser = TypographyTokenParser(PRIMITIVES_CSS)

    scale_factor = parser.extract_scale_factor()
    print(f"   ✓ iOS scale factor: {scale_factor}×")

    ios_tokens = parser.extract_typography_tokens()
    print(f"   ✓ Found {len(ios_tokens)} typography tokens")

    # Calculate web values
    web_tokens = parser.calculate_web_values(ios_tokens, scale_factor)

    # Generate Swift code
    print(f"\n2. Generating Swift file: {OUTPUT_FILE}")
    generator = SwiftTypographyGenerator(ios_tokens, web_tokens, scale_factor)
    swift_code = generator.generate_swift_file()

    # Write output
    OUTPUT_FILE.parent.mkdir(parents=True, exist_ok=True)
    with open(OUTPUT_FILE, 'w') as f:
        f.write(swift_code)

    print(f"   ✓ Generated {len(swift_code.splitlines())} lines")
    print(f"\n✅ Typography tokens generated successfully!")
    print(f"\n💡 Next steps:")
    print(f"   1. Review generated file: {OUTPUT_FILE}")
    print(f"   2. Run: swift build")
    print(f"   3. Verify all components compile")


if __name__ == "__main__":
    main()
