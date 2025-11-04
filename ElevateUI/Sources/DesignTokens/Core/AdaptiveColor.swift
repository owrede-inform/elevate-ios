#if os(iOS)
import SwiftUI
import UIKit

/// Native SwiftUI Color extensions for automatic light/dark mode adaptation
///
/// Replaces the custom DynamicColor system with native UIColor dynamic providers,
/// allowing colors to automatically adapt to system appearance changes without
/// manual @Environment(\.colorScheme) resolution.
///
/// Example usage:
/// ```swift
/// let primaryColor = Color.adaptive(
///     lightRGB: (red: 0.04, green: 0.36, blue: 0.87, opacity: 1.0),
///     darkRGB: (red: 0.30, green: 0.54, blue: 0.95, opacity: 1.0)
/// )
/// ```
@available(iOS 15, *)
public extension Color {

    /// Create an adaptive color from RGB values that automatically responds to light/dark mode
    ///
    /// Uses UIColor's dynamic provider to create colors that adapt based on the current
    /// user interface style. The system automatically re-evaluates colors when appearance
    /// changes, with no manual resolution required.
    ///
    /// - Parameters:
    ///   - lightRGB: RGB components for light mode (red, green, blue, opacity in 0-1 range)
    ///   - darkRGB: RGB components for dark mode (red, green, blue, opacity in 0-1 range)
    /// - Returns: A Color that automatically adapts to system appearance
    static func adaptive(
        lightRGB: (red: Double, green: Double, blue: Double, opacity: Double),
        darkRGB: (red: Double, green: Double, blue: Double, opacity: Double)
    ) -> Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(
                    red: darkRGB.red,
                    green: darkRGB.green,
                    blue: darkRGB.blue,
                    alpha: darkRGB.opacity
                )
            default: // .light, .unspecified
                return UIColor(
                    red: lightRGB.red,
                    green: lightRGB.green,
                    blue: lightRGB.blue,
                    alpha: lightRGB.opacity
                )
            }
        })
    }

    /// Create an adaptive color by composing other adaptive colors
    ///
    /// Used when design tokens reference other tokens (e.g., aliases referencing primitives).
    /// Extracts the underlying UIColor dynamic providers and composes them into a new
    /// adaptive color.
    ///
    /// - Parameters:
    ///   - light: Color to use in light mode (can be another adaptive color)
    ///   - dark: Color to use in dark mode (can be another adaptive color)
    /// - Returns: A Color that automatically adapts to system appearance
    static func adaptive(light: Color, dark: Color) -> Color {
        Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default: // .light, .unspecified
                return UIColor(light)
            }
        })
    }
}

#endif
