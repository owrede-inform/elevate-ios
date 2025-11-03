import SwiftUI
import UIKit

/// ELEVATE Design System Color Tokens
///
/// This file defines the core color palette for the ELEVATE design system.
/// Colors are organized by semantic purpose and support both light and dark themes.
///
/// Based on ELEVATE Core UI design tokens from:
/// @inform-elevate/elevate-design-tokens
public struct ElevateColors {

    // MARK: - Brand Colors

    /// Primary brand color
    public static let primary = Color("Primary", bundle: .module)

    /// Secondary brand color
    public static let secondary = Color("Secondary", bundle: .module)

    // MARK: - Semantic Colors

    /// Success state color (positive actions, confirmations)
    public static let success = Color("Success", bundle: .module)

    /// Warning state color (cautions, important notices)
    public static let warning = Color("Warning", bundle: .module)

    /// Danger state color (errors, destructive actions)
    public static let danger = Color("Danger", bundle: .module)

    /// Informational color
    public static let info = Color("Info", bundle: .module)

    // MARK: - Neutral Colors

    /// Neutral background colors
    public enum Background {
        public static let primary = Color("Background/Primary", bundle: .module)
        public static let secondary = Color("Background/Secondary", bundle: .module)
        public static let tertiary = Color("Background/Tertiary", bundle: .module)
    }

    /// Neutral surface colors (for cards, panels, etc.)
    public enum Surface {
        public static let primary = Color("Surface/Primary", bundle: .module)
        public static let secondary = Color("Surface/Secondary", bundle: .module)
        public static let elevated = Color("Surface/Elevated", bundle: .module)
    }

    /// Text colors
    public enum Text {
        public static let primary = Color("Text/Primary", bundle: .module)
        public static let secondary = Color("Text/Secondary", bundle: .module)
        public static let tertiary = Color("Text/Tertiary", bundle: .module)
        public static let inverse = Color("Text/Inverse", bundle: .module)
        public static let disabled = Color("Text/Disabled", bundle: .module)
    }

    /// Border colors
    public enum Border {
        public static let `default` = Color("Border/Default", bundle: .module)
        public static let subtle = Color("Border/Subtle", bundle: .module)
        public static let strong = Color("Border/Strong", bundle: .module)
    }

    // MARK: - Component-Specific Colors

    /// Button colors for different tones
    public enum Button {

        public enum Primary {
            public static let background = Color("Button/Primary/Background", bundle: .module)
            public static let backgroundHover = Color("Button/Primary/BackgroundHover", bundle: .module)
            public static let backgroundActive = Color("Button/Primary/BackgroundActive", bundle: .module)
            public static let backgroundDisabled = Color("Button/Primary/BackgroundDisabled", bundle: .module)
            public static let text = Color("Button/Primary/Text", bundle: .module)
            public static let textDisabled = Color("Button/Primary/TextDisabled", bundle: .module)
            public static let border = Color("Button/Primary/Border", bundle: .module)
        }

        public enum Secondary {
            public static let background = Color("Button/Secondary/Background", bundle: .module)
            public static let backgroundHover = Color("Button/Secondary/BackgroundHover", bundle: .module)
            public static let backgroundActive = Color("Button/Secondary/BackgroundActive", bundle: .module)
            public static let backgroundDisabled = Color("Button/Secondary/BackgroundDisabled", bundle: .module)
            public static let text = Color("Button/Secondary/Text", bundle: .module)
            public static let textDisabled = Color("Button/Secondary/TextDisabled", bundle: .module)
            public static let border = Color("Button/Secondary/Border", bundle: .module)
        }

        public enum Success {
            public static let background = Color("Button/Success/Background", bundle: .module)
            public static let backgroundHover = Color("Button/Success/BackgroundHover", bundle: .module)
            public static let backgroundActive = Color("Button/Success/BackgroundActive", bundle: .module)
            public static let backgroundDisabled = Color("Button/Success/BackgroundDisabled", bundle: .module)
            public static let text = Color("Button/Success/Text", bundle: .module)
            public static let textDisabled = Color("Button/Success/TextDisabled", bundle: .module)
            public static let border = Color("Button/Success/Border", bundle: .module)
        }

        public enum Warning {
            public static let background = Color("Button/Warning/Background", bundle: .module)
            public static let backgroundHover = Color("Button/Warning/BackgroundHover", bundle: .module)
            public static let backgroundActive = Color("Button/Warning/BackgroundActive", bundle: .module)
            public static let backgroundDisabled = Color("Button/Warning/BackgroundDisabled", bundle: .module)
            public static let text = Color("Button/Warning/Text", bundle: .module)
            public static let textDisabled = Color("Button/Warning/TextDisabled", bundle: .module)
            public static let border = Color("Button/Warning/Border", bundle: .module)
        }

        public enum Danger {
            public static let background = Color("Button/Danger/Background", bundle: .module)
            public static let backgroundHover = Color("Button/Danger/BackgroundHover", bundle: .module)
            public static let backgroundActive = Color("Button/Danger/BackgroundActive", bundle: .module)
            public static let backgroundDisabled = Color("Button/Danger/BackgroundDisabled", bundle: .module)
            public static let text = Color("Button/Danger/Text", bundle: .module)
            public static let textDisabled = Color("Button/Danger/TextDisabled", bundle: .module)
            public static let border = Color("Button/Danger/Border", bundle: .module)
        }
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
