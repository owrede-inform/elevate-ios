#if os(iOS)
import SwiftUI

/// ELEVATE Chip Component Design Tokens
///
/// Wrapper around generated component tokens for easier use in Chip component.
/// References ChipComponentTokens which contains all ELEVATE chip tokens.
///
/// Auto-generated component tokens maintain proper hierarchy:
/// Component Tokens → Alias Tokens → Primitive Tokens
@available(iOS 15, *)
public struct ChipTokens {

    // MARK: - Chip Tones

    public enum Tone {
        case primary, secondary, success, warning, danger, neutral, emphasized

        public var colors: ToneColors {
            switch self {
            case .primary: return .primary
            case .secondary: return .neutral  // Map to neutral
            case .success: return .success
            case .warning: return .warning
            case .danger: return .danger
            case .neutral: return .neutral
            case .emphasized: return .emphasized
            }
        }
    }

    // MARK: - Chip Sizes

    public enum Size {
        case small, medium, large

        public var config: SizeConfig {
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
        }
    }

    // MARK: - Chip Shapes

    public enum Shape {
        case box    // Squared corners
        case pill   // Fully rounded

        public func cornerRadius(for size: Size) -> CGFloat {
            switch self {
            case .box:
                return size == .small ? ElevateSpacing.xxs : ElevateSpacing.BorderRadius.small
            case .pill:
                return size.config.height / 2
            }
        }
    }

    // MARK: - Tone Color Configurations

    public struct ToneColors {
        // Default state
        let fill: Color
        let text: Color
        let border: Color
        let controlIcon: Color

        // Selected state
        let fillSelected: Color
        let textSelected: Color
        let borderSelected: Color

        // Disabled state
        let fillDisabled: Color
        let textDisabled: Color
        let borderDisabled: Color

        static let primary = ToneColors(
            fill: ChipComponentTokens.fill_primary_default,
            text: ChipComponentTokens.text_color_primary_default,
            border: ChipComponentTokens.border_color_primary_default,
            controlIcon: ChipComponentTokens.text_color_primary_default,
            fillSelected: ChipComponentTokens.fill_primary_selected_default,
            textSelected: ChipComponentTokens.text_color_primary_selected_default,
            borderSelected: ChipComponentTokens.border_color_primary_default, // No selected border in ELEVATE
            fillDisabled: ChipComponentTokens.fill_primary_disabled_default,
            textDisabled: ChipComponentTokens.text_color_primary_disabled_default,
            borderDisabled: ChipComponentTokens.border_color_primary_disabled_default
        )

        static let success = ToneColors(
            fill: ChipComponentTokens.fill_success_default,
            text: ChipComponentTokens.text_color_success_default,
            border: ChipComponentTokens.border_color_success_default,
            controlIcon: ChipComponentTokens.text_color_success_default,
            fillSelected: ChipComponentTokens.fill_success_selected_default,
            textSelected: ChipComponentTokens.text_color_success_selected_default,
            borderSelected: ChipComponentTokens.border_color_success_default, // No selected border in ELEVATE
            fillDisabled: ChipComponentTokens.fill_success_disabled_default,
            textDisabled: ChipComponentTokens.text_color_success_disabled_default,
            borderDisabled: ChipComponentTokens.border_color_success_disabled_default
        )

        static let warning = ToneColors(
            fill: ChipComponentTokens.fill_warning_default,
            text: ChipComponentTokens.text_color_warning_default,
            border: ChipComponentTokens.border_color_warning_default,
            controlIcon: ChipComponentTokens.text_color_warning_default,
            fillSelected: ChipComponentTokens.fill_warning_selected_default,
            textSelected: ChipComponentTokens.text_color_warning_selected_default,
            borderSelected: ChipComponentTokens.border_color_warning_default, // No selected border in ELEVATE
            fillDisabled: ChipComponentTokens.fill_warning_disabled_default,
            textDisabled: ChipComponentTokens.text_color_warning_disabled_default,
            borderDisabled: ChipComponentTokens.border_color_warning_disabled_default
        )

        static let danger = ToneColors(
            fill: ChipComponentTokens.fill_danger_default,
            text: ChipComponentTokens.text_color_danger_default,
            border: ChipComponentTokens.border_color_danger_default,
            controlIcon: ChipComponentTokens.text_color_danger_default,
            fillSelected: ChipComponentTokens.fill_danger_selected_default,
            textSelected: ChipComponentTokens.text_color_danger_selected_default,
            borderSelected: ChipComponentTokens.border_color_danger_default, // No selected border in ELEVATE
            fillDisabled: ChipComponentTokens.fill_danger_disabled_default,
            textDisabled: ChipComponentTokens.text_color_danger_disabled_default,
            borderDisabled: ChipComponentTokens.border_color_danger_disabled_default
        )

