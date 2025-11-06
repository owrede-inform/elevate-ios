#if os(iOS)
import SwiftUI

/// ELEVATE Toolbar Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ToolbarComponentTokens {

    // MARK: - Colors

    public static let border_color_default = Color.adaptive(light: ElevateAliases.Layout.General.border_accent, dark: ElevateAliases.Layout.General.border_accent)
    public static let border_color_elevated = Color.adaptive(light: ElevateAliases.Layout.General.border_accent, dark: ElevateAliases.Layout.General.border_accent)
    public static let border_color_overlay = Color.adaptive(light: ElevateAliases.Layout.General.border_accent, dark: ElevateAliases.Layout.General.border_accent)
    public static let border_color_sunken = Color.adaptive(light: ElevateAliases.Layout.General.border_accent, dark: ElevateAliases.Layout.General.border_accent)
    public static let fill_default = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let fill_elevated = Color.adaptive(
            lightRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000),
            darkRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
        )
    public static let fill_overlay = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let fill_sunken = Color.adaptive(
            lightRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000),
            darkRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000)
        )

    // MARK: - Dimensions

    public static let border_width: CGFloat = 1.0
    public static let gap: CGFloat = 16.0
    public static let padding: CGFloat = 12.0

}
#endif
