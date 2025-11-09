#if os(iOS)
import SwiftUI

/// ELEVATE Button Style
///
/// Custom ButtonStyle that provides instant visual feedback using SwiftUI's native
/// configuration.isPressed state, which updates synchronously with touch events.
///
/// **Performance**: <5ms visual feedback (vs 16-66ms with UIControl callbacks)
/// **Scroll-Friendly**: Native SwiftUI Button automatically works in ScrollView
///
/// This replaces the UIControl-based approach which had SwiftUI bridge latency.
@available(iOS 15, *)
public struct ElevateButtonStyle: ButtonStyle {

    let tone: ButtonTokens.Tone
    let size: ButtonTokens.Size
    let shape: ButtonTokens.Shape
    let isSelected: Bool
    let isDisabled: Bool
    let customPadding: EdgeInsets?

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(textColor(isPressed: configuration.isPressed))
            .padding(effectivePadding)
            .frame(maxWidth: .infinity)
            .frame(height: tokenHeight)
            .background(backgroundColor(isPressed: configuration.isPressed))
            .cornerRadius(tokenCornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: tokenCornerRadius)
                    .stroke(tokenBorderColor, lineWidth: tokenBorderWidth)
            )
            .opacity(isDisabled ? 0.6 : 1.0)
    }

    // MARK: - Token Accessors

    private var toneColors: ButtonTokens.ToneColors {
        tone.colors
    }

    private func backgroundColor(isPressed: Bool) -> Color {
        if isDisabled {
            return toneColors.backgroundDisabled
        } else if isSelected {
            return isPressed ? toneColors.backgroundSelectedActive : toneColors.backgroundSelected
        } else if isPressed {
            return toneColors.backgroundActive
        } else {
            return toneColors.background
        }
    }

    private func textColor(isPressed: Bool) -> Color {
        if isDisabled {
            return toneColors.textDisabled
        } else if isSelected {
            return isPressed ? toneColors.textSelectedActive : toneColors.textSelected
        } else if isPressed {
            return toneColors.textActive
        } else {
            return toneColors.text
        }
    }

    private var tokenBorderColor: Color {
        if isSelected {
            return toneColors.borderSelected
        } else {
            return toneColors.border
        }
    }

    private var tokenBorderWidth: CGFloat {
        ButtonComponentTokens.border_width
    }

    private var tokenHeight: CGFloat {
        size.componentSize.height
    }

    private var effectivePadding: EdgeInsets {
        customPadding ?? EdgeInsets(
            top: 0,
            leading: size.componentSize.paddingInline,
            bottom: 0,
            trailing: size.componentSize.paddingInline
        )
    }

    private var tokenCornerRadius: CGFloat {
        shape.borderRadius
    }
}

#endif
