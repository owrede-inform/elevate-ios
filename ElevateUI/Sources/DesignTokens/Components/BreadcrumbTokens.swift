#if os(iOS)
import SwiftUI

/// ELEVATE Breadcrumb Component Tokens
///
/// Manually defined tokens from ELEVATE design system breadcrumb components.
/// These tokens were not auto-extractable from SCSS, so they are defined manually
/// based on the source files in elevate-design-tokens.
///
/// Source:
/// - _breadcrumb.scss: Container gap
/// - _breadcrumb-item.scss: Item colors, height, radius, separator
///
/// Note: Hover states are included for macOS compatibility but are
/// not typically used on iOS touch interfaces.
@available(iOS 15, *)
public struct BreadcrumbTokens {

    // MARK: - Size Configuration

    public enum Size {
        case small
        case medium
        case large
    }

    public struct SizeConfig {
        let height: CGFloat
        let fontSize: CGFloat
        let gap: CGFloat
        let separatorSize: CGFloat
        let cornerRadius: CGFloat
        let horizontalPadding: CGFloat
        let minTouchTarget: CGFloat

        static let small = SizeConfig(
            height: 28.0,          // ~1.75rem
            fontSize: ElevateTypography.Sizes.labelMedium,  // Already iOS-scaled: 17.5pt (was 13, using closest)
            gap: 8.0,              // ~0.5rem
            separatorSize: 12.0,
            cornerRadius: ElevateCornerRadius.xs,  // 4pt × 1.25 = 5pt (was 3, using closest)
            horizontalPadding: 8.0,
            minTouchTarget: 44.0
        )

        static let medium = SizeConfig(
            height: 36.0,          // 1.5rem = 24pt, adjusted for iOS
            fontSize: ElevateTypography.Sizes.bodyMedium,  // Already iOS-scaled: 17.5pt (was 15, using closest)
            gap: 12.0,             // 0.75rem = 12pt
            separatorSize: 14.0,
            cornerRadius: ElevateCornerRadius.xs,  // 4pt × 1.25 = 5pt
            horizontalPadding: 10.0,
            minTouchTarget: 44.0
        )

        static let large = SizeConfig(
            height: 44.0,
            fontSize: ElevateTypography.Sizes.bodyLarge,  // Already iOS-scaled: 20pt (was 17, using closest)
            gap: 16.0,
            separatorSize: 16.0,
            cornerRadius: ElevateCornerRadius.s,  // 8pt × 1.25 = 10pt (was 6, using closest)
            horizontalPadding: 12.0,
            minTouchTarget: 44.0
        )
    }

    // MARK: - Link Colors (for clickable breadcrumb items)
    // Uses Alias Tokens for proper dark mode support

    public struct LinkColors {
        let linkTextDefault: Color
        let linkTextHover: Color
        let linkTextActive: Color
        let linkTextSelectedDefault: Color
        let linkTextSelectedHover: Color
        let linkTextSelectedActive: Color

        static let `default` = LinkColors(
            linkTextDefault: ElevateAliases.Action.UnderstatedPrimary.text_default,
            linkTextHover: ElevateAliases.Action.UnderstatedPrimary.text_hover,
            linkTextActive: ElevateAliases.Action.UnderstatedPrimary.text_active,
            linkTextSelectedDefault: ElevateAliases.Action.UnderstatedPrimary.text_selected_default,
            linkTextSelectedHover: ElevateAliases.Action.UnderstatedPrimary.text_selected_hover,
            linkTextSelectedActive: ElevateAliases.Action.UnderstatedPrimary.text_selected_active
        )
    }

    // MARK: - Text Colors
    // Uses Alias Tokens for proper dark mode support

    /// Text color for non-clickable breadcrumb items (current page)
    public static let textDefault = ElevateAliases.Content.General.text_default

    /// Separator color between breadcrumb items
    public static let separatorColor = ElevateAliases.Content.General.text_muted

    // MARK: - Link Color Helpers

    /// Returns the link text color based on item state
    public static func linkTextColor(
        isSelected: Bool,
        isPressed: Bool
    ) -> Color {
        let colors = LinkColors.default

        if isSelected {
            return isPressed ? colors.linkTextSelectedActive : colors.linkTextSelectedDefault
        } else {
            return isPressed ? colors.linkTextActive : colors.linkTextDefault
        }
    }
}

extension BreadcrumbTokens.Size {
    var config: BreadcrumbTokens.SizeConfig {
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
