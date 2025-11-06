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
