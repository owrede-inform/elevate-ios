#if os(iOS)
import SwiftUI

/// ELEVATE Notification Component (iOS-Native Banner)
///
/// Displays important messages as iOS-native notification banners that slide from the top.
/// Supports auto-dismiss, custom icons, swipe-to-dismiss, and haptic feedback.
///
/// **iOS Adaptation:** Uses native banner presentation instead of web-style in-page notifications.
/// Inspired by NotificationBanner library with SwiftUI-native implementation.
///
/// **Web Component:** `<elvt-notification>`
/// **API Reference:** `.claude/components/Feedback/notification.md`
///
/// ## Usage
///
/// To enable notification banners, add `.notificationBannerOverlay()` to your app's root view:
///
/// ```swift
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///                 .notificationBannerOverlay()  // Enable notification banners
///         }
///     }
/// }
/// ```
///
/// Then show notifications using `ElevateNotification.show()`:
///
/// ```swift
/// ElevateNotification.show(
///     message: "Operation completed successfully",
///     tone: .success,
///     duration: 5.0
/// )
/// ```
///
@available(iOS 15, *)
public struct ElevateNotification {

    // MARK: - Static Methods

    /// Show a notification banner
    /// - Parameters:
    ///   - message: The notification message text
    ///   - tone: Color scheme (default: .primary)
    ///   - customIcon: Optional SF Symbol name (default: nil uses tone-based icon)
    ///   - duration: Auto-dismiss duration in seconds (default: 5.0)
    ///   - onClose: Action when notification is closed (default: nil)
    public static func show(
        message: String,
        tone: NotificationTone = .primary,
        customIcon: String? = nil,
        duration: TimeInterval = 5.0,
        onClose: (() -> Void)? = nil
    ) {
        NotificationBannerManager.shared.show(
            message: message,
            tone: tone,
            customIcon: customIcon,
            duration: duration,
            onClose: onClose
        )
    }

    /// Dismiss the current notification banner
    public static func dismiss() {
        NotificationBannerManager.shared.dismiss()
    }

    // MARK: - Convenience Methods

    /// Show success notification
    public static func success(_ message: String, duration: TimeInterval = 5.0) {
        show(message: message, tone: .success, duration: duration)
    }

    /// Show warning notification
    public static func warning(_ message: String, duration: TimeInterval = 5.0) {
        show(message: message, tone: .warning, duration: duration)
    }

    /// Show danger notification
    public static func danger(_ message: String, duration: TimeInterval = 5.0) {
        show(message: message, tone: .danger, duration: duration)
    }

    /// Show info notification
    public static func info(_ message: String, duration: TimeInterval = 5.0) {
        show(message: message, tone: .primary, duration: duration)
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
        PreviewContainer()
            .notificationBannerOverlay()
    }

    struct PreviewContainer: View {
        var body: some View {
            ScrollView {
                VStack(spacing: 20) {
                    Text("ELEVATE Notification Banners")
                        .font(.title)
                        .padding(.top, 40)

                    // Basic Notifications
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Basic Notifications").font(.headline)

                        Button("Show Primary") {
                            ElevateNotification.show(
                                message: "This is a primary notification",
                                tone: .primary
                            )
                        }

                        Button("Show Success") {
                            ElevateNotification.success("Operation completed successfully")
                        }

                        Button("Show Warning") {
                            ElevateNotification.warning("Please review this warning")
                        }

                        Button("Show Danger") {
                            ElevateNotification.danger("An error occurred")
                        }

                        Button("Show Neutral") {
                            ElevateNotification.show(
                                message: "Informational message",
                                tone: .neutral
                            )
                        }
                    }
                    .padding()

                    Divider()

                    // Custom Durations
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Custom Durations").font(.headline)

                        Button("Quick (2s)") {
                            ElevateNotification.show(
                                message: "Quick notification",
                                tone: .primary,
                                duration: 2.0
                            )
                        }

                        Button("Long (10s)") {
                            ElevateNotification.show(
                                message: "Long notification",
                                tone: .primary,
                                duration: 10.0
                            )
                        }
                    }
                    .padding()

                    Divider()

                    // Custom Icons
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Custom Icons").font(.headline)

                        Button("Download Complete") {
                            ElevateNotification.show(
                                message: "Download complete",
                                tone: .success,
                                customIcon: "arrow.down.circle.fill"
                            )
                        }

                        Button("New Message") {
                            ElevateNotification.show(
                                message: "New message received",
                                tone: .primary,
                                customIcon: "envelope.fill"
                            )
                        }

                        Button("Connection Lost") {
                            ElevateNotification.show(
                                message: "Connection lost",
                                tone: .danger,
                                customIcon: "wifi.slash"
                            )
                        }
                    }
                    .padding()

                    Divider()

                    // Common Use Cases
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Common Use Cases").font(.headline)

                        Button("Save Success") {
                            ElevateNotification.show(
                                message: "Your changes have been saved successfully.",
                                tone: .success,
                                customIcon: "checkmark.circle.fill"
                            )
                        }

                        Button("Upload Error") {
                            ElevateNotification.show(
                                message: "Failed to upload file. Please check your connection and try again.",
                                tone: .danger
                            )
                        }

                        Button("Session Warning") {
                            ElevateNotification.show(
                                message: "Your session will expire in 5 minutes. Please save your work.",
                                tone: .warning
                            )
                        }

                        Button("Update Available") {
                            ElevateNotification.show(
                                message: "A new version of the app is available. Update now to get the latest features.",
                                tone: .primary,
                                customIcon: "arrow.up.circle.fill"
                            )
                        }
                    }
                    .padding()

                    Spacer(minLength: 50)
                }
            }
        }
    }
}
#endif

#endif
