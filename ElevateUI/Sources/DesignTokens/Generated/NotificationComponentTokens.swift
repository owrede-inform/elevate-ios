#if os(iOS)
import SwiftUI

/// ELEVATE Notification Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct NotificationComponentTokens {

    // MARK: - Colors

    public static let border_color_danger = Color.adaptive(light: ElevateAliases.Action.UnderstatedDanger.border_default, dark: ElevateAliases.Action.UnderstatedDanger.border_default)
    public static let border_color_neutral = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.border_default, dark: ElevateAliases.Action.UnderstatedNeutral.border_default)
    public static let border_color_primary = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.border_default, dark: ElevateAliases.Action.UnderstatedPrimary.border_default)
    public static let border_color_success = Color.adaptive(light: ElevateAliases.Action.UnderstatedSuccess.border_default, dark: ElevateAliases.Action.UnderstatedSuccess.border_default)
    public static let border_color_warning = Color.adaptive(light: ElevateAliases.Action.UnderstatedWarning.border_default, dark: ElevateAliases.Action.UnderstatedWarning.border_default)
    public static let fill_danger = Color.adaptive(light: ElevateAliases.Action.UnderstatedDanger.fill_default, dark: ElevateAliases.Action.UnderstatedDanger.fill_default)
    public static let fill_neutral = Color.adaptive(light: ElevateAliases.Action.UnderstatedNeutral.fill_default, dark: ElevateAliases.Action.UnderstatedNeutral.fill_default)
    public static let fill_primary = Color.adaptive(light: ElevateAliases.Action.UnderstatedPrimary.fill_default, dark: ElevateAliases.Action.UnderstatedPrimary.fill_default)
    public static let fill_success = Color.adaptive(light: ElevateAliases.Action.UnderstatedSuccess.fill_default, dark: ElevateAliases.Action.UnderstatedSuccess.fill_default)
    public static let fill_warning = Color.adaptive(light: ElevateAliases.Action.UnderstatedWarning.fill_default, dark: ElevateAliases.Action.UnderstatedWarning.fill_default)
    public static let icon_color_closable = Color.adaptive(
            lightRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000),
            darkRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
        )
    public static let icon_color_danger = Color.adaptive(
            lightRGB: (red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
    public static let icon_color_neutral = Color.adaptive(
            lightRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000),
            darkRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
        )
    public static let icon_color_primary = Color.adaptive(
            lightRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000),
            darkRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
        )
    public static let icon_color_success = Color.adaptive(
            lightRGB: (red: 0.0196, green: 0.4627, blue: 0.2392, opacity: 1.0000),
            darkRGB: (red: 0.0196, green: 0.4627, blue: 0.2392, opacity: 1.0000)
        )
    public static let icon_color_warning = Color.adaptive(
            lightRGB: (red: 0.7333, green: 0.3882, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.7333, green: 0.3882, blue: 0.0000, opacity: 1.0000)
        )
    public static let text_color = Color.adaptive(light: ElevateAliases.Feedback.General.text_neutral, dark: ElevateAliases.Feedback.General.text_neutral)

    // MARK: - Dimensions

    public static let border_radius: CGFloat = 4.0
    public static let border_width: CGFloat = 1.0
    public static let border_width_top: CGFloat = 4.0
    public static let content_gap: CGFloat = 8.0
    public static let footer_gap: CGFloat = 12.0
    public static let gap: CGFloat = 16.0
    public static let icon_padding: CGFloat = 0.0
    public static let icon_size: CGFloat = 24.0
    public static let padding_block: CGFloat = 16.0
    public static let padding_inline: CGFloat = 16.0
    public static let progress_height: CGFloat = 4.0
    public static let text_gap: CGFloat = 4.0
    public static let width_min: CGFloat = 200.0

}
#endif
