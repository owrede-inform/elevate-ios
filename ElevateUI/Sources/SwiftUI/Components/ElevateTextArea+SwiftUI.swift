#if os(iOS)
import SwiftUI

/// ELEVATE TextArea Component for SwiftUI
///
/// A multi-line text input field with label, placeholder, and validation support.
/// iOS adaptation of the web textarea component using TextEditor.
///
/// # Usage
/// ```swift
/// @State private var notes = ""
///
/// ElevateTextArea(
///     "Notes",
///     text: $notes,
///     placeholder: "Enter your notes here...",
///     size: .medium
/// )
/// ```
///
/// # iOS Adaptations
/// - Uses native TextEditor for multi-line input
/// - Keyboard handling and return key support
/// - Character counter (optional)
/// - Dynamic height or fixed height
/// - VoiceOver support
///
/// # Design Tokens
/// Uses ELEVATE textarea component tokens.
@available(iOS 15, *)
public struct ElevateTextArea: View {

    // MARK: - Properties

    private let label: String?
    @Binding private var text: String
    private let placeholder: String
    private let size: TextAreaTokens.Size
    private let isDisabled: Bool
    private let isInvalid: Bool
    private let isReadOnly: Bool
    private let helpText: String?
    private let maxLength: Int?
    private let showCharacterCount: Bool
    private let height: CGFloat?

    @FocusState private var isFocused: Bool

    // MARK: - Computed Properties

    private var sizeConfig: TextAreaTokens.SizeConfig {
        size.config
    }

    private var backgroundColor: Color {
        TextAreaTokens.backgroundColor(
            isDisabled: isDisabled,
            isInvalid: isInvalid,
            isReadOnly: isReadOnly
        )
    }

    private var borderColor: Color {
        TextAreaTokens.borderColor(
            isFocused: isFocused,
            isInvalid: isInvalid,
            isDisabled: isDisabled,
            isReadOnly: isReadOnly
        )
    }

    private var textColor: Color {
        TextAreaTokens.textColor(isDisabled: isDisabled)
    }

    private var placeholderColor: Color {
        TextAreaTokens.placeholderColor(isDisabled: isDisabled)
    }

    private var labelColor: Color {
        if isInvalid {
            return FieldComponentTokens.label_invalid_color
        }
        return isFocused
            ? FieldComponentTokens.label_focus_color
            : FieldComponentTokens.label_default_color
    }

    private var helpTextColor: Color {
        if isInvalid {
            return FieldComponentTokens.helpText_color_danger
        }
        return FieldComponentTokens.helpText_color_default
    }

    private var characterCountColor: Color {
        if let maxLength = maxLength, text.count > maxLength {
            return FieldComponentTokens.characterCounter_color_danger
        }
        return FieldComponentTokens.characterCounter_color_default
    }

    private var effectiveHeight: CGFloat {
        height ?? sizeConfig.minHeight
    }

    // MARK: - Initializer

