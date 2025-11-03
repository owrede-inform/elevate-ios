import SwiftUI

/// ELEVATE Button Component (SwiftUI)
///
/// A button component that follows the ELEVATE design system with support for
/// different tones, sizes, and states.
///
/// Example usage:
/// ```swift
/// ElevateButton(
///     title: "Primary Button",
///     tone: .primary,
///     size: .medium,
///     action: { print("Button tapped") }
/// )
/// ```
public struct ElevateButton: View {

    // MARK: - Properties

    private let title: String
    private let tone: ButtonTokens.Tone
    private let size: ButtonTokens.Size
    private let shape: ButtonTokens.Shape
    private let isDisabled: Bool
    private let action: () -> Void

    // MARK: - State

    @State private var isPressed = false

    // MARK: - Initialization

    /// Create an ELEVATE button
    /// - Parameters:
    ///   - title: The button title text
    ///   - tone: The button tone/variant (default: .primary)
    ///   - size: The button size (default: .medium)
    ///   - shape: The button shape (default: .default)
    ///   - isDisabled: Whether the button is disabled (default: false)
    ///   - action: The action to perform when the button is tapped
    public init(
        title: String,
        tone: ButtonTokens.Tone = .primary,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.tone = tone
        self.size = size
        self.shape = shape
        self.isDisabled = isDisabled
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: {
            if !isDisabled {
                action()
            }
        }) {
            Text(title)
                .font(font)
                .foregroundColor(textColor)
                .frame(height: size.componentSize.height)
                .padding(.horizontal, size.componentSize.paddingInline)
                .frame(maxWidth: .infinity)
        }
        .background(backgroundColor)
        .cornerRadius(borderRadius)
        .overlay(
            RoundedRectangle(cornerRadius: borderRadius)
                .stroke(borderColor, lineWidth: ElevateSpacing.BorderWidth.thin)
        )
        .disabled(isDisabled)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !isPressed && !isDisabled {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    isPressed = false
                }
        )
    }

    // MARK: - Computed Properties

    private var toneColors: ButtonTokens.ToneColors {
        tone.colors
    }

    private var backgroundColor: Color {
        if isDisabled {
            return toneColors.backgroundDisabled
        } else if isPressed {
            return toneColors.backgroundActive
        } else {
            return toneColors.background
        }
    }

    private var textColor: Color {
        isDisabled ? toneColors.textDisabled : toneColors.text
    }

    private var borderColor: Color {
        toneColors.border
    }

    private var borderRadius: CGFloat {
        shape.borderRadius
    }

    private var font: Font {
        switch size {
        case .small:
            return ElevateTypography.labelSmall
        case .medium:
            return ElevateTypography.labelMedium
        case .large:
            return ElevateTypography.labelLarge
        }
    }
}

// MARK: - Previews

struct ElevateButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: ElevateSpacing.l) {
            Group {
                Text("Button Tones")
                    .font(ElevateTypography.headingSmall)
                    .padding(.top, ElevateSpacing.xl)

                ElevateButton(title: "Primary", tone: .primary) {}
                ElevateButton(title: "Secondary", tone: .secondary) {}
                ElevateButton(title: "Success", tone: .success) {}
                ElevateButton(title: "Warning", tone: .warning) {}
                ElevateButton(title: "Danger", tone: .danger) {}
                ElevateButton(title: "Emphasized", tone: .emphasized) {}
                ElevateButton(title: "Subtle", tone: .subtle) {}
                ElevateButton(title: "Neutral", tone: .neutral) {}
            }

            Group {
                Text("Button Sizes")
                    .font(ElevateTypography.headingSmall)
                    .padding(.top, ElevateSpacing.xl)

                ElevateButton(title: "Small Button", size: .small) {}
                ElevateButton(title: "Medium Button", size: .medium) {}
                ElevateButton(title: "Large Button", size: .large) {}
            }

            Group {
                Text("Button Shapes")
                    .font(ElevateTypography.headingSmall)
                    .padding(.top, ElevateSpacing.xl)

                ElevateButton(title: "Default Shape") {}
                ElevateButton(title: "Pill Shape", shape: .pill) {}
            }

            Group {
                Text("Button States")
                    .font(ElevateTypography.headingSmall)
                    .padding(.top, ElevateSpacing.xl)

                ElevateButton(title: "Enabled Button") {}
                ElevateButton(title: "Disabled Button", isDisabled: true) {}
            }
        }
        .padding(ElevateSpacing.l)
        .previewLayout(.sizeThatFits)
    }
}
