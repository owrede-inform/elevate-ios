#if os(iOS)
import SwiftUI

/// ELEVATE Button Component Design Tokens
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens.py to update
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
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

        /// Secondary button colors
        static let secondary = ToneColors(
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

        /// Success button colors
        static let success = ToneColors(
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

        /// Warning button colors
        static let warning = ToneColors(
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

        /// Danger button colors
        static let danger = ToneColors(
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

        /// Emphasized button colors
        static let emphasized = ToneColors(
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

        /// Subtle button colors
        static let subtle = ToneColors(
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

        /// Neutral button colors
        static let neutral = ToneColors(
            background: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundHover: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundActive: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            backgroundDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            text: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            textDisabled: Color(red: 0.5020, green: 0.5020, blue: 0.5020),
            border: Color(red: 0.5020, green: 0.5020, blue: 0.5020)
        )

    }
}
#endif
