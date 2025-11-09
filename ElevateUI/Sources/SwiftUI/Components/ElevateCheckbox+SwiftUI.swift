#if os(iOS)
import SwiftUI

/// ELEVATE Checkbox Component
///
/// A standard checkbox control with support for checked, unchecked, and indeterminate states.
/// Includes label, validation states, and accessibility support.
///
/// **Web Component:** `<elvt-checkbox>`
/// **API Reference:** `.claude/components/Forms/checkbox.md`
@available(iOS 15, *)
public struct ElevateCheckbox: View {

    // MARK: - Properties

    /// The label text for the checkbox
    private let label: String

    /// Whether the checkbox is checked
    @Binding private var isChecked: Bool

    /// Whether the checkbox is in indeterminate state (partial selection)
    private let isIndeterminate: Bool

    /// Whether the checkbox is disabled
    private let isDisabled: Bool

    /// Whether the checkbox has invalid value
    private let isInvalid: Bool

    /// The size of the checkbox
    private let size: CheckboxSize

    /// Action to perform when checkbox state changes
    private let onChange: ((Bool) -> Void)?

    // MARK: - Initializer

    /// Creates a checkbox with label and binding
    public init(
        _ label: String,
        isChecked: Binding<Bool>,
        isIndeterminate: Bool = false,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        size: CheckboxSize = .medium,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self.label = label
        self._isChecked = isChecked
        self.isIndeterminate = isIndeterminate
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.size = size
        self.onChange = onChange
    }

    // MARK: - Body

    public var body: some View {
        Button(action: {
            if !isDisabled {
                isChecked.toggle()
                onChange?(isChecked)
            }
        }) {
            Text(label)
        }
        .buttonStyle(ElevateCheckboxStyle(
            size: size,
            isChecked: isChecked,
            isIndeterminate: isIndeterminate,
            isDisabled: isDisabled,
            isInvalid: isInvalid
        ))
        .disabled(isDisabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isIndeterminate ? "Mixed" : (isChecked ? "Checked" : "Unchecked"))
    }

}

// MARK: - Checkbox Size

@available(iOS 15, *)
public enum CheckboxSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateCheckbox_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // States
                VStack(alignment: .leading, spacing: 12) {
                    Text("Checkbox States").font(.headline)
                    PreviewCheckbox(label: "Unchecked", isChecked: false)
                    PreviewCheckbox(label: "Checked", isChecked: true)
                    PreviewCheckbox(label: "Indeterminate", isChecked: false, isIndeterminate: true)
                    PreviewCheckbox(label: "Disabled Unchecked", isChecked: false, isDisabled: true)
                    PreviewCheckbox(label: "Disabled Checked", isChecked: true, isDisabled: true)
                    PreviewCheckbox(label: "Invalid", isChecked: false, isInvalid: true)
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 12) {
                    Text("Checkbox Sizes").font(.headline)
                    PreviewCheckbox(label: "Small Checkbox", isChecked: true, size: .small)
                    PreviewCheckbox(label: "Medium Checkbox", isChecked: true, size: .medium)
                    PreviewCheckbox(label: "Large Checkbox", isChecked: true, size: .large)
                }
            }
            .padding()
        }
    }

    struct PreviewCheckbox: View {
        let label: String
        @State var isChecked: Bool
        var isIndeterminate: Bool = false
        var isDisabled: Bool = false
        var isInvalid: Bool = false
        var size: CheckboxSize = .medium

        var body: some View {
            ElevateCheckbox(
                label,
                isChecked: $isChecked,
                isIndeterminate: isIndeterminate,
                isDisabled: isDisabled,
                isInvalid: isInvalid,
                size: size
            )
        }
    }
}
#endif

#endif
