#if os(iOS)
import SwiftUI
import Combine

/// iOS-Native Notification Banner Manager
///
/// Singleton that manages the presentation of notification banners.
/// Inspired by NotificationBanner library but simplified for SwiftUI.
@available(iOS 15, *)
public class NotificationBannerManager: ObservableObject {

    // MARK: - Singleton

    public static let shared = NotificationBannerManager()

    // MARK: - Published Properties

    @Published public var currentBanner: NotificationBannerItem?
    @Published public var isPresented: Bool = false

    // MARK: - Private Properties

    private var dismissTimer: Timer?

    // MARK: - Initializer

    private init() {}

    // MARK: - Public Methods

    /// Show a notification banner
    /// - Parameters:
    ///   - message: The notification message
    ///   - tone: Color scheme
    ///   - customIcon: Optional SF Symbol name
    ///   - duration: Auto-dismiss duration (default: 5.0 seconds)
    ///   - onClose: Closure called when banner is dismissed
    public func show(
        message: String,
        tone: NotificationTone = .primary,
        customIcon: String? = nil,
        duration: TimeInterval = 5.0,
        onClose: (() -> Void)? = nil
    ) {
        // Cancel existing timer
        dismissTimer?.invalidate()
        dismissTimer = nil

        // Create new banner item
        let banner = NotificationBannerItem(
            id: UUID(),
            message: message,
            tone: tone,
            customIcon: customIcon,
            duration: duration,
            onClose: onClose
        )

        // If already presented, replace immediately without animation conflict
        if isPresented {
            // Replace banner content immediately
            currentBanner = banner

            // Reset timer
            if duration > 0 {
                dismissTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
                    self?.dismiss()
                }
            }

            // Trigger haptic
            performHaptic(for: tone)
        } else {
            // Present banner with animation
            currentBanner = banner

            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                isPresented = true
            }

            // Trigger haptic feedback
            performHaptic(for: tone)

            // Schedule auto-dismiss
            if duration > 0 {
                dismissTimer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
                    self?.dismiss()
                }
            }
        }
    }

    /// Dismiss the current banner
    public func dismiss() {
        dismissTimer?.invalidate()
        dismissTimer = nil

        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            isPresented = false
        }

        // Call onClose callback
        currentBanner?.onClose?()

        // Clear banner after animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            self?.currentBanner = nil
        }
    }

    // MARK: - Private Methods

    /// Perform haptic feedback based on tone
    private func performHaptic(for tone: NotificationTone) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
}

// MARK: - NotificationBannerItem

/// Data model for a notification banner
@available(iOS 15, *)
public struct NotificationBannerItem: Identifiable {
    public let id: UUID
    public let message: String
    public let tone: NotificationTone
    public let customIcon: String?
    public let duration: TimeInterval
    public let onClose: (() -> Void)?

    /// Get the icon name (custom or tone-based)
    public var iconName: String {
        if let customIcon = customIcon {
            return customIcon
        }

        switch tone {
        case .primary: return "info.circle.fill"
        case .success: return "checkmark.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .danger: return "exclamationmark.octagon.fill"
        case .neutral: return "gear"
        }
    }
}

#endif
