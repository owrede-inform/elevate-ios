#if os(iOS)
import SwiftUI

/// ELEVATE Field Component
///
/// Wrapper for form controls with label, help text, and validation state.
/// Provides consistent layout and styling for form fields.
///
/// **Web Component:** `<elvt-field>`
/// **API Reference:** `.claude/components/Forms/field.md`
@available(iOS 15, *)
public struct ElevateField<Control: View>: View {

    // MARK: - Properties

    /// The field label text
    private let label: String

    /// Optional help text
    private let helpText: String?

    /// Whether the field is required
    private let isRequired: Bool

    /// Whether the field is disabled
    private let isDisabled: Bool

    /// Whether the field is invalid
    private let isInvalid: Bool

    /// Whether to hide the label visually
    private let hideLabel: Bool

    /// The size of the field
    private let size: FieldSize

    /// Optional status text (e.g., character count)
    private let status: String?

    /// The form control
    private let control: () -> Control

    // MARK: - Initializer

    /// Creates a field wrapper
    ///
    /// - Parameters:
    ///   - label: The field label text
    ///   - helpText: Optional help text (default: nil)
    ///   - isRequired: Whether required (default: false)
    ///   - isDisabled: Whether disabled (default: false)
    ///   - isInvalid: Whether invalid (default: false)
    ///   - hideLabel: Visually hide label (default: false)
    ///   - size: The field size (default: .medium)
    ///   - status: Optional status text (default: nil)
    ///   - control: The form control view
    public init(
        _ label: String,
        helpText: String? = nil,
        isRequired: Bool = false,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        hideLabel: Bool = false,
        size: FieldSize = .medium,
        status: String? = nil,
        @ViewBuilder control: @escaping () -> Control
    ) {
        self.label = label
        self.helpText = helpText
        self.isRequired = isRequired
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.hideLabel = hideLabel
        self.size = size
        self.status = status
        self.control = control
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: tokenGap) {
            // Label
            if !hideLabel {
                HStack(spacing: tokenRequiredIndicatorGap) {
                    Text(label)
                        .font(labelFont)
                        .foregroundColor(tokenLabelColor)

                    if isRequired {
                        Text("*")
                            .font(labelFont)
                            .foregroundColor(tokenLabelColor)
                    }
                }
            }

            // Control
            control()

            // Footer (help text and/or status)
            if helpText != nil || status != nil {
                HStack(alignment: .top) {
                    if let helpText = helpText {
                        HStack(alignment: .top, spacing: tokenHelpTextPrefixGap) {
                            if isInvalid {
                                Image(systemName: "exclamationmark.circle.fill")
                                    .font(.caption)
                                    .foregroundColor(tokenHelpTextColor)
                            }

                            Text(helpText)
                                .font(ElevateTypographyiOS.bodySmall) // 14pt (web: 12pt)
                                .foregroundColor(tokenHelpTextColor)
                        }
                    }

                    if let status = status {
                        Spacer()
                        Text(status)
                            .font(ElevateTypographyiOS.bodySmall) // 14pt (web: 12pt)
                            .foregroundColor(tokenStatusColor)
                    }
                }
            }
        }
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityElement(children: .contain)
    }

    // MARK: - Token Accessors

    private var tokenGap: CGFloat {
        switch size {
        case .small: return FieldComponentTokens.gap_s
        case .medium: return FieldComponentTokens.gap_m
        case .large: return FieldComponentTokens.gap_l
        }
    }

    private var tokenRequiredIndicatorGap: CGFloat {
        switch size {
        case .small: return FieldComponentTokens.label_gap_required_indicator_s
        case .medium: return FieldComponentTokens.label_gap_required_indicator_m
        case .large: return FieldComponentTokens.label_gap_required_indicator_l
        }
    }

    private var tokenHelpTextPrefixGap: CGFloat {
        switch size {
        case .small: return FieldComponentTokens.helpText_gap_prefix_s
        case .medium: return FieldComponentTokens.helpText_gap_prefix_m
        case .large: return FieldComponentTokens.helpText_gap_prefix_l
        }
    }

    private var tokenLabelColor: Color {
        if isDisabled {
            return FieldComponentTokens.label_disabled_color
        }
        if isInvalid {
            return FieldComponentTokens.label_invalid_color
        }
        return FieldComponentTokens.label_default_color
    }

    private var tokenHelpTextColor: Color {
        if isDisabled {
            return FieldComponentTokens.helpText_color_disabled
        }
        if isInvalid {
            return FieldComponentTokens.helpText_color_danger
        }
        return FieldComponentTokens.helpText_color_default
    }

    private var tokenStatusColor: Color {
        isInvalid ? FieldComponentTokens.characterCounter_color_danger : FieldComponentTokens.characterCounter_color_default
    }

    private var labelFont: Font {
        switch size {
        case .small: return ElevateTypographyiOS.labelSmall // 14pt (web: 12pt)
        case .medium: return ElevateTypographyiOS.labelMedium // 16pt (web: 14pt)
        case .large: return ElevateTypographyiOS.labelLarge // 18pt (web: 16pt)
        }
    }
}