    /// Creates a multi-line text area
    /// - Parameters:
    ///   - label: Optional label text
    ///   - text: Binding to the text value
    ///   - placeholder: Placeholder text when empty
    ///   - size: The size variant
    ///   - isDisabled: Whether the field is disabled
    ///   - isInvalid: Whether the field has validation errors
    ///   - isReadOnly: Whether the field is read-only
    ///   - helpText: Optional help text shown below
    ///   - maxLength: Maximum character count
    ///   - showCharacterCount: Whether to show character counter
    ///   - height: Custom height (nil for default)
    public init(
        _ label: String? = nil,
        text: Binding<String>,
        placeholder: String = "",
        size: TextAreaTokens.Size = .medium,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        isReadOnly: Bool = false,
        helpText: String? = nil,
        maxLength: Int? = nil,
        showCharacterCount: Bool = false,
        height: CGFloat? = nil
    ) {
        self.label = label
        self._text = text
        self.placeholder = placeholder
        self.size = size
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.isReadOnly = isReadOnly
        self.helpText = helpText
        self.maxLength = maxLength
        self.showCharacterCount = showCharacterCount
        self.height = height
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Label
            if let label = label {
                Text(label)
                    .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: labelFontSize)
                        .weight(.medium))
                    .foregroundColor(labelColor)
            }

            // Text editor with placeholder
            ZStack(alignment: .topLeading) {
                // Placeholder
                if text.isEmpty {
                    Text(placeholder)
                        .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: sizeConfig.fontSize))
                        .foregroundColor(placeholderColor)
                        .padding(.horizontal, sizeConfig.horizontalPadding)
                        .padding(.vertical, sizeConfig.verticalPadding)
                        .allowsHitTesting(false)
                }

                // Text editor
                TextEditor(text: Binding(
                    get: { text },
                    set: { newValue in
                        if let maxLength = maxLength, newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        } else {
                            text = newValue
                        }
                    }
                ))
                .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: sizeConfig.fontSize))
                .foregroundColor(textColor)
                .padding(.horizontal, sizeConfig.horizontalPadding - 5) // TextEditor has built-in padding
                .padding(.vertical, sizeConfig.verticalPadding - 8)
                .disabled(isDisabled || isReadOnly)
                .focused($isFocused)
                .apply { view in
                    if #available(iOS 16.0, *) {
                        view.scrollContentBackground(.hidden)
                    } else {
                        view
                    }
                }
            }
            .frame(minHeight: effectiveHeight)
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
                            .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: helpTextFontSize))
                            .foregroundColor(helpTextColor)
                    }

                    Spacer()

                    // Character count
                    if showCharacterCount {
                        Text("\(text.count)\(maxLength.map { "/\($0)" } ?? "")")
                            .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: helpTextFontSize))
                            .foregroundColor(characterCountColor)
                            .monospacedDigit()
                    }
                }
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label ?? "Text area")
        .accessibilityValue(text.isEmpty ? "Empty" : text)
    }

    // MARK: - Helper Properties

    /// Label font size based on iOS-scaled typography
    private var labelFontSize: CGFloat {
        switch size {
        case .small: return ElevateTypography.Sizes.labelSmall  // Already iOS-scaled: 15pt
        case .medium: return ElevateTypography.Sizes.labelMedium  // Already iOS-scaled: 17.5pt
        case .large: return ElevateTypography.Sizes.labelLarge  // Already iOS-scaled: 20pt
        }
    }

    /// Help text font size based on iOS-scaled typography
    private var helpTextFontSize: CGFloat {
        switch size {
        case .small: return ElevateTypography.Sizes.labelXSmall  // Already iOS-scaled: 13.75pt
        case .medium: return ElevateTypography.Sizes.labelSmall  // Already iOS-scaled: 15pt
        case .large: return ElevateTypography.Sizes.labelMedium  // Already iOS-scaled: 17.5pt
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateTextArea_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic Text Areas
            PreviewWrapper_Basic()
                .previewDisplayName("Basic")

            // Sizes
            PreviewWrapper_Sizes()
                .previewDisplayName("Sizes")

            // States
            PreviewWrapper_States()
                .previewDisplayName("States")

            // With Character Counter
            PreviewWrapper_CharacterCount()
                .previewDisplayName("Character Count")

            // Dark Mode
            PreviewWrapper_Basic()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }

    struct PreviewWrapper_Basic: View {
        @State private var notes = ""
        @State private var description = "Some initial text that spans multiple lines to demonstrate the multi-line text input capability."

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Basic Text Areas").font(.headline)

                    ElevateTextArea(
                        "Notes",
                        text: $notes,
                        placeholder: "Enter your notes here...",
                        helpText: "Add any additional notes"
                    )

                    ElevateTextArea(
                        "Description",
                        text: $description,
                        placeholder: "Describe the item..."
                    )
                }
                .padding()
            }
        }
    }

    struct PreviewWrapper_Sizes: View {
        @State private var textSmall = ""
        @State private var textMedium = ""
        @State private var textLarge = ""

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Sizes").font(.headline)

                    ElevateTextArea(
                        "Small",
                        text: $textSmall,
                        placeholder: "Small text area",
                        size: .small
                    )

                    ElevateTextArea(
                        "Medium",
                        text: $textMedium,
                        placeholder: "Medium text area",
                        size: .medium
                    )

                    ElevateTextArea(
                        "Large",
                        text: $textLarge,
                        placeholder: "Large text area",
                        size: .large
                    )
                }
                .padding()
            }
        }
    }

    struct PreviewWrapper_States: View {
        @State private var normalText = "Normal state"
        @State private var disabledText = "Disabled state"
        @State private var invalidText = "Invalid input"
        @State private var readOnlyText = "Read-only text that cannot be edited"

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("States").font(.headline)

                    ElevateTextArea(
                        "Normal",
                        text: $normalText,
                        helpText: "This is a normal text area"
                    )

                    ElevateTextArea(
                        "Disabled",
                        text: $disabledText,
                        isDisabled: true,
                        helpText: "This field is disabled"
                    )

                    ElevateTextArea(
                        "Invalid",
                        text: $invalidText,
                        isInvalid: true,
                        helpText: "Please enter valid content"
                    )

                    ElevateTextArea(
                        "Read-only",
                        text: $readOnlyText,
                        isReadOnly: true,
                        helpText: "This field is read-only"
                    )
                }
                .padding()
            }
        }
    }

    struct PreviewWrapper_CharacterCount: View {
        @State private var bio = ""

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Character Counter").font(.headline)

                    ElevateTextArea(
                        "Bio",
                        text: $bio,
                        placeholder: "Tell us about yourself...",
                        helpText: "Maximum 200 characters",
                        maxLength: 200,
                        showCharacterCount: true
                    )

                    Text("Current length: \(bio.count)")
                        .font(.caption)
                        .foregroundColor(ElevateAliases.Content.General.text_muted)
                }
                .padding()
            }
        }
    }
}
#endif

// MARK: - View Extension for Conditional Modifiers

@available(iOS 15, *)
extension View {
    @ViewBuilder
    func apply<Content: View>(@ViewBuilder transform: (Self) -> Content) -> some View {
        transform(self)
    }
}

#endif
