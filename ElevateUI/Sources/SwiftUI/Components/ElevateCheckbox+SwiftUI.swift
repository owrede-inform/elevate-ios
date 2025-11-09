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

    // MARK: - State

    @State private var isPressed = false

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
        HStack(spacing: tokenGap) {
            // Checkbox control
            ZStack {
                // Background and border
                RoundedRectangle(cornerRadius: tokenCornerRadius)
                    .fill(tokenBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: tokenCornerRadius)
                            .strokeBorder(tokenBorderColor, lineWidth: tokenBorderWidth)
                    )

                // Icon (checkmark or dash)
                if isChecked || isIndeterminate {
                    Image(systemName: isIndeterminate ? "minus" : "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: tokenIconSize, height: tokenIconSize)
                        .foregroundColor(tokenIconColor)
                }
            }
            .frame(width: tokenControlSize, height: tokenControlSize)
            .scrollFriendlyTap(
                onPressedChanged: { pressed in
                    if !isDisabled {
                        isPressed = pressed
                    }
                },
                action: {
                    if !isDisabled {
                        isChecked.toggle()
                        onChange?(isChecked)
                    }
                }
            )

            // Label
            Text(label)
                .font(tokenLabelFont)
                .foregroundColor(tokenLabelColor)
        }
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isIndeterminate ? "Mixed" : (isChecked ? "Checked" : "Unchecked"))
    }

    // MARK: - Token Accessors

    private var tokenControlSize: CGFloat {
        switch size {
        case .small: return CheckboxComponentTokens.control_width_s
        case .medium: return CheckboxComponentTokens.control_width_m
        case .large: return CheckboxComponentTokens.control_width_l
        }
    }

    private var tokenGap: CGFloat {
        switch size {
        case .small: return CheckboxComponentTokens.gap_s
        case .medium: return CheckboxComponentTokens.gap_m
        case .large: return CheckboxComponentTokens.gap_l
        }
    }

    private var tokenCornerRadius: CGFloat {
        switch size {
        case .small: return CheckboxComponentTokens.control_radius_s
        case .medium: return CheckboxComponentTokens.control_radius_m
        case .large: return CheckboxComponentTokens.control_radius_l
        }
    }

    private var tokenBorderWidth: CGFloat {
        switch size {
        case .small: return CheckboxComponentTokens.control_border_width_s
        case .medium: return CheckboxComponentTokens.control_border_width_m
        case .large: return CheckboxComponentTokens.control_border_width_l
        }
    }

    private var tokenIconSize: CGFloat {
        switch size {
        case .small: return CheckboxComponentTokens.icon_width_s * 0.6
        case .medium: return CheckboxComponentTokens.icon_width_m * 0.6
        case .large: return CheckboxComponentTokens.icon_width_l * 0.6
        }
    }

    private var tokenBackgroundColor: Color {
        if isDisabled {
            if isChecked || isIndeterminate {
                return CheckboxComponentTokens.control_fill_checked_disabled
            } else {
                return CheckboxComponentTokens.control_fill_unchecked_disabled
            }
        }

        if isChecked {
            return isPressed
                ? CheckboxComponentTokens.control_fill_checked_active
                : CheckboxComponentTokens.control_fill_checked_default
        } else if isIndeterminate {
            return isPressed
                ? CheckboxComponentTokens.control_fill_indeterminate_active
                : CheckboxComponentTokens.control_fill_indeterminate_default
        } else {
            return isPressed
                ? CheckboxComponentTokens.control_fill_unchecked_active
                : CheckboxComponentTokens.control_fill_unchecked_default
        }
    }

    private var tokenBorderColor: Color {
        if isDisabled {
            if isChecked || isIndeterminate {
                return CheckboxComponentTokens.control_border_color_checked_disabled
            } else {
                return CheckboxComponentTokens.control_border_color_unchecked_disabled
            }
        }

        if isInvalid {
            if isChecked || isIndeterminate {
                return CheckboxComponentTokens.control_border_color_checked_invalid_default
            } else {
                return isPressed
                    ? CheckboxComponentTokens.control_border_color_unchecked_invalid_active
                    : CheckboxComponentTokens.control_border_color_unchecked_invalid_default
            }
        }

        if isChecked {
            return isPressed
                ? CheckboxComponentTokens.control_border_color_checked_active
                : CheckboxComponentTokens.control_border_color_checked_default
        } else if isIndeterminate {
            return isPressed
                ? CheckboxComponentTokens.control_border_color_indeterminate_active
                : CheckboxComponentTokens.control_border_color_indeterminate_default
        } else {
            return isPressed
                ? CheckboxComponentTokens.control_border_color_unchecked_active
                : CheckboxComponentTokens.control_border_color_unchecked_default
        }
    }

    private var tokenIconColor: Color {
        if isDisabled {
            return CheckboxComponentTokens.icon_color_disabled
        }
        return isPressed
            ? CheckboxComponentTokens.icon_color_active
            : CheckboxComponentTokens.icon_color_default
    }

    private var tokenLabelColor: Color {
        if isDisabled {
            return CheckboxComponentTokens.label_disabled
        }
        return isPressed
            ? CheckboxComponentTokens.label_active
            : CheckboxComponentTokens.label_default
    }

    private var tokenLabelFont: Font {
        switch size {
        case .small: return ElevateTypography.labelSmall
        case .medium: return ElevateTypography.labelMedium
        case .large: return ElevateTypography.labelLarge
        }
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
