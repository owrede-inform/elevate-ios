#if os(iOS)
import SwiftUI

/// ELEVATE Shadow System for iOS
///
/// Represents multi-layer CSS box-shadows adapted for SwiftUI.
/// CSS supports comma-separated shadow layers, SwiftUI requires multiple .shadow() modifiers.
///
/// Usage:
/// ```swift
/// VStack {
///     Text("Elevated Card")
/// }
/// .applyShadow(ElevateShadow.elevated)
/// ```
@available(iOS 15, *)
public struct ElevateShadow {

    /// Individual shadow layer matching CSS box-shadow syntax
    public struct Layer {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat

        public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }

    public let layers: [Layer]

    public init(layers: [Layer]) {
        self.layers = layers
    }

    // MARK: - ELEVATE Shadow Aliases (Light Mode)

    /// Elevated shadow for dropdowns and floating elements
    /// CSS: 0 0 1px rgba(41,47,55,0.3), 0 1px 4px rgba(79,94,113,0.12), 0 5px 16px -3px rgba(79,94,113,0.12), 0 8px 24px -5px rgba(79,94,113,0.1)
    public static let elevated = ElevateShadow(layers: [
        Layer(color: Color(red: 41/255, green: 47/255, blue: 55/255, opacity: 0.3), radius: 1, x: 0, y: 0),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.12), radius: 4, x: 0, y: 1),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.12), radius: 16, x: 0, y: 5),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.1), radius: 24, x: 0, y: 8)
    ])

    /// Overlay shadow for modals and dialogs
    /// CSS: 0 2px 6px -1px rgba(79,94,113,0.14), 0 5px 16px rgba(79,94,113,0.2), 0 15px 15px rgba(79,94,113,0.1), 0 34px 20px rgba(79,94,113,0.05)
    public static let overlay = ElevateShadow(layers: [
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.14), radius: 6, x: 0, y: 2),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.2), radius: 16, x: 0, y: 5),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.1), radius: 15, x: 0, y: 15),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.05), radius: 20, x: 0, y: 34)
    ])

    /// Popover shadow for menus and tooltips
    /// CSS: Same as overlay
    public static let popover = overlay

    /// Raised shadow for subtle elevation
    /// CSS: 0 0 1px rgba(41,47,55,0.3), 0 0 2px rgba(79,94,113,0.12), 0 2px 6px rgba(79,94,113,0.08)
    public static let raised = ElevateShadow(layers: [
        Layer(color: Color(red: 41/255, green: 47/255, blue: 55/255, opacity: 0.3), radius: 1, x: 0, y: 0),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.12), radius: 2, x: 0, y: 0),
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.08), radius: 6, x: 0, y: 2)
    ])

    /// Sunken shadow for inset elements
    /// CSS: 0 0 5px 0 rgba(79,94,113,0.5)
    /// Note: SwiftUI doesn't support inset shadows, this is an approximation
    public static let sunken = ElevateShadow(layers: [
        Layer(color: Color(red: 79/255, green: 94/255, blue: 113/255, opacity: 0.5), radius: 5, x: 0, y: 0)
    ])

    // MARK: - Dark Mode Shadows

    /// Elevated shadow for dark mode
    /// CSS: 0 0 1px 0 rgba(0,0,0,0.6), 0 1px 4px 0 rgba(0,0,0,0.4), 0 5px 16px -3px rgba(0,0,0,0.3), 0 8px 24px -5px rgba(0,0,0,0.12)
    public static let elevatedDark = ElevateShadow(layers: [
        Layer(color: Color.black.opacity(0.6), radius: 1, x: 0, y: 0),
        Layer(color: Color.black.opacity(0.4), radius: 4, x: 0, y: 1),
        Layer(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 5),
        Layer(color: Color.black.opacity(0.12), radius: 24, x: 0, y: 8)
    ])

    /// Overlay shadow for dark mode
    /// CSS: 0 2px 6px -1px rgba(0,0,0,0.7), 0 24px 24px 0 rgba(0,0,0,0.6), 0 60px 40px 0 rgba(0,0,0,0.4)
    public static let overlayDark = ElevateShadow(layers: [
        Layer(color: Color.black.opacity(0.7), radius: 6, x: 0, y: 2),
        Layer(color: Color.black.opacity(0.6), radius: 24, x: 0, y: 24),
        Layer(color: Color.black.opacity(0.4), radius: 40, x: 0, y: 60)
    ])

    /// Popover shadow for dark mode
    /// CSS: 0 34px 20px 0 rgba(0,0,0,0.3), 0 15px 15px 0 rgba(0,0,0,0.4), 0 5px 16px 0 rgba(0,0,0,0.5), 0 2px 6px -1px rgba(0,0,0,0.6)
    public static let popoverDark = ElevateShadow(layers: [
        Layer(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 34),
        Layer(color: Color.black.opacity(0.4), radius: 15, x: 0, y: 15),
        Layer(color: Color.black.opacity(0.5), radius: 16, x: 0, y: 5),
        Layer(color: Color.black.opacity(0.6), radius: 6, x: 0, y: 2)
    ])

    /// Raised shadow for dark mode
    /// CSS: 0 0 1px 0 rgba(31,33,43,0.5), 0 0 2px 0 rgba(0,0,0,0.3), 0 2px 6px 0 rgba(0,0,0,0.2)
    public static let raisedDark = ElevateShadow(layers: [
        Layer(color: Color(red: 31/255, green: 33/255, blue: 43/255, opacity: 0.5), radius: 1, x: 0, y: 0),
        Layer(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 0),
        Layer(color: Color.black.opacity(0.2), radius: 6, x: 0, y: 2)
    ])

    /// Sunken shadow for dark mode
    /// CSS: 0 0 5px 0 rgba(0,0,0,0.8), inset 0 0 20px 0 rgba(0,0,0,0.3)
    /// Note: SwiftUI doesn't support inset shadows, this is an approximation
    public static let sunkenDark = ElevateShadow(layers: [
        Layer(color: Color.black.opacity(0.8), radius: 5, x: 0, y: 0)
    ])
}

