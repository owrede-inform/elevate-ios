#if os(iOS)
import SwiftUI

/// ELEVATE Divider Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct DividerComponentTokens {

    // MARK: - Colors

    public static let stroke_color_danger = Color.adaptive(light: ElevateAliases.Feedback.General.border_danger, dark: ElevateAliases.Feedback.General.border_danger)
    public static let stroke_color_emphasized = Color.adaptive(light: ElevateAliases.Layout.General.border_accent, dark: ElevateAliases.Layout.General.border_accent)
    public static let stroke_color_neutral = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let stroke_color_primary = Color.adaptive(light: ElevateAliases.Feedback.General.border_primary, dark: ElevateAliases.Feedback.General.border_primary)
    public static let stroke_color_subtle = Color.adaptive(light: ElevateAliases.Layout.General.border_subtle, dark: ElevateAliases.Layout.General.border_subtle)
    public static let text_color_danger = Color.adaptive(light: ElevateAliases.Feedback.General.text_danger, dark: ElevateAliases.Feedback.General.text_danger)
    public static let text_color_emphasized = Color.adaptive(light: ElevateAliases.Content.General.text_default, dark: ElevateAliases.Content.General.text_default)
    public static let text_color_neutral = Color.adaptive(light: ElevateAliases.Content.General.text_understated, dark: ElevateAliases.Content.General.text_understated)
    public static let text_color_primary = Color.adaptive(light: ElevateAliases.Feedback.General.text_primary, dark: ElevateAliases.Feedback.General.text_primary)
    public static let text_color_subtle = Color.adaptive(light: ElevateAliases.Content.General.text_muted, dark: ElevateAliases.Content.General.text_muted)

    // MARK: - Dimensions

    public static let gap_l: CGFloat = 12.0
    public static let gap_m: CGFloat = 12.0
    public static let gap_s: CGFloat = 12.0
    public static let spacing_l: CGFloat = 24.0
    public static let spacing_m: CGFloat = 16.0
    public static let spacing_s: CGFloat = 8.0
    public static let stroke_width: CGFloat = 1.0
    public static let text_width: CGFloat = 1.0

}
#endif
