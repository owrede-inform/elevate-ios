#if os(iOS)
import SwiftUI

/// ELEVATE Button Group Component
///
/// Groups related buttons together with connected styling.
/// Buttons are visually connected with shared borders and corner radius masking.
///
/// **Key Features:**
/// - Connected buttons with no gap between them
/// - First button has left rounded corners
/// - Middle buttons have no rounded corners
/// - Last button has right rounded corners
/// - Shared border between buttons (no double borders)
/// - Supports all button tones
/// - Supports selection states
///
/// **Web Component:** `<elvt-button-group>`
@available(iOS 16, *)
public struct ElevateButtonGroup: View {

    // MARK: - Properties

    /// The buttons in the group
    private let buttons: [ButtonItem]

    /// Accessibility label for the group
    private let label: String

    /// Button size
    private let size: ButtonTokens.Size

    /// Button tone
    private let tone: ButtonTokens.Tone

    // MARK: - Button Item

    public struct ButtonItem: Identifiable {
        public let id = UUID()
        public let title: String
        public let icon: String?
        public let isSelected: Bool
        public let isDisabled: Bool
        public let action: () -> Void

        public init(
            title: String,
            icon: String? = nil,
            isSelected: Bool = false,
            isDisabled: Bool = false,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.icon = icon
            self.isSelected = isSelected
            self.isDisabled = isDisabled
            self.action = action
        }
    }

    // MARK: - Initializer

    /// Creates a button group
    ///
    /// - Parameters:
    ///   - buttons: Array of button items
    ///   - label: Accessibility label for the group
    ///   - size: Size of the buttons
    ///   - tone: Tone/style of the buttons
    public init(
        buttons: [ButtonItem],
        label: String = "Button group",
        size: ButtonTokens.Size = .medium,
        tone: ButtonTokens.Tone = .neutral
    ) {
        self.buttons = buttons
        self.label = label
        self.size = size
        self.tone = tone
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(buttons.enumerated()), id: \.element.id) { index, button in
                ConnectedButton(
                    button: button,
                    position: position(for: index),
                    size: size,
                    tone: tone
                )
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label)
    }

    // MARK: - Helper Methods

    private func position(for index: Int) -> ButtonPosition {
        if buttons.count == 1 {
            return .single
        } else if index == 0 {
            return .first
        } else if index == buttons.count - 1 {
            return .last
        } else {
            return .middle
        }
    }
}

// MARK: - Button Position

private enum ButtonPosition {
    case single
    case first
    case middle
    case last
}

// MARK: - Connected Button

@available(iOS 16, *)
private struct ConnectedButton: View {
    let button: ElevateButtonGroup.ButtonItem
    let position: ButtonPosition
    let size: ButtonTokens.Size
    let tone: ButtonTokens.Tone

    private var cornerRadius: CGFloat {
        switch size {
        case .small: return 8
        case .medium: return 8
        case .large: return 8
        }
    }

    private var height: CGFloat {
        switch size {
        case .small: return 44
        case .medium: return 48
        case .large: return 56
        }
    }

    private var fontSize: Font {
        switch size {
        case .small: return ElevateTypography.labelSmall
        case .medium: return ElevateTypography.labelMedium
        case .large: return ElevateTypography.titleSmall
        }
    }

    private var horizontalPadding: CGFloat {
        switch size {
        case .small: return 12
        case .medium: return 16
        case .large: return 20
        }
    }

    var body: some View {
        Button(action: button.action) {
            HStack(spacing: 8) {
                if let icon = button.icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .medium))
                }

