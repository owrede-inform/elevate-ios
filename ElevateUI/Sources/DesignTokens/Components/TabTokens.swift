#if os(iOS)
import SwiftUI

/// ELEVATE Tab Component Token Wrapper
///
/// Wraps the auto-generated TabComponentTokens with convenience methods
/// for tab styling and layout.
///
/// iOS Implementation Note:
/// Tabs translate to a custom segmented control-style component for top navigation,
/// not the native iOS TabView (which places tabs at the bottom).
@available(iOS 15, *)
public struct TabTokens {

    // MARK: - Size Configuration

    public enum Size {
        case small
        case medium
        case large
    }

    public struct SizeConfig {
        let height: CGFloat
        let horizontalPadding: CGFloat
        let fontSize: CGFloat
        let closeIconSize: CGFloat
        let gap: CGFloat
        let minTouchTarget: CGFloat

        static let small = SizeConfig(
            height: 36.0,
            horizontalPadding: 12.0,
            fontSize: ElevateTypography.Sizes.labelMedium,  // Already iOS-scaled: 17.5pt
            closeIconSize: 16.0,
            gap: 6.0,
            minTouchTarget: 44.0
        )

        static let medium = SizeConfig(
            height: 44.0,
            horizontalPadding: 16.0,
            fontSize: ElevateTypography.Sizes.bodyLarge,  // Already iOS-scaled: 20pt
            closeIconSize: 18.0,
            gap: 8.0,
            minTouchTarget: 44.0
        )

        static let large = SizeConfig(
            height: 52.0,
            horizontalPadding: 20.0,
            fontSize: ElevateTypography.Sizes.titleMedium,  // Already iOS-scaled: 20pt (was 18, using closest)
            closeIconSize: 20.0,
            gap: 10.0,
            minTouchTarget: 52.0
        )
    }

    // MARK: - Text Colors

    /// Tab text color for default state
    public static var textDefault: Color {
        TabComponentTokens.text_color_default
    }

    /// Tab text color when selected
    public static var textSelected: Color {
        TabComponentTokens.text_color_selected
    }

    /// Tab text color when disabled
    public static var textDisabled: Color {
        TabComponentTokens.text_color_disabled
    }

    // MARK: - Close Icon Colors

    /// Close icon color for default state
    public static var closeIconDefault: Color {
        TabComponentTokens.closeIcon_color_default
    }

    /// Close icon color when disabled
    public static var closeIconDisabled: Color {
        TabComponentTokens.closeIcon_color_disabled
    }

    // MARK: - State-Based Colors

    public static func textColor(isSelected: Bool, isDisabled: Bool) -> Color {
        if isDisabled {
            return textDisabled
        }
        return isSelected ? textSelected : textDefault
    }

    public static func closeIconColor(isDisabled: Bool) -> Color {
        isDisabled ? closeIconDisabled : closeIconDefault
    }
}

extension TabTokens.Size {
    var config: TabTokens.SizeConfig {
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
