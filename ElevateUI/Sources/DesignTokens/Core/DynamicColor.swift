#if os(iOS)
import SwiftUI

/// A color that automatically adapts to light and dark color schemes
///
/// **DEPRECATED:** This system has been replaced with native SwiftUI Color.adaptive()
/// which uses UIColor dynamic providers for automatic light/dark adaptation.
/// See AdaptiveColor.swift for the new implementation.
///
/// This wrapper enables proper theming support by holding separate values
/// for light and dark modes, switching automatically based on the environment.
///
/// Example usage:
/// ```swift
/// let primaryBackground = DynamicColor(
///     light: ElevatePrimitives.Blue._600,
///     dark: ElevatePrimitives.Blue._500
/// )
/// ```
@available(iOS, deprecated: 15.0, message: "Use Color.adaptive() instead. This custom DynamicColor system is no longer needed as colors now use native UIColor dynamic providers.")
@available(iOS 15, *)
public struct DynamicColor {

    // MARK: - Properties

    private let lightColor: Color
    private let darkColor: Color

    // MARK: - Initialization

    /// Create a dynamic color with separate light and dark mode values
    /// - Parameters:
    ///   - light: Color for light mode
    ///   - dark: Color for dark mode
    public init(light: Color, dark: Color) {
        self.lightColor = light
        self.darkColor = dark
    }

    /// Create a dynamic color from a single color (same in both modes)
    /// - Parameter color: Color to use in both light and dark modes
    public init(_ color: Color) {
        self.lightColor = color
        self.darkColor = color
    }

    /// Create a dynamic color by referencing other dynamic colors
    /// - Parameters:
    ///   - light: DynamicColor to use for light mode (extracts light color)
    ///   - dark: DynamicColor to use for dark mode (extracts dark color)
    ///
    /// This initializer is used when composing design tokens, allowing aliases
    /// to reference primitives which are already DynamicColors.
    public init(light: DynamicColor, dark: DynamicColor) {
        self.lightColor = light.lightColor
        self.darkColor = dark.darkColor
    }

    // MARK: - Color Access

    /// Get the appropriate color for the current color scheme
    /// - Parameter colorScheme: The current color scheme (light or dark)
    /// - Returns: The appropriate color for the color scheme
    public func color(for colorScheme: ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            return lightColor
        case .dark:
            return darkColor
        @unknown default:
            return lightColor
        }
    }

    /// Resolve to SwiftUI Color based on environment
    /// Use this in SwiftUI views with @Environment(\.colorScheme)
    public func resolve(in colorScheme: ColorScheme) -> Color {
        color(for: colorScheme)
    }
}

// MARK: - SwiftUI Extensions

@available(iOS 15, *)
extension View {
    /// Apply a dynamic color as foreground color
    /// - Parameter dynamicColor: The dynamic color to apply
    /// - Returns: View with dynamic foreground color
    public func foregroundColor(_ dynamicColor: DynamicColor, colorScheme: ColorScheme) -> some View {
        self.foregroundColor(dynamicColor.resolve(in: colorScheme))
    }

    /// Apply a dynamic color as background
    /// - Parameter dynamicColor: The dynamic color to apply
    /// - Returns: View with dynamic background
    public func background(_ dynamicColor: DynamicColor, colorScheme: ColorScheme) -> some View {
        self.background(dynamicColor.resolve(in: colorScheme))
    }
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension DynamicColor {
    /// Create from RGB values for light and dark modes
    public init(
        lightRGB: (red: Double, green: Double, blue: Double, opacity: Double),
        darkRGB: (red: Double, green: Double, blue: Double, opacity: Double)
    ) {
        self.lightColor = Color(
            red: lightRGB.red,
            green: lightRGB.green,
            blue: lightRGB.blue,
            opacity: lightRGB.opacity
        )
        self.darkColor = Color(
            red: darkRGB.red,
            green: darkRGB.green,
            blue: darkRGB.blue,
            opacity: darkRGB.opacity
        )
    }
}

#endif
