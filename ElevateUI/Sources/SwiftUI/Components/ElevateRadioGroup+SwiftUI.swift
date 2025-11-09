#if os(iOS)
import SwiftUI

/// ELEVATE Radio Group Component
///
/// A container component that manages a group of radio buttons,
/// ensuring only one can be selected at a time.
///
/// **Web Component:** `<elvt-radio-group>`
/// **API Reference:** `.claude/components/Forms/radio-group.md`
@available(iOS 15, *)
public struct ElevateRadioGroup<Value: Hashable, Content: View>: View {

    // MARK: - Properties

    /// The label for the radio group
    private let label: String?

    /// Help text for the radio group
    private let helpText: String?

    /// The currently selected value
    @Binding private var selectedValue: Value?

    /// Whether the radio group is disabled
    private let isDisabled: Bool

    /// Whether the radio group is required
    private let isRequired: Bool

    /// Whether the radio group has invalid value
    private let isInvalid: Bool

    /// The size of the radio buttons
    private let size: RadioSize

    /// The content (radio buttons)
    private let content: () -> Content

    /// Action to perform when selection changes
    private let onChange: ((Value?) -> Void)?

    // MARK: - Initializer

    /// Creates a radio group with label and content
    public init(
        label: String? = nil,
        helpText: String? = nil,
        selectedValue: Binding<Value?>,
        isDisabled: Bool = false,
        isRequired: Bool = false,
        isInvalid: Bool = false,
        size: RadioSize = .medium,
        onChange: ((Value?) -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.label = label
        self.helpText = helpText
        self._selectedValue = selectedValue
        self.isDisabled = isDisabled
        self.isRequired = isRequired
        self.isInvalid = isInvalid
        self.size = size
        self.onChange = onChange
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: tokenGroupSpacing) {
            // Label (optional)
            if let label = label {
                HStack(spacing: 4) {
                    Text(label)
                        .font(tokenLabelFont)
                        .foregroundColor(tokenLabelColor)

                    if isRequired {
                        Text("*")
                            .font(tokenLabelFont)
                            .foregroundColor(tokenRequiredColor)
                    }
                }
            }

            // Radio options
            VStack(alignment: .leading, spacing: tokenItemSpacing) {
                content()
            }
            .disabled(isDisabled)

            // Help text (optional)
            if let helpText = helpText {
                Text(helpText)
                    .font(tokenHelpTextFont)
                    .foregroundColor(tokenHelpTextColor)
            }
        }
        .onChange(of: selectedValue) { newValue in
            onChange?(newValue)
        }
    }

    // MARK: - Token Accessors

    private var tokenGroupSpacing: CGFloat {
        switch size {
        case .small: return 8.0
        case .medium: return 12.0
        case .large: return 16.0
        }
    }

    private var tokenItemSpacing: CGFloat {
        switch size {
        case .small: return 8.0
        case .medium: return 12.0
        case .large: return 16.0
        }
    }

    private var tokenLabelFont: Font {
        switch size {
        case .small: return ElevateTypographyiOS.labelSmall   // 14pt (web: 12pt)
        case .medium: return ElevateTypographyiOS.labelMedium // 16pt (web: 14pt)
        case .large: return ElevateTypographyiOS.labelLarge   // 18pt (web: 16pt)
        }
    }

    private var tokenHelpTextFont: Font {
        ElevateTypographyiOS.bodySmall // 14pt (web: 12pt)
    }

    private var tokenLabelColor: Color {
        if isDisabled {
            return ElevateAliases.Content.General.text_muted
        }
        return ElevateAliases.Content.General.text_default
    }

    private var tokenHelpTextColor: Color {
        if isInvalid {
            return ElevateAliases.Feedback.General.text_danger
        }
        return ElevateAliases.Content.General.text_understated
    }

    private var tokenRequiredColor: Color {
        ElevateAliases.Feedback.Strong.fill_danger
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateRadioGroup_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Group
                PreviewGroup(
                    title: "Basic Radio Group",
                    label: "Select an option",
                    helpText: "Choose your preferred option"
                )

                Divider()

                // Required Group
                PreviewGroup(
                    title: "Required Group",
                    label: "Required Field",
                    isRequired: true
                )

                Divider()

                // Invalid Group
                PreviewGroup(
                    title: "Invalid State",
                    label: "Selection Error",
                    helpText: "Please select a valid option",
                    isInvalid: true
                )

                Divider()

                // Disabled Group
                PreviewGroup(
                    title: "Disabled Group",
                    label: "Cannot Change",
                    isDisabled: true
                )

                Divider()

                // Size Variations
                VStack(alignment: .leading, spacing: 16) {
                    Text("Size Variations").font(.headline)

                    PreviewGroup(
                        title: "Small",
                        label: "Small Radios",
                        size: .small
                    )

                    PreviewGroup(
                        title: "Medium",
                        label: "Medium Radios",
                        size: .medium
                    )

                    PreviewGroup(
                        title: "Large",
                        label: "Large Radios",
                        size: .large
                    )
                }
            }
            .padding()
        }
    }

    struct PreviewGroup: View {
        let title: String
        var label: String? = nil
        var helpText: String? = nil
        var isDisabled: Bool = false
        var isRequired: Bool = false
        var isInvalid: Bool = false
        var size: RadioSize = .medium

        @State private var selectedValue: String? = "option1"

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title).font(.subheadline).foregroundColor(.secondary)

                ElevateRadioGroup(
                    label: label,
                    helpText: helpText,
                    selectedValue: $selectedValue,
                    isDisabled: isDisabled,
                    isRequired: isRequired,
                    isInvalid: isInvalid,
                    size: size
                ) {
                    ElevateRadio(
                        "First Option",
                        value: "option1",
                        selectedValue: $selectedValue,
                        isDisabled: isDisabled,
                        isInvalid: isInvalid,
                        size: size
                    )

                    ElevateRadio(
                        "Second Option",
                        value: "option2",
                        selectedValue: $selectedValue,
                        isDisabled: isDisabled,
                        isInvalid: isInvalid,
                        size: size
                    )

                    ElevateRadio(
                        "Third Option",
                        value: "option3",
                        selectedValue: $selectedValue,
                        isDisabled: isDisabled,
                        isInvalid: isInvalid,
                        size: size
                    )
                }
            }
        }
    }
}
#endif

#endif
