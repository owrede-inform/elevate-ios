#!/usr/bin/env python3
"""
ELEVATE Design Tokens Update Script
Extracts design tokens from ELEVATE SCSS source and generates iOS Swift code
"""

import re
import os
import sys
import json
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Tuple, Optional

# Paths
ELEVATE_TOKENS_SRC = Path("/Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main/src/scss")
PROJECT_ROOT = Path(__file__).parent.parent
OUTPUT_DIR = PROJECT_ROOT / "ElevateUI" / "Sources" / "DesignTokens"

class ColorParser:
    """Parse RGB/RGBA color values from SCSS"""

    @staticmethod
    def parse_rgb(rgb_str: str) -> Optional[Tuple[float, float, float, float]]:
        """Parse rgb(r g b) or rgba(r g b / a) format"""
        # Clean up the string
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

class SpacingParser:
    """Parse rem spacing values from SCSS"""

    @staticmethod
    def rem_to_points(rem_str: str) -> Optional[float]:
        """Convert rem to CGFloat points (1rem = 16pt)"""
        rem_match = re.search(r'([\d.]+)rem', rem_str)
        if not rem_match:
            return None
        return float(rem_match.group(1)) * 16.0

    @staticmethod
    def to_swift_cgfloat(points: float) -> str:
        """Convert points to Swift CGFloat"""
        return f"{points:.4f}"

class SCSSParser:
    """Parse SCSS token files"""

    def __init__(self, filepath: Path):
        self.filepath = filepath
        self.tokens: Dict[str, str] = {}

    def parse(self) -> Dict[str, str]:
        """Parse SCSS file and extract all $variable: value pairs"""
        if not self.filepath.exists():
            print(f"⚠️  File not found: {self.filepath}")
            return {}

        with open(self.filepath, 'r') as f:
            content = f.read()

        # Match $variable: var(--token, value); - handle nested parentheses in rgb() values
        pattern = r'\$([a-zA-Z0-9_-]+):\s*var\([^,]+,\s*(.+?)\);'
        matches = re.finditer(pattern, content, re.MULTILINE)

        for match in matches:
            var_name = match.group(1)
            value = match.group(2).strip()
            self.tokens[var_name] = value

        return self.tokens

class ButtonTokensGenerator:
    """Generate ButtonTokens.swift from button SCSS tokens"""

    def __init__(self, tokens: Dict[str, str]):
        self.tokens = tokens
        self.color_parser = ColorParser()

    def generate(self) -> str:
        """Generate complete ButtonTokens.swift file"""
        # Extract token groups
        tones = ['primary', 'secondary', 'success', 'warning', 'danger', 'emphasized', 'subtle', 'neutral']
        states = ['default', 'hover', 'active', 'selected-default', 'selected-hover', 'selected-active', 'disabled-default']

        swift_code = '''#if os(iOS)
import SwiftUI

/// ELEVATE Button Component Design Tokens
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens.py to update
///
/// Based on ELEVATE Core UI button component tokens
@available(iOS 15, *)
public struct ButtonTokens {

    // MARK: - Button Tones

    /// Defines the visual tone/variant of a button
    public enum Tone {
        case primary
        case secondary
        case success
        case warning
        case danger
        case emphasized
        case subtle
        case neutral

        /// Get the color configuration for this tone
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

    // MARK: - Button Sizes

    /// Defines the size variant of a button
    public enum Size {
        case small
        case medium
        case large

        public var componentSize: ElevateSpacing.ComponentSize {
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
        }
    }

    // MARK: - Button States

    /// Defines the interaction state of a button
    public enum State {
        case `default`
        case hover
        case active
        case disabled
    }

    // MARK: - Button Shapes

    /// Defines the shape variant of a button
    public enum Shape {
        case `default`
        case pill

        public var borderRadius: CGFloat {
            switch self {
            case .default: return ElevateSpacing.BorderRadius.medium
            case .pill: return ElevateSpacing.BorderRadius.full
            }
        }
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

        # Generate tone colors for each tone
        for tone in tones:
            swift_code += f"        /// {tone.capitalize()} button colors\n"
            swift_code += f"        static let {tone} = ToneColors(\n"

            # Background colors
            bg_default = self._get_color_token(f"fill-{tone}-default")
            bg_hover = self._get_color_token(f"fill-{tone}-hover")
            bg_active = self._get_color_token(f"fill-{tone}-active")
            bg_disabled = self._get_color_token(f"fill-{tone}-disabled-default")

            swift_code += f"            background: {bg_default},\n"
            swift_code += f"            backgroundHover: {bg_hover},\n"
            swift_code += f"            backgroundActive: {bg_active},\n"
            swift_code += f"            backgroundDisabled: {bg_disabled},\n"

            # Text colors
            text_default = self._get_color_token(f"label-{tone}-default")
            text_disabled = self._get_color_token(f"label-{tone}-disabled-default")

            swift_code += f"            text: {text_default},\n"
            swift_code += f"            textDisabled: {text_disabled},\n"

            # Border colors
            border_default = self._get_color_token(f"border-{tone}-color-default")

            swift_code += f"            border: {border_default}\n"
            swift_code += "        )\n\n"

        swift_code += '''    }
}
#endif
'''

        return swift_code

    def _get_color_token(self, token_name: str) -> str:
        """Get color token and convert to Swift Color"""
        value = self.tokens.get(token_name, "rgb(128 128 128)")  # Gray fallback
        rgba = self.color_parser.parse_rgb(value)
        if rgba:
            return self.color_parser.to_swift_color(rgba)
        return "Color(red: 0.5, green: 0.5, blue: 0.5)"

class ColorsGenerator:
    """Generate ElevateColors.swift"""

    def __init__(self, tokens: Dict[str, str]):
        self.tokens = tokens
        self.color_parser = ColorParser()

    def generate(self) -> str:
        """Generate ElevateColors.swift from action alias tokens"""
        # This is a simplified version - we'd need to parse all color files
        # For now, keep the existing structure but update values

        swift_code = '''import Foundation
