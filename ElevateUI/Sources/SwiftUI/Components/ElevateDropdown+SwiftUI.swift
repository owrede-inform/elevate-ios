#if os(iOS)
import SwiftUI

/// Dropdown component with iOS-native menu patterns
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's hover dropdown, this uses:
/// - Tap trigger: .menu() for primary dropdown pattern
/// - Long-press trigger: .contextMenu() for contextual actions
/// - Never uses web-style hover dropdown on touch
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// ElevateDropdown(label: "Options") {
///     ElevateDropdownItem(title: "Edit", icon: "pencil") {
///         // Edit action
///     }
///     ElevateDropdownItem(title: "Delete", icon: "trash", isDestructive: true) {
///         // Delete action
///     }
/// }
/// ```
@available(iOS 15, *)
public struct ElevateDropdown<Content: View>: View {

    private let label: String
    private let icon: String?
    private let content: () -> Content
    private let isDestructive: Bool

    @Environment(\.isEnabled) private var isEnabled

    // MARK: - Initialization

    public init(
        label: String,
        icon: String? = nil,
        isDestructive: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.label = label
        self.icon = icon
        self.isDestructive = isDestructive
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        Menu {
            content()
        } label: {
            dropdownButton
        }
        .disabled(!isEnabled)
        .onTapGesture {
            performHaptic()
        }
    }

    // MARK: - Dropdown Button

    private var dropdownButton: some View {
        HStack(spacing: 8) {
            if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 16))
            }

            Text(label)
                .font(.body)

            Spacer()

            Image(systemName: "chevron.down")
                .font(.system(size: 12))
        }
        .foregroundColor(isDestructive ? ElevateAliases.Action.StrongDanger.text_default : ElevateAliases.Content.General.text_default)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(DropdownComponentTokens.fill)
        .cornerRadius(DropdownComponentTokens.radius)
        .opacity(isEnabled ? 1.0 : 0.5)
    }

    // MARK: - Haptics

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Dropdown Item

/// Individual item in a dropdown menu
@available(iOS 15, *)
public struct ElevateDropdownItem: View {

    private let title: String
    private let icon: String?
    private let isDestructive: Bool
    private let action: () -> Void

    public init(
        title: String,
        icon: String? = nil,
        isDestructive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isDestructive = isDestructive
        self.action = action
    }

    public var body: some View {
        Button(role: isDestructive ? .destructive : nil) {
            performHaptic()
            action()
        } label: {
            Label(title, systemImage: icon ?? "")
        }
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Context Menu Extension

@available(iOS 15, *)
extension View {
    /// Add a context menu dropdown (long-press trigger)
    ///
    /// **iOS Adaptation**: Uses long-press gesture instead of web hover.
    /// Context menus appear on long-press and provide iOS-native menu experience.
    ///
    /// Example:
    /// ```swift
    /// Text("Long press me")
    ///     .elevateContextMenu {
    ///         ElevateDropdownItem(title: "Edit", icon: "pencil") { }
    ///         ElevateDropdownItem(title: "Delete", icon: "trash", isDestructive: true) { }
    ///     }
    /// ```
    public func elevateContextMenu<Content: View>(
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.contextMenu {
            content()
        }
    }
}

// MARK: - Action Sheet Extension

@available(iOS 15, *)
extension View {
    /// Present an action sheet with destructive actions
    ///
    /// **iOS Adaptation**: Uses native action sheet for destructive operations.
    /// This is the iOS pattern for delete, remove, or other critical actions.
    ///
    /// Example:
    /// ```swift
    /// Button("Delete Item") { showActionSheet = true }
    ///     .elevateActionSheet(
    ///         isPresented: $showActionSheet,
    ///         title: "Delete Item",
    ///         message: "This cannot be undone",
    ///         destructiveAction: ActionSheetButton(title: "Delete") { }
    ///     )
    /// ```
    public func elevateActionSheet(
        isPresented: Binding<Bool>,
        title: String,
        message: String? = nil,
        destructiveAction: ActionSheetButton,
        cancelAction: (() -> Void)? = nil
    ) -> some View {
        self.confirmationDialog(
            title,
            isPresented: isPresented,
            titleVisibility: .visible
        ) {
            Button(destructiveAction.title, role: .destructive) {
                performHaptic(.medium)
                destructiveAction.action()
            }

            Button("Cancel", role: .cancel) {
                performHaptic(.light)
                cancelAction?()
            }
        } message: {
            if let message = message {
                Text(message)
            }
        }
    }

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Action Sheet Button

/// Button configuration for action sheets
@available(iOS 15, *)
public struct ActionSheetButton {
    public let title: String
    public let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateDropdown_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }

    struct PreviewContainer: View {
        @State private var showActionSheet = false

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text("Dropdown Examples")
                        .font(.title)

                    // Basic dropdown (tap trigger)
                    VStack(alignment: .leading) {
                        Text("Basic Menu (Tap)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Tap to open menu")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        ElevateDropdown(label: "Options", icon: "ellipsis.circle") {
                            ElevateDropdownItem(title: "Edit", icon: "pencil") {
                                print("Edit tapped")
                            }
                            ElevateDropdownItem(title: "Share", icon: "square.and.arrow.up") {
                                print("Share tapped")
                            }
                            Divider()
                            ElevateDropdownItem(title: "Delete", icon: "trash", isDestructive: true) {
                                print("Delete tapped")
                            }
                        }
                    }

                    // Context menu (long-press trigger)
                    VStack(alignment: .leading) {
                        Text("Context Menu (Long Press)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("Long press the card to open menu")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        HStack {
                            Image(systemName: "doc.fill")
                                .foregroundColor(.blue)
                            Text("Document.pdf")
                            Spacer()
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .elevateContextMenu {
                            ElevateDropdownItem(title: "Open", icon: "arrow.up.right.square") {
                                print("Open tapped")
                            }
                            ElevateDropdownItem(title: "Rename", icon: "pencil") {
                                print("Rename tapped")
                            }
                            ElevateDropdownItem(title: "Duplicate", icon: "doc.on.doc") {
                                print("Duplicate tapped")
                            }
                            Divider()
                            ElevateDropdownItem(title: "Delete", icon: "trash", isDestructive: true) {
                                print("Delete tapped")
                            }
                        }
                    }

                    // Action sheet (destructive actions)
                    VStack(alignment: .leading) {
                        Text("Action Sheet (Destructive)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("For critical actions like delete")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Button("Delete Account") {
                            showActionSheet = true
                        }
                        .buttonStyle(.bordered)
                        .tint(.red)
                        .elevateActionSheet(
                            isPresented: $showActionSheet,
                            title: "Delete Account",
                            message: "This action cannot be undone. All your data will be permanently deleted.",
                            destructiveAction: ActionSheetButton(title: "Delete Account") {
                                print("Account deleted")
                            }
                        )
                    }

                    // Disabled state
                    VStack(alignment: .leading) {
                        Text("Disabled State")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        ElevateDropdown(label: "Disabled Options") {
                            ElevateDropdownItem(title: "Edit", icon: "pencil") { }
                        }
                        .disabled(true)
                    }

                    // iOS Adaptation notes
                    VStack(alignment: .leading, spacing: 8) {
                        Text("iOS Adaptations:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("✓ Tap trigger: .menu() for primary dropdown")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ Long-press trigger: .contextMenu() for contextual actions")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ Action sheet for destructive actions")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ No hover dropdown (touch device)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("✓ Haptic feedback on open")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}
#endif

#endif
