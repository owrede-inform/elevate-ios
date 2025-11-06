#if os(iOS)
import SwiftUI

/// ELEVATE Notification Component
///
/// Displays important messages inline or as toast notifications.
/// Supports auto-dismiss, custom icons, and close actions.
///
/// **Web Component:** `<elvt-notification>`
/// **API Reference:** `.claude/components/Feedback/notification.md`
@available(iOS 15, *)
public struct ElevateNotification: View {

    // MARK: - Properties

    /// Binding to control whether the notification is shown
    @Binding private var isOpen: Bool

    /// The notification message
    private let message: String

    /// The tone (color scheme) of the notification
    private let tone: NotificationTone

    /// Whether the notification can be closed
    private let closable: Bool

    /// Optional custom icon (SF Symbol name)
    private let customIcon: String?

    /// Optional duration for auto-dismiss (in seconds)
    private let duration: TimeInterval?

    /// Action called when notification is closed
    private let onClose: (() -> Void)?

    // MARK: - State

    @State private var countdown: Double = 1.0
    @State private var timer: Timer?

    // MARK: - Initializer

    /// Creates a notification
    ///
    /// - Parameters:
    ///   - isOpen: Binding to control visibility
    ///   - message: The notification message text
    ///   - tone: Color scheme (default: .primary)
    ///   - closable: Whether to show close button (default: true)
    ///   - customIcon: Optional SF Symbol name (default: nil uses tone-based icon)
    ///   - duration: Auto-dismiss duration in seconds (default: nil for no auto-dismiss)
    ///   - onClose: Action when notification is closed (default: nil)
    public init(
        isOpen: Binding<Bool>,
        message: String,
        tone: NotificationTone = .primary,
        closable: Bool = true,
        customIcon: String? = nil,
        duration: TimeInterval? = nil,
        onClose: (() -> Void)? = nil
    ) {
        self._isOpen = isOpen
        self.message = message
        self.tone = tone
        self.closable = closable
        self.customIcon = customIcon
        self.duration = duration
        self.onClose = onClose
    }

    // MARK: - Body

    public var body: some View {
        if isOpen {
            VStack(spacing: 0) {
                HStack(alignment: .top, spacing: NotificationComponentTokens.gap) {
                    // Icon
                    Image(systemName: iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: tokenIconSize, height: tokenIconSize)
                        .foregroundColor(tokenIconColor)

                    // Content
                    VStack(alignment: .leading, spacing: NotificationComponentTokens.text_gap) {
                        Text(message)
                            .font(ElevateTypography.bodyMedium)
                            .foregroundColor(tokenTextColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    // Close button
                    if closable {
                        Button(action: {
                            closeNotification()
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(NotificationComponentTokens.icon_color_closable)
                        }
                        .accessibilityLabel("Close notification")
                    }
                }
                .padding(tokenPadding)

                // Progress bar (countdown)
                if let duration = duration, countdown > 0 {
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(tokenIconColor)
                            .frame(width: geometry.size.width * countdown, height: tokenProgressHeight)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: tokenProgressHeight)
                }
            }
            .frame(minWidth: tokenMinWidth)
            .background(tokenBackgroundColor)
            .overlay(
                VStack {
                    Rectangle()
                        .fill(tokenBorderColor)
                        .frame(height: tokenTopBorderWidth)
                    Spacer()
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: tokenBorderRadius)
                    .strokeBorder(tokenBorderColor, lineWidth: tokenBorderWidth)
            )
            .clipShape(RoundedRectangle(cornerRadius: tokenBorderRadius))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
            .transition(.opacity.combined(with: .scale(scale: 0.95)))
            .accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isAlert)
            .onAppear {
                startCountdown()
            }
            .onDisappear {
                stopCountdown()
            }
        }
    }

    // MARK: - Helpers

    private var iconName: String {
        if let customIcon = customIcon {
            return customIcon
        }

        switch tone {
        case .primary: return "info.circle"
        case .success: return "checkmark.circle"
        case .warning: return "exclamationmark.triangle"
        case .danger: return "exclamationmark.octagon"
        case .neutral: return "gear"
        }
    }

    private func closeNotification() {
        withAnimation {
            isOpen = false
        }
        onClose?()
        stopCountdown()
    }

    private func startCountdown() {
        guard let duration = duration, duration > 0 else { return }

        countdown = 1.0
        let interval = 0.1 // Update every 100ms

        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            countdown -= interval / duration

            if countdown <= 0 {
                closeNotification()
            }
        }
    }

    private func stopCountdown() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Token Accessors

    private var tokenIconSize: CGFloat {
        NotificationComponentTokens.icon_size
    }

    private var tokenPadding: CGFloat {
        NotificationComponentTokens.padding_inline
    }

    private var tokenBorderRadius: CGFloat {
        NotificationComponentTokens.border_radius
    }

    private var tokenBorderWidth: CGFloat {
        NotificationComponentTokens.border_width
    }

    private var tokenTopBorderWidth: CGFloat {
        NotificationComponentTokens.border_width_top
    }

