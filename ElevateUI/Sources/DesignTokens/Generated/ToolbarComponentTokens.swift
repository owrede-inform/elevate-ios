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
    public static let fill_default = Color.adaptive(light: ElevateAliases.Layout.Layer.ground, dark: ElevateAliases.Layout.Layer.ground)
    public static let fill_elevated = Color.adaptive(light: ElevateAliases.Layout.Layer.elevated, dark: ElevateAliases.Layout.Layer.elevated)
    public static let fill_overlay = Color.adaptive(light: ElevateAliases.Layout.Layer.overlay, dark: ElevateAliases.Layout.Layer.overlay)
    public static let fill_sunken = Color.adaptive(light: ElevateAliases.Layout.Layer.sunken, dark: ElevateAliases.Layout.Layer.sunken)

    // MARK: - Dimensions

    public static let border_width: CGFloat = 1.0
    public static let gap: CGFloat = 16.0
    public static let padding: CGFloat = 12.0

}
#endif
