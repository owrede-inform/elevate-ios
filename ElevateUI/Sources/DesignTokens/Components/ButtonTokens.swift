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

        public var componentSize: ElevateSpacing.ComponentSize {
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
        }
    }

    // MARK: - Button Shapes

    public enum Shape {
        case `default`  // Squared corners (box)
        case pill       // Fully rounded

        public var borderRadius: CGFloat {
            switch self {
            case .default: return ElevateSpacing.BorderRadius.small
            case .pill: return ElevateSpacing.BorderRadius.full
            }
        }
    }

    public enum State {
        case `default`, hover, active, disabled
    }

    // MARK: - Tone Color Configurations

    public struct ToneColors {
        let background: Color
        let backgroundHover: Color
        let backgroundActive: Color
        let backgroundDisabled: Color
        let backgroundSelected: Color
        let backgroundSelectedActive: Color
        let text: Color
        let textDisabled: Color
        let textSelected: Color
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
            textDisabled: ButtonComponentTokens.label_primary_disabled_default,
            textSelected: ButtonComponentTokens.label_primary_selected_default,
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
            textDisabled: ButtonComponentTokens.label_success_disabled_default,
            textSelected: ButtonComponentTokens.label_success_selected_default,
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
            textDisabled: ButtonComponentTokens.label_warning_disabled_default,
            textSelected: ButtonComponentTokens.label_warning_selected_default,
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
            textDisabled: ButtonComponentTokens.label_danger_disabled_default,
            textSelected: ButtonComponentTokens.label_danger_selected_default,
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
            textDisabled: ButtonComponentTokens.label_emphasized_disabled_default,
            textSelected: ButtonComponentTokens.label_emphasized_selected_default,
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
            textDisabled: ButtonComponentTokens.label_subtle_disabled_default,
            textSelected: ButtonComponentTokens.label_subtle_selected_default,
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
            textDisabled: ButtonComponentTokens.label_neutral_disabled_default,
            textSelected: ButtonComponentTokens.label_neutral_selected_default,
            border: ButtonComponentTokens.border_neutral_color_default,
            borderSelected: ButtonComponentTokens.border_neutral_color_selected_default
        )

    }
}
#endif
