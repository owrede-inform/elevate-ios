#if os(iOS)
import SwiftUI

/// ELEVATE Badge Component Design Tokens
///
/// Wrapper around generated component tokens for easier use in Badge component.
/// References BadgeComponentTokens which contains all ELEVATE badge tokens.
///
/// Auto-generated component tokens maintain proper hierarchy:
/// Component Tokens → Alias Tokens → Primitive Tokens
@available(iOS 15, *)
public struct BadgeTokens {

    // MARK: - Badge Tones

    public enum Tone {
        case primary, secondary, success, warning, danger, neutral

        public var colors: ToneColors {
            switch self {
            case .primary: return .primary
            case .secondary: return .neutral  // Map to neutral
            case .success: return .success
            case .warning: return .warning
            case .danger: return .danger
            case .neutral: return .neutral
            }
        }
    }

    // MARK: - Badge Ranks

    public enum Rank {
        case major  // Full prominence, larger size
        case minor  // Subtle, smaller size

        public var config: RankConfig {
            switch self {
            case .major: return .major
            case .minor: return .minor
            }
        }
    }

    // MARK: - Badge Shapes

    public enum Shape {
        case box    // Squared corners
        case pill   // Fully rounded

        public func cornerRadius(for rank: Rank) -> CGFloat {
            switch self {
            case .box:
                // Use extracted border radius tokens
                return rank == .major
                    ? BadgeComponentTokens.major_border_radius_box
                    : BadgeComponentTokens.minor_border_radius_box
            case .pill:
                // Pill shape: half of height for perfect rounding
                return rank == .major
                    ? BadgeComponentTokens.major_height / 2
                    : BadgeComponentTokens.minor_height / 2
            }
        }
    }

    // MARK: - Tone Color Configurations

    public struct ToneColors {
        // Major (prominent) colors
        let majorFill: Color
        let majorText: Color

        // Minor (subtle) colors
        let minorFill: Color
        let minorText: Color
        let minorBorder: Color

        static let primary = ToneColors(
            majorFill: BadgeComponentTokens.major_fill_primary,
            majorText: BadgeComponentTokens.major_text_color_primary,
            minorFill: BadgeComponentTokens.minor_fill_primary,
            minorText: BadgeComponentTokens.minor_text_color_primary,
            minorBorder: BadgeComponentTokens.minor_border_color_primary
        )

        static let success = ToneColors(
            majorFill: BadgeComponentTokens.major_fill_success,
            majorText: BadgeComponentTokens.major_text_color_success,
            minorFill: BadgeComponentTokens.minor_fill_success,
            minorText: BadgeComponentTokens.minor_text_color_success,
            minorBorder: BadgeComponentTokens.minor_border_color_success
        )

        static let warning = ToneColors(
            majorFill: BadgeComponentTokens.major_fill_warning,
            majorText: BadgeComponentTokens.major_text_color_warning,
            minorFill: BadgeComponentTokens.minor_fill_warning,
            minorText: BadgeComponentTokens.minor_text_color_warning,
            minorBorder: BadgeComponentTokens.minor_border_color_warning
        )

        static let danger = ToneColors(
            majorFill: BadgeComponentTokens.major_fill_danger,
            majorText: BadgeComponentTokens.major_text_color_danger,
            minorFill: BadgeComponentTokens.minor_fill_danger,
            minorText: BadgeComponentTokens.minor_text_color_danger,
            minorBorder: BadgeComponentTokens.minor_border_color_danger
        )

        static let neutral = ToneColors(
            majorFill: BadgeComponentTokens.major_fill_neutral,
            majorText: BadgeComponentTokens.major_text_color_neutral,
            minorFill: BadgeComponentTokens.minor_fill_neutral,
            minorText: BadgeComponentTokens.minor_text_color_neutral,
            minorBorder: BadgeComponentTokens.minor_border_color_neutral
        )
    }

    // MARK: - Rank Configuration

    public struct RankConfig {
        let height: CGFloat
        let horizontalPadding: CGFloat
        let verticalPadding: CGFloat
        let fontSize: CGFloat
        let fontWeight: Font.Weight
        let iconSize: CGFloat
        let gap: CGFloat

        static let major = RankConfig(
            height: BadgeComponentTokens.major_height,
            horizontalPadding: BadgeComponentTokens.padding_inline,
            verticalPadding: BadgeComponentTokens.elvt_component_badge_padding_block_major,
            fontSize: ElevateTypography.Sizes.labelMedium,  // Already iOS-scaled: 17.5pt
            fontWeight: .semibold,
            iconSize: BadgeComponentTokens.elvt_component_badge_icon_size_major,
            gap: BadgeComponentTokens.gap
        )

        static let minor = RankConfig(
            height: BadgeComponentTokens.minor_height,
            horizontalPadding: BadgeComponentTokens.elvt_component_badge_padding_inline_minor,
            verticalPadding: BadgeComponentTokens.elvt_component_badge_padding_block_minor,
            fontSize: ElevateTypography.Sizes.labelSmall,  // Already iOS-scaled: 15pt
            fontWeight: .medium,
            iconSize: BadgeComponentTokens.elvt_component_badge_icon_size_minor,
            gap: BadgeComponentTokens.gap
        )
    }

    // MARK: - Convenience Methods

    public static func fillColor(for tone: Tone, rank: Rank) -> DynamicColor {
        let colors = tone.colors
        let color = rank == .major ? colors.majorFill : colors.minorFill
        return DynamicColor(color)
    }

    public static func textColor(for tone: Tone, rank: Rank) -> DynamicColor {
        let colors = tone.colors
        let color = rank == .major ? colors.majorText : colors.minorText
        return DynamicColor(color)
    }

    public static func borderColor(for tone: Tone, rank: Rank) -> DynamicColor {
        let colors = tone.colors
        // Return transparent for major rank (no border)
        let color = rank == .minor ? colors.minorBorder : Color.clear
        return DynamicColor(color)
    }
}

#endif
