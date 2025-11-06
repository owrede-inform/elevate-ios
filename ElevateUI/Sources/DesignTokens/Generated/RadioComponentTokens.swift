#if os(iOS)
import SwiftUI

/// ELEVATE Radio Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct RadioComponentTokens {

    // MARK: - Colors

    public static let control_handle_color_clicked = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_handle_color_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_handle_color_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_default)
    public static let control_handle_color_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_track_border_color_invalid_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_active, dark: ElevateAliases.Action.StrongDanger.border_active)
    public static let control_track_border_color_invalid_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_default, dark: ElevateAliases.Action.StrongDanger.border_default)
    public static let control_track_border_color_invalid_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.border_hover, dark: ElevateAliases.Action.StrongDanger.border_hover)
    public static let control_track_border_color_neutral_checked_clicked = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_active, dark: ElevateAliases.Action.StrongEmphasized.border_active)
    public static let control_track_border_color_neutral_checked_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_default, dark: ElevateAliases.Action.StrongEmphasized.border_default)
    public static let control_track_border_color_neutral_checked_disabled = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_disabled_default, dark: ElevateAliases.Action.StrongEmphasized.border_disabled_default)
    public static let control_track_border_color_neutral_checked_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_hover, dark: ElevateAliases.Action.StrongEmphasized.border_hover)
    public static let control_track_border_color_neutral_unchecked_clicked = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_active, dark: ElevateAliases.Action.StrongEmphasized.border_active)
    public static let control_track_border_color_neutral_unchecked_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_default, dark: ElevateAliases.Action.StrongEmphasized.border_default)
    public static let control_track_border_color_neutral_unchecked_disabled = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_disabled_default, dark: ElevateAliases.Action.StrongEmphasized.border_disabled_default)
    public static let control_track_border_color_neutral_unchecked_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_hover, dark: ElevateAliases.Action.StrongEmphasized.border_hover)
    public static let control_track_color_invalid_clicked = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_track_color_invalid_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_track_color_invalid_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_track_color_neutral_checked_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_active, dark: ElevateAliases.Action.StrongPrimary.fill_active)
    public static let control_track_color_neutral_checked_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_default, dark: ElevateAliases.Action.StrongPrimary.fill_default)
    public static let control_track_color_neutral_checked_disabled = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_disabled_default, dark: ElevateAliases.Action.StrongPrimary.fill_disabled_default)
    public static let control_track_color_neutral_checked_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_hover, dark: ElevateAliases.Action.StrongPrimary.fill_hover)
    public static let control_track_color_neutral_unchecked_clicked = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_track_color_neutral_unchecked_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let control_track_color_neutral_unchecked_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default)
    public static let control_track_color_neutral_unchecked_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let value_color_clicked = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)
    public static let value_color_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)
    public static let value_color_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_disabled_default, dark: ElevateAliases.Action.StrongNeutral.text_disabled_default)
    public static let value_color_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)

    // MARK: - Dimensions

    public static let control_handle_height_l: CGFloat = 10.0
    public static let control_handle_height_m: CGFloat = 8.0
    public static let control_handle_height_s: CGFloat = 6.0
    public static let control_handle_width_l: CGFloat = 10.0
    public static let control_handle_width_m: CGFloat = 8.0
    public static let control_handle_width_s: CGFloat = 6.0
    public static let control_track_border_width_l: CGFloat = 1.0
    public static let control_track_border_width_m: CGFloat = 1.0
    public static let control_track_border_width_s: CGFloat = 1.0
    public static let control_track_height_l: CGFloat = 24.0
    public static let control_track_height_m: CGFloat = 20.0
    public static let control_track_height_s: CGFloat = 16.0
    public static let control_track_width_l: CGFloat = 24.0
    public static let control_track_width_m: CGFloat = 20.0
    public static let control_track_width_s: CGFloat = 16.0
    public static let gap_l: CGFloat = 12.0
    public static let gap_m: CGFloat = 8.0
    public static let gap_s: CGFloat = 8.0

}
#endif
