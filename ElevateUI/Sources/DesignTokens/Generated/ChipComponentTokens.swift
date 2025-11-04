#if os(iOS)
import SwiftUI

/// ELEVATE Chip Component Tokens
///
/// Complete token set extracted from ELEVATE design system.
/// These reference alias tokens which reference primitive tokens.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v3.py to update
@available(iOS 15, *)
public struct ChipComponentTokens {

    // MARK: - Border

    public static let border_color_danger_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_danger,
                    dark: ElevateAliases.Feedback.General.border_danger
                )

    public static let border_color_danger_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.border_disabled_default
                )

    public static let border_color_emphasized_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_neutral,
                    dark: ElevateAliases.Feedback.General.border_neutral
                )

    public static let border_color_emphasized_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.border_disabled_default
                )

    public static let border_color_neutral_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_emphasized,
                    dark: ElevateAliases.Feedback.General.border_emphasized
                )

    public static let border_color_neutral_disabled_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_emphasized,
                    dark: ElevateAliases.Feedback.General.border_emphasized
                )

    public static let border_color_primary_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_primary,
                    dark: ElevateAliases.Feedback.General.border_primary
                )

    public static let border_color_primary_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.border_disabled_default
                )

    public static let border_color_success_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_success,
                    dark: ElevateAliases.Feedback.General.border_success
                )

    public static let border_color_success_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.border_disabled_default
                )

    public static let border_color_warning_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_warning,
                    dark: ElevateAliases.Feedback.General.border_warning
                )

    public static let border_color_warning_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedWarning.border_disabled_default
                )

    // MARK: - Control

    public static let control_border_color_danger_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_danger,
                    dark: ElevateAliases.Feedback.General.border_danger
                )

    public static let control_border_color_danger_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.border_disabled_default
                )

    public static let control_border_color_emphasized_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_neutral,
                    dark: ElevateAliases.Feedback.General.border_neutral
                )

    public static let control_border_color_emphasized_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.border_disabled_default
                )

    public static let control_border_color_neutral_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_emphasized,
                    dark: ElevateAliases.Feedback.General.border_emphasized
                )

    public static let control_border_color_neutral_disabled_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_emphasized,
                    dark: ElevateAliases.Feedback.General.border_emphasized
                )

    public static let control_border_color_primary_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_primary,
                    dark: ElevateAliases.Feedback.General.border_primary
                )

    public static let control_border_color_primary_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.border_disabled_default
                )

    public static let control_border_color_success_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_success,
                    dark: ElevateAliases.Feedback.General.border_success
                )

    public static let control_border_color_success_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.border_disabled_default
                )

    public static let control_border_color_warning_default = Color.adaptive(
                    light: ElevateAliases.Feedback.General.border_warning,
                    dark: ElevateAliases.Feedback.General.border_warning
                )

    public static let control_border_color_warning_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.border_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedWarning.border_disabled_default
                )

    public static let control_fill_danger_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_active,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_active
                )

    public static let control_fill_danger_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_default
                )

    public static let control_fill_danger_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_default
                )

    public static let control_fill_danger_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_hover
                )

    public static let control_fill_emphasized_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.fill_active,
                    dark: ElevateAliases.Action.StrongNeutral.fill_active
                )

    public static let control_fill_emphasized_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.fill_default,
                    dark: ElevateAliases.Action.StrongNeutral.fill_default
                )

    public static let control_fill_emphasized_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.fill_disabled_default,
                    dark: ElevateAliases.Action.StrongEmphasized.fill_disabled_default
                )

    public static let control_fill_emphasized_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.fill_hover,
                    dark: ElevateAliases.Action.StrongNeutral.fill_hover
                )

    public static let control_fill_neutral_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_active,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_active
                )

    public static let control_fill_neutral_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default
                )

    public static let control_fill_neutral_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default
                )

    public static let control_fill_neutral_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_hover
                )

    public static let control_fill_primary_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_active,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_active
                )

    public static let control_fill_primary_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_default
                )

    public static let control_fill_primary_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_default
                )

    public static let control_fill_primary_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_hover
                )

    public static let control_fill_success_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_active,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_active
                )

    public static let control_fill_success_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_default
                )

    public static let control_fill_success_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_default
                )

    public static let control_fill_success_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_hover
                )

    public static let control_fill_warning_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_active,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_active
                )

    public static let control_fill_warning_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_default,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_default
                )

    public static let control_fill_warning_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_default,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_default
                )

    public static let control_fill_warning_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_hover
                )

    public static let control_icon_fill_danger_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongDanger.text_active,
                    dark: ElevateAliases.Action.StrongDanger.text_active
                )

    public static let control_icon_fill_danger_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.text_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.text_default
                )

    public static let control_icon_fill_danger_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.text_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.text_disabled_default
                )

    public static let control_icon_fill_danger_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.text_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.text_default
                )

    public static let control_icon_fill_emphasized_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_active,
                    dark: ElevateAliases.Action.StrongPrimary.text_active
                )

    public static let control_icon_fill_emphasized_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.text_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.text_default
                )

    public static let control_icon_fill_emphasized_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult,
                    dark: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult
                )

    public static let control_icon_fill_emphasized_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.text_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.text_default
                )

    public static let control_icon_fill_neutral_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_active,
                    dark: ElevateAliases.Action.StrongPrimary.text_active
                )

    public static let control_icon_fill_neutral_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.text_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.text_default
                )

    public static let control_icon_fill_neutral_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.text_disabled_default,
                    dark: ElevateAliases.Action.StrongNeutral.text_disabled_default
                )

    public static let control_icon_fill_neutral_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.text_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.text_default
                )

    public static let control_icon_fill_primary_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_active,
                    dark: ElevateAliases.Action.StrongPrimary.text_active
                )

    public static let control_icon_fill_primary_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.text_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.text_default
                )

    public static let control_icon_fill_primary_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.text_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.text_disabled_default
                )

    public static let control_icon_fill_primary_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.text_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.text_default
                )

    public static let control_icon_fill_success_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongSuccess.text_active,
                    dark: ElevateAliases.Action.StrongSuccess.text_active
                )

    public static let control_icon_fill_success_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.text_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.text_default
                )

    public static let control_icon_fill_success_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.text_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.text_disabled_default
                )

    public static let control_icon_fill_success_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.text_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.text_default
                )

    public static let control_icon_fill_warning_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_active,
                    dark: ElevateAliases.Action.StrongWarning.text_active
                )

    public static let control_icon_fill_warning_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_default,
                    dark: ElevateAliases.Action.StrongWarning.text_default
                )

    public static let control_icon_fill_warning_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_disabled_default,
                    dark: ElevateAliases.Action.StrongWarning.text_disabled_default
                )

    public static let control_icon_fill_warning_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_hover,
                    dark: ElevateAliases.Action.StrongWarning.text_hover
                )

    // MARK: - Fill

    public static let fill_danger_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_active,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_active
                )

    public static let fill_danger_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_default
                )

    public static let fill_danger_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_default
                )

    public static let fill_danger_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedDanger.fill_hover
                )

    public static let fill_danger_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongDanger.fill_active,
                    dark: ElevateAliases.Action.StrongDanger.fill_active
                )

    public static let fill_danger_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongDanger.fill_default,
                    dark: ElevateAliases.Action.StrongDanger.fill_default
                )

    public static let fill_danger_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongDanger.fill_hover,
                    dark: ElevateAliases.Action.StrongDanger.fill_hover
                )

    public static let fill_emphasized_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.fill_active,
                    dark: ElevateAliases.Action.StrongNeutral.fill_active
                )

    public static let fill_emphasized_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.fill_default,
                    dark: ElevateAliases.Action.StrongNeutral.fill_default
                )

    public static let fill_emphasized_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.fill_default,
                    dark: ElevateAliases.Action.StrongNeutral.fill_default
                )

    public static let fill_emphasized_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.fill_hover,
                    dark: ElevateAliases.Action.StrongNeutral.fill_hover
                )

    public static let fill_emphasized_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.fill_selected_active,
                    dark: ElevateAliases.Action.StrongEmphasized.fill_selected_active
                )

    public static let fill_emphasized_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.fill_selected_default,
                    dark: ElevateAliases.Action.StrongEmphasized.fill_selected_default
                )

    public static let fill_emphasized_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.fill_selected_hover,
                    dark: ElevateAliases.Action.StrongEmphasized.fill_selected_hover
                )

    public static let fill_neutral_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_active,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_active
                )

    public static let fill_neutral_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default
                )

    public static let fill_neutral_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default
                )

    public static let fill_neutral_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_hover
                )

    public static let fill_neutral_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_active,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_active
                )

    public static let fill_neutral_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_default,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_default
                )

    public static let fill_neutral_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_hover,
                    dark: ElevateAliases.Action.UnderstatedEmphasized.fill_selected_hover
                )

    public static let fill_primary_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_active,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_active
                )

    public static let fill_primary_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_default
                )

    public static let fill_primary_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_default
                )

    public static let fill_primary_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedPrimary.fill_hover
                )

    public static let fill_primary_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.fill_active,
                    dark: ElevateAliases.Action.StrongPrimary.fill_active
                )

    public static let fill_primary_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.fill_default,
                    dark: ElevateAliases.Action.StrongPrimary.fill_default
                )

    public static let fill_primary_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.fill_hover,
                    dark: ElevateAliases.Action.StrongPrimary.fill_hover
                )

    public static let fill_success_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_active,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_active
                )

    public static let fill_success_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_default
                )

    public static let fill_success_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_default
                )

    public static let fill_success_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedSuccess.fill_hover
                )

    public static let fill_success_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongSuccess.fill_active,
                    dark: ElevateAliases.Action.StrongSuccess.fill_active
                )

    public static let fill_success_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongSuccess.fill_default,
                    dark: ElevateAliases.Action.StrongSuccess.fill_default
                )

    public static let fill_success_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongSuccess.fill_hover,
                    dark: ElevateAliases.Action.StrongSuccess.fill_hover
                )

    public static let fill_warning_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_active,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_active
                )

    public static let fill_warning_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_default,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_default
                )

    public static let fill_warning_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_default,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_default
                )

    public static let fill_warning_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedWarning.fill_hover,
                    dark: ElevateAliases.Action.UnderstatedWarning.fill_hover
                )

    public static let fill_warning_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.fill_active,
                    dark: ElevateAliases.Action.StrongWarning.fill_active
                )

    public static let fill_warning_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.fill_default,
                    dark: ElevateAliases.Action.StrongWarning.fill_default
                )

    public static let fill_warning_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.fill_hover,
                    dark: ElevateAliases.Action.StrongWarning.fill_hover
                )

    // MARK: - Text

    public static let text_color_danger_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.text_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.text_default
                )

    public static let text_color_danger_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.text_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.text_default
                )

    public static let text_color_danger_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.text_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.text_disabled_default
                )

    public static let text_color_danger_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedDanger.text_default,
                    dark: ElevateAliases.Action.UnderstatedDanger.text_default
                )

    public static let text_color_danger_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongDanger.text_selected_default,
                    dark: ElevateAliases.Action.StrongDanger.text_selected_default
                )

    public static let text_color_danger_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongDanger.text_selected_default,
                    dark: ElevateAliases.Action.StrongDanger.text_selected_default
                )

    public static let text_color_danger_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongDanger.text_selected_default,
                    dark: ElevateAliases.Action.StrongDanger.text_selected_default
                )

    public static let text_color_emphasized_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_default
                )

    public static let text_color_emphasized_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_default
                )

    public static let text_color_emphasized_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult,
                    dark: ElevateAliases.Action.StrongEmphasized.text_disabled_deafult
                )

    public static let text_color_emphasized_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_default
                )

    public static let text_color_emphasized_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_selected_default,
                    dark: ElevateAliases.Action.StrongPrimary.text_selected_default
                )

    public static let text_color_emphasized_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_selected_default,
                    dark: ElevateAliases.Action.StrongPrimary.text_selected_default
                )

    public static let text_color_emphasized_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_selected_default,
                    dark: ElevateAliases.Action.StrongPrimary.text_selected_default
                )

    public static let text_color_neutral_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_default
                )

    public static let text_color_neutral_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_default
                )

    public static let text_color_neutral_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongNeutral.text_disabled_default,
                    dark: ElevateAliases.Action.StrongNeutral.text_disabled_default
                )

    public static let text_color_neutral_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_default
                )

    public static let text_color_neutral_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_selected_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_selected_default
                )

    public static let text_color_neutral_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_selected_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_selected_default
                )

    public static let text_color_neutral_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongEmphasized.text_selected_default,
                    dark: ElevateAliases.Action.StrongEmphasized.text_selected_default
                )

    public static let text_color_primary_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.text_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.text_default
                )

    public static let text_color_primary_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.text_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.text_default
                )

    public static let text_color_primary_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.text_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.text_disabled_default
                )

    public static let text_color_primary_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedPrimary.text_default,
                    dark: ElevateAliases.Action.UnderstatedPrimary.text_default
                )

    public static let text_color_primary_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_selected_default,
                    dark: ElevateAliases.Action.StrongPrimary.text_selected_default
                )

    public static let text_color_primary_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_selected_default,
                    dark: ElevateAliases.Action.StrongPrimary.text_selected_default
                )

    public static let text_color_primary_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongPrimary.text_selected_default,
                    dark: ElevateAliases.Action.StrongPrimary.text_selected_default
                )

    public static let text_color_success_active = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.text_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.text_default
                )

    public static let text_color_success_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.text_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.text_default
                )

    public static let text_color_success_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.text_disabled_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.text_disabled_default
                )

    public static let text_color_success_hover = Color.adaptive(
                    light: ElevateAliases.Action.UnderstatedSuccess.text_default,
                    dark: ElevateAliases.Action.UnderstatedSuccess.text_default
                )

    public static let text_color_success_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongSuccess.text_selected_default,
                    dark: ElevateAliases.Action.StrongSuccess.text_selected_default
                )

    public static let text_color_success_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongSuccess.text_selected_default,
                    dark: ElevateAliases.Action.StrongSuccess.text_selected_default
                )

    public static let text_color_success_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongSuccess.text_selected_default,
                    dark: ElevateAliases.Action.StrongSuccess.text_selected_default
                )

    public static let text_color_warning_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_active,
                    dark: ElevateAliases.Action.StrongWarning.text_active
                )

    public static let text_color_warning_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_default,
                    dark: ElevateAliases.Action.StrongWarning.text_default
                )

    public static let text_color_warning_disabled_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_disabled_default,
                    dark: ElevateAliases.Action.StrongWarning.text_disabled_default
                )

    public static let text_color_warning_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_hover,
                    dark: ElevateAliases.Action.StrongWarning.text_hover
                )

    public static let text_color_warning_selected_active = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_selected_default,
                    dark: ElevateAliases.Action.StrongWarning.text_selected_default
                )

    public static let text_color_warning_selected_default = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_selected_default,
                    dark: ElevateAliases.Action.StrongWarning.text_selected_default
                )

    public static let text_color_warning_selected_hover = Color.adaptive(
                    light: ElevateAliases.Action.StrongWarning.text_selected_default,
                    dark: ElevateAliases.Action.StrongWarning.text_selected_default
                )

}
#endif
