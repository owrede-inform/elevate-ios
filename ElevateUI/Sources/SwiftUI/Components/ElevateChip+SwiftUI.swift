#if os(iOS)
import SwiftUI

/// ELEVATE Chip Component
///
/// Chips are labels used to organize things or indicate selections.
/// They can be removable and editable with optional prefix/suffix content.
///
/// **Web Component:** `<elvt-chip>`
/// **API Reference:** `.claude/components/Display/chip.md`
@available(iOS 15, *)
public struct ElevateChip<Prefix: View, Suffix: View>: View {

    // MARK: - Properties

    /// The visual style of the chip
    public var tone: ChipTokens.Tone

    /// The size of the chip
    public var size: ChipTokens.Size

    /// The shape of the chip
    public var shape: ChipTokens.Shape

    /// Whether the chip is selected
    public var isSelected: Bool

    /// Whether the chip is disabled
    public var isDisabled: Bool

    /// Whether the chip shows a remove button
    public var removable: Bool

    // MARK: - Content

    private let label: String
    private let prefix: () -> Prefix
    private let suffix: () -> Suffix

    // MARK: - Actions

    private let action: (() -> Void)?
    private let onRemove: (() -> Void)?
    private let onEdit: (() -> Void)?

    // MARK: - Environment

    @Environment(\.colorScheme) var colorScheme

    // MARK: - State

    @State private var isPressed = false

    // MARK: - Initializers

    /// Create chip with all options
    public init(
        label: String,
        tone: ChipTokens.Tone = .neutral,
        size: ChipTokens.Size = .medium,
        shape: ChipTokens.Shape = .box,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        removable: Bool = false,
        action: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil,
        onEdit: (() -> Void)? = nil,
        @ViewBuilder prefix: @escaping () -> Prefix = { EmptyView() },
        @ViewBuilder suffix: @escaping () -> Suffix = { EmptyView() }
    ) {
        self.label = label
        self.tone = tone
        self.size = size
        self.shape = shape
        self.isSelected = isSelected
        self.isDisabled = isDisabled
        self.removable = removable
        self.action = action
        self.onRemove = onRemove
        self.onEdit = onEdit
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

            if removable {
                removeButton
            }
        }
        .foregroundColor(tokenTextColor)
        .padding(.horizontal, tokenHorizontalPadding)
        .padding(.vertical, tokenVerticalPadding)
        .frame(height: tokenHeight)
        .background(tokenFillColor)
        .overlay(
            RoundedRectangle(cornerRadius: tokenCornerRadius)
                .stroke(tokenBorderColor, lineWidth: tokenBorderWidth)
        )
        .cornerRadius(tokenCornerRadius)
        .scrollFriendlyTap(
            onPressedChanged: { pressed in
                if !isDisabled && action != nil {
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
                    action?()
                }
            }
        )
        .allowsHitTesting(!isDisabled)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityHint(removable ? "Double tap to remove" : "")
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }

    private var removeButton: some View {
        Image(systemName: "xmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: tokenRemoveButtonSize, height: tokenRemoveButtonSize)
            .foregroundColor(tokenControlIconColor)
            .scrollFriendlyTap {
                if !isDisabled {
                    onRemove?()
                }
            }
            .accessibilityLabel("Remove")
    }

    // MARK: - Token Accessors

    private var tokenFillColor: Color {
        ChipTokens.fillColor(for: tone, isSelected: isSelected, isDisabled: isDisabled).color(for: colorScheme)
    }

    private var tokenTextColor: Color {
        ChipTokens.textColor(for: tone, isSelected: isSelected, isDisabled: isDisabled).color(for: colorScheme)
    }

    private var tokenBorderColor: Color {
        ChipTokens.borderColor(for: tone, isSelected: isSelected, isDisabled: isDisabled).color(for: colorScheme)
    }

    private var tokenControlIconColor: Color {
        let colors = tone.colors
        let color: Color
        if isDisabled {
            color = colors.textDisabled
        } else {
            color = isSelected ? colors.textSelected : colors.controlIcon
        }
        return color
    }

    private var tokenBorderWidth: CGFloat {
        ChipTokens.borderWidth(for: size)
    }

    private var tokenHeight: CGFloat {
        size.config.height
    }

    private var tokenHorizontalPadding: CGFloat {
        size.config.horizontalPadding
    }

    private var tokenVerticalPadding: CGFloat {
        size.config.verticalPadding
    }

    private var tokenFont: Font {
        Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: size.config.fontSize).weight(size.config.fontWeight)
    }

    private var tokenGap: CGFloat {
        size.config.gap
    }

    private var tokenRemoveButtonSize: CGFloat {
        size.config.removeButtonSize
    }

    private var tokenCornerRadius: CGFloat {
        shape.cornerRadius(for: size)
    }
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension ElevateChip where Prefix == EmptyView, Suffix == EmptyView {
    /// Create chip with label only
    public init(
        _ label: String,
        tone: ChipTokens.Tone = .neutral,
        size: ChipTokens.Size = .medium,
        shape: ChipTokens.Shape = .box,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        removable: Bool = false,
        action: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil,
        onEdit: (() -> Void)? = nil
    ) {
        self.init(
            label: label,
            tone: tone,
            size: size,
            shape: shape,
            isSelected: isSelected,
            isDisabled: isDisabled,
            removable: removable,
            action: action,
            onRemove: onRemove,
            onEdit: onEdit
        )
    }
}

