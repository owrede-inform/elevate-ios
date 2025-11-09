#if os(iOS)
import SwiftUI

/// ELEVATE Radio Style
///
/// Custom ButtonStyle for radio with instant visual feedback.
/// Supports checked/unchecked states with disabled and invalid states.
@available(iOS 15, *)
public struct ElevateRadioStyle<Value: Hashable>: ButtonStyle {

    let isChecked: Bool
    let isDisabled: Bool
    let isInvalid: Bool
    let size: RadioSize

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: tokenGap) {
            // Radio control (circular)
            ZStack {
                // Track (background circle with border)
                Circle()
                    .fill(trackColor(isPressed: configuration.isPressed))
                    .overlay(
                        Circle()
                            .strokeBorder(borderColor(isPressed: configuration.isPressed), lineWidth: tokenBorderWidth)
                    )

                // Handle (center dot when checked)
                if isChecked {
                    Circle()
                        .fill(handleColor(isPressed: configuration.isPressed))
                        .frame(width: tokenHandleSize, height: tokenHandleSize)
                }
            }
            .frame(width: tokenControlSize, height: tokenControlSize)

            // Label
            configuration.label
                .font(tokenLabelFont)
                .foregroundColor(labelColor(isPressed: configuration.isPressed))
        }
        .opacity(isDisabled ? 0.6 : 1.0)
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

    private func trackColor(isPressed: Bool) -> Color {
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

    private func borderColor(isPressed: Bool) -> Color {
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

    private func handleColor(isPressed: Bool) -> Color {
        if isDisabled {
            return RadioComponentTokens.control_handle_color_disabled
        }
        return isPressed
            ? RadioComponentTokens.control_handle_color_clicked
            : RadioComponentTokens.control_handle_color_default
    }

    private func labelColor(isPressed: Bool) -> Color {
        if isDisabled {
            return RadioComponentTokens.value_color_disabled
        }
        return isPressed
            ? RadioComponentTokens.value_color_clicked
            : RadioComponentTokens.value_color_default
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