                if !button.title.isEmpty {
                    Text(button.title)
                        .font(fontSize)
                }
            }
            .frame(height: height)
            .padding(.horizontal, horizontalPadding)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .overlay(
                // Border overlay
                Group {
                    if position == .middle || position == .last {
                        // Left border for middle and last buttons
                        Rectangle()
                            .fill(borderColor)
                            .frame(width: 1)
                            .frame(maxHeight: .infinity)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            )
        }
        .disabled(button.isDisabled)
        .clipShape(maskShape)
        .overlay(
            // Outer border
            Group {
                switch position {
                case .single:
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: 1)
                case .first:
                    UnevenRoundedRectangle(
                        topLeadingRadius: cornerRadius,
                        bottomLeadingRadius: cornerRadius,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                    .stroke(borderColor, lineWidth: 1)
                case .middle:
                    Rectangle()
                        .stroke(borderColor, lineWidth: 1)
                case .last:
                    UnevenRoundedRectangle(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: cornerRadius,
                        topTrailingRadius: cornerRadius
                    )
                    .stroke(borderColor, lineWidth: 1)
                }
            }
        )
    }

    private var maskShape: AnyShape {
        switch position {
        case .single:
            return AnyShape(RoundedRectangle(cornerRadius: cornerRadius))
        case .first:
            return AnyShape(UnevenRoundedRectangle(
                topLeadingRadius: cornerRadius,
                bottomLeadingRadius: cornerRadius,
                bottomTrailingRadius: 0,
                topTrailingRadius: 0
            ))
        case .middle:
            return AnyShape(Rectangle())
        case .last:
            return AnyShape(UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: cornerRadius,
                topTrailingRadius: cornerRadius
            ))
        }
    }

    private var backgroundColor: Color {
        if button.isDisabled {
            return ElevateAliases.Action.StrongNeutral.fill_disabled_default
        } else if button.isSelected {
            return fillColorSelected
        } else {
            return fillColorDefault
        }
    }

    private var textColor: Color {
        if button.isDisabled {
            return ElevateAliases.Action.StrongNeutral.text_disabled_default
        } else if button.isSelected {
            return textColorSelected
        } else {
            return textColorDefault
        }
    }

    private var borderColor: Color {
        if button.isDisabled {
            return ElevateAliases.Action.StrongNeutral.border_disabled_default
        } else if button.isSelected {
            return borderColorSelected
        } else {
            return borderColorDefault
        }
    }

    // Tone-specific colors
    private var fillColorDefault: Color {
        switch tone {
        case .primary: return ElevateAliases.Action.StrongPrimary.fill_default
        case .success: return ElevateAliases.Action.StrongSuccess.fill_default
        case .warning: return ElevateAliases.Action.StrongWarning.fill_default
        case .danger: return ElevateAliases.Action.StrongDanger.fill_default
        case .emphasized: return ElevateAliases.Action.StrongEmphasized.fill_default
        case .subtle: return ElevateAliases.Action.UnderstatedNeutral.fill_default
        case .neutral: return ElevateAliases.Action.StrongNeutral.fill_default
        @unknown default: return ElevateAliases.Action.StrongNeutral.fill_default
        }
    }

    private var fillColorSelected: Color {
        switch tone {
        case .primary: return ElevateAliases.Action.StrongPrimary.fill_selected_default
        case .success: return ElevateAliases.Action.StrongSuccess.fill_selected_default
        case .warning: return ElevateAliases.Action.StrongWarning.fill_selected_default
        case .danger: return ElevateAliases.Action.StrongDanger.fill_selected_default
        case .emphasized: return ElevateAliases.Action.StrongEmphasized.fill_selected_default
        case .subtle: return ElevateAliases.Action.UnderstatedNeutral.fill_selected_default
        case .neutral: return ElevateAliases.Action.StrongNeutral.fill_selected_default
        @unknown default: return ElevateAliases.Action.StrongNeutral.fill_selected_default
        }
    }

    private var textColorDefault: Color {
        switch tone {
        case .primary: return ElevateAliases.Action.StrongPrimary.text_default
        case .success: return ElevateAliases.Action.StrongSuccess.text_default
        case .warning: return ElevateAliases.Action.StrongWarning.text_default
        case .danger: return ElevateAliases.Action.StrongDanger.text_default
        case .emphasized: return ElevateAliases.Action.StrongEmphasized.text_default
        case .subtle: return ElevateAliases.Action.UnderstatedNeutral.text_default
        case .neutral: return ElevateAliases.Action.StrongNeutral.text_default
        @unknown default: return ElevateAliases.Action.StrongNeutral.text_default
        }
    }

    private var textColorSelected: Color {
        switch tone {
        case .primary: return ElevateAliases.Action.StrongPrimary.text_selected_default
        case .success: return ElevateAliases.Action.StrongSuccess.text_selected_default
        case .warning: return ElevateAliases.Action.StrongWarning.text_selected_default
        case .danger: return ElevateAliases.Action.StrongDanger.text_selected_default
        case .emphasized: return ElevateAliases.Action.StrongEmphasized.text_selected_default
        case .subtle: return ElevateAliases.Action.UnderstatedNeutral.text_selected_default
        case .neutral: return ElevateAliases.Action.StrongNeutral.text_selected_default
        @unknown default: return ElevateAliases.Action.StrongNeutral.text_selected_default
        }
    }

    private var borderColorDefault: Color {
        switch tone {
        case .primary: return ElevateAliases.Action.StrongPrimary.border_default
        case .success: return ElevateAliases.Action.StrongSuccess.border_default
        case .warning: return ElevateAliases.Action.StrongWarning.border_default
        case .danger: return ElevateAliases.Action.StrongDanger.border_default
        case .emphasized: return ElevateAliases.Action.StrongEmphasized.border_default
        case .subtle: return ElevateAliases.Action.UnderstatedNeutral.border_default
        case .neutral: return ElevateAliases.Action.StrongNeutral.border_default
        @unknown default: return ElevateAliases.Action.StrongNeutral.border_default
        }
    }

    private var borderColorSelected: Color {
        switch tone {
        case .primary: return ElevateAliases.Action.StrongPrimary.border_selected_default
        case .success: return ElevateAliases.Action.StrongSuccess.border_selected_default
        case .warning: return ElevateAliases.Action.StrongWarning.border_selected_default
        case .danger: return ElevateAliases.Action.StrongDanger.border_selected_default
        case .emphasized: return ElevateAliases.Action.StrongEmphasized.border_selected_default
        case .subtle: return ElevateAliases.Action.UnderstatedNeutral.border_selected_selected
        case .neutral: return ElevateAliases.Action.StrongNeutral.border_selected_default
        @unknown default: return ElevateAliases.Action.StrongNeutral.border_selected_default
        }
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 16, *)
struct ElevateButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Text Alignment
                VStack(alignment: .leading, spacing: 8) {
                    Text("Text Alignment").font(ElevateTypography.titleMedium)

                    ElevateButtonGroup(
                        buttons: [
                            .init(title: "", icon: "text.alignleft", isSelected: true) {},
                            .init(title: "", icon: "text.aligncenter") {},
                            .init(title: "", icon: "text.alignright") {},
                            .init(title: "", icon: "text.justify") {}
                        ],
                        label: "Text alignment"
                    )
                }

                // View Mode
                VStack(alignment: .leading, spacing: 8) {
                    Text("View Mode").font(ElevateTypography.titleMedium)

                    ElevateButtonGroup(
                        buttons: [
                            .init(title: "", icon: "square.grid.2x2") {},
                            .init(title: "", icon: "list.bullet", isSelected: true) {},
                            .init(title: "", icon: "rectangle.grid.1x2") {}
                        ],
                        label: "View mode"
                    )
                }

                // Zoom Controls
                VStack(alignment: .leading, spacing: 8) {
                    Text("Zoom Controls").font(ElevateTypography.titleMedium)

                    ElevateButtonGroup(
                        buttons: [
                            .init(title: "", icon: "minus") {},
                            .init(title: "100%") {},
                            .init(title: "", icon: "plus") {}
                        ],
                        label: "Zoom controls"
                    )
                }

                // Filter Options
                VStack(alignment: .leading, spacing: 8) {
                    Text("Filter Options").font(ElevateTypography.titleMedium)

                    ElevateButtonGroup(
                        buttons: [
                            .init(title: "All", isSelected: true) {},
                            .init(title: "Active") {},
                            .init(title: "Completed") {},
                            .init(title: "Archived") {}
                        ],
                        label: "Filter"
                    )
                }

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sizes").font(ElevateTypography.titleMedium)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Small").font(ElevateTypography.labelSmall).foregroundColor(ElevateAliases.Content.General.text_muted)
                        ElevateButtonGroup(
                            buttons: [
                                .init(title: "Left") {},
                                .init(title: "Center", isSelected: true) {},
                                .init(title: "Right") {}
                            ],
                            size: .small
                        )

                        Text("Medium").font(ElevateTypography.labelSmall).foregroundColor(ElevateAliases.Content.General.text_muted)
                        ElevateButtonGroup(
                            buttons: [
                                .init(title: "Left") {},
                                .init(title: "Center", isSelected: true) {},
                                .init(title: "Right") {}
                            ],
                            size: .medium
                        )

                        Text("Large").font(ElevateTypography.labelSmall).foregroundColor(ElevateAliases.Content.General.text_muted)
                        ElevateButtonGroup(
                            buttons: [
                                .init(title: "Left") {},
                                .init(title: "Center", isSelected: true) {},
                                .init(title: "Right") {}
                            ],
                            size: .large
                        )
                    }
                }

                // Tones
                VStack(alignment: .leading, spacing: 16) {
                    Text("Tones").font(ElevateTypography.titleMedium)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateButtonGroup(
                            buttons: [
                                .init(title: "Primary", isSelected: true) {},
                                .init(title: "Option 2") {},
                                .init(title: "Option 3") {}
                            ],
                            tone: .primary
                        )

                        ElevateButtonGroup(
                            buttons: [
                                .init(title: "Success", isSelected: true) {},
                                .init(title: "Option 2") {},
                                .init(title: "Option 3") {}
                            ],
                            tone: .success
                        )

                        ElevateButtonGroup(
                            buttons: [
                                .init(title: "Neutral", isSelected: true) {},
                                .init(title: "Option 2") {},
                                .init(title: "Option 3") {}
                            ],
                            tone: .neutral
                        )
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