@available(iOS 15, *)
extension ElevateChip where Suffix == EmptyView {
    /// Create chip with prefix icon
    public init(
        _ label: String,
        tone: ChipTokens.Tone = .neutral,
        size: ChipTokens.Size = .medium,
        shape: ChipTokens.Shape = .box,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        removable: Bool = false,
        action: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil,
        onEdit: (() -> Void)? = nil,
        @ViewBuilder prefix: @escaping () -> Prefix
    ) {
        self.init(
            label: label,
            tone: tone,
            size: size,
            shape: shape,
            isSelected: isSelected,
            isDisabled: isDisabled,
            removable: removable,
            action: action,
            onRemove: onRemove,
            onEdit: onEdit,
            prefix: prefix
        )
    }
}

@available(iOS 15, *)
extension ElevateChip where Prefix == EmptyView {
    /// Create chip with suffix icon
    public init(
        _ label: String,
        tone: ChipTokens.Tone = .neutral,
        size: ChipTokens.Size = .medium,
        shape: ChipTokens.Shape = .box,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        removable: Bool = false,
        action: (() -> Void)? = nil,
        onRemove: (() -> Void)? = nil,
        onEdit: (() -> Void)? = nil,
        @ViewBuilder suffix: @escaping () -> Suffix
    ) {
        self.init(
            label: label,
            tone: tone,
            size: size,
            shape: shape,
            isSelected: isSelected,
            isDisabled: isDisabled,
            removable: removable,
            action: action,
            onRemove: onRemove,
            onEdit: onEdit,
            suffix: suffix
        )
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateChip_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Basic chips - all tones
            HStack(spacing: 8) {
                ElevateChip("Primary", tone: .primary)
                ElevateChip("Success", tone: .success)
                ElevateChip("Warning", tone: .warning)
                ElevateChip("Danger", tone: .danger)
            }

            // Sizes
            HStack(spacing: 8) {
                ElevateChip("Small", tone: .primary, size: .small)
                ElevateChip("Medium", tone: .primary, size: .medium)
                ElevateChip("Large", tone: .primary, size: .large)
            }

            // Selected state
            HStack(spacing: 8) {
                ElevateChip("Unselected", tone: .primary, isSelected: false)
                ElevateChip("Selected", tone: .primary, isSelected: true)
            }

            // Removable
            HStack(spacing: 8) {
                ElevateChip("Removable", tone: .primary, removable: true, onRemove: {
                    print("Remove tapped")
                })
                ElevateChip("Remove Success", tone: .success, removable: true, onRemove: {
                    print("Remove tapped")
                })
            }

            // With icon
            ElevateChip("With Icon", tone: .primary, prefix: {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 14, height: 14)
            })

            // Pill shape
            HStack(spacing: 8) {
                ElevateChip("Pill Shape", tone: .primary, shape: .pill)
                ElevateChip("Pill Small", tone: .success, size: .small, shape: .pill)
            }

            // Disabled
            HStack(spacing: 8) {
                ElevateChip("Disabled", tone: .primary, isDisabled: true)
                ElevateChip("Disabled Removable", tone: .danger, isDisabled: true, removable: true)
            }
        }
        .padding()
    }
}
#endif

#endif