// MARK: - Field Size

@available(iOS 15, *)
public enum FieldSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateField_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Field
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Fields").font(.headline)

                    ElevateField("Email") {
                        TextField("Enter your email", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }

                    ElevateField("Password", isRequired: true) {
                        SecureField("Enter password", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }
                }

                Divider()

                // With Help Text
                VStack(alignment: .leading, spacing: 16) {
                    Text("With Help Text").font(.headline)

                    ElevateField(
                        "Username",
                        helpText: "Choose a unique username (3-20 characters)"
                    ) {
                        TextField("Username", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }
                }

                Divider()

                // Invalid State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Invalid State").font(.headline)

                    ElevateField(
                        "Email",
                        helpText: "Please enter a valid email address",
                        isRequired: true,
                        isInvalid: true
                    ) {
                        TextField("email@example.com", text: .constant("invalid"))
                            .textFieldStyle(.roundedBorder)
                    }
                }

                Divider()

                // Disabled State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disabled State").font(.headline)

                    ElevateField(
                        "Read Only",
                        helpText: "This field cannot be edited",
                        isDisabled: true
                    ) {
                        TextField("Value", text: .constant("Disabled value"))
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                    }
                }

                Divider()

                // With Status (Character Count)
                VStack(alignment: .leading, spacing: 16) {
                    Text("With Status").font(.headline)

                    ElevateField(
                        "Bio",
                        helpText: "Tell us about yourself",
                        status: "45 / 200"
                    ) {
                        TextEditor(text: .constant("Sample bio text"))
                            .frame(height: 80)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }

                Divider()

                // Size Variants
                VStack(alignment: .leading, spacing: 16) {
                    Text("Size Variants").font(.headline)

                    ElevateField("Small Field", size: .small) {
                        TextField("Small", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }

                    ElevateField("Medium Field", size: .medium) {
                        TextField("Medium", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }

                    ElevateField("Large Field", size: .large) {
                        TextField("Large", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }
                }

                Divider()

                // Hidden Label
                VStack(alignment: .leading, spacing: 16) {
                    Text("Hidden Label").font(.headline)

                    ElevateField(
                        "Search",
                        hideLabel: true
                    ) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search...", text: .constant(""))
                        }
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    }
                }

                Divider()

                // Form Example
                VStack(alignment: .leading, spacing: 16) {
                    Text("Complete Form Example").font(.headline)

                    ElevateField(
                        "Full Name",
                        helpText: "Enter your first and last name",
                        isRequired: true
                    ) {
                        TextField("John Doe", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                    }

                    ElevateField(
                        "Email Address",
                        helpText: "We'll never share your email",
                        isRequired: true
                    ) {
                        TextField("email@example.com", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.emailAddress)
                    }

                    ElevateField(
                        "Phone Number",
                        helpText: "Include country code"
                    ) {
                        TextField("+1 (555) 123-4567", text: .constant(""))
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.phonePad)
                    }

                    ElevateField(
                        "Message",
                        helpText: "Share your feedback",
                        isRequired: true,
                        status: "0 / 500"
                    ) {
                        TextEditor(text: .constant(""))
                            .frame(height: 100)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
