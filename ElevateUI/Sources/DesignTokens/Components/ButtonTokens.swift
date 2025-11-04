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
            background: Color(red: 0.0431, green: 0.3608, blue: 0.8745),
            backgroundHover: Color(red: 0.1059, green: 0.3137, blue: 0.6510),
            backgroundActive: Color(red: 0.1373, green: 0.2000, blue: 0.2941),
            backgroundDisabled: Color(red: 0.5647, green: 0.7765, blue: 1.0000),
            text: Color(red: 1.0000, green: 1.0000, blue: 1.0000),
            textDisabled: Color(red: 0.9176, green: 0.9569, blue: 1.0000),
            border: Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.0000)
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
            background: Color(red: 0.0196, green: 0.4627, blue: 0.2392),
            backgroundHover: Color(red: 0.0196, green: 0.3765, blue: 0.2118),
            backgroundActive: Color(red: 0.0627, green: 0.2275, blue: 0.1490),
            backgroundDisabled: Color(red: 0.6667, green: 0.9020, blue: 0.7373),
            text: Color(red: 1.0000, green: 1.0000, blue: 1.0000),
            textDisabled: Color(red: 0.9020, green: 0.9725, blue: 0.9255),
            border: Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.0000)
        )

        /// Warning button colors
        static let warning = ToneColors(
            background: Color(red: 0.9725, green: 0.5608, blue: 0.0000),
            backgroundHover: Color(red: 0.8471, green: 0.4706, blue: 0.0000),
            backgroundActive: Color(red: 0.6431, green: 0.3020, blue: 0.0000),
            backgroundDisabled: Color(red: 1.0000, green: 0.9529, blue: 0.8275),
            text: Color(red: 0.3725, green: 0.1098, blue: 0.0000),
            textDisabled: Color(red: 1.0000, green: 0.7020, blue: 0.2118),
            border: Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.0000)
        )

        /// Danger button colors
        static let danger = ToneColors(
            background: Color(red: 0.8078, green: 0.0039, blue: 0.0039),
            backgroundHover: Color(red: 0.6706, green: 0.0039, blue: 0.0039),
            backgroundActive: Color(red: 0.4235, green: 0.0039, blue: 0.0039),
            backgroundDisabled: Color(red: 1.0000, green: 0.6745, blue: 0.6745),
            text: Color(red: 1.0000, green: 1.0000, blue: 1.0000),
            textDisabled: Color(red: 1.0000, green: 0.9412, blue: 0.9412),
            border: Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.0000)
        )

        /// Emphasized button colors
        static let emphasized = ToneColors(
            background: Color(red: 0.8353, green: 0.8510, blue: 0.8824),
            backgroundHover: Color(red: 0.7451, green: 0.7647, blue: 0.8039),
            backgroundActive: Color(red: 0.5333, green: 0.5686, blue: 0.6275),
            backgroundDisabled: Color(red: 0.8353, green: 0.8510, blue: 0.8824),
            text: Color(red: 0.1843, green: 0.1961, blue: 0.2510),
            textDisabled: Color(red: 0.6392, green: 0.6667, blue: 0.7059),
            border: Color(red: 0.4392, green: 0.4784, blue: 0.5608)
        )

        /// Subtle button colors
        static let subtle = ToneColors(
            background: Color(red: 0.9176, green: 0.9569, blue: 1.0000),
            backgroundHover: Color(red: 0.7255, green: 0.8588, blue: 1.0000),
            backgroundActive: Color(red: 0.3725, green: 0.6745, blue: 1.0000),
            backgroundDisabled: Color(red: 0.7255, green: 0.8588, blue: 1.0000),
            text: Color(red: 0.0431, green: 0.3608, blue: 0.8745),
            textDisabled: Color(red: 0.9176, green: 0.9569, blue: 1.0000),
            border: Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.0000)
        )

        /// Neutral button colors
        static let neutral = ToneColors(
            background: Color(red: 1.0000, green: 1.0000, blue: 1.0000),
            backgroundHover: Color(red: 0.9529, green: 0.9569, blue: 0.9686),
            backgroundActive: Color(red: 0.7451, green: 0.7647, blue: 0.8039),
            backgroundDisabled: Color(red: 0.9529, green: 0.9569, blue: 0.9686),
            text: Color(red: 0.1843, green: 0.1961, blue: 0.2510),
            textDisabled: Color(red: 0.6392, green: 0.6667, blue: 0.7059),
            border: Color(red: 0.6392, green: 0.6667, blue: 0.7059)
        )

    }
}
#endif
