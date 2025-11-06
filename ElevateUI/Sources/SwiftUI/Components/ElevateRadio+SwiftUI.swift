#if os(iOS)
import SwiftUI

/// ELEVATE Radio Component
///
/// A standard radio control for selecting a single option from a group.
/// Must be used within an ElevateRadioGroup for proper behavior.
///
/// **Web Component:** `<elvt-radio>`
/// **API Reference:** `.claude/components/Forms/radio.md`
@available(iOS 15, *)
public struct ElevateRadio<Value: Hashable>: View {

    // MARK: - Properties

    /// The label text for the radio
    private let label: String

    /// The value this radio represents
    private let value: Value

    /// The currently selected value from the group
    @Binding private var selectedValue: Value?

    /// Whether the radio is disabled
    private let isDisabled: Bool

    /// Whether the radio has invalid value
    private let isInvalid: Bool

    /// The size of the radio
    private let size: RadioSize

    /// Whether to hide the label (not recommended for accessibility)
    private let hideLabel: Bool

    /// Action to perform when radio is selected
    private let onChange: ((Value) -> Void)?

    // MARK: - State

    @State private var isPressed = false

    // MARK: - Computed Properties

    private var isChecked: Bool {
        selectedValue == value
    }

    // MARK: - Initializer

    /// Creates a radio with label, value, and binding to selected value
    public init(
        _ label: String,
        value: Value,
        selectedValue: Binding<Value?>,
        isDisabled: Bool = false,
        isInvalid: Bool = false,
        size: RadioSize = .medium,
        hideLabel: Bool = false,
        onChange: ((Value) -> Void)? = nil
    ) {
        self.label = label
        self.value = value
        self._selectedValue = selectedValue
        self.isDisabled = isDisabled
        self.isInvalid = isInvalid
        self.size = size
        self.hideLabel = hideLabel
        self.onChange = onChange
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: tokenGap) {
            // Radio control (circular)
            ZStack {
                // Track (background circle with border)
                Circle()
                    .fill(tokenTrackColor)
                    .overlay(
                        Circle()
                            .strokeBorder(tokenBorderColor, lineWidth: tokenBorderWidth)
                    )

                // Handle (center dot when checked)
                if isChecked {
                    Circle()
                        .fill(tokenHandleColor)
                        .frame(width: tokenHandleSize, height: tokenHandleSize)
                }
            }
            .frame(width: tokenControlSize, height: tokenControlSize)
            .onTapGesture {
                if !isDisabled && !isChecked {
                    selectedValue = value
                    onChange?(value)
                }
            }
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isDisabled {
                            isPressed = true
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                    }
            )

