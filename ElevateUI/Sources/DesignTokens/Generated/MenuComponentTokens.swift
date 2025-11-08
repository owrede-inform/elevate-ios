#if os(iOS)
import SwiftUI

/// ELEVATE Menu Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct MenuComponentTokens {

    // MARK: - Colors

    public static let border = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_selected_default, dark: ElevateAliases.Action.UnderstatedNeutral.fill_selected_default)
    public static let elvt_component_menu_shadow_color = Color.clear
    public static let fill = Color.adaptive(light: ElevateAliases.Layout.Layer.overlay, dark: ElevateAliases.Layout.Layer.overlay)
    public static let groupLabel_fill = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.fill_default, dark: ElevateAliases.Action.UnderstatedEmphasized.fill_default)
    public static let groupLabel_text = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_default, dark: ElevateAliases.Action.StrongNeutral.text_default)

    // MARK: - Dimensions

    public static let border_radius: CGFloat = 4.0
    public static let border_width: CGFloat = 1.0
    public static let elvt_component_menu_shadow_offset_x: CGFloat = 0.0
    public static let elvt_component_menu_shadow_offset_y: CGFloat = 4.0
    public static let elvt_component_menu_shadow_radius: CGFloat = 8.0
    public static let padding_block: CGFloat = 8.0

}
#endif