// MARK: - View Extension

@available(iOS 15, *)
public extension View {

    /// Apply ELEVATE multi-layer shadow to a view
    ///
    /// Example:
    /// ```swift
    /// VStack {
    ///     Text("Menu")
    /// }
    /// .applyShadow(ElevateShadow.elevated)
    /// ```
    func applyShadow(_ shadow: ElevateShadow) -> some View {
        self.modifier(ElevateShadowModifier(shadow: shadow))
    }

    /// Apply ELEVATE shadow with automatic light/dark mode support
    ///
    /// Example:
    /// ```swift
    /// VStack {
    ///     Text("Dropdown")
    /// }
    /// .applyShadow(light: .elevated, dark: .elevatedDark)
    /// ```
    func applyShadow(light: ElevateShadow, dark: ElevateShadow) -> some View {
        self.modifier(ElevateAdaptiveShadowModifier(light: light, dark: dark))
    }
}

// MARK: - View Modifiers

@available(iOS 15, *)
private struct ElevateShadowModifier: ViewModifier {
    let shadow: ElevateShadow

    func body(content: Content) -> some View {
        shadow.layers.reduce(AnyView(content)) { view, layer in
            AnyView(
                view.shadow(
                    color: layer.color,
                    radius: layer.radius,
                    x: layer.x,
                    y: layer.y
                )
            )
        }
    }
}

@available(iOS 15, *)
private struct ElevateAdaptiveShadowModifier: ViewModifier {
    let light: ElevateShadow
    let dark: ElevateShadow

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        let shadow = colorScheme == .dark ? dark : light
        content.modifier(ElevateShadowModifier(shadow: shadow))
    }
}

#endif