            // Label
            if !hideLabel {
                Text(label)
                    .font(tokenLabelFont)
                    .foregroundColor(tokenLabelColor)
            }
        }
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isChecked ? "Selected" : "Not selected")
    }

    // MARK: - Token Accessors

    private var tokenControlSize: CGFloat {
        switch size {
        case .small: return RadioComponentTokens.control_track_width_s
        case .medium: return RadioComponentTokens.control_track_width_m
        case .large: return RadioComponentTokens.control_track_width_l
        }
    }

    private var tokenHandleSize: CGFloat {
        switch size {
        case .small: return RadioComponentTokens.control_handle_width_s
        case .medium: return RadioComponentTokens.control_handle_width_m
        case .large: return RadioComponentTokens.control_handle_width_l
        }
    }

    private var tokenGap: CGFloat {
        switch size {
        case .small: return 8.0
        case .medium: return 12.0
        case .large: return 16.0
        }
    }

    private var tokenBorderWidth: CGFloat {
        switch size {
        case .small: return RadioComponentTokens.control_track_border_width_s
        case .medium: return RadioComponentTokens.control_track_border_width_m
        case .large: return RadioComponentTokens.control_track_border_width_l
        }
    }

    private var tokenTrackColor: Color {
        if isDisabled {
            if isChecked {
                return RadioComponentTokens.control_track_color_neutral_checked_disabled
            } else {
                return RadioComponentTokens.control_track_color_neutral_unchecked_disabled
            }
        }

        if isInvalid {
            return isPressed
                ? RadioComponentTokens.control_track_color_invalid_clicked
                : RadioComponentTokens.control_track_color_invalid_default
        }

        if isChecked {
            return isPressed
                ? RadioComponentTokens.control_track_color_neutral_checked_active
                : RadioComponentTokens.control_track_color_neutral_checked_default
        } else {
            return isPressed
                ? RadioComponentTokens.control_track_color_neutral_unchecked_clicked
                : RadioComponentTokens.control_track_color_neutral_unchecked_default
        }
    }

    private var tokenBorderColor: Color {
        if isDisabled {
            if isChecked {
                return RadioComponentTokens.control_track_border_color_neutral_checked_disabled
            } else {
                return RadioComponentTokens.control_track_border_color_neutral_unchecked_disabled
            }
        }

        if isInvalid {
            return isPressed
                ? RadioComponentTokens.control_track_border_color_invalid_active
                : RadioComponentTokens.control_track_border_color_invalid_default
        }

        if isChecked {
            return isPressed
                ? RadioComponentTokens.control_track_border_color_neutral_checked_clicked
                : RadioComponentTokens.control_track_border_color_neutral_checked_default
        } else {
            return isPressed
                ? RadioComponentTokens.control_track_border_color_neutral_unchecked_clicked
                : RadioComponentTokens.control_track_border_color_neutral_unchecked_default
        }
    }

    private var tokenHandleColor: Color {
        if isDisabled {
            return RadioComponentTokens.control_handle_color_disabled
        }
        return isPressed
            ? RadioComponentTokens.control_handle_color_clicked
            : RadioComponentTokens.control_handle_color_default
    }

    private var tokenLabelColor: Color {
        if isDisabled {
            return RadioComponentTokens.value_color_disabled
        }
        return isPressed
            ? RadioComponentTokens.value_color_clicked
            : RadioComponentTokens.value_color_default
    }

    private var tokenLabelFont: Font {
        switch size {
        case .small: return ElevateTypography.labelSmall
        case .medium: return ElevateTypography.labelMedium
        case .large: return ElevateTypography.labelLarge
        }
    }
}

// MARK: - Radio Size

@available(iOS 15, *)
public enum RadioSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateRadio_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // States
                VStack(alignment: .leading, spacing: 12) {
                    Text("Radio States").font(.headline)
                    PreviewRadioGroup(title: "Basic Radio Group")
                    PreviewRadioGroup(title: "Disabled Options", disabledIndices: [1])
                    PreviewRadioGroup(title: "Invalid State", isInvalid: true)
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 12) {
                    Text("Radio Sizes").font(.headline)
                    PreviewRadioGroup(title: "Small Radios", size: .small)
                    PreviewRadioGroup(title: "Medium Radios", size: .medium)
                    PreviewRadioGroup(title: "Large Radios", size: .large)
                }
            }
            .padding()
        }
    }

    struct PreviewRadioGroup: View {
        let title: String
        var size: RadioSize = .medium
        var disabledIndices: Set<Int> = []
        var isInvalid: Bool = false

        @State private var selectedValue: String? = "option1"

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title).font(.subheadline).foregroundColor(.secondary)

                ElevateRadio(
                    "Option 1",
                    value: "option1",
                    selectedValue: $selectedValue,
                    isDisabled: disabledIndices.contains(0),
                    isInvalid: isInvalid,
                    size: size
                )

                ElevateRadio(
                    "Option 2",
                    value: "option2",
                    selectedValue: $selectedValue,
                    isDisabled: disabledIndices.contains(1),
                    isInvalid: isInvalid,
                    size: size
                )

                ElevateRadio(
                    "Option 3",
                    value: "option3",
                    selectedValue: $selectedValue,
                    isDisabled: disabledIndices.contains(2),
                    isInvalid: isInvalid,
                    size: size
                )
            }
        }
    }
}
#endif

#endif
