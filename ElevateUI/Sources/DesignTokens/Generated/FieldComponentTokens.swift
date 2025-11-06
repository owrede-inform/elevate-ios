#if os(iOS)
import SwiftUI

/// ELEVATE Field Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct FieldComponentTokens {

    // MARK: - Colors

    public static let characterCounter_color_danger = Color.adaptive(light: ElevateAliases.Feedback.General.text_danger, dark: ElevateAliases.Feedback.General.text_danger)
    public static let characterCounter_color_default = Color.adaptive(light: ElevateAliases.Feedback.General.text_neutral, dark: ElevateAliases.Feedback.General.text_neutral)
    public static let helpText_color_danger = Color.adaptive(light: ElevateAliases.Feedback.General.text_danger, dark: ElevateAliases.Feedback.General.text_danger)
    public static let helpText_color_default = Color.adaptive(light: ElevateAliases.Feedback.General.text_neutral, dark: ElevateAliases.Feedback.General.text_neutral)
    public static let helpText_color_disabled = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)
    public static let label_default_color = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let label_disabled_color = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)
    public static let label_focus_color = Color.adaptive(light: ElevateAliases.Action.Focus.border_color_default, dark: ElevateAliases.Action.Focus.border_color_default)
    public static let label_invalid_color = Color.adaptive(light: ElevateAliases.Feedback.General.text_danger, dark: ElevateAliases.Feedback.General.text_danger)
    public static let placeholder_caret_placeholder = Color.adaptive(light: ElevateAliases.Content.General.text_understated, dark: ElevateAliases.Content.General.text_understated)
    public static let placeholder_caret_value = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let placeholder_text_placeholder = Color.adaptive(light: ElevateAliases.Content.General.text_understated, dark: ElevateAliases.Content.General.text_understated)
    public static let placeholder_text_value = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)

    // MARK: - Dimensions

    public static let gap_l: CGFloat = 8.0
    public static let gap_m: CGFloat = 4.0
    public static let gap_s: CGFloat = 4.0
    public static let helpText_gap_prefix_l: CGFloat = 4.0
    public static let helpText_gap_prefix_m: CGFloat = 4.0
    public static let helpText_gap_prefix_s: CGFloat = 4.0
    public static let helpText_gap_prefix_xl: CGFloat = 4.0
    public static let label_gap_required_indicator_l: CGFloat = 8.0
    public static let label_gap_required_indicator_m: CGFloat = 4.0
    public static let label_gap_required_indicator_s: CGFloat = 4.0
    public static let label_gap_required_indicator_xl: CGFloat = 8.0

}
#endif
