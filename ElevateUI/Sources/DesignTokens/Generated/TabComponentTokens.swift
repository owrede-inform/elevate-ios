#if os(iOS)
import SwiftUI

/// ELEVATE Tab Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct TabComponentTokens {

    // MARK: - Colors

    public static let closeIcon_color_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_active, dark: ElevateAliases.Action.UnderstatedPrimary.text_active)
    public static let closeIcon_color_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_default, dark: ElevateAliases.Action.StrongEmphasized.text_default)
    public static let closeIcon_color_disabled = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)
    public static let closeIcon_color_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_hover, dark: ElevateAliases.Action.UnderstatedPrimary.text_hover)
    public static let text_color_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_active, dark: ElevateAliases.Action.UnderstatedPrimary.text_active)
    public static let text_color_default = Color.adaptive(light: ElevateAliases.Action.StrongEmphasized.text_default, dark: ElevateAliases.Action.StrongEmphasized.text_default)
    public static let text_color_disabled = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)
    public static let text_color_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_hover, dark: ElevateAliases.Action.UnderstatedPrimary.text_hover)
    public static let text_color_selected = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_selected_default, dark: ElevateAliases.Action.UnderstatedPrimary.text_selected_default)

    // MARK: - Dimensions

    public static let column_height: CGFloat = 64.0
    public static let column_navigation_padding_inline_end: CGFloat = 12.0
    public static let column_padding_inline: CGFloat = 16.0
    public static let gap: CGFloat = 8.0
    public static let height: CGFloat = 48.0
    public static let navigation_padding_block_end: CGFloat = 2.0
    public static let padding_inline: CGFloat = 16.0
    public static let radius: CGFloat = 4.0

}
#endif
