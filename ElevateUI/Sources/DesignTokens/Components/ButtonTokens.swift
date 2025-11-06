#if os(iOS)
import SwiftUI

/// ELEVATE Button Component Design Tokens
///
/// Wrapper around generated component tokens for easier use in Button component.
/// References ButtonComponentTokens which contains all ELEVATE button tokens.
///
/// Auto-generated component tokens maintain proper hierarchy:
/// Component Tokens → Alias Tokens → Primitive Tokens
@available(iOS 15, *)
public struct ButtonTokens {

    // MARK: - Button Tones

    public enum Tone {
        case primary, secondary, success, warning, danger, emphasized, subtle, neutral

        public var colors: ToneColors {
            switch self {
            case .primary: return .primary
            case .secondary: return .neutral  // Map secondary to neutral tokens
            case .success: return .success
            case .warning: return .warning
            case .danger: return .danger
            case .emphasized: return .emphasized
            case .subtle: return .subtle
            case .neutral: return .neutral
            }
        }
    }

    // MARK: - Button Sizes

    public enum Size {
        case small, medium, large

        public var componentSize: SizeConfig {
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
        }
    }

    // MARK: - Size Configuration

    public struct SizeConfig {
        let height: CGFloat
        let paddingInline: CGFloat

        static let small = SizeConfig(
            height: ButtonComponentTokens.height_s,
            paddingInline: ButtonComponentTokens.padding_inline_s
        )

        static let medium = SizeConfig(
            height: ButtonComponentTokens.height_m,
            paddingInline: ButtonComponentTokens.padding_inline_m
        )

        static let large = SizeConfig(
            height: ButtonComponentTokens.height_l,
            paddingInline: ButtonComponentTokens.padding_inline_l
        )
    }

    // MARK: - Button Shapes

    public enum Shape {
        case `default`  // Squared corners (box)
        case pill       // Fully rounded

        public var borderRadius: CGFloat {
            switch self {
            case .default: return ButtonComponentTokens.border_radius_m
            case .pill: return ButtonComponentTokens.elvt_component_button_border_radius_pill
            }
        }
    }

    public enum State {
        case `default`, hover, active, disabled
    }

    // MARK: - Tone Color Configurations

    public struct ToneColors {
        // Background colors for all states
        let background: Color
        let backgroundHover: Color
        let backgroundActive: Color
        let backgroundDisabled: Color
        let backgroundSelected: Color
        let backgroundSelectedActive: Color

        // Text colors for all states
        let text: Color
        let textHover: Color
        let textActive: Color
        let textDisabled: Color
        let textSelected: Color
        let textSelectedHover: Color
        let textSelectedActive: Color

        // Border colors
        let border: Color
        let borderSelected: Color

        static let primary = ToneColors(
            background: ButtonComponentTokens.fill_primary_default,
            backgroundHover: ButtonComponentTokens.fill_primary_hover,
            backgroundActive: ButtonComponentTokens.fill_primary_active,
            backgroundDisabled: ButtonComponentTokens.fill_primary_disabled_default,
            backgroundSelected: ButtonComponentTokens.fill_primary_selected_default,
            backgroundSelectedActive: ButtonComponentTokens.fill_primary_selected_active,
            text: ButtonComponentTokens.label_primary_default,
            textHover: ButtonComponentTokens.label_primary_hover,
            textActive: ButtonComponentTokens.label_primary_active,
            textDisabled: ButtonComponentTokens.label_primary_disabled_default,
            textSelected: ButtonComponentTokens.label_primary_selected_default,
            textSelectedHover: ButtonComponentTokens.label_primary_selected_hover,
            textSelectedActive: ButtonComponentTokens.label_primary_selected_active,
            border: Color.clear, // No border tokens for primary in ELEVATE
            borderSelected: Color.clear
        )

        static let success = ToneColors(
            background: ButtonComponentTokens.fill_success_default,
            backgroundHover: ButtonComponentTokens.fill_success_hover,
            backgroundActive: ButtonComponentTokens.fill_success_active,
            backgroundDisabled: ButtonComponentTokens.fill_success_disabled_default,
            backgroundSelected: ButtonComponentTokens.fill_success_selected_default,
            backgroundSelectedActive: ButtonComponentTokens.fill_success_selected_active,
            text: ButtonComponentTokens.label_success_default,
            textHover: ButtonComponentTokens.label_success_hover,
            textActive: ButtonComponentTokens.label_success_active,
            textDisabled: ButtonComponentTokens.label_success_disabled_default,
            textSelected: ButtonComponentTokens.label_success_selected_default,
            textSelectedHover: ButtonComponentTokens.label_success_selected_hover,
            textSelectedActive: ButtonComponentTokens.label_success_selected_active,
            border: Color.clear, // No border tokens for success in ELEVATE
            borderSelected: Color.clear
        )

