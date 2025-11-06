#if os(iOS)
import SwiftUI

/// Scrollbar component and scroll indicators
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's custom scrollbars, iOS uses:
/// - **System scrollbars**: Native iOS scroll indicators (automatic)
/// - **No custom styling**: iOS HIG discourages custom scrollbar appearance
/// - **Temporary visibility**: Scrollbars appear during scroll, fade after
/// - **ScrollView modifiers**: Control indicator visibility
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// ScrollView {
///     Content()
/// }
/// .elevateScrollIndicators(.visible) // Show indicators
/// ```
@available(iOS 15, *)
public struct ElevateScrollbar {

    // This is a namespace struct for scroll-related utilities
    private init() {}

    /// Scroll indicator visibility options
    public enum IndicatorVisibility {
        case automatic
        case visible
        case hidden
    }
}

// MARK: - View Extensions

@available(iOS 15, *)
extension View {
    /// Configure scroll indicators with ELEVATE styling
    ///
    /// **iOS Adaptation**: Uses native iOS scroll indicators.
    /// Custom scrollbar styling is not recommended on iOS per HIG.
    ///
    /// Example:
    /// ```swift
    /// ScrollView {
    ///     Content()
    /// }
    /// .elevateScrollIndicators(.visible)
    /// ```
    public func elevateScrollIndicators(_ visibility: ElevateScrollbar.IndicatorVisibility) -> some View {
        switch visibility {
        case .automatic:
            return self.scrollIndicators(.automatic)
        case .visible:
            return self.scrollIndicators(.visible)
        case .hidden:
            return self.scrollIndicators(.hidden)
        }
    }

    /// Add a custom scroll position indicator
    ///
    /// **iOS Adaptation**: Custom visual indicator for scroll position.
    /// This is supplemental to system scrollbars, not a replacement.
    @available(iOS 17, *)
    public func elevateScrollPosition<ID: Hashable>(
        _ id: Binding<ID?>,
        anchor: UnitPoint = .center
    ) -> some View {
        self.scrollPosition(id: id, anchor: anchor)
    }
}

// MARK: - Custom Scroll Indicator (Optional)

/// Custom scroll position indicator overlay
///
/// **iOS Adaptation**: Visual indicator for scroll position in long lists.
/// Use sparingly - iOS users expect system scrollbars.
@available(iOS 15, *)
public struct ElevateScrollPositionIndicator: View {

    @Binding var scrollPosition: CGFloat
    private let totalHeight: CGFloat

    public init(
        scrollPosition: Binding<CGFloat>,
        totalHeight: CGFloat
    ) {
        self._scrollPosition = scrollPosition
        self.totalHeight = totalHeight
    }

    public var body: some View {
        VStack {
            Spacer()

            HStack {
                Spacer()

                // Custom indicator
                RoundedRectangle(cornerRadius: 2)
                    .fill(ScrollbarComponentTokens.thumb_color)
                    .frame(width: 4, height: 40)
                    .opacity(0.6)
                    .padding(.trailing, 4)
                    .offset(y: indicatorOffset)
            }

            Spacer()
        }
        .allowsHitTesting(false) // Don't intercept touches
    }

    private var indicatorOffset: CGFloat {
        let normalizedPosition = scrollPosition / max(totalHeight, 1)
        return normalizedPosition * (totalHeight - 40)
    }
}

// MARK: - Scroll-to-Top Button

/// Scroll-to-top button (iOS pattern for long scrolls)
///
/// **iOS Adaptation**: Floating button to scroll to top.
/// Common iOS pattern for long content.
@available(iOS 15, *)
public struct ElevateScrollToTopButton: View {

    private let action: () -> Void

    public init(action: @escaping () -> Void) {
        self.action = action
    }

    public var body: some View {
        Button {
            performHaptic()
            withAnimation {
                action()
            }
        } label: {
            Image(systemName: "arrow.up.circle.fill")
                .font(.system(size: 44))
                .foregroundColor(.blue)
                .shadow(radius: 4)
        }
        .buttonStyle(.plain)
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 17, *)
struct ElevateScrollbar_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            // Automatic indicators (default)
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<50) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .elevateScrollIndicators(.automatic)
            .navigationTitle("Automatic")
            .tabItem {
                Label("Auto", systemImage: "1.circle")
            }

            // Always visible indicators
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<50) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.1))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .elevateScrollIndicators(.visible)
            .navigationTitle("Visible")
            .tabItem {
                Label("Visible", systemImage: "2.circle")
            }

            // Hidden indicators with scroll-to-top
            ScrollToTopExample()
                .tabItem {
                    Label("Scroll to Top", systemImage: "3.circle")
                }

            // Info tab
            InfoView()
                .tabItem {
                    Label("Info", systemImage: "info.circle")
                }
        }
    }

    struct ScrollToTopExample: View {
        @State private var scrollPosition: CGFloat = 0

        var body: some View {
            NavigationView {
                ZStack(alignment: .bottomTrailing) {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(spacing: 20) {
                                ForEach(0..<100) { index in
                                    Text("Item \(index)")
                                        .id(index)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.orange.opacity(0.1))
                                        .cornerRadius(8)
                                }
                            }
                            .padding()
                        }
                        .overlay(alignment: .bottomTrailing) {
                            if scrollPosition > 200 {
                                ElevateScrollToTopButton {
                                    proxy.scrollTo(0, anchor: .top)
                                }
                                .padding()
                                .transition(.scale.combined(with: .opacity))
                            }
                        }
                    }
                }
                .navigationTitle("Scroll to Top")
            }
        }
    }

    struct InfoView: View {
        var body: some View {
            NavigationView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("iOS Scroll Adaptations")
                        .font(.title)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("✓ System scrollbars (automatic)")
                            .font(.caption)

                        Text("✓ Temporary visibility during scroll")
                            .font(.caption)

                        Text("✓ No custom scrollbar styling (iOS HIG)")
                            .font(.caption)

                        Text("✓ Scroll-to-top button for long content")
                            .font(.caption)

                        Text("✓ Native scroll indicators preferred")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                    Spacer()

                    Text("Note: iOS automatically manages scrollbar appearance. Custom scrollbars are discouraged per Apple's Human Interface Guidelines.")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding()
                }
                .padding()
                .navigationTitle("Info")
            }
        }
    }
}
#endif

#endif
