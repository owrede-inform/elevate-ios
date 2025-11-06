#if os(iOS)
import SwiftUI

/// ELEVATE Table Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct TableComponentTokens {

    // MARK: - Colors

    public static let cell_even_border_color_default = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let cell_even_fill_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_active, dark: ElevateAliases.Action.UnderstatedNeutral.fill_active)
    public static let cell_even_fill_default = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let cell_even_fill_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_hover, dark: ElevateAliases.Action.UnderstatedNeutral.fill_hover)
    public static let cell_even_fill_selected_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_active, dark: ElevateAliases.Action.UnderstatedPrimary.fill_active)
    public static let cell_even_fill_selected_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_default)
    public static let cell_even_fill_selected_disabled_default = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    public static let cell_even_fill_selected_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_hover, dark: ElevateAliases.Action.UnderstatedPrimary.fill_hover)
    public static let cell_even_text_active = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_even_text_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_even_text_disabled_default = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)
    public static let cell_even_text_hover = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_even_text_selected_active = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_even_text_selected_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_even_text_selected_hover = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_odd_border_color_default = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let cell_odd_fill_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_active, dark: ElevateAliases.Action.UnderstatedNeutral.fill_active)
    public static let cell_odd_fill_default = Color.adaptive(
            lightRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000),
            darkRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
        )
    public static let cell_odd_fill_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_hover, dark: ElevateAliases.Action.UnderstatedNeutral.fill_hover)
    public static let cell_odd_fill_selected_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_active, dark: ElevateAliases.Action.UnderstatedPrimary.fill_active)
    public static let cell_odd_fill_selected_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_default)
    public static let cell_odd_fill_selected_disabled_default = Color.adaptive(
            lightRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000),
            darkRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
        )
    public static let cell_odd_fill_selected_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_hover, dark: ElevateAliases.Action.UnderstatedPrimary.fill_hover)
    public static let cell_odd_text_active = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_odd_text_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_odd_text_disabled_default = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)
    public static let cell_odd_text_hover = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_odd_text_selected_active = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_odd_text_selected_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let cell_odd_text_selected_hover = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let column_border_color_default = Color.adaptive(light: ElevateAliases.Layout.General.border_accent, dark: ElevateAliases.Layout.General.border_accent)
    public static let column_fill_default = Color.adaptive(
            lightRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000),
            darkRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000)
        )
    public static let column_prefix_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let column_suffix_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let column_text_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)

    // MARK: - Dimensions

    public static let cell_even_border_width: CGFloat = 1.0
    public static let cell_even_border_width_default: CGFloat = 1.0
    public static let cell_even_height: CGFloat = 36.0
    public static let cell_even_padding_inline_start: CGFloat = 12.0
    public static let cell_even_text_width: CGFloat = 1.0
    public static let cell_odd_border_width: CGFloat = 1.0
    public static let cell_odd_border_width_default: CGFloat = 1.0
    public static let cell_odd_height: CGFloat = 36.0
    public static let cell_odd_padding_inline_start: CGFloat = 12.0
    public static let cell_odd_text_width: CGFloat = 1.0
    public static let column_border_width: CGFloat = 1.0
    public static let column_border_width_default: CGFloat = 1.0
    public static let column_gap: CGFloat = 4.0
    public static let column_height: CGFloat = 40.0
    public static let column_padding_inline_start: CGFloat = 12.0

}
#endif
