#if os(iOS)
import SwiftUI

/// ELEVATE Badge Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct BadgeComponentTokens {

    // MARK: - Colors

    public static let major_fill_danger = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_danger, dark: ElevateAliases.Feedback.Strong.fill_danger)
    public static let major_fill_neutral = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_emphasized, dark: ElevateAliases.Feedback.Strong.fill_emphasized)
    public static let major_fill_primary = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_primary, dark: ElevateAliases.Feedback.Strong.fill_primary)
    public static let major_fill_success = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_success, dark: ElevateAliases.Feedback.Strong.fill_success)
    public static let major_fill_warning = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_warning, dark: ElevateAliases.Feedback.Strong.fill_warning)
    public static let major_text_color_danger = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_default, dark: ElevateAliases.Feedback.Strong.text_default)
    public static let major_text_color_neutral = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_default, dark: ElevateAliases.Feedback.Strong.text_default)
    public static let major_text_color_primary = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_default, dark: ElevateAliases.Feedback.Strong.text_default)
    public static let major_text_color_success = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_default, dark: ElevateAliases.Feedback.Strong.text_default)
    public static let major_text_color_warning = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_inverted, dark: ElevateAliases.Feedback.Strong.text_inverted)
    public static let minor_border_color_danger = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let minor_border_color_neutral = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_default, dark: ElevateAliases.Action.StrongEmphasized.border_default)
    public static let minor_border_color_primary = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_default, dark: ElevateAliases.Action.StrongPrimary.border_default)
    public static let minor_border_color_success = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.border_default, dark: ElevateAliases.Action.StrongSuccess.border_default)
    public static let minor_border_color_warning = Color.adaptive(light: ElevateAliases.Action.StrongWarning.border_default, dark: ElevateAliases.Action.StrongWarning.border_default)
    public static let minor_fill_danger = Color.adaptive(light: ElevateAliases.Action.UnderstatedDanger.fill_default, dark: ElevateAliases.Action.UnderstatedDanger.fill_default)
    public static let minor_fill_neutral = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_default, dark: ElevateAliases.Action.UnderstatedNeutral.fill_default)
    public static let minor_fill_primary = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_default)
    public static let minor_fill_success = Color.adaptive(light: ElevateAliases.Action.UnderstatedSuccess.fill_default, dark: ElevateAliases.Action.UnderstatedSuccess.fill_default)
    public static let minor_fill_warning = Color.adaptive(light: ElevateAliases.Action.UnderstatedWarning.fill_default, dark: ElevateAliases.Action.UnderstatedWarning.fill_default)
    public static let minor_text_color_danger = Color.adaptive(light: ElevateAliases.Feedback.General.text_danger, dark: ElevateAliases.Feedback.General.text_danger)
    public static let minor_text_color_neutral = Color.adaptive(light: ElevateAliases.Feedback.General.text_neutral, dark: ElevateAliases.Feedback.General.text_neutral)
    public static let minor_text_color_primary = Color.adaptive(light: ElevateAliases.Feedback.General.text_primary, dark: ElevateAliases.Feedback.General.text_primary)
    public static let minor_text_color_success = Color.adaptive(light: ElevateAliases.Feedback.General.text_success, dark: ElevateAliases.Feedback.General.text_success)
    public static let minor_text_color_warning = Color.adaptive(light: ElevateAliases.Feedback.General.text_warning, dark: ElevateAliases.Feedback.General.text_warning)

    // MARK: - Dimensions

    public static let elvt_component_badge_icon_size_major: CGFloat = 16.0
    public static let elvt_component_badge_icon_size_minor: CGFloat = 12.0
    public static let elvt_component_badge_padding_block_major: CGFloat = 2.0
    public static let elvt_component_badge_padding_block_minor: CGFloat = 1.0
    public static let elvt_component_badge_padding_inline_minor: CGFloat = 6.0
    public static let gap: CGFloat = 4.0
    public static let major_border_radius_box: CGFloat = 4.0
    public static let major_border_width: CGFloat = 1.0
    public static let major_height: CGFloat = 24.0
    public static let minor_border_radius_box: CGFloat = 4.0
    public static let minor_border_width: CGFloat = 1.0
    public static let minor_height: CGFloat = 20.0
    public static let padding_inline: CGFloat = 8.0

}
#endif
