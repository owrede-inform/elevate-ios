#if os(iOS)
import SwiftUI

/// ELEVATE Menu Item Component for SwiftUI
///
/// A single menu item that can be used within ElevateMenu.
/// Supports icons, labels, and disabled state.
///
/// # Usage
/// ```swift
/// ElevateMenuItem("Copy", icon: "doc.on.doc") {
///     // Handle copy action
/// }
/// ```
///
/// # iOS Adaptations
/// - Scroll-friendly tap gestures
/// - Full-width touch target
/// - Dynamic text support
/// - VoiceOver support
///
/// # Design Tokens
/// Uses ELEVATE action tokens for interactive states.
@available(iOS 15, *)
public struct ElevateMenuItem: View {

    // MARK: - Properties

    private let label: String
    private let icon: String?
    private let isDisabled: Bool
    private let isDestructive: Bool
    private let size: MenuTokens.Size
    private let action: () -> Void

    @State private var isPressed = false

    // MARK: - Computed Properties

    private var sizeConfig: MenuTokens.SizeConfig {
        size.config
    }

    private var textColor: Color {
        if isDisabled {
            return ElevateAliases.Action.StrongNeutral.text_disabled_default
        } else if isDestructive {
            return ElevateAliases.Feedback.General.text_danger
        } else if isPressed {
            return ElevateAliases.Action.StrongNeutral.text_active
        } else {
            return ElevateAliases.Action.StrongNeutral.text_default
        }
    }

    private var backgroundColor: Color {
        if isPressed && !isDisabled {
            return ElevateAliases.Action.StrongNeutral.fill_hover
        } else {
            return Color.clear
        }
    }

    // MARK: - Initializer

    /// Creates a menu item
    /// - Parameters:
    ///   - label: The text label
    ///   - icon: Optional SF Symbol name
    ///   - isDisabled: Whether the item is disabled
    ///   - isDestructive: Whether this is a destructive action (red text)
    ///   - size: The size variant
    ///   - action: Closure called when item is tapped
    public init(
        _ label: String,
        icon: String? = nil,
        isDisabled: Bool = false,
        isDestructive: Bool = false,
        size: MenuTokens.Size = .medium,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.icon = icon
        self.isDisabled = isDisabled
        self.isDestructive = isDestructive
        self.size = size
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: sizeConfig.gap) {
            // Icon
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: sizeConfig.iconSize))
                    .foregroundColor(textColor)
                    .frame(width: sizeConfig.iconSize, height: sizeConfig.iconSize)
            }

            // Label
            Text(label)
                .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: sizeConfig.fontSize))
                .foregroundColor(textColor)
                .lineLimit(1)

            Spacer()
        }
        .padding(.horizontal, sizeConfig.horizontalPadding)
        .frame(height: sizeConfig.itemHeight)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(backgroundColor)
        .contentShape(Rectangle())
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(.isButton)
        .disabled(isDisabled)
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic Menu Items
            VStack(spacing: 0) {
                Text("Basic Items").font(.headline)
                    .padding()

                ElevateMenuItem("Copy", icon: "doc.on.doc") {}
                ElevateMenuItem("Paste", icon: "doc.on.clipboard") {}
                ElevateMenuItem("Select All", icon: "checkmark.circle") {}
                Divider()
                ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {}
            }
            .frame(width: 250)
            .background(MenuTokens.fillColor)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding()
            .previewDisplayName("Basic Items")

            // With Disabled State
            VStack(spacing: 0) {
                ElevateMenuItem("Copy", icon: "doc.on.doc") {}
                ElevateMenuItem("Paste", icon: "doc.on.clipboard", isDisabled: true) {}
                ElevateMenuItem("Cut", icon: "scissors") {}
            }
            .frame(width: 250)
            .background(MenuTokens.fillColor)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding()
            .previewDisplayName("With Disabled")

            // Sizes
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    Text("Small").font(.caption)
                    ElevateMenuItem("Copy", icon: "doc.on.doc", size: .small) {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard", size: .small) {}
                }
                .frame(width: 200)
                .background(MenuTokens.fillColor)
                .cornerRadius(6)

                VStack(spacing: 0) {
                    Text("Medium").font(.caption)
                    ElevateMenuItem("Copy", icon: "doc.on.doc", size: .medium) {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard", size: .medium) {}
                }
                .frame(width: 250)
                .background(MenuTokens.fillColor)
                .cornerRadius(6)

                VStack(spacing: 0) {
                    Text("Large").font(.caption)
                    ElevateMenuItem("Copy", icon: "doc.on.doc", size: .large) {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard", size: .large) {}
                }
                .frame(width: 300)
                .background(MenuTokens.fillColor)
                .cornerRadius(6)
            }
            .padding()
            .previewDisplayName("Sizes")

            // Dark Mode
            VStack(spacing: 0) {
                ElevateMenuItem("Copy", icon: "doc.on.doc") {}
                ElevateMenuItem("Paste", icon: "doc.on.clipboard") {}
                ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {}
            }
            .frame(width: 250)
            .background(MenuTokens.fillColor)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
    }
}
#endif

#endif
