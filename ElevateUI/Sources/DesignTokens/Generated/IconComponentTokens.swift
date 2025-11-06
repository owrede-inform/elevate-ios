#if os(iOS)
import SwiftUI

/// ELEVATE Icon Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct IconComponentTokens {

    // MARK: - Colors

    public static let avatar_border_color_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_active, dark: ElevateAliases.Action.StrongNeutral.fill_active)
    public static let avatar_border_color_default = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let avatar_border_color_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_hover, dark: ElevateAliases.Action.StrongNeutral.fill_hover)
    public static let avatar_border_color_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_active, dark: ElevateAliases.Action.StrongPrimary.border_active)
    public static let avatar_border_color_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_default, dark: ElevateAliases.Action.StrongPrimary.border_default)
    public static let avatar_border_color_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_hover, dark: ElevateAliases.Action.StrongPrimary.border_hover)
    public static let avatar_fill_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let avatar_fill_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let avatar_fill_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let avatar_fill_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let avatar_fill_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let avatar_fill_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let avatar_text_color_onDark = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_default, dark: ElevateAliases.Action.StrongPrimary.text_default)
    public static let avatar_text_color_onLight = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)
    public static let color_danger = Color.adaptive(
            lightRGB: (red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
    public static let color_emphasized = Color.adaptive(
            lightRGB: (red: 0.1843, green: 0.1961, blue: 0.2510, opacity: 1.0000),
            darkRGB: (red: 0.1843, green: 0.1961, blue: 0.2510, opacity: 1.0000)
        )
    public static let color_neutral = Color.adaptive(
            lightRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000),
            darkRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
        )
    public static let color_primary = Color.adaptive(
            lightRGB: (red: 0.0000, green: 0.4471, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.0000, green: 0.4471, blue: 1.0000, opacity: 1.0000)
        )
    public static let color_success = Color.adaptive(
            lightRGB: (red: 0.0706, green: 0.5490, blue: 0.2745, opacity: 1.0000),
            darkRGB: (red: 0.0706, green: 0.5490, blue: 0.2745, opacity: 1.0000)
        )
    public static let color_warning = Color.adaptive(
            lightRGB: (red: 0.7333, green: 0.3882, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.7333, green: 0.3882, blue: 0.0000, opacity: 1.0000)
        )

    // MARK: - Dimensions

    public static let avatar_border_radius_default: CGFloat = 4.0
    public static let avatar_border_width_default: CGFloat = 2.0
    public static let avatar_sizeNotPublished_box_height_l: CGFloat = 48.0
    public static let avatar_sizeNotPublished_box_height_m: CGFloat = 40.0
    public static let avatar_sizeNotPublished_box_height_s: CGFloat = 36.0
    public static let avatar_sizeNotPublished_box_width_l: CGFloat = 48.0
    public static let avatar_sizeNotPublished_box_width_m: CGFloat = 40.0
    public static let avatar_sizeNotPublished_box_width_s: CGFloat = 36.0
    public static let avatar_sizeNotPublished_circle_diameter_l: CGFloat = 48.0
    public static let avatar_sizeNotPublished_circle_diameter_m: CGFloat = 40.0
    public static let avatar_sizeNotPublished_circle_diameter_s: CGFloat = 36.0

}
#endif
