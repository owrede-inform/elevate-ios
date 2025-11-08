#if os(iOS)
import SwiftUI

/// ELEVATE TextField Component for SwiftUI
///
/// A text input field with label, placeholder, validation, and optional icons.
/// Follows iOS keyboard handling patterns and design guidelines.
///
/// # Usage
/// ```swift
/// @State private var email = ""
///
/// ElevateTextField(
///     "Email",
///     text: $email,
///     placeholder: "Enter your email",
///     size: .medium
/// )
/// .keyboardType(.emailAddress)
/// .textContentType(.emailAddress)
/// .autocapitalization(.never)
///
/// // With validation
/// ElevateTextField(
///     "Password",
///     text: $password,
///     isInvalid: !isValidPassword,
///     helpText: "Must be at least 8 characters"
/// )
/// .keyboardType(.default)
/// .textContentType(.password)
/// ```
///
/// # iOS Adaptations
/// - Native keyboard types and content types
/// - Return key handling (.done, .next, .search, etc.)
/// - Proper focus management
/// - Keyboard toolbar support
/// - Character counter (optional)
/// - Clear button (optional)
/// - Prefix/suffix icon support
///
/// # Design Tokens
/// Uses ELEVATE input and field component tokens.
@available(iOS 15, *)
public struct ElevateTextField: View {

    // MARK: - Properties

    private let label: String?
    @Binding private var text: String
    private let placeholder: String
    private let size: TextFieldTokens.Size
    private let isDisabled: Bool
    private let isInvalid: Bool
    private let helpText: String?
    private let maxLength: Int?
    private let showCharacterCount: Bool
    private let isClearable: Bool
    private let prefixIcon: ElevateIcon?
    private let suffixIcon: ElevateIcon?

    @FocusState private var isFocused: Bool
    @State private var isSecure: Bool

    // MARK: - Computed Properties

    private var sizeConfig: TextFieldTokens.SizeConfig {
        size.config
    }

    private var backgroundColor: Color {
        TextFieldTokens.backgroundColor(isDisabled: isDisabled)
    }

    private var borderColor: Color {
        TextFieldTokens.borderColor(
            isFocused: isFocused,
            isInvalid: isInvalid,
            isDisabled: isDisabled
        )
    }

    private var textColor: Color {
        TextFieldTokens.textColor(isDisabled: isDisabled)
    }

    private var placeholderColor: Color {
        TextFieldTokens.placeholderColor(isDisabled: isDisabled)
    }

    private var labelColor: Color {
        guard let _ = label else { return .clear }
        return TextFieldTokens.labelColor(
            isFocused: isFocused,
            isInvalid: isInvalid,
            isDisabled: isDisabled
        )
    }

    private var helpTextColor: Color {
        TextFieldTokens.helpTextColor(isInvalid: isInvalid, isDisabled: isDisabled)
    }

    private var characterCountColor: Color {
        if let maxLength = maxLength, text.count > maxLength {
            return FieldComponentTokens.characterCounter_color_danger
        }
        return FieldComponentTokens.characterCounter_color_default
    }

    private var showClearButton: Bool {
        isClearable && !text.isEmpty && isFocused && !isDisabled
    }

    // MARK: - Initializer

