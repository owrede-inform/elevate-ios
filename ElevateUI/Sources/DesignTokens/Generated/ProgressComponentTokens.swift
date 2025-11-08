#if os(iOS)
import SwiftUI

/// ELEVATE Progress Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ProgressComponentTokens {

    // MARK: - Colors

    public static let bar_text_on_progress = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_default, dark: ElevateAliases.Feedback.Strong.text_default)
    public static let bar_text_on_track = Color.adaptive(light: ElevateAliases.Feedback.Strong.text_inverted, dark: ElevateAliases.Feedback.Strong.text_inverted)
    public static let fill_empty = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_neutral, dark: ElevateAliases.Feedback.Strong.fill_neutral)
    public static let fill_filled = Color.adaptive(light: ElevateAliases.Feedback.Strong.fill_primary, dark: ElevateAliases.Feedback.Strong.fill_primary)
    public static let icon_color = Color.adaptive(light: ElevateAliases.Feedback.Icon.neutral, dark: ElevateAliases.Feedback.Icon.neutral)

    // MARK: - Dimensions

    public static let bar_height_l: CGFloat = 16.0
    public static let bar_height_m: CGFloat = 12.0
    public static let bar_height_s: CGFloat = 8.0
    public static let bar_minWidth_l: CGFloat = 64.0
    public static let bar_minWidth_m: CGFloat = 64.0
    public static let bar_minWidth_s: CGFloat = 64.0
    public static let icon_size_l: CGFloat = 24.0
    public static let icon_size_m: CGFloat = 20.0
    public static let icon_size_s: CGFloat = 16.0
    public static let ring_diameter_l: CGFloat = 80.0
    public static let ring_diameter_m: CGFloat = 48.0
    public static let ring_diameter_s: CGFloat = 32.0
    public static let ring_width_l: CGFloat = 12.0
    public static let ring_width_m: CGFloat = 8.0
    public static let ring_width_s: CGFloat = 4.0

}
#endif
