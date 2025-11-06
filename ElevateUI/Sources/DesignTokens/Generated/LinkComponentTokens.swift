#if os(iOS)
import SwiftUI

/// ELEVATE Link Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct LinkComponentTokens {

    // MARK: - Colors

    public static let color_active = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_active, dark: ElevateAliases.Action.UnderstatedPrimary.text_active)
    public static let color_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_default, dark: ElevateAliases.Action.UnderstatedPrimary.text_default)
    public static let color_disabled = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.text_disabled_default, dark: ElevateAliases.Action.StrongNeutral.text_disabled_default)
    public static let color_hover = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_hover, dark: ElevateAliases.Action.UnderstatedPrimary.text_hover)
    public static let color_visited = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.text_selected_default, dark: ElevateAliases.Action.UnderstatedPrimary.text_selected_default)

    // MARK: - Dimensions

    public static let radius: CGFloat = 4.0

}
#endif