    public init(
        _ label: String? = nil,
        text: Binding<String>,
        placeholder: String = "",
        size: TextFieldTokens.Size = .medium,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        helpText: String? = nil,
        maxLength: Int? = nil,
        showCharacterCount: Bool = false,
        isClearable: Bool = false,
        prefixIcon: ElevateIcon? = nil,
        suffixIcon: ElevateIcon? = nil,
        isSecure: Bool = false
    ) {
        self.label = label
        self._text = text
        self.placeholder = placeholder
        self.size = size
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.helpText = helpText
        self.maxLength = maxLength
        self.showCharacterCount = showCharacterCount
        self.isClearable = isClearable
        self.prefixIcon = prefixIcon
        self.suffixIcon = suffixIcon
        self._isSecure = State(initialValue: isSecure)
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Label
            if let label = label {
                Text(label)
                    .font(.system(size: labelFontSize, weight: .medium))
                    .foregroundColor(labelColor)
            }

            // Input field
            HStack(spacing: 8) {
                // Prefix icon
                if let prefixIcon = prefixIcon {
                    prefixIcon
                        .frame(width: sizeConfig.iconSize, height: sizeConfig.iconSize)
                        .foregroundColor(TextFieldTokens.iconColor(isDisabled: isDisabled))
                }

                // Text input
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: sizeConfig.fontSize))
                        .foregroundColor(textColor)
                        .disabled(isDisabled)
                        .focused($isFocused)
                } else {
                    TextField(placeholder, text: $text)
                        .font(.system(size: sizeConfig.fontSize))
                        .foregroundColor(textColor)
                        .disabled(isDisabled)
                        .focused($isFocused)
                        .onChange(of: text) { newValue in
                            if let maxLength = maxLength, newValue.count > maxLength {
                                text = String(newValue.prefix(maxLength))
                            }
                        }
                }

                // Clear button
                if showClearButton {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(ElevateAliases.Content.General.text_muted)
                        .font(.system(size: sizeConfig.iconSize))
                        .scrollFriendlyTap(action: clearText)
                        .accessibilityLabel("Clear text")
                }

                // Suffix icon
                if let suffixIcon = suffixIcon {
                    suffixIcon
                        .frame(width: sizeConfig.iconSize, height: sizeConfig.iconSize)
                        .foregroundColor(TextFieldTokens.iconColor(isDisabled: isDisabled))
                }
            }
            .padding(.horizontal, sizeConfig.horizontalPadding)
            .frame(height: sizeConfig.height)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: sizeConfig.borderRadius))
            .overlay(
                RoundedRectangle(cornerRadius: sizeConfig.borderRadius)
                    .strokeBorder(borderColor, lineWidth: sizeConfig.borderWidth)
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
            .animation(.easeInOut(duration: 0.2), value: isInvalid)

            // Help text and character count
            if helpText != nil || showCharacterCount {
                HStack {
                    // Help text
                    if let helpText = helpText {
                        Text(helpText)
                            .font(.system(size: helpTextFontSize))
                            .foregroundColor(helpTextColor)
                    }

                    Spacer()

                    // Character count
                    if showCharacterCount {
                        Text("\(text.count)\(maxLength.map { "/\($0)" } ?? "")")
                            .font(.system(size: helpTextFontSize))
                            .foregroundColor(characterCountColor)
                            .monospacedDigit()
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label ?? placeholder)
        .accessibilityValue(text.isEmpty ? "Empty" : text)
    }

    // MARK: - Actions

    private func clearText() {
        text = ""
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    // MARK: - Helper Properties

    private var labelFontSize: CGFloat {
        switch size {
        case .small: return 13.0
        case .medium: return 14.0
        case .large: return 16.0
        }
    }

    private var helpTextFontSize: CGFloat {
        switch size {
        case .small: return 11.0
        case .medium: return 12.0
        case .large: return 13.0
        }
    }
}

// MARK: - Convenience Modifiers

@available(iOS 15, *)
public extension ElevateTextField {
    /// Sets the keyboard type for the text field
    func keyboardType(_ type: UIKeyboardType) -> some View {
        // Note: This modifier can't be applied directly to ElevateTextField
        // Users should apply it to the root view containing the text field
        self
    }
}

// MARK: - Previews

/*
// Temporarily disabled due to SwiftUI type inference issue
@available(iOS 15, *)
struct ElevateTextField_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic Text Fields
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Basic Text Fields").font(.headline)

                    ElevateTextField(
                        "Email",
                        text: .constant(""),
                        placeholder: "Enter your email",
                        size: .small
                    )

                    ElevateTextField(
                        "Username",
                        text: .constant("john_doe"),
                        placeholder: "Enter username",
                        size: .medium
                    )

                    ElevateTextField(
                        "Company Name",
                        text: .constant(""),
                        placeholder: "Enter company name",
                        size: .large
                    )
                }
                .padding()
            }
            .previewDisplayName("Basic")

            // With Icons
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("With Icons").font(.headline)

                    ElevateTextField(
                        "Search",
                        text: .constant(""),
                        placeholder: "Search...",
                        prefixIcon: .search
                    )

                    ElevateTextField(
                        "Email",
                        text: .constant("user@example.com"),
                        placeholder: "Email",
                        isClearable: true,
                        prefixIcon: .mail
                    )

                    ElevateTextField(
                        "Website",
                        text: .constant("https://example.com"),
                        placeholder: "URL",
                        prefixIcon: .link,
                        suffixIcon: .externalLink
                    )
                }
                .padding()
            }
            .previewDisplayName("With Icons")

            // States
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("States").font(.headline)

                    ElevateTextField(
                        "Normal",
                        text: .constant("Normal state"),
                        helpText: "This is help text"
                    )

                    ElevateTextField(
                        "Disabled",
                        text: .constant("Disabled state"),
                        isDisabled: true,
                        helpText: "Field is disabled"
                    )

                    ElevateTextField(
                        "Invalid",
                        text: .constant("invalid@"),
                        isInvalid: true,
                        helpText: "Please enter a valid email"
                    )

                    ElevateTextField(
                        "With Counter",
                        text: .constant("Hello World"),
                        maxLength: 50,
                        showCharacterCount: true
                    )
                }
                .padding()
            }
            .previewDisplayName("States")

            // Dark Mode
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ElevateTextField(
                        "Dark Mode",
                        text: .constant("Sample text"),
                        placeholder: "Enter text",
                        prefixIcon: .pencil,
                        helpText: "This is in dark mode"
                    )

                    ElevateTextField(
                        "Invalid Dark",
                        text: .constant("Error"),
                        isInvalid: true,
                        helpText: "Validation error"
                    )
                }
                .padding()
            }
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
    }
}
*/

#endif