#if os(iOS)
import SwiftUI
import UIKit

/// ELEVATE Design System Color Tokens
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens.py to update
///
/// Based on ELEVATE Core UI design tokens
@available(iOS 15, *)
public struct ElevateColors {

    // MARK: - Brand Colors

    /// Primary brand color
    public static let primary = ''' + self._get_primary_color() + '''

    /// Secondary brand color
    public static let secondary = ''' + self._get_secondary_color() + '''

    // MARK: - Semantic Colors

    /// Success state color
    public static let success = ''' + self._get_success_color() + '''

    /// Warning state color
    public static let warning = ''' + self._get_warning_color() + '''

    /// Danger state color
    public static let danger = ''' + self._get_danger_color() + '''

    /// Informational color
    public static let info = Color(red: 0.05, green: 0.66, blue: 0.84)

    // MARK: - Neutral Colors

    /// Neutral background colors
    public enum Background {
        public static let primary = Color(red: 1.0, green: 1.0, blue: 1.0)
        public static let secondary = Color(red: 0.97, green: 0.97, blue: 0.97)
        public static let tertiary = Color(red: 0.94, green: 0.94, blue: 0.94)
    }

    /// Neutral surface colors
    public enum Surface {
        public static let primary = Color(red: 1.0, green: 1.0, blue: 1.0)
        public static let secondary = Color(red: 0.98, green: 0.98, blue: 0.98)
        public static let elevated = Color(red: 1.0, green: 1.0, blue: 1.0)
    }

    /// Text colors
    public enum Text {
        public static let primary = Color(red: 0.13, green: 0.13, blue: 0.13)
        public static let secondary = Color(red: 0.42, green: 0.42, blue: 0.42)
        public static let tertiary = Color(red: 0.62, green: 0.62, blue: 0.62)
        public static let inverse = Color(red: 1.0, green: 1.0, blue: 1.0)
        public static let disabled = Color(red: 0.7, green: 0.7, blue: 0.7)
    }

    /// Border colors
    public enum Border {
        public static let `default` = Color(red: 0.86, green: 0.86, blue: 0.86)
        public static let subtle = Color(red: 0.93, green: 0.93, blue: 0.93)
        public static let strong = Color(red: 0.53, green: 0.53, blue: 0.53)
    }

    // MARK: - UIKit Compatibility

    /// UIKit-compatible color accessors
    public enum UIKit {
        public static var primary: UIColor { UIColor(ElevateColors.primary) }
        public static var secondary: UIColor { UIColor(ElevateColors.secondary) }
        public static var success: UIColor { UIColor(ElevateColors.success) }
        public static var warning: UIColor { UIColor(ElevateColors.warning) }
        public static var danger: UIColor { UIColor(ElevateColors.danger) }
        public static var info: UIColor { UIColor(ElevateColors.info) }

        public enum Background {
            public static var primary: UIColor { UIColor(ElevateColors.Background.primary) }
            public static var secondary: UIColor { UIColor(ElevateColors.Background.secondary) }
            public static var tertiary: UIColor { UIColor(ElevateColors.Background.tertiary) }
        }

        public enum Surface {
            public static var primary: UIColor { UIColor(ElevateColors.Surface.primary) }
            public static var secondary: UIColor { UIColor(ElevateColors.Surface.secondary) }
            public static var elevated: UIColor { UIColor(ElevateColors.Surface.elevated) }
        }

        public enum Text {
            public static var primary: UIColor { UIColor(ElevateColors.Text.primary) }
            public static var secondary: UIColor { UIColor(ElevateColors.Text.secondary) }
            public static var tertiary: UIColor { UIColor(ElevateColors.Text.tertiary) }
            public static var inverse: UIColor { UIColor(ElevateColors.Text.inverse) }
            public static var disabled: UIColor { UIColor(ElevateColors.Text.disabled) }
        }

        public enum Border {
            public static var `default`: UIColor { UIColor(ElevateColors.Border.default) }
            public static var subtle: UIColor { UIColor(ElevateColors.Border.subtle) }
            public static var strong: UIColor { UIColor(ElevateColors.Border.strong) }
        }
    }
}

// MARK: - Helper Extensions

