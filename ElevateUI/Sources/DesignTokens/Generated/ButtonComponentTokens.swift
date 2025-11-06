#if os(iOS)
import SwiftUI

/// ELEVATE Button Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ButtonComponentTokens {

    // MARK: - Colors

    public static let border_danger_color_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_danger_color_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_danger_color_disabled_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_danger_color_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_danger_color_selected_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_danger_color_selected_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_danger_color_selected_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_emphasized_color_active = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_active, dark: ElevateAliases.Action.StrongEmphasized.border_active)
    public static let border_emphasized_color_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_default, dark: ElevateAliases.Action.StrongEmphasized.border_default)
    public static let border_emphasized_color_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_disabled_default, dark: ElevateAliases.Action.StrongEmphasized.border_disabled_default)
    public static let border_emphasized_color_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_hover, dark: ElevateAliases.Action.StrongEmphasized.border_hover)
    public static let border_emphasized_color_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_selected_active, dark: ElevateAliases.Action.StrongEmphasized.border_selected_active)
    public static let border_emphasized_color_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_selected_default, dark: ElevateAliases.Action.StrongEmphasized.border_selected_default)
    public static let border_emphasized_color_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.border_selected_hover, dark: ElevateAliases.Action.StrongEmphasized.border_selected_hover)
    public static let border_neutral_color_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_active, dark: ElevateAliases.Action.UnderstatedNeutral.border_active)
    public static let border_neutral_color_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_default, dark: ElevateAliases.Action.UnderstatedNeutral.border_default)
    public static let border_neutral_color_disabled_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_disabled_disabled, dark: ElevateAliases.Action.UnderstatedNeutral.border_disabled_disabled)
    public static let border_neutral_color_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_hover, dark: ElevateAliases.Action.UnderstatedNeutral.border_hover)
    public static let border_neutral_color_selected_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_selected_active, dark: ElevateAliases.Action.UnderstatedNeutral.border_selected_active)
    public static let border_neutral_color_selected_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_selected_selected, dark: ElevateAliases.Action.UnderstatedNeutral.border_selected_selected)
    public static let border_neutral_color_selected_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_selected_hover, dark: ElevateAliases.Action.UnderstatedNeutral.border_selected_hover)
    public static let border_primary_color_active = Color.clear
    public static let border_primary_color_default = Color.clear
    public static let border_primary_color_disabled_default = Color.clear
    public static let border_primary_color_hover = Color.clear
    public static let border_primary_color_selected_active = Color.clear
    public static let border_primary_color_selected_default = Color.clear
    public static let border_primary_color_selected_hover = Color.clear
    public static let border_subtle_color_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_subtle_color_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_subtle_color_disabled_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_subtle_color_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_subtle_color_selected_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_subtle_color_selected_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_subtle_color_selected_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_success_color_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_success_color_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_success_color_disabled_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_success_color_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_success_color_selected_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_success_color_selected_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_success_color_selected_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_warning_color_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_warning_color_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_warning_color_disabled_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_warning_color_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_warning_color_selected_active = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_warning_color_selected_default = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let border_warning_color_selected_hover = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)
    public static let fill_danger_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_active, dark: ElevateAliases.Action.StrongDanger.fill_active)
    public static let fill_danger_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_default, dark: ElevateAliases.Action.StrongDanger.fill_default)
    public static let fill_danger_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_disabled_default, dark: ElevateAliases.Action.StrongDanger.fill_disabled_default)
    public static let fill_danger_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_hover, dark: ElevateAliases.Action.StrongDanger.fill_hover)
    public static let fill_danger_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_selected_active, dark: ElevateAliases.Action.StrongDanger.fill_selected_active)
    public static let fill_danger_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_selected_default, dark: ElevateAliases.Action.StrongDanger.fill_selected_default)
    public static let fill_danger_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.fill_selected_hover, dark: ElevateAliases.Action.StrongDanger.fill_selected_hover)
    public static let fill_emphasized_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_active, dark: ElevateAliases.Action.StrongNeutral.fill_active)
    public static let fill_emphasized_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_default, dark: ElevateAliases.Action.StrongNeutral.fill_default)
    public static let fill_emphasized_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_disabled_default, dark: ElevateAliases.Action.StrongNeutral.fill_disabled_default)
    public static let fill_emphasized_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_hover, dark: ElevateAliases.Action.StrongNeutral.fill_hover)
    public static let fill_emphasized_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_selected_active, dark: ElevateAliases.Action.StrongNeutral.fill_selected_active)
    public static let fill_emphasized_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_selected_default, dark: ElevateAliases.Action.StrongNeutral.fill_selected_default)
    public static let fill_emphasized_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_selected_hover, dark: ElevateAliases.Action.StrongNeutral.fill_selected_hover)
    public static let fill_neutral_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_active, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_active)
    public static let fill_neutral_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let fill_neutral_disabled_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_disabled_default)
    public static let fill_neutral_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_hover, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_hover)
    public static let fill_neutral_selected_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_active, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_active)
    public static let fill_neutral_selected_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_default)
    public static let fill_neutral_selected_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_hover, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_hover)
    public static let fill_primary_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_active, dark: ElevateAliases.Action.StrongPrimary.fill_active)
    public static let fill_primary_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_default, dark: ElevateAliases.Action.StrongPrimary.fill_default)
    public static let fill_primary_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_disabled_default, dark: ElevateAliases.Action.StrongPrimary.fill_disabled_default)
    public static let fill_primary_disabled_default_2 = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_disabled_default, dark: ElevateAliases.Action.StrongPrimary.fill_disabled_default)
    public static let fill_primary_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_hover, dark: ElevateAliases.Action.StrongPrimary.fill_hover)
    public static let fill_primary_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_selected_active, dark: ElevateAliases.Action.StrongPrimary.fill_selected_active)
    public static let fill_primary_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_selected_default, dark: ElevateAliases.Action.StrongPrimary.fill_selected_default)
    public static let fill_primary_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.fill_selected_hover, dark: ElevateAliases.Action.StrongPrimary.fill_selected_hover)
    public static let fill_subtle_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_active, dark: ElevateAliases.Action.UnderstatedPrimary.fill_active)
    public static let fill_subtle_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_default)
    public static let fill_subtle_disabled_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_disabled_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_disabled_default)
    public static let fill_subtle_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_hover, dark: ElevateAliases.Action.UnderstatedPrimary.fill_hover)
    public static let fill_subtle_selected_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_selected_active, dark: ElevateAliases.Action.UnderstatedPrimary.fill_selected_active)
    public static let fill_subtle_selected_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_selected_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_selected_default)
    public static let fill_subtle_selected_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_selected_hover, dark: ElevateAliases.Action.UnderstatedPrimary.fill_selected_hover)
    public static let fill_success_active = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_active, dark: ElevateAliases.Action.StrongSuccess.fill_active)
    public static let fill_success_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_default, dark: ElevateAliases.Action.StrongSuccess.fill_default)
    public static let fill_success_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_disabled_default, dark: ElevateAliases.Action.StrongSuccess.fill_disabled_default)
    public static let fill_success_hover = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_hover, dark: ElevateAliases.Action.StrongSuccess.fill_hover)
    public static let fill_success_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_selected_active, dark: ElevateAliases.Action.StrongSuccess.fill_selected_active)
    public static let fill_success_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_selected_default, dark: ElevateAliases.Action.StrongSuccess.fill_selected_default)
    public static let fill_success_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.fill_selected_hover, dark: ElevateAliases.Action.StrongSuccess.fill_selected_hover)
    public static let fill_warning_active = Color.adaptive(light: ElevateAliases.Action.StrongWarning.fill_active, dark: ElevateAliases.Action.StrongWarning.fill_active)
    public static let fill_warning_default = Color.adaptive(light: ElevateAliases.Action.StrongWarning.fill_default, dark: ElevateAliases.Action.StrongWarning.fill_default)
    public static let fill_warning_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongWarning.fill_disabled_default, dark: ElevateAliases.Action.StrongWarning.fill_disabled_default)
    public static let fill_warning_hover = Color.adaptive(light: ElevateAliases.Action.StrongWarning.fill_hover, dark: ElevateAliases.Action.StrongWarning.fill_hover)
    public static let fill_warning_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongWarning.fill_selected_active, dark: ElevateAliases.Action.StrongWarning.fill_selected_active)
    public static let fill_warning_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongWarning.fill_selected_default, dark: ElevateAliases.Action.StrongWarning.fill_selected_default)
    public static let fill_warning_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongWarning.fill_selected_hover, dark: ElevateAliases.Action.StrongWarning.fill_selected_hover)
    public static let label_danger_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.text_active, dark: ElevateAliases.Action.StrongDanger.text_active)
    public static let label_danger_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.text_default, dark: ElevateAliases.Action.StrongDanger.text_default)
    public static let label_danger_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.text_disabled_default, dark: ElevateAliases.Action.StrongDanger.text_disabled_default)
    public static let label_danger_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.text_hover, dark: ElevateAliases.Action.StrongDanger.text_hover)
    public static let label_danger_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongDanger.text_selected_active, dark: ElevateAliases.Action.StrongDanger.text_selected_active)
    public static let label_danger_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongDanger.text_selected_default, dark: ElevateAliases.Action.StrongDanger.text_selected_default)
    public static let label_danger_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongDanger.text_selected_hover, dark: ElevateAliases.Action.StrongDanger.text_selected_hover)
    public static let label_emphasized_active = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_active, dark: ElevateAliases.Action.StrongEmphasized.text_active)
    public static let label_emphasized_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_default, dark: ElevateAliases.Action.StrongEmphasized.text_default)
    public static let label_emphasized_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult, dark: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult)
    public static let label_emphasized_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_hover, dark: ElevateAliases.Action.StrongEmphasized.text_hover)
    public static let label_emphasized_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_selected_active, dark: ElevateAliases.Action.StrongEmphasized.text_selected_active)
    public static let label_emphasized_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_selected_default, dark: ElevateAliases.Action.StrongEmphasized.text_selected_default)
    public static let label_emphasized_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_selected_hover, dark: ElevateAliases.Action.StrongEmphasized.text_selected_hover)
    public static let label_neutral_active = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_active, dark: ElevateAliases.Action.StrongEmphasized.text_active)
    public static let label_neutral_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_default, dark: ElevateAliases.Action.StrongEmphasized.text_default)
    public static let label_neutral_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult, dark: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult)
    public static let label_neutral_hover = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_hover, dark: ElevateAliases.Action.StrongEmphasized.text_hover)
    public static let label_neutral_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_selected_active, dark: ElevateAliases.Action.StrongNeutral.text_selected_active)
    public static let label_neutral_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_selected_default, dark: ElevateAliases.Action.StrongNeutral.text_selected_default)
    public static let label_neutral_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_selected_hover, dark: ElevateAliases.Action.StrongNeutral.text_selected_hover)
    public static let label_primary_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_active, dark: ElevateAliases.Action.StrongPrimary.text_active)
    public static let label_primary_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_default, dark: ElevateAliases.Action.StrongPrimary.text_default)
    public static let label_primary_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_disabled_default, dark: ElevateAliases.Action.StrongPrimary.text_disabled_default)
    public static let label_primary_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_hover, dark: ElevateAliases.Action.StrongPrimary.text_hover)
    public static let label_primary_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_selected_active, dark: ElevateAliases.Action.StrongPrimary.text_selected_active)
    public static let label_primary_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_selected_default, dark: ElevateAliases.Action.StrongPrimary.text_selected_default)
    public static let label_primary_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_selected_hover, dark: ElevateAliases.Action.StrongPrimary.text_selected_hover)
    public static let label_subtle_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_default, dark: ElevateAliases.Action.UnderstatedPrimary.text_default)
    public static let label_subtle_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_default, dark: ElevateAliases.Action.UnderstatedPrimary.text_default)
    public static let label_subtle_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongPrimary.text_disabled_default, dark: ElevateAliases.Action.StrongPrimary.text_disabled_default)
    public static let label_subtle_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_default, dark: ElevateAliases.Action.UnderstatedPrimary.text_default)
    public static let label_subtle_selected_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_active, dark: ElevateAliases.Action.UnderstatedPrimary.text_active)
    public static let label_subtle_selected_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_default, dark: ElevateAliases.Action.UnderstatedPrimary.text_default)
    public static let label_subtle_selected_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_hover, dark: ElevateAliases.Action.UnderstatedPrimary.text_hover)
    public static let label_success_active = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.text_active, dark: ElevateAliases.Action.StrongSuccess.text_active)
    public static let label_success_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.text_default, dark: ElevateAliases.Action.StrongSuccess.text_default)
    public static let label_success_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.text_disabled_default, dark: ElevateAliases.Action.StrongSuccess.text_disabled_default)
    public static let label_success_hover = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.text_hover, dark: ElevateAliases.Action.StrongSuccess.text_hover)
    public static let label_success_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.text_selected_active, dark: ElevateAliases.Action.StrongSuccess.text_selected_active)
    public static let label_success_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.text_selected_default, dark: ElevateAliases.Action.StrongSuccess.text_selected_default)
    public static let label_success_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongSuccess.text_selected_hover, dark: ElevateAliases.Action.StrongSuccess.text_selected_hover)
    public static let label_warning_active = Color.adaptive(light: ElevateAliases.Action.StrongWarning.text_active, dark: ElevateAliases.Action.StrongWarning.text_active)
    public static let label_warning_default = Color.adaptive(light: ElevateAliases.Action.StrongWarning.text_default, dark: ElevateAliases.Action.StrongWarning.text_default)
    public static let label_warning_disabled_default = Color.adaptive(light: ElevateAliases.Action.StrongWarning.text_disabled_default, dark: ElevateAliases.Action.StrongWarning.text_disabled_default)
    public static let label_warning_hover = Color.adaptive(light: ElevateAliases.Action.StrongWarning.text_hover, dark: ElevateAliases.Action.StrongWarning.text_hover)
    public static let label_warning_selected_active = Color.adaptive(light: ElevateAliases.Action.StrongWarning.text_selected_active, dark: ElevateAliases.Action.StrongWarning.text_selected_active)
    public static let label_warning_selected_default = Color.adaptive(light: ElevateAliases.Action.StrongWarning.text_selected_default, dark: ElevateAliases.Action.StrongWarning.text_selected_default)
    public static let label_warning_selected_hover = Color.adaptive(light: ElevateAliases.Action.StrongWarning.text_selected_hover, dark: ElevateAliases.Action.StrongWarning.text_selected_hover)

    // MARK: - Dimensions

    public static let border_radius_l: CGFloat = 4.0
    public static let border_radius_m: CGFloat = 4.0
    public static let border_radius_s: CGFloat = 4.0
    public static let border_width: CGFloat = 1.0
    public static let elvt_component_button_border_radius_pill: CGFloat = 9999.0
    public static let elvt_component_button_font_size_m: CGFloat = 16.0
    public static let gap_l: CGFloat = 12.0
    public static let gap_m: CGFloat = 8.0
    public static let gap_s: CGFloat = 4.0
    public static let height_l: CGFloat = 48.0
    public static let height_m: CGFloat = 40.0
    public static let height_s: CGFloat = 32.0
    public static let padding_inline_l: CGFloat = 20.0
    public static let padding_inline_m: CGFloat = 12.0
    public static let padding_inline_s: CGFloat = 12.0

}
#endif
