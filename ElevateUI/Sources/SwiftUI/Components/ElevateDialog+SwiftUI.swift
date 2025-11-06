#if os(iOS)
import SwiftUI

/// Dialog component using iOS-native sheet presentation
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's fixed modal overlay, this uses
/// native iOS `.sheet()` presentation with drag-to-dismiss gesture and adaptive
/// sizing. See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// @State private var showDialog = false
///
/// Button("Show Dialog") {
///     showDialog = true
/// }
/// .elevateDialog(isPresented: $showDialog) {
///     Text("Dialog Content")
/// }
/// ```
@available(iOS 15, *)
public struct ElevateDialog<Content: View>: View {

    private let title: String?
    private let message: String?
    private let content: (() -> Content)?
    private let primaryAction: DialogAction?
    private let secondaryAction: DialogAction?
    private let onDismiss: (() -> Void)?

    // MARK: - Initialization

    /// Create a dialog with custom content
    public init(
        title: String? = nil,
        @ViewBuilder content: @escaping () -> Content,
        primaryAction: DialogAction? = nil,
        secondaryAction: DialogAction? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = nil
        self.content = content
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.onDismiss = onDismiss
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: DialogComponentTokens.body_gap_row) {
            // Title
            if let title = title {
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(.label))
            }

            // Content
            if let content = content {
                content()
                    .foregroundColor(Color(.secondaryLabel))
            }

            // Actions
            if primaryAction != nil || secondaryAction != nil {
                HStack(spacing: 12) {
                    if let secondary = secondaryAction {
                        Button(secondary.title) {
                            performHaptic(.light)
                            secondary.action()
                        }
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity)
                    }

                    if let primary = primaryAction {
                        Button(primary.title) {
                            performHaptic(.light)
                            primary.action()
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .padding(.horizontal, DialogComponentTokens.body_padding_inline)
        .padding(.vertical, DialogComponentTokens.body_padding_block)
        .background(Color(.systemBackground))
    }

    // MARK: - Haptics

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Message-based Dialog

@available(iOS 15, *)
extension ElevateDialog where Content == Text {
    /// Create a dialog with a simple text message
    public init(
        title: String,
        message: String,
        primaryAction: DialogAction? = nil,
        secondaryAction: DialogAction? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.title = title
        self.message = message
        self.content = { Text(message) }
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
        self.onDismiss = onDismiss
    }
}

// MARK: - Dialog Action

/// Represents an action button in a dialog
@available(iOS 15, *)
public struct DialogAction {
    public let title: String
    public let action: () -> Void

    public init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

// MARK: - View Extension

@available(iOS 15, *)
extension View {
    /// Present a dialog as an iOS sheet with native behavior
    ///
    /// **iOS Adaptation**: Uses `.sheet()` instead of web-style fixed modal.
    /// Supports drag-to-dismiss, adaptive sizing, and haptic feedback.
    ///
    /// - Parameters:
    ///   - isPresented: Binding to control dialog visibility
    ///   - detents: Presentation detents (e.g., [.medium, .large])
    ///   - dragIndicator: Show drag indicator (default: true for medium detents)
    ///   - onDismiss: Closure called when dialog is dismissed
    ///   - content: Dialog content builder
    public func elevateDialog<Content: View>(
        isPresented: Binding<Bool>,
        detents: Set<PresentationDetent> = [.large],
        dragIndicator: Bool = true,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: isPresented, onDismiss: onDismiss) {
            content()
                .presentationDetents(detents)
                .presentationDragIndicator(dragIndicator ? .visible : .hidden)
                .interactiveDismissDisabled(false) // Allow swipe-to-dismiss
        }
    }

    /// Present a simple alert-style dialog
    ///
    /// - Parameters:
    ///   - isPresented: Binding to control dialog visibility
    ///   - title: Dialog title
    ///   - message: Dialog message
    ///   - primaryAction: Primary button action
    ///   - secondaryAction: Secondary button action (optional)
    public func elevateAlert(
        isPresented: Binding<Bool>,
        title: String,
        message: String,
        primaryAction: DialogAction,
        secondaryAction: DialogAction? = nil
    ) -> some View {
        self.elevateDialog(
            isPresented: isPresented,
            detents: [.height(200)],
            dragIndicator: false
        ) {
            ElevateDialog(
                title: title,
                message: message,
                primaryAction: primaryAction,
                secondaryAction: secondaryAction
            )
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateDialog_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }

    struct PreviewContainer: View {
        @State private var showSimpleDialog = false
        @State private var showCustomDialog = false
        @State private var showMediumDialog = false
        @State private var showAlert = false

        var body: some View {
            NavigationView {
                List {
                    Section("Basic Dialogs") {
                        Button("Simple Message Dialog") {
                            showSimpleDialog = true
                        }

                        Button("Custom Content Dialog") {
                            showCustomDialog = true
                        }

                        Button("Medium Size Dialog") {
                            showMediumDialog = true
                        }
                    }

                    Section("Alert Style") {
                        Button("Alert Dialog") {
                            showAlert = true
                        }
                    }

                    Section("iOS Adaptation") {
                        Text("Dialogs use native .sheet() presentation")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("• Drag down to dismiss")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("• Adaptive sizing (medium/large)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("• Haptic feedback on actions")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .navigationTitle("Dialog Examples")

                // Simple dialog
                .elevateDialog(isPresented: $showSimpleDialog) {
                    ElevateDialog(
                        title: "Welcome",
                        message: "This is a simple dialog with a message",
                        primaryAction: DialogAction(title: "OK") {
                            showSimpleDialog = false
                        },
                        secondaryAction: DialogAction(title: "Cancel") {
                            showSimpleDialog = false
                        }
                    )
                }

                // Custom content dialog
                .elevateDialog(
                    isPresented: $showCustomDialog,
                    detents: [.medium, .large]
                ) {
                    ElevateDialog(
                        title: "Custom Content",
                        content: {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("This dialog contains custom content")

                                Divider()

                                ForEach(0..<5) { index in
                                    HStack {
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                        Text("Item \(index + 1)")
                                    }
                                }
                            }
                        },
                        primaryAction: DialogAction(title: "Done") {
                            showCustomDialog = false
                        }
                    )
                }

                // Medium size dialog
                .elevateDialog(
                    isPresented: $showMediumDialog,
                    detents: [.medium]
                ) {
                    ElevateDialog(
                        title: "Medium Dialog",
                        content: {
                            Text("This dialog is presented at medium height and can be dragged to resize.")
                        },
                        primaryAction: DialogAction(title: "Close") {
                            showMediumDialog = false
                        }
                    )
                }

                // Alert style
                .elevateAlert(
                    isPresented: $showAlert,
                    title: "Confirm Action",
                    message: "Are you sure you want to proceed?",
                    primaryAction: DialogAction(title: "Confirm") {
                        showAlert = false
                    },
                    secondaryAction: DialogAction(title: "Cancel") {
                        showAlert = false
                    }
                )
            }
        }
    }
}
#endif

#endif
