#if os(iOS)
import SwiftUI

/// ELEVATE Button Component
///
/// Buttons represent actions that are available to the user.
/// Support for different tones, sizes, shapes, and states including selected.
///
/// **Web Component:** `<elvt-button>`
/// **API Reference:** `.claude/components/Navigation/button.md`
@available(iOS 15, *)
public struct ElevateButton<Prefix: View, Suffix: View>: View {

    // MARK: - Properties

    /// The visual style of the button
    public var tone: ButtonTokens.Tone

    /// The size of the button
    public var size: ButtonTokens.Size

    /// The shape of the button
    public var shape: ButtonTokens.Shape

    /// Whether the button is selected/active
    public var isSelected: Bool

    /// Whether the button is disabled
    public var isDisabled: Bool

    /// Optional custom padding override
    public var customPadding: EdgeInsets?

    // MARK: - Content

    private let label: String
    private let prefix: () -> Prefix
    private let suffix: () -> Suffix

    // MARK: - Actions

    private let action: () -> Void

    // MARK: - State

    @State private var isPressed = false

    // MARK: - Initializers

    /// Create button with all options
    public init(
        label: String,
        tone: ButtonTokens.Tone = .neutral,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        customPadding: EdgeInsets? = nil,
        action: @escaping () -> Void,
        @ViewBuilder prefix: @escaping () -> Prefix = { EmptyView() },
        @ViewBuilder suffix: @escaping () -> Suffix = { EmptyView() }
    ) {
        self.label = label
        self.tone = tone
        self.size = size
        self.shape = shape
        self.isSelected = isSelected
        self.isDisabled = isDisabled
        self.customPadding = customPadding
        self.action = action
        self.prefix = prefix
        self.suffix = suffix
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: tokenGap) {
            prefix()

            Text(label)
                .font(tokenFont)
                .lineLimit(1)

            suffix()
        }
        .foregroundColor(tokenTextColor)
        .padding(effectivePadding)
        .frame(height: tokenHeight)
        .frame(maxWidth: .infinity)
        .background(tokenBackgroundColor)
        .cornerRadius(tokenCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: tokenCornerRadius)
                .stroke(tokenBorderColor, lineWidth: tokenBorderWidth)
        )
        .scrollFriendlyTap(
            onPressedChanged: { pressed in
                if !isDisabled {
                    // Force immediate update with no animation delay
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        isPressed = pressed
                    }
                }
            },
            action: {
                if !isDisabled {
                    action()
                }
            }
        )
        .allowsHitTesting(!isDisabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
        .accessibilityAddTraits(.isButton)
    }

    // MARK: - Token Accessors

    private var toneColors: ButtonTokens.ToneColors {
        tone.colors
    }

    private var tokenBackgroundColor: Color {
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

    private var tokenTextColor: Color {
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

    private var tokenFont: Font {
        switch size {
        case .small:
            return ElevateTypography.labelSmall
        case .medium:
            return ElevateTypography.labelMedium
        case .large:
            return ElevateTypography.labelLarge
        }
    }

    private var tokenGap: CGFloat {
        switch size {
        case .small: return ButtonComponentTokens.gap_s
        case .medium: return ButtonComponentTokens.gap_m
        case .large: return ButtonComponentTokens.gap_l
        }
    }

    private var tokenCornerRadius: CGFloat {
        shape.borderRadius
    }
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension ElevateButton where Prefix == EmptyView, Suffix == EmptyView {
    /// Create button with label only
    public init(
        _ label: String,
        tone: ButtonTokens.Tone = .neutral,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.init(
            label: label,
            tone: tone,
            size: size,
            shape: shape,
            isSelected: isSelected,
            isDisabled: isDisabled,
            action: action
        )
    }

    /// Legacy initializer for compatibility
    public init(
        title: String,
        tone: ButtonTokens.Tone = .primary,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.init(
            label: title,
            tone: tone,
            size: size,
            shape: shape,
            isSelected: false,
            isDisabled: isDisabled,
            action: action
        )
    }
}

@available(iOS 15, *)
extension ElevateButton where Suffix == EmptyView {
    /// Create button with prefix icon
    public init(
        _ label: String,
        tone: ButtonTokens.Tone = .neutral,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder prefix: @escaping () -> Prefix
    ) {
        self.init(
            label: label,
            tone: tone,
            size: size,
            shape: shape,
            isSelected: isSelected,
            isDisabled: isDisabled,
            action: action,
            prefix: prefix
        )
    }
}

@available(iOS 15, *)
extension ElevateButton where Prefix == EmptyView {
    /// Create button with suffix icon
    public init(
        _ label: String,
        tone: ButtonTokens.Tone = .neutral,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        action: @escaping () -> Void,
        @ViewBuilder suffix: @escaping () -> Suffix
    ) {
        self.init(
            label: label,
            tone: tone,
            size: size,
            shape: shape,
            isSelected: isSelected,
            isDisabled: isDisabled,
            action: action,
            suffix: suffix
        )
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateButton_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 20) {
                // All tones
                VStack(spacing: 12) {
                    Text("Button Tones").font(.headline)
                    ElevateButton("Primary", tone: .primary) {}
                    ElevateButton("Secondary", tone: .secondary) {}
                    ElevateButton("Success", tone: .success) {}
                    ElevateButton("Warning", tone: .warning) {}
                    ElevateButton("Danger", tone: .danger) {}
                    ElevateButton("Emphasized", tone: .emphasized) {}
                    ElevateButton("Subtle", tone: .subtle) {}
                    ElevateButton("Neutral", tone: .neutral) {}
                }

                Divider()

                // Sizes
                VStack(spacing: 12) {
                    Text("Button Sizes").font(.headline)
                    ElevateButton("Small Button", tone: .primary, size: .small) {}
                    ElevateButton("Medium Button", tone: .primary, size: .medium) {}
                    ElevateButton("Large Button", tone: .primary, size: .large) {}
                }

                Divider()

                // Shapes
                VStack(spacing: 12) {
                    Text("Button Shapes").font(.headline)
                    ElevateButton("Default Shape", tone: .primary) {}
                    ElevateButton("Pill Shape", tone: .primary, shape: .pill) {}
                }

                Divider()

                // States
                VStack(spacing: 12) {
                    Text("Button States").font(.headline)
                    ElevateButton("Normal", tone: .primary) {}
                    ElevateButton("Selected", tone: .primary, isSelected: true) {}
                    ElevateButton("Disabled", tone: .primary, isDisabled: true) {}
                }

                Divider()

                // With icons
                VStack(spacing: 12) {
                    Text("With Icons").font(.headline)
                    ElevateButton("With Prefix", tone: .primary, action: {}, prefix: {
                        Image(systemName: "star.fill")
                            .resizable()
                            .frame(width: 16, height: 16)
                    })

                    ElevateButton("With Suffix", tone: .success, action: {}, suffix: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 16, height: 16)
                    })

                    ElevateButton(
                        label: "Both Icons",
                        tone: .warning,
                        action: {},
                        prefix: {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .frame(width: 16, height: 16)
                        },
                        suffix: {
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 16, height: 16)
                        }
                    )
                }
            }
            .padding()
        }
    }
}
#endif

#endif