    private var tokenMinWidth: CGFloat {
        NotificationComponentTokens.width_min
    }

    private var tokenProgressHeight: CGFloat {
        NotificationComponentTokens.progress_height
    }

    private var tokenBackgroundColor: Color {
        switch tone {
        case .primary: return NotificationComponentTokens.fill_primary
        case .success: return NotificationComponentTokens.fill_success
        case .warning: return NotificationComponentTokens.fill_warning
        case .danger: return NotificationComponentTokens.fill_danger
        case .neutral: return NotificationComponentTokens.fill_neutral
        }
    }

    private var tokenBorderColor: Color {
        switch tone {
        case .primary: return NotificationComponentTokens.border_color_primary
        case .success: return NotificationComponentTokens.border_color_success
        case .warning: return NotificationComponentTokens.border_color_warning
        case .danger: return NotificationComponentTokens.border_color_danger
        case .neutral: return NotificationComponentTokens.border_color_neutral
        }
    }

    private var tokenIconColor: Color {
        switch tone {
        case .primary: return NotificationComponentTokens.icon_color_primary
        case .success: return NotificationComponentTokens.icon_color_success
        case .warning: return NotificationComponentTokens.icon_color_warning
        case .danger: return NotificationComponentTokens.icon_color_danger
        case .neutral: return NotificationComponentTokens.icon_color_neutral
        }
    }

    private var tokenTextColor: Color {
        NotificationComponentTokens.text_color
    }
}

// MARK: - Notification Tone

@available(iOS 15, *)
public enum NotificationTone {
    case primary
    case success
    case warning
    case danger
    case neutral
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateNotification_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Notifications
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Notifications").font(.headline)

                    VStack(spacing: 12) {
                        PreviewNotification(
                            message: "This is a primary notification",
                            tone: .primary
                        )

                        PreviewNotification(
                            message: "Operation completed successfully",
                            tone: .success
                        )

                        PreviewNotification(
                            message: "Please review this warning",
                            tone: .warning
                        )

                        PreviewNotification(
                            message: "An error occurred",
                            tone: .danger
                        )

                        PreviewNotification(
                            message: "Informational message",
                            tone: .neutral
                        )
                    }
                }

                Divider()

                // Non-closable
                VStack(alignment: .leading, spacing: 16) {
                    Text("Non-closable Notifications").font(.headline)

                    VStack(spacing: 12) {
                        PreviewNotification(
                            message: "This notification cannot be dismissed",
                            tone: .primary,
                            closable: false
                        )
                    }
                }

                Divider()

                // Auto-dismiss
                VStack(alignment: .leading, spacing: 16) {
                    Text("Auto-dismiss Notifications").font(.headline)

                    VStack(spacing: 12) {
                        PreviewNotification(
                            message: "This notification will auto-dismiss in 5 seconds",
                            tone: .success,
                            duration: 5.0
                        )

                        PreviewNotification(
                            message: "Quick notification (3 seconds)",
                            tone: .primary,
                            duration: 3.0
                        )
                    }
                }

                Divider()

                // Custom Icons
                VStack(alignment: .leading, spacing: 16) {
                    Text("Custom Icons").font(.headline)

                    VStack(spacing: 12) {
                        PreviewNotification(
                            message: "Download complete",
                            tone: .success,
                            customIcon: "arrow.down.circle.fill"
                        )

                        PreviewNotification(
                            message: "New message received",
                            tone: .primary,
                            customIcon: "envelope.fill"
                        )

                        PreviewNotification(
                            message: "Connection lost",
                            tone: .danger,
                            customIcon: "wifi.slash"
                        )
                    }
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Use Cases").font(.headline)

                    VStack(spacing: 12) {
                        // Success message
                        PreviewNotification(
                            message: "Your changes have been saved successfully.",
                            tone: .success,
                            customIcon: "checkmark.circle.fill"
                        )

                        // Error message
                        PreviewNotification(
                            message: "Failed to upload file. Please check your connection and try again.",
                            tone: .danger
                        )

                        // Warning message
                        PreviewNotification(
                            message: "Your session will expire in 5 minutes. Please save your work.",
                            tone: .warning
                        )

                        // Info message
                        PreviewNotification(
                            message: "A new version of the app is available. Update now to get the latest features.",
                            tone: .primary,
                            customIcon: "arrow.up.circle.fill"
                        )
                    }
                }
            }
            .padding()
        }
    }

    struct PreviewNotification: View {
        @State var isOpen: Bool = true
        let message: String
        var tone: NotificationTone = .primary
        var closable: Bool = true
        var customIcon: String? = nil
        var duration: TimeInterval? = nil

        var body: some View {
            VStack {
                ElevateNotification(
                    isOpen: $isOpen,
                    message: message,
                    tone: tone,
                    closable: closable,
                    customIcon: customIcon,
                    duration: duration
                ) {
                    print("Notification closed")
                }

                if !isOpen {
                    Button("Show Again") {
                        isOpen = true
                    }
                    .font(.caption)
                }
            }
        }
    }
}
#endif

#endif
