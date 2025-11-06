#if os(iOS)
import SwiftUI

/// ELEVATE Input Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct InputComponentTokens {

    // MARK: - Colors

    public static let border_color_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.border_default, dark: ElevateAliases.Action.StrongNeutral.border_default)
    public static let border_color_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.border_disabled_default, dark: ElevateAliases.Action.StrongNeutral.border_disabled_default)
    public static let border_color_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_hover, dark: ElevateAliases.Action.StrongPrimary.border_hover)
    public static let border_color_invalid = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let border_color_selected = Color.adaptive(light: ElevateAliases.Action.Focus.border_color_default, dark: ElevateAliases.Action.Focus.border_color_default)
    public static let fill_default = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.1098, green: 0.1098, blue: 0.1176, opacity: 1.0000)
        )
    public static let fill_disabled = Color.adaptive(
            lightRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000),
            darkRGB: (red: 0.1725, green: 0.1725, blue: 0.1804, opacity: 1.0000)
        )
    public static let fill_hover = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let fill_invalid = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.1098, green: 0.1098, blue: 0.1176, opacity: 1.0000)
        )
    public static let fill_selected = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let icon_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_default, dark: ElevateAliases.Action.StrongEmphasized.text_default)
    public static let icon_disabled = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult, dark: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult)

    // MARK: - Dimensions

    public static let border_radius_l: CGFloat = 4.0
    public static let border_radius_m: CGFloat = 4.0
    public static let border_radius_s: CGFloat = 4.0
    public static let border_width_default: CGFloat = 1.0
    public static let border_width_disabled: CGFloat = 1.0
    public static let border_width_hover: CGFloat = 1.0
    public static let border_width_invalid: CGFloat = 2.0
    public static let border_width_selected: CGFloat = 2.0
    public static let gap_l: CGFloat = 4.0
    public static let gap_m: CGFloat = 4.0
    public static let gap_prefix_l: CGFloat = 8.0
    public static let gap_prefix_m: CGFloat = 4.0
    public static let gap_prefix_s: CGFloat = 4.0
    public static let gap_s: CGFloat = 4.0
    public static let height_l: CGFloat = 48.0
    public static let height_m: CGFloat = 40.0
    public static let height_s: CGFloat = 32.0
    public static let icon_size_height_l: CGFloat = 24.0
    public static let icon_size_height_m: CGFloat = 20.0
    public static let icon_size_height_s: CGFloat = 16.0
    public static let icon_size_width_l: CGFloat = 24.0
    public static let icon_size_width_m: CGFloat = 20.0
    public static let icon_size_width_s: CGFloat = 16.0
    public static let padding_inline_l: CGFloat = 16.0
    public static let padding_inline_m: CGFloat = 12.0
    public static let padding_inline_s: CGFloat = 8.0

}
#endif
