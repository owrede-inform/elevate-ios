#if os(iOS)
import SwiftUI

/// ELEVATE Switch Style
///
/// Custom ButtonStyle for switch with instant visual feedback.
/// Supports on/off states with primary and success tones.
@available(iOS 15, *)
public struct ElevateSwitchStyle: ButtonStyle {

    let isOn: Bool
    let isDisabled: Bool
    let tone: SwitchTone
    let size: SwitchSize

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: tokenGap) {
            // Switch control
            ZStack(alignment: isOn ? .trailing : .leading) {
                // Track background
                RoundedRectangle(cornerRadius: tokenTrackHeight / 2)
                    .fill(trackColor(isPressed: configuration.isPressed))
                    .frame(width: tokenTrackWidth, height: tokenTrackHeight)

                // Handle (thumb)
                Circle()
                    .fill(handleColor(isPressed: configuration.isPressed))
                    .frame(width: tokenHandleDiameter, height: tokenHandleDiameter)
                    .padding(tokenTrackPadding)
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isOn)

            // Label
            configuration.label
                .font(tokenLabelFont)
                .foregroundColor(labelColor(isPressed: configuration.isPressed))
        }
        .opacity(isDisabled ? 0.6 : 1.0)
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

    private func trackColor(isPressed: Bool) -> Color {
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

    private func handleColor(isPressed: Bool) -> Color {
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

    private func labelColor(isPressed: Bool) -> Color {
        if isDisabled {
            return SwitchComponentTokens.label_disabled
        }
        return SwitchComponentTokens.label_default
    }

    private var tokenLabelFont: Font {
        switch size {
        case .small: return ElevateTypographyiOS.labelSmall   // 14pt (web: 12pt)
        case .medium: return ElevateTypographyiOS.labelMedium // 16pt (web: 14pt)
        case .large: return ElevateTypographyiOS.labelLarge   // 18pt (web: 16pt)
        }
    }
}

#endif
