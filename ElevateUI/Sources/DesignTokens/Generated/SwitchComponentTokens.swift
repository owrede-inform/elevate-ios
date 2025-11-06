#if os(iOS)
import SwiftUI

/// ELEVATE Switch Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct SwitchComponentTokens {

    // MARK: - Colors

    public static let elvt_component_switch_handle_fill_checked_active = Color(red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_checked_default = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_checked_primary_active = Color(red: 0.7255, green: 0.8588, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_checked_primary_default = Color(red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_checked_primary_disabled = Color(red: 0.9176, green: 0.9569, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_checked_success_active = Color(red: 0.6667, green: 0.9020, blue: 0.7373, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_checked_success_default = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_checked_success_disabled = Color(red: 0.9020, green: 0.9725, blue: 0.9255, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_unchecked_default = Color(red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000)
    public static let elvt_component_switch_handle_fill_unchecked_disabled = Color(red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
    public static let elvt_component_switch_label_default = Color(red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
    public static let elvt_component_switch_label_disabled = Color(red: 0.6392, green: 0.6667, blue: 0.7059, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_checked_primary_disabled = Color(red: 0.5647, green: 0.7765, blue: 1.0000, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_checked_primary_enabled = Color(red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_checked_primary_hover = Color(red: 0.1059, green: 0.3137, blue: 0.6510, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_checked_success_default = Color(red: 0.0196, green: 0.4627, blue: 0.2392, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_checked_success_disabled = Color(red: 0.6667, green: 0.9020, blue: 0.7373, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_checked_success_hover = Color(red: 0.0196, green: 0.3765, blue: 0.2118, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_unchecked_default = Color(red: 0.6392, green: 0.6667, blue: 0.7059, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_unchecked_disabled = Color(red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000)
    public static let elvt_component_switch_track_fill_unchecked_hover = Color(red: 0.5333, green: 0.5686, blue: 0.6275, opacity: 1.0000)
    public static let handle_fill_checked_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let handle_fill_checked_default = Color.adaptive(light: ElevatePrimitives.White._color_white, dark: ElevatePrimitives.White._color_white)
    public static let handle_fill_checked_primary_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_hover, dark: ElevateAliases.Action.UnderstatedPrimary.fill_hover)
    public static let handle_fill_checked_primary_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.fill_default, dark: ElevateAliases.Action.StrongEmphasized.fill_default)
    public static let handle_fill_checked_primary_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_default)
    public static let handle_fill_checked_success_active = Color.adaptive(light: ElevatePrimitives.Green._100, dark: ElevatePrimitives.Green._100)
    public static let handle_fill_checked_success_default = Color.adaptive(light: ElevatePrimitives.White._color_white, dark: ElevatePrimitives.White._color_white)
    public static let handle_fill_checked_success_disabled = Color.adaptive(light: ElevatePrimitives.Green._50, dark: ElevatePrimitives.Green._50)
    public static let handle_fill_unchecked_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let handle_fill_unchecked_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedNeutral.fill_disabled_default)
    public static let label_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)
    public static let label_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_disabled_default, dark: ElevateAliases.Action.StrongNeutral.text_disabled_default)
    public static let track_fill_checked_primary_disabled = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_disabled_default, dark: ElevateAliases.Action.StrongPrimary.fill_disabled_default)
    public static let track_fill_checked_primary_enabled = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_default, dark: ElevateAliases.Action.StrongPrimary.fill_default)
    public static let track_fill_checked_primary_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_hover, dark: ElevateAliases.Action.StrongPrimary.fill_hover)
    public static let track_fill_checked_success_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_default, dark: ElevateAliases.Action.StrongSuccess.fill_default)
    public static let track_fill_checked_success_disabled = Color.adaptive(light: ElevateAliases.Action.UnderstatedSuccess.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedSuccess.fill_disabled_default)
    public static let track_fill_checked_success_hover = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_hover, dark: ElevateAliases.Action.StrongSuccess.fill_hover)
    public static let track_fill_unchecked_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_selected_default, dark: ElevateAliases.Action.StrongNeutral.fill_selected_default)
    public static let track_fill_unchecked_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_disabled_default, dark: ElevateAliases.Action.StrongNeutral.fill_disabled_default)
    public static let track_fill_unchecked_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_selected_hover, dark: ElevateAliases.Action.StrongNeutral.fill_selected_hover)

    // MARK: - Dimensions

    public static let elvt_component_switch_gap_l: CGFloat = 12.0
    public static let elvt_component_switch_gap_m: CGFloat = 8.0
    public static let elvt_component_switch_gap_s: CGFloat = 8.0
    public static let elvt_component_switch_handle_diameter_l: CGFloat = 24.0
    public static let elvt_component_switch_handle_diameter_m: CGFloat = 20.0
    public static let elvt_component_switch_handle_diameter_s: CGFloat = 16.0
    public static let elvt_component_switch_track_height_l: CGFloat = 28.0
    public static let elvt_component_switch_track_height_m: CGFloat = 24.0
    public static let elvt_component_switch_track_height_s: CGFloat = 20.0
    public static let elvt_component_switch_track_padding_l: CGFloat = 2.0
    public static let elvt_component_switch_track_padding_m: CGFloat = 2.0
    public static let elvt_component_switch_track_padding_s: CGFloat = 2.0
    public static let elvt_component_switch_track_width_l: CGFloat = 56.0
    public static let elvt_component_switch_track_width_m: CGFloat = 48.0
    public static let elvt_component_switch_track_width_s: CGFloat = 40.0
    public static let gap_l: CGFloat = 12.0
    public static let gap_m: CGFloat = 8.0
    public static let gap_s: CGFloat = 8.0
    public static let handle_diameter_l: CGFloat = 24.0
    public static let handle_diameter_m: CGFloat = 20.0
    public static let handle_diameter_s: CGFloat = 16.0
    public static let track_height_l: CGFloat = 28.0
    public static let track_height_m: CGFloat = 24.0
    public static let track_height_s: CGFloat = 20.0
    public static let track_padding_l: CGFloat = 2.0
    public static let track_padding_m: CGFloat = 2.0
    public static let track_padding_s: CGFloat = 2.0
    public static let track_width_l: CGFloat = 56.0
    public static let track_width_m: CGFloat = 48.0
    public static let track_width_s: CGFloat = 40.0

}
#endif
