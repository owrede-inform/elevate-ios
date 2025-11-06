#if os(iOS)
import SwiftUI

/// Input component with iOS-native keyboard integration
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's hover states, this uses
/// focused states only (no hover on touch). Supports iOS keyboard types,
/// AutoFill, and keyboard accessories. See docs/DIVERSIONS.md.
///
/// Example:
/// ```swift
/// @State private var email = ""
///
/// ElevateInput(
///     text: $email,
///     placeholder: "Email",
///     keyboardType: .emailAddress
/// )
/// ```
@available(iOS 15, *)
public struct ElevateInput: View {

    @Binding private var text: String
    @FocusState private var isFocused: Bool

    private let placeholder: String
    private let leadingIcon: String?
    private let trailingIcon: String?
    private let isInvalid: Bool
    private let keyboardType: UIKeyboardType
    private let textContentType: UITextContentType?
    private let submitLabel: SubmitLabel
    private let onSubmit: (() -> Void)?

    @Environment(\.isEnabled) private var isEnabled

    // MARK: - Initialization

    public init(
        text: Binding<String>,
        placeholder: String = "",
        leadingIcon: String? = nil,
        trailingIcon: String? = nil,
        isInvalid: Bool = false,
        keyboardType: UIKeyboardType = .default,
        textContentType: UITextContentType? = nil,
        submitLabel: SubmitLabel = .done,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.leadingIcon = leadingIcon
        self.trailingIcon = trailingIcon
        self.isInvalid = isInvalid
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: InputComponentTokens.gap_icon_m) {
            // Leading icon
            if let leadingIcon = leadingIcon {
                Image(systemName: leadingIcon)
                    .foregroundColor(iconColor)
                    .font(.system(size: InputComponentTokens.icon_size_m))
            }

            // Text field
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .keyboardType(keyboardType)
                .textContentType(textContentType)
                .submitLabel(submitLabel)
                .onSubmit {
                    onSubmit?()
                }
                .foregroundColor(textColor)
                .disabled(!isEnabled)

            // Trailing icon
            if let trailingIcon = trailingIcon {
                Image(systemName: trailingIcon)
                    .foregroundColor(iconColor)
                    .font(.system(size: InputComponentTokens.icon_size_m))
            }
        }
        .padding(.horizontal, InputComponentTokens.padding_inline_m)
        .padding(.vertical, InputComponentTokens.padding_block_m)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: InputComponentTokens.border_radius_m)
                .stroke(borderColor, lineWidth: InputComponentTokens.border_width_m)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }

    // MARK: - Computed Properties

    /// iOS Adaptation: No hover state - use focused state only
    private var backgroundColor: Color {
        if !isEnabled {
            return InputComponentTokens.fill_disabled
        }
        if isInvalid {
            return InputComponentTokens.fill_invalid
        }
        // NOTE: Removed fill_hover - no hover on iOS per DIVERSIONS.md
        return InputComponentTokens.fill_default
    }

    /// iOS Adaptation: Map focused to "selected" state (closest equivalent)
    private var borderColor: Color {
        if !isEnabled {
            return InputComponentTokens.border_color_disabled
        }
        if isInvalid {
            return InputComponentTokens.border_color_invalid
        }
        if isFocused {
            // iOS focused state maps to web's "selected" border
            return InputComponentTokens.border_color_selected
        }
        // NOTE: Removed border_color_hover - no hover on iOS per DIVERSIONS.md
        return InputComponentTokens.border_color_default
    }

    private var textColor: Color {
        if !isEnabled {
            return InputComponentTokens.text_color_disabled
        }
        return InputComponentTokens.text_color_default
    }

    private var iconColor: Color {
        if !isEnabled {
            return InputComponentTokens.icon_disabled
        }
        return InputComponentTokens.icon_default
    }
}

// MARK: - Secure Input

@available(iOS 15, *)
public struct ElevateSecureInput: View {

    @Binding private var text: String
    @FocusState private var isFocused: Bool

