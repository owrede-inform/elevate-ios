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

    // MARK: - State

    @State private var isPressed = false

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
        HStack(spacing: tokenGap) {
            // Switch control
            ZStack(alignment: isOn ? .trailing : .leading) {
                // Track background
                RoundedRectangle(cornerRadius: tokenTrackHeight / 2)
                    .fill(tokenTrackColor)
                    .frame(width: tokenTrackWidth, height: tokenTrackHeight)

                // Handle (thumb)
                Circle()
                    .fill(tokenHandleColor)
                    .frame(width: tokenHandleDiameter, height: tokenHandleDiameter)
                    .padding(tokenTrackPadding)
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isOn)
            .onTapGesture {
                if !isDisabled {
                    isOn.toggle()
                    onChange?(isOn)
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
            Text(label)
                .font(tokenLabelFont)
                .foregroundColor(tokenLabelColor)
        }
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
        .accessibilityValue(isOn ? "On" : "Off")
    }

    // MARK: - Token Accessors

    private var tokenTrackWidth: CGFloat {
        switch size {
        case .small: return SwitchComponentTokens.track_width_s
        case .medium: return SwitchComponentTokens.track_width_m
        case .large: return SwitchComponentTokens.track_width_l
        }
    }

    private var tokenTrackHeight: CGFloat {
        switch size {
        case .small: return SwitchComponentTokens.track_height_s
        case .medium: return SwitchComponentTokens.track_height_m
        case .large: return SwitchComponentTokens.track_height_l
        }
    }

    private var tokenHandleDiameter: CGFloat {
        switch size {
        case .small: return SwitchComponentTokens.handle_diameter_s
        case .medium: return SwitchComponentTokens.handle_diameter_m
        case .large: return SwitchComponentTokens.handle_diameter_l
        }
    }

    private var tokenTrackPadding: CGFloat {
        switch size {
        case .small: return SwitchComponentTokens.track_padding_s
        case .medium: return SwitchComponentTokens.track_padding_m
        case .large: return SwitchComponentTokens.track_padding_l
        }
    }

    private var tokenGap: CGFloat {
        switch size {
        case .small: return SwitchComponentTokens.gap_s
        case .medium: return SwitchComponentTokens.gap_m
        case .large: return SwitchComponentTokens.gap_l
        }
    }

    private var tokenTrackColor: Color {
        if isDisabled {
            return isOn
                ? (tone == .success
                    ? SwitchComponentTokens.track_fill_checked_success_disabled
                    : SwitchComponentTokens.track_fill_checked_primary_disabled)
                : SwitchComponentTokens.track_fill_unchecked_disabled
        }

        if isOn {
            if tone == .success {
                return isPressed
                    ? SwitchComponentTokens.track_fill_checked_success_hover
                    : SwitchComponentTokens.track_fill_checked_success_default
            } else {
                return isPressed
                    ? SwitchComponentTokens.track_fill_checked_primary_hover
                    : SwitchComponentTokens.track_fill_checked_primary_enabled
            }
        } else {
            return isPressed
                ? SwitchComponentTokens.track_fill_unchecked_hover
                : SwitchComponentTokens.track_fill_unchecked_default
        }
    }

    private var tokenHandleColor: Color {
        if isDisabled {
            return isOn
                ? (tone == .success
                    ? SwitchComponentTokens.handle_fill_checked_success_disabled
                    : SwitchComponentTokens.handle_fill_checked_primary_disabled)
                : SwitchComponentTokens.handle_fill_unchecked_disabled
        }

        if isOn {
            if tone == .success {
                return isPressed
                    ? SwitchComponentTokens.handle_fill_checked_success_active
                    : SwitchComponentTokens.handle_fill_checked_success_default
            } else {
                return isPressed
                    ? SwitchComponentTokens.handle_fill_checked_primary_active
                    : SwitchComponentTokens.handle_fill_checked_primary_default
            }
        } else {
            return SwitchComponentTokens.handle_fill_unchecked_default
        }
    }

    private var tokenLabelColor: Color {
        if isDisabled {
            return SwitchComponentTokens.label_disabled
        }
        return SwitchComponentTokens.label_default
    }

    private var tokenLabelFont: Font {
        switch size {
        case .small: return ElevateTypography.labelSmall
        case .medium: return ElevateTypography.labelMedium
        case .large: return ElevateTypography.labelLarge
        }
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