        static let neutral = ToneColors(
            fill: ChipComponentTokens.fill_neutral_default,
            text: ChipComponentTokens.text_color_neutral_default,
            border: ChipComponentTokens.border_color_neutral_default,
            controlIcon: ChipComponentTokens.text_color_neutral_default,
            fillSelected: ChipComponentTokens.fill_neutral_selected_default,
            textSelected: ChipComponentTokens.text_color_neutral_selected_default,
            borderSelected: ChipComponentTokens.border_color_neutral_default, // No selected border in ELEVATE
            fillDisabled: ChipComponentTokens.fill_neutral_disabled_default,
            textDisabled: ChipComponentTokens.text_color_neutral_disabled_default,
            borderDisabled: ChipComponentTokens.border_color_neutral_disabled_default
        )

        static let emphasized = ToneColors(
            fill: ChipComponentTokens.fill_emphasized_default,
            text: ChipComponentTokens.text_color_emphasized_default,
            border: ChipComponentTokens.border_color_emphasized_default,
            controlIcon: ChipComponentTokens.text_color_emphasized_default,
            fillSelected: ChipComponentTokens.fill_emphasized_selected_default,
            textSelected: ChipComponentTokens.text_color_emphasized_selected_default,
            borderSelected: ChipComponentTokens.border_color_emphasized_default, // No selected border in ELEVATE
            fillDisabled: ChipComponentTokens.fill_emphasized_disabled_default,
            textDisabled: ChipComponentTokens.text_color_emphasized_disabled_default,
            borderDisabled: ChipComponentTokens.border_color_emphasized_disabled_default
        )
    }

    // MARK: - Size Configuration

    public struct SizeConfig {
        let height: CGFloat
        let horizontalPadding: CGFloat
        let verticalPadding: CGFloat
        let fontSize: CGFloat
        let fontWeight: Font.Weight
        let iconSize: CGFloat
        let gap: CGFloat
        let removeButtonSize: CGFloat

        static let small = SizeConfig(
            height: 24.0,
            horizontalPadding: ElevateSpacing.s,
            verticalPadding: ElevateSpacing.xs,
            fontSize: 12.0,
            fontWeight: .medium,
            iconSize: 14.0,
            gap: ElevateSpacing.xs,
            removeButtonSize: ElevateSpacing.IconSize.small.value
        )

        static let medium = SizeConfig(
            height: 32.0,
            horizontalPadding: ElevateSpacing.m,
            verticalPadding: 6.0,
            fontSize: 14.0,
            fontWeight: .medium,
            iconSize: ElevateSpacing.IconSize.small.value,
            gap: 6.0,
            removeButtonSize: ElevateSpacing.IconSize.medium.value
        )

        static let large = SizeConfig(
            height: 40.0,
            horizontalPadding: ElevateSpacing.l,
            verticalPadding: ElevateSpacing.s,
            fontSize: 16.0,
            fontWeight: .medium,
            iconSize: ElevateSpacing.IconSize.medium.value,
            gap: ElevateSpacing.s,
            removeButtonSize: ElevateSpacing.IconSize.large.value
        )
    }

    // MARK: - Border Width

    public static func borderWidth(for size: Size) -> CGFloat {
        return ElevateSpacing.BorderWidth.thin
    }

    // MARK: - Convenience Methods

    public static func fillColor(for tone: Tone, isSelected: Bool, isDisabled: Bool) -> DynamicColor {
        let colors = tone.colors
        let color: Color
        if isDisabled {
            color = colors.fillDisabled
        } else {
            color = isSelected ? colors.fillSelected : colors.fill
        }
        return DynamicColor(color)
    }

    public static func textColor(for tone: Tone, isSelected: Bool, isDisabled: Bool) -> DynamicColor {
        let colors = tone.colors
        let color: Color
        if isDisabled {
            color = colors.textDisabled
        } else {
            color = isSelected ? colors.textSelected : colors.text
        }
        return DynamicColor(color)
    }

    public static func borderColor(for tone: Tone, isSelected: Bool, isDisabled: Bool) -> DynamicColor {
        let colors = tone.colors
        let color: Color
        if isDisabled {
            color = colors.borderDisabled
        } else {
            color = isSelected ? colors.borderSelected : colors.border
        }
        return DynamicColor(color)
    }
}

#endif