        static let warning = ToneColors(
            background: ButtonComponentTokens.fill_warning_default,
            backgroundHover: ButtonComponentTokens.fill_warning_hover,
            backgroundActive: ButtonComponentTokens.fill_warning_active,
            backgroundDisabled: ButtonComponentTokens.fill_warning_disabled_default,
            backgroundSelected: ButtonComponentTokens.fill_warning_selected_default,
            backgroundSelectedActive: ButtonComponentTokens.fill_warning_selected_active,
            text: ButtonComponentTokens.label_warning_default,
            textHover: ButtonComponentTokens.label_warning_hover,
            textActive: ButtonComponentTokens.label_warning_active,
            textDisabled: ButtonComponentTokens.label_warning_disabled_default,
            textSelected: ButtonComponentTokens.label_warning_selected_default,
            textSelectedHover: ButtonComponentTokens.label_warning_selected_hover,
            textSelectedActive: ButtonComponentTokens.label_warning_selected_active,
            border: Color.clear, // No border tokens for warning in ELEVATE
            borderSelected: Color.clear
        )

        static let danger = ToneColors(
            background: ButtonComponentTokens.fill_danger_default,
            backgroundHover: ButtonComponentTokens.fill_danger_hover,
            backgroundActive: ButtonComponentTokens.fill_danger_active,
            backgroundDisabled: ButtonComponentTokens.fill_danger_disabled_default,
            backgroundSelected: ButtonComponentTokens.fill_danger_selected_default,
            backgroundSelectedActive: ButtonComponentTokens.fill_danger_selected_active,
            text: ButtonComponentTokens.label_danger_default,
            textHover: ButtonComponentTokens.label_danger_hover,
            textActive: ButtonComponentTokens.label_danger_active,
            textDisabled: ButtonComponentTokens.label_danger_disabled_default,
            textSelected: ButtonComponentTokens.label_danger_selected_default,
            textSelectedHover: ButtonComponentTokens.label_danger_selected_hover,
            textSelectedActive: ButtonComponentTokens.label_danger_selected_active,
            border: Color.clear, // No border tokens for danger in ELEVATE
            borderSelected: Color.clear
        )

        static let emphasized = ToneColors(
            background: ButtonComponentTokens.fill_emphasized_default,
            backgroundHover: ButtonComponentTokens.fill_emphasized_hover,
            backgroundActive: ButtonComponentTokens.fill_emphasized_active,
            backgroundDisabled: ButtonComponentTokens.fill_emphasized_disabled_default,
            backgroundSelected: ButtonComponentTokens.fill_emphasized_selected_default,
            backgroundSelectedActive: ButtonComponentTokens.fill_emphasized_selected_active,
            text: ButtonComponentTokens.label_emphasized_default,
            textHover: ButtonComponentTokens.label_emphasized_hover,
            textActive: ButtonComponentTokens.label_emphasized_active,
            textDisabled: ButtonComponentTokens.label_emphasized_disabled_default,
            textSelected: ButtonComponentTokens.label_emphasized_selected_default,
            textSelectedHover: ButtonComponentTokens.label_emphasized_selected_hover,
            textSelectedActive: ButtonComponentTokens.label_emphasized_selected_active,
            border: ButtonComponentTokens.border_emphasized_color_default,
            borderSelected: ButtonComponentTokens.border_emphasized_color_selected_default
        )

        static let subtle = ToneColors(
            background: ButtonComponentTokens.fill_subtle_default,
            backgroundHover: ButtonComponentTokens.fill_subtle_hover,
            backgroundActive: ButtonComponentTokens.fill_subtle_active,
            backgroundDisabled: ButtonComponentTokens.fill_subtle_disabled_default,
            backgroundSelected: ButtonComponentTokens.fill_subtle_selected_default,
            backgroundSelectedActive: ButtonComponentTokens.fill_subtle_selected_active,
            text: ButtonComponentTokens.label_subtle_default,
            textHover: ButtonComponentTokens.label_subtle_hover,
            textActive: ButtonComponentTokens.label_subtle_active,
            textDisabled: ButtonComponentTokens.label_subtle_disabled_default,
            textSelected: ButtonComponentTokens.label_subtle_selected_default,
            textSelectedHover: ButtonComponentTokens.label_subtle_selected_hover,
            textSelectedActive: ButtonComponentTokens.label_subtle_selected_active,
            border: Color.clear, // No border tokens for subtle in ELEVATE
            borderSelected: Color.clear
        )

        static let neutral = ToneColors(
            background: ButtonComponentTokens.fill_neutral_default,
            backgroundHover: ButtonComponentTokens.fill_neutral_hover,
            backgroundActive: ButtonComponentTokens.fill_neutral_active,
            backgroundDisabled: ButtonComponentTokens.fill_neutral_disabled_default,
            backgroundSelected: ButtonComponentTokens.fill_neutral_selected_default,
            backgroundSelectedActive: ButtonComponentTokens.fill_neutral_selected_active,
            text: ButtonComponentTokens.label_neutral_default,
            textHover: ButtonComponentTokens.label_neutral_hover,
            textActive: ButtonComponentTokens.label_neutral_active,
            textDisabled: ButtonComponentTokens.label_neutral_disabled_default,
            textSelected: ButtonComponentTokens.label_neutral_selected_default,
            textSelectedHover: ButtonComponentTokens.label_neutral_selected_hover,
            textSelectedActive: ButtonComponentTokens.label_neutral_selected_active,
            border: ButtonComponentTokens.border_neutral_color_default,
            borderSelected: ButtonComponentTokens.border_neutral_color_selected_default
        )

    }
}
#endif
