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
                // Use extracted border radius tokens
                switch size {
                case .small: return ChipComponentTokens.border_radius_s
                case .medium: return ChipComponentTokens.border_radius_m
                case .large: return ChipComponentTokens.border_radius_l
                }
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
            height: ChipComponentTokens.height_s,
            horizontalPadding: ChipComponentTokens.padding_inline_s,
            verticalPadding: ChipComponentTokens.elvt_component_chip_padding_block_s,
            fontSize: 12.0,
            fontWeight: .medium,
            iconSize: ChipComponentTokens.elvt_component_chip_icon_size_s,
            gap: ChipComponentTokens.gap_s,
            removeButtonSize: ChipComponentTokens.elvt_component_chip_remove_button_size_s
        )

        static let medium = SizeConfig(
            height: ChipComponentTokens.height_m,
            horizontalPadding: ChipComponentTokens.padding_inline_m,
            verticalPadding: ChipComponentTokens.elvt_component_chip_padding_block_m,
            fontSize: 14.0,
            fontWeight: .medium,
            iconSize: ChipComponentTokens.elvt_component_chip_icon_size_m,
            gap: ChipComponentTokens.gap_m,
            removeButtonSize: ChipComponentTokens.elvt_component_chip_remove_button_size_m
        )

        static let large = SizeConfig(
            height: ChipComponentTokens.height_l,
            horizontalPadding: ChipComponentTokens.padding_inline_l,
            verticalPadding: ChipComponentTokens.elvt_component_chip_padding_block_l,
            fontSize: 16.0,
            fontWeight: .medium,
            iconSize: ChipComponentTokens.elvt_component_chip_icon_size_l,
            gap: ChipComponentTokens.gap_l,
            removeButtonSize: ChipComponentTokens.elvt_component_chip_remove_button_size_l
        )
    }

    // MARK: - Border Width

    public static func borderWidth(for size: Size) -> CGFloat {
        switch size {
        case .small: return ChipComponentTokens.border_width_s
        case .medium: return ChipComponentTokens.border_width_m
        case .large: return ChipComponentTokens.border_width_l
        }
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
