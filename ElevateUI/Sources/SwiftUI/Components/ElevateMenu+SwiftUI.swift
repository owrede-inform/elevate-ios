#if os(iOS)
import SwiftUI

/// ELEVATE Menu Component for SwiftUI
///
/// A container for menu items with optional group labels.
/// Can be presented as a popover, sheet, or embedded in views.
///
/// # Usage
/// ```swift
/// ElevateMenu {
///     ElevateMenuItem("Copy", icon: "doc.on.doc") { /* action */ }
///     ElevateMenuItem("Paste", icon: "doc.on.clipboard") { /* action */ }
/// }
///
/// // With groups
/// ElevateMenu {
///     ElevateMenuGroup("Edit") {
///         ElevateMenuItem("Copy", icon: "doc.on.doc") { /* action */ }
///         ElevateMenuItem("Paste", icon: "doc.on.clipboard") { /* action */ }
///     }
///
///     ElevateMenuGroup("Delete") {
///         ElevateMenuItem("Delete", icon: "trash", isDestructive: true) { /* action */ }
///     }
/// }
/// ```
///
/// # iOS Adaptations
/// - Custom container matching ELEVATE design system
/// - Group labels with proper styling
/// - Shadow and border from design tokens
/// - Scrollable for long menus
///
/// # Design Tokens
/// Uses ELEVATE menu component tokens for container styling.
@available(iOS 15, *)
public struct ElevateMenu<Content: View>: View {

    // MARK: - Properties

    private let size: MenuTokens.Size
    private let content: Content

    // MARK: - Computed Properties

    private var sizeConfig: MenuTokens.SizeConfig {
        size.config
    }

    // MARK: - Initializer

    /// Creates a menu container
    /// - Parameters:
    ///   - size: The size variant
    ///   - content: The menu items and groups
    public init(
        size: MenuTokens.Size = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.size = size
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                content
            }
            .padding(.vertical, sizeConfig.verticalPadding)
        }
        .frame(minWidth: sizeConfig.minWidth)
        .frame(maxWidth: sizeConfig.maxWidth)
        .background(MenuTokens.fillColor)
        .cornerRadius(sizeConfig.cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: sizeConfig.cornerRadius)
                .strokeBorder(MenuTokens.borderColor, lineWidth: sizeConfig.borderWidth)
        )
        .applyShadow(light: .popover, dark: .popoverDark)
    }
}

/// ELEVATE Menu Group for organizing menu items
///
/// A labeled section within a menu for grouping related items.
@available(iOS 15, *)
public struct ElevateMenuGroup<Content: View>: View {

    // MARK: - Properties

    private let label: String?
    private let size: MenuTokens.Size
    private let content: Content

    // MARK: - Computed Properties

    private var sizeConfig: MenuTokens.SizeConfig {
        size.config
    }

    // MARK: - Initializer

    /// Creates a menu group with optional label
    /// - Parameters:
    ///   - label: Optional group label
    ///   - size: The size variant
    ///   - content: The menu items
    public init(
        _ label: String? = nil,
        size: MenuTokens.Size = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.label = label
        self.size = size
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            // Group label
            if let label = label {
                HStack {
                    Text(label)
                        .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: sizeConfig.groupLabelFontSize).weight(.semibold))
                        .foregroundColor(MenuTokens.groupLabelTextColor)
                        .textCase(.uppercase)
                    Spacer()
                }
                .padding(.horizontal, sizeConfig.horizontalPadding)
                .frame(height: sizeConfig.groupLabelHeight)
                .background(MenuTokens.groupLabelFillColor)
            }

            // Items
            content
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateMenu_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic Menu
            ElevateMenu {
                ElevateMenuItem("Copy", icon: "doc.on.doc") {}
                ElevateMenuItem("Paste", icon: "doc.on.clipboard") {}
                ElevateMenuItem("Cut", icon: "scissors") {}
                Divider()
                ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {}
            }
            .padding()
            .previewDisplayName("Basic Menu")

            // Menu with Groups
            ElevateMenu {
                ElevateMenuGroup("Edit") {
                    ElevateMenuItem("Copy", icon: "doc.on.doc") {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard") {}
                    ElevateMenuItem("Cut", icon: "scissors") {}
                }

                Divider()

                ElevateMenuGroup("Format") {
                    ElevateMenuItem("Bold", icon: "bold") {}
                    ElevateMenuItem("Italic", icon: "italic") {}
                    ElevateMenuItem("Underline", icon: "underline") {}
                }

                Divider()

                ElevateMenuGroup("Actions") {
                    ElevateMenuItem("Share", icon: "square.and.arrow.up") {}
                    ElevateMenuItem("Duplicate", icon: "plus.square.on.square") {}
                }

                Divider()

                ElevateMenuGroup {
                    ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {}
                }
            }
            .padding()
            .previewDisplayName("With Groups")

            // Sizes
            VStack(spacing: 16) {
                ElevateMenu(size: .small) {
                    ElevateMenuItem("Copy", icon: "doc.on.doc", size: .small) {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard", size: .small) {}
                }

                ElevateMenu(size: .medium) {
                    ElevateMenuItem("Copy", icon: "doc.on.doc", size: .medium) {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard", size: .medium) {}
                }

                ElevateMenu(size: .large) {
                    ElevateMenuItem("Copy", icon: "doc.on.doc", size: .large) {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard", size: .large) {}
                }
            }
            .padding()
            .previewDisplayName("Sizes")

            // Interactive Example
            MenuExample()
                .previewDisplayName("Interactive Example")

            // Dark Mode
            ElevateMenu {
                ElevateMenuGroup("Actions") {
                    ElevateMenuItem("Copy", icon: "doc.on.doc") {}
                    ElevateMenuItem("Paste", icon: "doc.on.clipboard") {}
                }
                Divider()
                ElevateMenuGroup {
                    ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {}
                }
            }
            .padding()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
    }

    struct MenuExample: View {
        @State private var showMenu = false
        @State private var message = "Tap button to show menu"

        var body: some View {
            VStack(spacing: 20) {
                Text(message)
                    .font(.caption)
                    .foregroundColor(ElevateAliases.Content.General.text_muted)

                Button("Show Menu") {
                    showMenu.toggle()
                }

                if showMenu {
                    ElevateMenu {
                        ElevateMenuGroup("Edit") {
                            ElevateMenuItem("Copy", icon: "doc.on.doc") {
                                message = "Copied!"
                                showMenu = false
                            }
                            ElevateMenuItem("Paste", icon: "doc.on.clipboard") {
                                message = "Pasted!"
                                showMenu = false
                            }
                        }

                        Divider()

                        ElevateMenuGroup {
                            ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {
                                message = "Deleted!"
                                showMenu = false
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