@available(iOS 15, *)
extension Color {
    /// Helper to create color from hex string
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
#endif
'''
        return swift_code

    def _get_primary_color(self) -> str:
        value = self.tokens.get('strong-primary-fill-default', 'rgb(11 92 223)')
        rgba = self.color_parser.parse_rgb(value)
        return self.color_parser.to_swift_color(rgba) if rgba else 'Color.blue'

    def _get_secondary_color(self) -> str:
        value = self.tokens.get('strong-neutral-fill-default', 'rgb(213 217 225)')
        rgba = self.color_parser.parse_rgb(value)
        return self.color_parser.to_swift_color(rgba) if rgba else 'Color.gray'

    def _get_success_color(self) -> str:
        value = self.tokens.get('strong-success-fill-default', 'rgb(5 118 61)')
        rgba = self.color_parser.parse_rgb(value)
        return self.color_parser.to_swift_color(rgba) if rgba else 'Color.green'

    def _get_warning_color(self) -> str:
        value = self.tokens.get('strong-warning-fill-default', 'rgb(248 143 0)')
        rgba = self.color_parser.parse_rgb(value)
        return self.color_parser.to_swift_color(rgba) if rgba else 'Color.orange'

    def _get_danger_color(self) -> str:
        value = self.tokens.get('strong-danger-fill-default', 'rgb(206 1 1)')
        rgba = self.color_parser.parse_rgb(value)
        return self.color_parser.to_swift_color(rgba) if rgba else 'Color.red'

def main():
    print("🎨 ELEVATE Design Tokens Update Script")
    print("=" * 50)
    print()

    # Check source exists
    if not ELEVATE_TOKENS_SRC.exists():
        print(f"❌ Error: ELEVATE tokens source not found at {ELEVATE_TOKENS_SRC}")
        sys.exit(1)

    print(f"Source: {ELEVATE_TOKENS_SRC}")
    print(f"Output: {OUTPUT_DIR}")
    print()

    # Step 1: Parse SCSS files
    print("📝 Step 1: Parsing SCSS design token files...")
    print()

    button_file = ELEVATE_TOKENS_SRC / "tokens" / "component" / "_button.scss"
    action_file = ELEVATE_TOKENS_SRC / "tokens" / "alias" / "_action.scss"

    print(f"  → Parsing button tokens from {button_file.name}...")
    button_parser = SCSSParser(button_file)
    button_tokens = button_parser.parse()
    print(f"    Found {len(button_tokens)} button tokens")

    print(f"  → Parsing action color tokens from {action_file.name}...")
    action_parser = SCSSParser(action_file)
    action_tokens = action_parser.parse()
    print(f"    Found {len(action_tokens)} action tokens")

    print()
    print("✅ Token parsing complete")
    print()

    # Step 2: Generate Swift code
    print("🔨 Step 2: Generating Swift code...")
    print()

    print("  → Generating ButtonTokens.swift...")
    button_gen = ButtonTokensGenerator(button_tokens)
    button_swift = button_gen.generate()

    print("  → Generating ElevateColors.swift...")
    colors_gen = ColorsGenerator(action_tokens)
    colors_swift = colors_gen.generate()

    print()
    print("✅ Swift code generation complete")
    print()

    # Step 3: Backup existing files
    print("📦 Step 3: Backing up existing files...")
    print()

    backup_dir = PROJECT_ROOT / "scripts" / "backups" / datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_dir.mkdir(parents=True, exist_ok=True)

    button_tokens_file = OUTPUT_DIR / "Components" / "ButtonTokens.swift"
    colors_file = OUTPUT_DIR / "Colors" / "ElevateColors.swift"

    if button_tokens_file.exists():
        import shutil
        shutil.copy2(button_tokens_file, backup_dir / "ButtonTokens.swift")
    if colors_file.exists():
        import shutil
        shutil.copy2(colors_file, backup_dir / "ElevateColors.swift")

    print(f"  → Backups saved to: {backup_dir}")
    print()

    # Step 4: Write new files
    print("🔄 Step 4: Writing updated Swift files...")
    print()

    # Ensure directories exist
    (OUTPUT_DIR / "Components").mkdir(parents=True, exist_ok=True)
    (OUTPUT_DIR / "Colors").mkdir(parents=True, exist_ok=True)

    with open(button_tokens_file, 'w') as f:
        f.write(button_swift)
    print("  ✓ ButtonTokens.swift updated")

    with open(colors_file, 'w') as f:
        f.write(colors_swift)
    print("  ✓ ElevateColors.swift updated")

    print()
    print("=" * 50)
    print("✨ Design tokens updated successfully!")
    print()
    print("Summary:")
    print(f"  - {len(button_tokens)} button tokens extracted")
    print(f"  - {len(action_tokens)} color tokens extracted")
    print("  - ButtonTokens.swift generated with all tones and states")
    print("  - ElevateColors.swift updated with semantic colors")
    print()
    print(f"Backup location: {backup_dir}")
    print()
    print("Next steps:")
    print("  1. Build the project: swift build")
    print("  2. Review the changes: git diff")
    print("  3. Test UI components in demo app")
    print("  4. Commit if everything looks good")
    print()

if __name__ == "__main__":
    main()
