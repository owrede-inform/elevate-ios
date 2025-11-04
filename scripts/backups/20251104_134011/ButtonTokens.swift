#if os(iOS)
import SwiftUI

/// ELEVATE Button Component Design Tokens
///
/// This file defines button-specific design tokens including tones (color variants),
/// sizes, and states (default, hover, active, disabled).
///
/// Based on ELEVATE Core UI button component tokens
@available(iOS 15, *)
public struct ButtonTokens {

    // MARK: - Button Tones

    /// Defines the visual tone/variant of a button
    public enum Tone {
        case primary
        case secondary
        case success
        case warning
        case danger
        case emphasized
        case subtle
        case neutral

        /// Get the color configuration for this tone
        public var colors: ToneColors {
            switch self {
            case .primary: return .primary
            case .secondary: return .secondary
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

    /// Defines the size variant of a button
    public enum Size {
        case small
        case medium
        case large

        public var componentSize: ElevateSpacing.ComponentSize {
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
        }
    }

    // MARK: - Button States

    /// Defines the interaction state of a button
    public enum State {
        case `default`
        case hover
        case active
        case disabled
    }

    // MARK: - Button Shapes

    /// Defines the shape variant of a button
    public enum Shape {
        case `default`
        case pill

        public var borderRadius: CGFloat {
            switch self {
            case .default: return ElevateSpacing.BorderRadius.medium
            case .pill: return ElevateSpacing.BorderRadius.full
            }
        }
    }

    // MARK: - Tone Color Configurations

    public struct ToneColors {
        let background: Color
        let backgroundHover: Color
        let backgroundActive: Color
        let backgroundDisabled: Color
        let text: Color
        let textDisabled: Color
        let border: Color

        /// Primary button colors
        static let primary = ToneColors(
            background: ElevateColors.primary,
            backgroundHover: ElevateColors.primary.opacity(0.9),
            backgroundActive: ElevateColors.primary.opacity(0.8),
            backgroundDisabled: ElevateColors.primary.opacity(0.3),
            text: ElevateColors.Text.inverse,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.primary
        )

        /// Secondary button colors
        static let secondary = ToneColors(
            background: ElevateColors.secondary,
            backgroundHover: ElevateColors.secondary.opacity(0.9),
            backgroundActive: ElevateColors.secondary.opacity(0.8),
            backgroundDisabled: ElevateColors.secondary.opacity(0.3),
            text: ElevateColors.Text.inverse,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.secondary
        )

        /// Success button colors
        static let success = ToneColors(
            background: ElevateColors.success,
            backgroundHover: ElevateColors.success.opacity(0.9),
            backgroundActive: ElevateColors.success.opacity(0.8),
            backgroundDisabled: ElevateColors.success.opacity(0.3),
            text: ElevateColors.Text.inverse,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.success
        )

        /// Warning button colors
        static let warning = ToneColors(
            background: ElevateColors.warning,
            backgroundHover: ElevateColors.warning.opacity(0.9),
            backgroundActive: ElevateColors.warning.opacity(0.8),
            backgroundDisabled: ElevateColors.warning.opacity(0.3),
            text: ElevateColors.Text.primary,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.warning
        )

        /// Danger button colors
        static let danger = ToneColors(
            background: ElevateColors.danger,
            backgroundHover: ElevateColors.danger.opacity(0.9),
            backgroundActive: ElevateColors.danger.opacity(0.8),
            backgroundDisabled: ElevateColors.danger.opacity(0.3),
            text: ElevateColors.Text.inverse,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.danger
        )

        /// Emphasized button colors (high contrast)
        static let emphasized = ToneColors(
            background: ElevateColors.Text.primary,
            backgroundHover: ElevateColors.Text.primary.opacity(0.9),
            backgroundActive: ElevateColors.Text.primary.opacity(0.8),
            backgroundDisabled: ElevateColors.Text.primary.opacity(0.3),
            text: ElevateColors.Background.primary,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.Text.primary
        )

        /// Subtle button colors (low contrast)
        static let subtle = ToneColors(
            background: ElevateColors.Surface.secondary,
            backgroundHover: ElevateColors.Surface.secondary.opacity(0.8),
            backgroundActive: ElevateColors.Surface.secondary.opacity(0.6),
            backgroundDisabled: ElevateColors.Surface.secondary.opacity(0.3),
            text: ElevateColors.Text.primary,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.Border.subtle
        )

        /// Neutral button colors
        static let neutral = ToneColors(
            background: ElevateColors.Background.secondary,
            backgroundHover: ElevateColors.Background.secondary.opacity(0.8),
            backgroundActive: ElevateColors.Background.secondary.opacity(0.6),
            backgroundDisabled: ElevateColors.Background.secondary.opacity(0.3),
            text: ElevateColors.Text.primary,
            textDisabled: ElevateColors.Text.disabled,
            border: ElevateColors.Border.default
        )
    }
}
#endif
