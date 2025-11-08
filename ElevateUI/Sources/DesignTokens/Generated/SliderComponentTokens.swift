#if os(iOS)
import SwiftUI

/// ELEVATE Slider Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct SliderComponentTokens {

    // MARK: - Colors

    public static let progress_fill_danger = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_danger, dark: ElevateAliases.Feedback.Strong.fill_danger)
    public static let progress_fill_default = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_primary, dark: ElevateAliases.Feedback.Strong.fill_primary)
    public static let progress_fill_disabled = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_neutral, dark: ElevateAliases.Feedback.Strong.fill_neutral)
    public static let progress_fill_success = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_success, dark: ElevateAliases.Feedback.Strong.fill_success)
    public static let thumb_border_color_danger_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_hover, dark: ElevateAliases.Action.StrongDanger.border_hover)
    public static let thumb_border_color_danger_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let thumb_border_color_danger_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let thumb_border_color_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.border_disabled_default, dark: ElevateAliases.Action.StrongNeutral.border_disabled_default)
    public static let thumb_border_color_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_hover, dark: ElevateAliases.Action.StrongPrimary.border_hover)
    public static let thumb_border_color_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_default, dark: ElevateAliases.Action.StrongPrimary.border_default)
    public static let thumb_border_color_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_default, dark: ElevateAliases.Action.StrongPrimary.border_default)
    public static let thumb_border_color_success_active = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.border_hover, dark: ElevateAliases.Action.StrongSuccess.border_hover)
    public static let thumb_border_color_success_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.border_default, dark: ElevateAliases.Action.StrongSuccess.border_default)
    public static let thumb_border_color_success_hover = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.border_default, dark: ElevateAliases.Action.StrongSuccess.border_default)
    public static let thumb_fill_active_active = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_default, dark: ElevateAliases.Action.StrongSuccess.fill_default)
    public static let thumb_fill_active_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedSuccess.hover, dark: ElevateAliases.Action.UnderstatedSuccess.hover)
    public static let thumb_fill_danger_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_default, dark: ElevateAliases.Action.StrongDanger.fill_default)
    public static let thumb_fill_danger_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedDanger.fill_hover, dark: ElevateAliases.Action.UnderstatedDanger.fill_hover)
    public static let thumb_fill_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let thumb_fill_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default)
    public static let thumb_fill_primary_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_default, dark: ElevateAliases.Action.StrongPrimary.fill_default)
    public static let thumb_fill_primary_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_hover, dark: ElevateAliases.Action.UnderstatedPrimary.fill_hover)
    public static let track_fill_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_active, dark: ElevateAliases.Action.UnderstatedNeutral.fill_active)
    public static let track_fill_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_hover, dark: ElevateAliases.Action.UnderstatedNeutral.fill_hover)

    // MARK: - Dimensions

    public static let progress_size_column_l: CGFloat = 16.0
    public static let progress_size_column_m: CGFloat = 8.0
    public static let progress_size_column_s: CGFloat = 4.0
    public static let progress_size_row_l: CGFloat = 16.0
    public static let progress_size_row_m: CGFloat = 8.0
    public static let progress_size_row_s: CGFloat = 4.0
    public static let size_column_l: CGFloat = 32.0
    public static let size_column_m: CGFloat = 24.0
    public static let size_column_s: CGFloat = 16.0
    public static let size_row_l: CGFloat = 32.0
    public static let size_row_m: CGFloat = 24.0
    public static let size_row_s: CGFloat = 16.0
    public static let thumb_border_width_active: CGFloat = 1.0
    public static let thumb_border_width_default: CGFloat = 1.0
    public static let thumb_border_width_hover: CGFloat = 1.0
    public static let thumb_diameter_l: CGFloat = 32.0
    public static let thumb_diameter_m: CGFloat = 24.0
    public static let thumb_diameter_s: CGFloat = 16.0
    public static let track_padding_l: CGFloat = 16.0
    public static let track_padding_m: CGFloat = 12.0
    public static let track_padding_s: CGFloat = 8.0
    public static let track_size_column_l: CGFloat = 16.0
    public static let track_size_column_m: CGFloat = 8.0
    public static let track_size_column_s: CGFloat = 4.0
    public static let track_size_row_l: CGFloat = 16.0
    public static let track_size_row_m: CGFloat = 8.0
    public static let track_size_row_s: CGFloat = 4.0

}
#endif
