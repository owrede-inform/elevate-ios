#if os(iOS)
import SwiftUI

/// ELEVATE Application Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ApplicationComponentTokens {

    // MARK: - Colors

    public static let fill = Color.adaptive(light: ElevateAliases.Layout.Layer.appBackground, dark: ElevateAliases.Layout.Layer.appBackground)
    public static let text = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)

}
#endif
