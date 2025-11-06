#if os(iOS)
import SwiftUI

/// ELEVATE Checkbox Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct CheckboxComponentTokens {

    // MARK: - Colors

    public static let control_border_color_checked_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_active, dark: ElevateAliases.Action.StrongPrimary.border_active)
    public static let control_border_color_checked_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_default, dark: ElevateAliases.Action.StrongPrimary.border_default)
    public static let control_border_color_checked_disabled = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_disabled_default, dark: ElevateAliases.Action.StrongEmphasized.border_disabled_default)
    public static let control_border_color_checked_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_hover, dark: ElevateAliases.Action.StrongPrimary.border_hover)
    public static let control_border_color_checked_invalid_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let control_border_color_indeterminate_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_active, dark: ElevateAliases.Action.StrongPrimary.border_active)
    public static let control_border_color_indeterminate_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_default, dark: ElevateAliases.Action.StrongPrimary.border_default)
    public static let control_border_color_indeterminate_disabled = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_disabled_default, dark: ElevateAliases.Action.StrongEmphasized.border_disabled_default)
    public static let control_border_color_indeterminate_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.border_hover, dark: ElevateAliases.Action.StrongPrimary.border_hover)
    public static let control_border_color_indeterminate_invalid_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let control_border_color_unchecked_active = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_active, dark: ElevateAliases.Action.StrongEmphasized.border_active)
    public static let control_border_color_unchecked_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_default, dark: ElevateAliases.Action.StrongEmphasized.border_default)
    public static let control_border_color_unchecked_disabled = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_disabled_default, dark: ElevateAliases.Action.StrongEmphasized.border_disabled_default)
    public static let control_border_color_unchecked_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_hover, dark: ElevateAliases.Action.StrongEmphasized.border_hover)
    public static let control_border_color_unchecked_invalid_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_active, dark: ElevateAliases.Action.StrongDanger.border_active)
    public static let control_border_color_unchecked_invalid_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let control_border_color_unchecked_invalid_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_hover, dark: ElevateAliases.Action.StrongDanger.border_hover)
    public static let control_fill_checked_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_active, dark: ElevateAliases.Action.StrongPrimary.fill_active)
    public static let control_fill_checked_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_default, dark: ElevateAliases.Action.StrongPrimary.fill_default)
    public static let control_fill_checked_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default)
    public static let control_fill_checked_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_hover, dark: ElevateAliases.Action.StrongPrimary.fill_hover)
    public static let control_fill_indeterminate_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_active, dark: ElevateAliases.Action.StrongPrimary.fill_active)
    public static let control_fill_indeterminate_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_default, dark: ElevateAliases.Action.StrongPrimary.fill_default)
    public static let control_fill_indeterminate_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default)
    public static let control_fill_indeterminate_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_hover, dark: ElevateAliases.Action.StrongPrimary.fill_hover)
    public static let control_fill_unchecked_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_fill_unchecked_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_fill_unchecked_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default)
    public static let control_fill_unchecked_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let elvt_component_checkbox_control_border_color_checked_active = Color(red: 0.1373, green: 0.2588, blue: 0.4588, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_checked_default = Color(red: 0.0000, green: 0.4471, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_checked_disabled = Color(red: 0.7451, green: 0.7647, blue: 0.8039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_checked_hover = Color(red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_checked_invalid_default = Color(red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_indeterminate_active = Color(red: 0.1373, green: 0.2588, blue: 0.4588, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_indeterminate_default = Color(red: 0.0000, green: 0.4471, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_indeterminate_disabled = Color(red: 0.7451, green: 0.7647, blue: 0.8039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_indeterminate_hover = Color(red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_indeterminate_invalid_default = Color(red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_unchecked_active = Color(red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_unchecked_default = Color(red: 0.4392, green: 0.4784, blue: 0.5608, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_unchecked_disabled = Color(red: 0.7451, green: 0.7647, blue: 0.8039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_unchecked_hover = Color(red: 0.3647, green: 0.4000, blue: 0.4745, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_unchecked_invalid_active = Color(red: 0.5451, green: 0.0039, blue: 0.0039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_unchecked_invalid_default = Color(red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_border_color_unchecked_invalid_hover = Color(red: 0.8078, green: 0.0039, blue: 0.0039, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_checked_active = Color(red: 0.1373, green: 0.2000, blue: 0.2941, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_checked_default = Color(red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_checked_disabled = Color(red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_checked_hover = Color(red: 0.1059, green: 0.3137, blue: 0.6510, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_indeterminate_active = Color(red: 0.1373, green: 0.2000, blue: 0.2941, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_indeterminate_default = Color(red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_indeterminate_disabled = Color(red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_indeterminate_hover = Color(red: 0.1059, green: 0.3137, blue: 0.6510, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_unchecked_active = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_unchecked_default = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_unchecked_disabled = Color(red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
    public static let elvt_component_checkbox_control_fill_unchecked_hover = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_icon_color_active = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_icon_color_default = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_icon_color_disabled = Color(red: 0.6392, green: 0.6667, blue: 0.7059, opacity: 1.0000)
    public static let elvt_component_checkbox_icon_color_hover = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_checkbox_label_active = Color(red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
    public static let elvt_component_checkbox_label_default = Color(red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
    public static let elvt_component_checkbox_label_disabled = Color(red: 0.6392, green: 0.6667, blue: 0.7059, opacity: 1.0000)
    public static let elvt_component_checkbox_label_hover = Color(red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
    public static let icon_color_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_default, dark: ElevateAliases.Action.StrongPrimary.text_default)
    public static let icon_color_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_default, dark: ElevateAliases.Action.StrongPrimary.text_default)
    public static let icon_color_disabled = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult, dark: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult)
    public static let icon_color_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_default, dark: ElevateAliases.Action.StrongPrimary.text_default)
    public static let label_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)
    public static let label_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)
    public static let label_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_disabled_default, dark: ElevateAliases.Action.StrongNeutral.text_disabled_default)
    public static let label_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)

    // MARK: - Dimensions

    public static let control_border_width_l: CGFloat = 1.0
    public static let control_border_width_m: CGFloat = 1.0
    public static let control_border_width_s: CGFloat = 1.0
    public static let control_height_l: CGFloat = 24.0
    public static let control_height_m: CGFloat = 20.0
    public static let control_height_s: CGFloat = 16.0
    public static let control_radius_l: CGFloat = 4.0
    public static let control_radius_m: CGFloat = 4.0
    public static let control_radius_s: CGFloat = 2.0
    public static let control_width_l: CGFloat = 24.0
    public static let control_width_m: CGFloat = 20.0
    public static let control_width_s: CGFloat = 16.0
    public static let elvt_component_checkbox_control_border_width_l: CGFloat = 1.0
    public static let elvt_component_checkbox_control_border_width_m: CGFloat = 1.0
    public static let elvt_component_checkbox_control_border_width_s: CGFloat = 1.0
    public static let elvt_component_checkbox_control_height_l: CGFloat = 24.0
    public static let elvt_component_checkbox_control_height_m: CGFloat = 20.0
    public static let elvt_component_checkbox_control_height_s: CGFloat = 16.0
    public static let elvt_component_checkbox_control_radius_l: CGFloat = 4.0
    public static let elvt_component_checkbox_control_radius_m: CGFloat = 4.0
    public static let elvt_component_checkbox_control_radius_s: CGFloat = 2.0
    public static let elvt_component_checkbox_control_width_l: CGFloat = 24.0
    public static let elvt_component_checkbox_control_width_m: CGFloat = 20.0
    public static let elvt_component_checkbox_control_width_s: CGFloat = 16.0
    public static let elvt_component_checkbox_gap_l: CGFloat = 12.0
    public static let elvt_component_checkbox_gap_m: CGFloat = 8.0
    public static let elvt_component_checkbox_gap_s: CGFloat = 8.0
    public static let elvt_component_checkbox_icon_height_l: CGFloat = 32.0
    public static let elvt_component_checkbox_icon_height_m: CGFloat = 24.0
    public static let elvt_component_checkbox_icon_height_s: CGFloat = 20.0
    public static let elvt_component_checkbox_icon_width_l: CGFloat = 32.0
    public static let elvt_component_checkbox_icon_width_m: CGFloat = 24.0
    public static let elvt_component_checkbox_icon_width_s: CGFloat = 20.0
    public static let gap_l: CGFloat = 12.0
    public static let gap_m: CGFloat = 8.0
    public static let gap_s: CGFloat = 8.0
    public static let icon_height_l: CGFloat = 32.0
    public static let icon_height_m: CGFloat = 24.0
    public static let icon_height_s: CGFloat = 20.0
    public static let icon_width_l: CGFloat = 32.0
    public static let icon_width_m: CGFloat = 24.0
    public static let icon_width_s: CGFloat = 20.0

}
#endif
