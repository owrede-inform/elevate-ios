import Foundation
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
    public static let primary = Color(red: 0.0431, green: 0.3608, blue: 0.8745)

    /// Secondary brand color
    public static let secondary = Color(red: 0.8353, green: 0.8510, blue: 0.8824)

    // MARK: - Semantic Colors

    /// Success state color
    public static let success = Color(red: 0.0196, green: 0.4627, blue: 0.2392)

    /// Warning state color
    public static let warning = Color(red: 0.9725, green: 0.5608, blue: 0.0000)

    /// Danger state color
    public static let danger = Color(red: 0.8078, green: 0.0039, blue: 0.0039)

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

    // MARK: - Flattened Convenience Access
    // Provides easy autocomplete-friendly access to common colors
    // while maintaining the organized nested structure above

    // Background colors (flattened)
    public static let backgroundPrimary = Background.primary
    public static let backgroundSecondary = Background.secondary
    public static let backgroundTertiary = Background.tertiary

    // Surface colors (flattened)
    public static let surfacePrimary = Surface.primary
    public static let surfaceSecondary = Surface.secondary
    public static let surfaceElevated = Surface.elevated

    // Text colors (flattened)
    public static let textPrimary = Text.primary
    public static let textSecondary = Text.secondary
    public static let textTertiary = Text.tertiary
    public static let textInverse = Text.inverse
    public static let textDisabled = Text.disabled

    // Border colors (flattened)
    public static let borderDefault = Border.default
    public static let borderSubtle = Border.subtle
    public static let borderStrong = Border.strong
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
