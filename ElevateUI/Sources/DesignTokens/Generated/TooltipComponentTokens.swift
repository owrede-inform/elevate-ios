#if os(iOS)
import SwiftUI

/// ELEVATE Tooltip Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct TooltipComponentTokens {

    // MARK: - Colors

    public static let border_color = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let fill_color = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_emphasized, dark: ElevateAliases.Feedback.Strong.fill_emphasized)
    public static let label_color = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_default, dark: ElevateAliases.Feedback.Strong.text_default)

    // MARK: - Dimensions

    public static let arrow_padding: CGFloat = 6.0
    public static let border_radius: CGFloat = 4.0
    public static let border_width: CGFloat = 1.0
    public static let distance_withArrow: CGFloat = 4.0
    public static let distance_withoutArrow: CGFloat = 4.0
    public static let padding_block: CGFloat = 2.0
    public static let padding_inline: CGFloat = 8.0

}
#endif
