#if os(iOS)
import SwiftUI

/// ELEVATE TextField Component Design Tokens
///
/// Combines Input and Field tokens for a complete text field implementation.
/// References InputComponentTokens and FieldComponentTokens which contain all ELEVATE text input tokens.
///
/// Auto-generated component tokens maintain proper hierarchy:
/// Component Tokens → Alias Tokens → Primitive Tokens
@available(iOS 15, *)
public struct TextFieldTokens {

    // MARK: - TextField Sizes

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

    // MARK: - Size Configuration

    public struct SizeConfig {
        let height: CGFloat
        let horizontalPadding: CGFloat
        let verticalPadding: CGFloat
        let fontSize: CGFloat
        let iconSize: CGFloat
        let borderRadius: CGFloat
        let borderWidth: CGFloat
        let minTouchTarget: CGFloat

        static let small = SizeConfig(
            height: 36.0,  // 2rem web = 32pt, increased to 36pt
            horizontalPadding: 8.0,  // 0.5rem
            verticalPadding: 8.0,
            fontSize: ElevateTypography.Sizes.labelMedium,  // Already iOS-scaled: 17.5pt
            iconSize: 16.0,  // 1rem
            borderRadius: ElevateCornerRadius.xs,  // 4pt × 1.25 = 5pt (iOS scaled)
            borderWidth: 1.0,
            minTouchTarget: 44.0
        )

        static let medium = SizeConfig(
            height: 44.0,  // 2.5rem web = 40pt, meets 44pt minimum
            horizontalPadding: 12.0,  // 0.75rem
            verticalPadding: 10.0,
            fontSize: ElevateTypography.Sizes.bodyLarge,  // Already iOS-scaled: 20pt
            iconSize: 20.0,  // 1.25rem
            borderRadius: ElevateCornerRadius.xs,  // 4pt × 1.25 = 5pt (iOS scaled)
            borderWidth: 1.0,
            minTouchTarget: 44.0
        )

        static let large = SizeConfig(
            height: 52.0,  // 3rem web = 48pt, increased to 52pt
            horizontalPadding: 16.0,  // 1rem
            verticalPadding: 12.0,
            fontSize: ElevateTypography.Sizes.titleMedium,  // Already iOS-scaled: 20pt (titleMedium base)
            iconSize: 24.0,  // 1.5rem
            borderRadius: ElevateCornerRadius.xs,  // 4pt × 1.25 = 5pt (iOS scaled)
            borderWidth: 1.0,
            minTouchTarget: 44.0
        )
    }

    // MARK: - State Colors

    public struct StateColors {
        // Input field colors
        let background: Color
        let borderDefault: Color
        let borderFocused: Color
        let borderInvalid: Color

        // Text colors
        let text: Color
        let placeholder: Color

        // Label colors
        let label: Color
        let labelFocused: Color
        let labelInvalid: Color

        // Help text colors
        let helpText: Color
        let helpTextInvalid: Color

        // Icon colors
        let icon: Color

        static let normal = StateColors(
            background: InputComponentTokens.fill_default,  // Use Component Token
            borderDefault: InputComponentTokens.border_color_default,
            borderFocused: InputComponentTokens.border_color_selected,
            borderInvalid: InputComponentTokens.border_color_invalid,
            text: FieldComponentTokens.placeholder_text_value,
            placeholder: FieldComponentTokens.placeholder_text_placeholder,
            label: FieldComponentTokens.label_default_color,
            labelFocused: FieldComponentTokens.label_focus_color,
            labelInvalid: FieldComponentTokens.label_invalid_color,
            helpText: FieldComponentTokens.helpText_color_default,
            helpTextInvalid: FieldComponentTokens.helpText_color_danger,
            icon: InputComponentTokens.icon_default
        )

        static let disabled = StateColors(
            background: InputComponentTokens.fill_disabled,  // Use Component Token
            borderDefault: InputComponentTokens.border_color_disabled,
            borderFocused: InputComponentTokens.border_color_disabled,
            borderInvalid: InputComponentTokens.border_color_disabled,
            text: FieldComponentTokens.label_disabled_color,
            placeholder: FieldComponentTokens.helpText_color_disabled,
            label: FieldComponentTokens.label_disabled_color,
            labelFocused: FieldComponentTokens.label_disabled_color,
            labelInvalid: FieldComponentTokens.label_disabled_color,
            helpText: FieldComponentTokens.helpText_color_disabled,
            helpTextInvalid: FieldComponentTokens.helpText_color_disabled,
            icon: InputComponentTokens.icon_disabled
        )
    }

    // MARK: - Convenience Methods

    public static func backgroundColor(isDisabled: Bool) -> Color {
        isDisabled ? StateColors.disabled.background : StateColors.normal.background
    }

    public static func borderColor(isFocused: Bool, isInvalid: Bool, isDisabled: Bool) -> Color {
        let colors = isDisabled ? StateColors.disabled : StateColors.normal

        if isInvalid {
            return colors.borderInvalid
        }
        if isFocused {
            return colors.borderFocused
        }
        return colors.borderDefault
    }

    public static func textColor(isDisabled: Bool) -> Color {
        isDisabled ? StateColors.disabled.text : StateColors.normal.text
    }

    public static func placeholderColor(isDisabled: Bool) -> Color {
        isDisabled ? StateColors.disabled.placeholder : StateColors.normal.placeholder
    }

    public static func labelColor(isFocused: Bool, isInvalid: Bool, isDisabled: Bool) -> Color {
        let colors = isDisabled ? StateColors.disabled : StateColors.normal

        if isInvalid {
            return colors.labelInvalid
        }
        if isFocused {
            return colors.labelFocused
        }
        return colors.label
    }

    public static func helpTextColor(isInvalid: Bool, isDisabled: Bool) -> Color {
        let colors = isDisabled ? StateColors.disabled : StateColors.normal
        return isInvalid ? colors.helpTextInvalid : colors.helpText
    }

    public static func iconColor(isDisabled: Bool) -> Color {
        isDisabled ? StateColors.disabled.icon : StateColors.normal.icon
    }
}

#endif
