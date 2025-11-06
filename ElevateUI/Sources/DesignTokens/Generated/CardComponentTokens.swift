#if os(iOS)
import SwiftUI

/// ELEVATE Card Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct CardComponentTokens {

    // MARK: - Colors

    public static let border_color_danger = Color.adaptive(light: ElevateAliases.Action.UnderstatedDanger.border_default, dark: ElevateAliases.Action.UnderstatedDanger.border_default)
    public static let border_color_emphasized = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_default, dark: ElevateAliases.Action.StrongEmphasized.border_default)
    public static let border_color_neutral_default = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let border_color_neutral_elevated = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let border_color_neutral_overlay = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let border_color_neutral_sunken = Color.adaptive(light: ElevateAliases.Layout.General.border_prominent, dark: ElevateAliases.Layout.General.border_prominent)
    public static let border_color_primary = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.border_default, dark: ElevateAliases.Action.UnderstatedPrimary.border_default)
    public static let border_color_success = Color.adaptive(light: ElevateAliases.Action.UnderstatedSuccess.border_default, dark: ElevateAliases.Action.UnderstatedSuccess.border_default)
    public static let border_color_warning = Color.adaptive(light: ElevateAliases.Action.UnderstatedWarning.border_default, dark: ElevateAliases.Action.UnderstatedWarning.border_default)
    public static let fill_elevated = Color.adaptive(
            lightRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000),
            darkRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
        )
    public static let fill_ground = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let fill_overlay = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let fill_popover = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let fill_raised = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let fill_sunken = Color.adaptive(
            lightRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000),
            darkRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000)
        )
    public static let footer_border_color = Color.adaptive(light: ElevateAliases.Layout.General.border_subtle, dark: ElevateAliases.Layout.General.border_subtle)
    public static let footer_fill_danger = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let footer_fill_emphasized = Color.adaptive(
            lightRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000),
            darkRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
        )
    public static let footer_fill_neutral = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let footer_fill_primary = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let footer_fill_success = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let footer_fill_warning = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let heading_border_color = Color.adaptive(light: ElevateAliases.Layout.General.border_subtle, dark: ElevateAliases.Layout.General.border_subtle)
    public static let heading_text_color = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let text_color = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)

    // MARK: - Dimensions

    public static let border_radius: CGFloat = 12.0
    public static let border_width: CGFloat = 1.0
    public static let footer_border_width: CGFloat = 1.0
    public static let footer_gap: CGFloat = 12.0
    public static let heading_border_width: CGFloat = 1.0
    public static let heading_gap: CGFloat = 4.0
    public static let padding_block: CGFloat = 12.0
    public static let padding_inline: CGFloat = 16.0

}
#endif
