#if os(iOS)
import SwiftUI

/// ELEVATE Textarea Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct TextareaComponentTokens {

    // MARK: - Colors

    public static let field_border_focus_color_default = Color.adaptive(light: ElevateAliases.Action.Focus.border_color_default, dark: ElevateAliases.Action.Focus.border_color_default)
    public static let field_border_focus_color_invalid = Color.adaptive(light: ElevateAliases.Action.Focus.border_color_invalid, dark: ElevateAliases.Action.Focus.border_color_invalid)
    public static let field_border_form_color_invalid_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let field_border_form_color_invalid_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_hover, dark: ElevateAliases.Action.StrongDanger.border_hover)
    public static let field_border_form_color_neutral_default_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.border_default, dark: ElevateAliases.Action.StrongNeutral.border_default)
    public static let field_border_form_color_neutral_default_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_hover, dark: ElevateAliases.Action.StrongPrimary.border_hover)
    public static let field_border_form_color_neutral_disabled_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.border_disabled_default, dark: ElevateAliases.Action.StrongNeutral.border_disabled_default)
    public static let field_border_form_color_neutral_read_only_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.border_default, dark: ElevateAliases.Action.StrongNeutral.border_default)
    public static let field_border_form_color_neutral_read_only_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.border_hover, dark: ElevateAliases.Action.StrongNeutral.border_hover)
    public static let field_fill_default = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.1098, green: 0.1098, blue: 0.1176, opacity: 1.0000)
        )
    public static let field_fill_disabled = Color.adaptive(
            lightRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000),
            darkRGB: (red: 0.1725, green: 0.1725, blue: 0.1804, opacity: 1.0000)
        )
    public static let field_fill_invalid = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.1098, green: 0.1098, blue: 0.1176, opacity: 1.0000)
        )
    public static let field_fill_read_only = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.1725, green: 0.1725, blue: 0.1804, opacity: 1.0000)
        )
    public static let field_placeholder_color_default = Color.adaptive(light: ElevateAliases.Content.General.text_understated, dark: ElevateAliases.Content.General.text_understated)
    public static let field_placeholder_color_disabled = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)
    public static let field_text_input_color_default = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let field_text_input_color_disabled = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)

    // MARK: - Dimensions

    public static let field_border_focus_radius_l: CGFloat = 4.0
    public static let field_border_focus_radius_m: CGFloat = 4.0
    public static let field_border_focus_radius_s: CGFloat = 4.0
    public static let field_border_focus_width_neutral: CGFloat = 1.0
    public static let field_border_form_radius_l: CGFloat = 8.0
    public static let field_border_form_radius_m: CGFloat = 4.0
    public static let field_border_form_radius_s: CGFloat = 2.0
    public static let field_border_form_width_neutral: CGFloat = 1.0
    public static let field_gap_l: CGFloat = 12.0
    public static let field_gap_m: CGFloat = 8.0
    public static let field_gap_s: CGFloat = 4.0
    public static let field_padding_block_l: CGFloat = 16.0
    public static let field_padding_block_m: CGFloat = 12.0
    public static let field_padding_block_s: CGFloat = 8.0
    public static let field_padding_inline_l: CGFloat = 16.0
    public static let field_padding_inline_m: CGFloat = 12.0
    public static let field_padding_inline_s: CGFloat = 8.0
    public static let field_text_input_gap_default: CGFloat = 0.0
    public static let footer_gap_l: CGFloat = 12.0
    public static let footer_gap_m: CGFloat = 8.0
    public static let footer_gap_s: CGFloat = 4.0
    public static let gap_l: CGFloat = 4.0
    public static let gap_m: CGFloat = 4.0
    public static let gap_s: CGFloat = 4.0
    public static let header_gap_l: CGFloat = 8.0
    public static let header_gap_m: CGFloat = 8.0
    public static let header_gap_s: CGFloat = 4.0

}
#endif
