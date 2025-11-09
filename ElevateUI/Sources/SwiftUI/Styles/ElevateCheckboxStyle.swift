#if os(iOS)
import SwiftUI

/// ELEVATE Checkbox Style
///
/// Custom ButtonStyle for checkbox with instant visual feedback.
/// Supports checked, unchecked, indeterminate, disabled, and invalid states.
@available(iOS 15, *)
public struct ElevateCheckboxStyle: ButtonStyle {

    let size: CheckboxSize
    let isChecked: Bool
    let isIndeterminate: Bool
    let isDisabled: Bool
    let isInvalid: Bool

    public func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: tokenGap) {
            // Checkbox control
            ZStack {
                // Background and border
                RoundedRectangle(cornerRadius: tokenCornerRadius)
                    .fill(backgroundColor(isPressed: configuration.isPressed))
                    .overlay(
                        RoundedRectangle(cornerRadius: tokenCornerRadius)
                            .strokeBorder(borderColor(isPressed: configuration.isPressed), lineWidth: tokenBorderWidth)
                    )

                // Icon (checkmark or dash)
                if isChecked || isIndeterminate {
                    Image(systemName: isIndeterminate ? "minus" : "checkmark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: tokenIconSize, height: tokenIconSize)
                        .foregroundColor(iconColor(isPressed: configuration.isPressed))
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

    private func backgroundColor(isPressed: Bool) -> Color {
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

    private func borderColor(isPressed: Bool) -> Color {
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

    private func iconColor(isPressed: Bool) -> Color {
        if isDisabled {
            return CheckboxComponentTokens.icon_color_disabled
        }
        return isPressed
            ? CheckboxComponentTokens.icon_color_active
            : CheckboxComponentTokens.icon_color_default
    }

    private func labelColor(isPressed: Bool) -> Color {
        if isDisabled {
            return CheckboxComponentTokens.label_disabled
        }
        return isPressed
            ? CheckboxComponentTokens.label_active
            : CheckboxComponentTokens.label_default
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