    private let placeholder: String
    private let isInvalid: Bool
    private let textContentType: UITextContentType?
    private let submitLabel: SubmitLabel
    private let onSubmit: (() -> Void)?

    @Environment(\.isEnabled) private var isEnabled

    public init(
        text: Binding<String>,
        placeholder: String = "Password",
        isInvalid: Bool = false,
        textContentType: UITextContentType? = .password,
        submitLabel: SubmitLabel = .done,
        onSubmit: (() -> Void)? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.isInvalid = isInvalid
        self.textContentType = textContentType
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
    }

    public var body: some View {
        HStack(spacing: InputComponentTokens.gap_icon_m) {
            SecureField(placeholder, text: $text)
                .focused($isFocused)
                .textContentType(textContentType)
                .submitLabel(submitLabel)
                .onSubmit {
                    onSubmit?()
                }
                .foregroundColor(textColor)
                .disabled(!isEnabled)
        }
        .padding(.horizontal, InputComponentTokens.padding_inline_m)
        .padding(.vertical, InputComponentTokens.padding_block_m)
        .background(backgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: InputComponentTokens.border_radius_m)
                .stroke(borderColor, lineWidth: InputComponentTokens.border_width_m)
        )
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }

    private var backgroundColor: Color {
        if !isEnabled { return InputComponentTokens.fill_disabled }
        if isInvalid { return InputComponentTokens.fill_invalid }
        return InputComponentTokens.fill_default
    }

    private var borderColor: Color {
        if !isEnabled { return InputComponentTokens.border_color_disabled }
        if isInvalid { return InputComponentTokens.border_color_invalid }
        if isFocused { return InputComponentTokens.border_color_selected }
        return InputComponentTokens.border_color_default
    }

    private var textColor: Color {
        if !isEnabled { return InputComponentTokens.text_color_disabled }
        return InputComponentTokens.text_color_default
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateInput_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }

    struct PreviewContainer: View {
        @State private var email = ""
        @State private var password = ""
        @State private var search = ""
        @State private var phone = ""
        @State private var invalidEmail = "invalid"

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Input Examples")
                        .font(.title)

                    // Basic input
                    VStack(alignment: .leading) {
                        Text("Basic Input")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateInput(
                            text: $email,
                            placeholder: "Enter email",
                            keyboardType: .emailAddress,
                            textContentType: .emailAddress
                        )
                    }

                    // With icons
                    VStack(alignment: .leading) {
                        Text("With Icons")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateInput(
                            text: $search,
                            placeholder: "Search",
                            leadingIcon: "magnifyingglass",
                            trailingIcon: "xmark.circle.fill"
                        )
                    }

                    // Invalid state
                    VStack(alignment: .leading) {
                        Text("Invalid State")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateInput(
                            text: $invalidEmail,
                            placeholder: "Email",
                            isInvalid: true,
                            keyboardType: .emailAddress
                        )
                    }

                    // Secure input
                    VStack(alignment: .leading) {
                        Text("Secure Input (Password)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateSecureInput(
                            text: $password,
                            placeholder: "Password",
                            textContentType: .password
                        )
                    }

                    // Phone number
                    VStack(alignment: .leading) {
                        Text("Phone Number")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateInput(
                            text: $phone,
                            placeholder: "Phone",
                            leadingIcon: "phone",
                            keyboardType: .phonePad,
                            textContentType: .telephoneNumber
                        )
                    }

                    // Disabled
                    VStack(alignment: .leading) {
                        Text("Disabled State")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateInput(
                            text: .constant("Disabled"),
                            placeholder: "Disabled"
                        )
                        .disabled(true)
                    }

                    // iOS Adaptation notes
                    VStack(alignment: .leading, spacing: 8) {
                        Text("iOS Adaptations:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("✓ No hover states (touch device)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ Focused state instead")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ Native keyboard types")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ AutoFill support (.textContentType)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}
#endif

#endif
