#if os(iOS)
import SwiftUI

/// ELEVATE Switch Component
///
/// A toggle switch control for binary on/off states.
/// Supports primary and success tones with disabled states.
///
/// **Web Component:** `<elvt-switch>`
/// **API Reference:** `.claude/components/Forms/switch.md`
@available(iOS 15, *)
public struct ElevateSwitch: View {

    // MARK: - Properties

    /// The label text for the switch
    private let label: String

    /// Whether the switch is on
    @Binding private var isOn: Bool

    /// Whether the switch is disabled
    private let isDisabled: Bool

    /// The tone/color of the switch
    private let tone: SwitchTone

    /// The size of the switch
    private let size: SwitchSize

    /// Action to perform when switch state changes
    private let onChange: ((Bool) -> Void)?

    // MARK: - Initializer

    /// Creates a switch with label and binding
    public init(
        _ label: String,
        isOn: Binding<Bool>,
        isDisabled: Bool = false,
        tone: SwitchTone = .primary,
        size: SwitchSize = .medium,
        onChange: ((Bool) -> Void)? = nil
    ) {
        self.label = label
        self._isOn = isOn
        self.isDisabled = isDisabled
        self.tone = tone
        self.size = size
        self.onChange = onChange
    }

    // MARK: - Body

    public var body: some View {
        Button(action: {
            if !isDisabled {
                isOn.toggle()
                onChange?(isOn)
            }
        }) {
            Text(label)
        }
        .buttonStyle(ElevateSwitchStyle(
            isOn: isOn,
            isDisabled: isDisabled,
            tone: tone,
            size: size
        ))
        .disabled(isDisabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isOn ? "On" : "Off")
    }
}

// MARK: - Switch Tone

@available(iOS 15, *)
public enum SwitchTone {
    case primary
    case success
}

// MARK: - Switch Size

@available(iOS 15, *)
public enum SwitchSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateSwitch_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // States
                VStack(alignment: .leading, spacing: 12) {
                    Text("Switch States").font(.headline)
                    PreviewSwitch(label: "Off", isOn: false)
                    PreviewSwitch(label: "On", isOn: true)
                    PreviewSwitch(label: "Disabled Off", isOn: false, isDisabled: true)
                    PreviewSwitch(label: "Disabled On", isOn: true, isDisabled: true)
                }

                Divider()

                // Tones
                VStack(alignment: .leading, spacing: 12) {
                    Text("Switch Tones").font(.headline)
                    PreviewSwitch(label: "Primary Tone", isOn: true, tone: .primary)
                    PreviewSwitch(label: "Success Tone", isOn: true, tone: .success)
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 12) {
                    Text("Switch Sizes").font(.headline)
                    PreviewSwitch(label: "Small Switch", isOn: true, size: .small)
                    PreviewSwitch(label: "Medium Switch", isOn: true, size: .medium)
                    PreviewSwitch(label: "Large Switch", isOn: true, size: .large)
                }
            }
            .padding()
        }
    }

    struct PreviewSwitch: View {
        let label: String
        @State var isOn: Bool
        var isDisabled: Bool = false
        var tone: SwitchTone = .primary
        var size: SwitchSize = .medium

        var body: some View {
            ElevateSwitch(
                label,
                isOn: $isOn,
                isDisabled: isDisabled,
                tone: tone,
                size: size
            )
        }
    }
}
#endif

#endif
