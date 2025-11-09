#if os(iOS)
import SwiftUI

/// View modifier for app-level notification banner overlay
@available(iOS 15, *)
struct NotificationBannerModifier: ViewModifier {

    @StateObject private var manager = NotificationBannerManager.shared
    @State private var dragOffset: CGFloat = 0

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if manager.isPresented, let banner = manager.currentBanner {
                    NotificationBannerView(item: banner, dragOffset: $dragOffset)
                        .padding(.horizontal, 12)
                        .padding(.top, safeAreaTop + 8)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(999) // Ensure banner appears above all content
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    // Only allow upward drag
                                    if value.translation.height < 0 {
                                        dragOffset = value.translation.height
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.height < -50 {
                                        // Swipe up to dismiss
                                        manager.dismiss()
                                    }
                                    dragOffset = 0
                                }
                        )
                }
            }
    }

    /// Get safe area top inset
    private var safeAreaTop: CGFloat {
        let window = UIApplication.shared.windows.first
        return window?.safeAreaInsets.top ?? 0
    }
}

/// The actual banner view with iOS-standard styling
@available(iOS 15, *)
private struct NotificationBannerView: View {

    let item: NotificationBannerItem
    @Binding var dragOffset: CGFloat

    @State private var timerProgress: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 0) {
            // Main content
            HStack(alignment: .center, spacing: 14) {
                // Icon
                Image(systemName: item.iconName)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(iconColor)

                // Message
                Text(item.message)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)

                // Close button
                Button(action: {
                    NotificationBannerManager.shared.dismiss()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.secondary.opacity(0.5))
                }
                .accessibilityLabel("Close notification")
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)

            // Timer progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Background track
                    Rectangle()
                        .fill(borderColor.opacity(0.2))
                        .frame(height: 3)

                    // Progress indicator
                    Rectangle()
                        .fill(borderColor)
                        .frame(width: geometry.size.width * timerProgress, height: 3)
                }
            }
            .frame(height: 3)
        }
        .background(
            // iOS-style background with blur
            ZStack {
                backgroundColor
                    .opacity(0.95)

                // Subtle blur effect
                if #available(iOS 15.0, *) {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .opacity(0.3)
                }
            }
        )
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .overlay(
            // Colored left border
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .strokeBorder(borderColor, lineWidth: 3)
                .mask(
                    // Only show left edge
                    HStack(spacing: 0) {
                        Rectangle()
                            .frame(width: 10)
                        Spacer()
                    }
                )
        )
        .overlay(
            // Full border for light mode
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .strokeBorder(borderColor.opacity(0.15), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 4)
        .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
        .offset(y: dragOffset)
        .onAppear {
            startTimer()
        }
        .onTapGesture {
            // Tap to dismiss
            NotificationBannerManager.shared.dismiss()
        }
    }

    // MARK: - Timer Animation

    private func startTimer() {
        guard item.duration > 0 else { return }

        withAnimation(.linear(duration: item.duration)) {
            timerProgress = 0.0
        }
    }

    // MARK: - Token Accessors

    private var backgroundColor: Color {
        switch item.tone {
        case .primary: return NotificationComponentTokens.fill_primary
        case .success: return NotificationComponentTokens.fill_success
        case .warning: return NotificationComponentTokens.fill_warning
        case .danger: return NotificationComponentTokens.fill_danger
        case .neutral: return NotificationComponentTokens.fill_neutral
        }
    }

    private var iconColor: Color {
        switch item.tone {
        case .primary: return NotificationComponentTokens.icon_color_primary
        case .success: return NotificationComponentTokens.icon_color_success
        case .warning: return NotificationComponentTokens.icon_color_warning
        case .danger: return NotificationComponentTokens.icon_color_danger
        case .neutral: return NotificationComponentTokens.icon_color_neutral
        }
    }

    private var borderColor: Color {
        switch item.tone {
        case .primary: return NotificationComponentTokens.border_color_primary
        case .success: return NotificationComponentTokens.border_color_success
        case .warning: return NotificationComponentTokens.border_color_warning
        case .danger: return NotificationComponentTokens.border_color_danger
        case .neutral: return NotificationComponentTokens.border_color_neutral
        }
    }
}

// MARK: - View Extension

@available(iOS 15, *)
public extension View {
    /// Apply notification banner overlay to the root view
    ///
    /// Add this modifier to your app's root view to enable iOS-native notification banners.
    ///
    /// Example:
    /// ```swift
    /// WindowGroup {
    ///     ContentView()
    ///         .notificationBannerOverlay()
    /// }
    /// ```
    func notificationBannerOverlay() -> some View {
        self.modifier(NotificationBannerModifier())
    }
}

#endif
