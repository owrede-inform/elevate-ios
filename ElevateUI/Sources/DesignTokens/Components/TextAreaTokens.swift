#if os(iOS)
import SwiftUI

/// ELEVATE TextArea Component Token Wrapper
///
/// Wraps the auto-generated TextareaComponentTokens with convenience methods
/// for multi-line text input styling.
///
/// iOS Implementation Note:
/// TextArea maps to SwiftUI TextEditor for multi-line text input.
@available(iOS 15, *)
public struct TextAreaTokens {

    // MARK: - Size Configuration

    public enum Size {
        case small
        case medium
        case large
    }

    public struct SizeConfig {
        let minHeight: CGFloat
        let horizontalPadding: CGFloat
        let verticalPadding: CGFloat
        let fontSize: CGFloat
        let borderRadius: CGFloat
        let borderWidth: CGFloat

        static let small = SizeConfig(
            minHeight: 80.0,
            horizontalPadding: 12.0,
            verticalPadding: 8.0,
            fontSize: 14.0,
            borderRadius: 4.0,
            borderWidth: 1.0
        )

        static let medium = SizeConfig(
            minHeight: 120.0,
            horizontalPadding: 16.0,
            verticalPadding: 12.0,
            fontSize: 16.0,
            borderRadius: 6.0,
            borderWidth: 1.0
        )

        static let large = SizeConfig(
            minHeight: 160.0,
            horizontalPadding: 20.0,
            verticalPadding: 16.0,
            fontSize: 18.0,
            borderRadius: 8.0,
            borderWidth: 1.0
        )
    }

    // MARK: - Field Colors

    /// Background color for default state
    public static func backgroundColor(isDisabled: Bool, isInvalid: Bool, isReadOnly: Bool) -> Color {
        if isDisabled {
            return TextareaComponentTokens.field_fill_disabled
        }
        if isReadOnly {
            return TextareaComponentTokens.field_fill_read_only
        }
        if isInvalid {
            return TextareaComponentTokens.field_fill_invalid
        }
        return TextareaComponentTokens.field_fill_default
    }

    /// Border color based on state
    public static func borderColor(
        isFocused: Bool,
        isInvalid: Bool,
        isDisabled: Bool,
        isReadOnly: Bool
    ) -> Color {
        if isFocused {
            return isInvalid
                ? TextareaComponentTokens.field_border_focus_color_invalid
                : TextareaComponentTokens.field_border_focus_color_default
        }

        if isDisabled {
            return TextareaComponentTokens.field_border_form_color_neutral_disabled_disabled
        }

        if isReadOnly {
            return TextareaComponentTokens.field_border_form_color_neutral_read_only_default
        }

        if isInvalid {
            return TextareaComponentTokens.field_border_form_color_invalid_default
        }

        return TextareaComponentTokens.field_border_form_color_neutral_default_default
    }

    /// Text color
    public static func textColor(isDisabled: Bool) -> Color {
        isDisabled
            ? TextareaComponentTokens.field_text_input_color_disabled
            : TextareaComponentTokens.field_text_input_color_default
    }

    /// Placeholder color
    public static func placeholderColor(isDisabled: Bool) -> Color {
        isDisabled
            ? TextareaComponentTokens.field_placeholder_color_disabled
            : TextareaComponentTokens.field_placeholder_color_default
    }
}

extension TextAreaTokens.Size {
    var config: TextAreaTokens.SizeConfig {
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
