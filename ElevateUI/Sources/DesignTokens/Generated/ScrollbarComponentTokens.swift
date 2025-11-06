#if os(iOS)
import SwiftUI

/// ELEVATE Scrollbar Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ScrollbarComponentTokens {

    // MARK: - Colors

    public static let thumb_color = Color.adaptive(light: ElevateAliases.Action.StrongNeutral.fill_selected_default, dark: ElevateAliases.Action.StrongNeutral.fill_selected_default)
    public static let track_color = Color.adaptive(light: ElevatePrimitives.Transparent._color_transparent, dark: ElevatePrimitives.Transparent._color_transparent)

}
#endif
