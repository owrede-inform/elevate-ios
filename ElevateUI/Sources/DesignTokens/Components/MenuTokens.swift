#if os(iOS)
import SwiftUI

/// ELEVATE Menu Component Token Wrapper
///
/// Wraps the auto-generated MenuComponentTokens with convenience methods
/// for menu styling and layout.
///
/// Menu tokens support:
/// - Menu container (border, fill)
/// - Group labels (fill, text)
///
/// iOS Implementation Note:
/// This creates a custom menu view (not the native SwiftUI Menu) to
/// match ELEVATE design system exactly. Use with popover or custom presentation.
@available(iOS 15, *)
public struct MenuTokens {

    // MARK: - Size Configuration

    public enum Size {
        case small
        case medium
        case large
    }

    public struct SizeConfig {
        let minWidth: CGFloat
        let maxWidth: CGFloat
        let itemHeight: CGFloat
        let horizontalPadding: CGFloat
        let verticalPadding: CGFloat
        let cornerRadius: CGFloat
        let borderWidth: CGFloat
        let groupLabelHeight: CGFloat
        let fontSize: CGFloat
        let groupLabelFontSize: CGFloat
        let iconSize: CGFloat
        let gap: CGFloat

        static let small = SizeConfig(
            minWidth: 160.0,
            maxWidth: 240.0,
            itemHeight: 36.0,
            horizontalPadding: 12.0,
            verticalPadding: 6.0,
            cornerRadius: ElevateCornerRadius.xs,  // 4pt × 1.25 = 5pt (iOS scaled)
            borderWidth: 1.0,
            groupLabelHeight: 32.0,
            fontSize: ElevateTypography.Sizes.labelMedium,  // Already iOS-scaled: 17.5pt
            groupLabelFontSize: ElevateTypography.Sizes.labelSmall,  // Already iOS-scaled: 15pt
            iconSize: 16.0,
            gap: 8.0
        )

        static let medium = SizeConfig(
            minWidth: 200.0,
            maxWidth: 320.0,
            itemHeight: 44.0,
            horizontalPadding: 16.0,
            verticalPadding: 8.0,
            cornerRadius: ElevateCornerRadius.s,  // 8pt × 1.25 = 10pt (iOS scaled)
            borderWidth: 1.0,
            groupLabelHeight: 36.0,
            fontSize: ElevateTypography.Sizes.bodyLarge,  // Already iOS-scaled: 20pt
            groupLabelFontSize: ElevateTypography.Sizes.labelMedium,  // Already iOS-scaled: 17.5pt (was 13, using closest)
            iconSize: 18.0,
            gap: 10.0
        )

        static let large = SizeConfig(
            minWidth: 240.0,
            maxWidth: 400.0,
            itemHeight: 52.0,
            horizontalPadding: 20.0,
            verticalPadding: 10.0,
            cornerRadius: ElevateCornerRadius.s,  // 8pt × 1.25 = 10pt (iOS scaled)
            borderWidth: 1.0,
            groupLabelHeight: 40.0,
            fontSize: ElevateTypography.Sizes.titleMedium,  // Already iOS-scaled: 20pt (was 18, using closest)
            groupLabelFontSize: ElevateTypography.Sizes.labelMedium,  // Already iOS-scaled: 17.5pt
            iconSize: 20.0,
            gap: 12.0
        )
    }

    // MARK: - Container Colors

    /// Menu container background color with proper dark mode support
    ///
    /// **Token Hierarchy Fix**: The auto-generated MenuComponentTokens.fill incorrectly
    /// points to Primitive tokens (White for both modes) instead of Alias tokens.
    ///
    /// This override uses the correct Alias token that provides proper light/dark mode support:
    /// - Light mode: Gray._50 (subtle light background)
    /// - Dark mode: Gray._950 (very dark background)
    ///
    /// Following the 3-tier hierarchy: Component → Alias → Primitive
    public static var fillColor: Color {
        ElevateAliases.Action.StrongEmphasized.fill_default
    }

    /// Menu container border color
    public static var borderColor: Color {
        MenuComponentTokens.border
    }

    // MARK: - Group Label Colors

    /// Group label background color
    public static var groupLabelFillColor: Color {
        MenuComponentTokens.groupLabel_fill
    }

    /// Group label text color
    public static var groupLabelTextColor: Color {
        MenuComponentTokens.groupLabel_text
    }
}

extension MenuTokens.Size {
    var config: MenuTokens.SizeConfig {
        switch self {
        case .small:
            return .small
        case .medium:
            return .medium
        case .large:
            return .large
        }
    }
}

#endif
