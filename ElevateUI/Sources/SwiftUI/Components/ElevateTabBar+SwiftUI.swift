#if os(iOS)
import SwiftUI

/// ELEVATE Tab Bar Component for SwiftUI
///
/// A horizontal tab bar for top-level navigation.
/// iOS adaptation of the web tab component - similar to a segmented control
/// but with individual tab items that can be disabled or closed.
///
/// # Usage
/// ```swift
/// @State private var selectedTab = 0
///
/// ElevateTabBar(selection: $selectedTab) {
///     ElevateTab("Home", index: 0)
///     ElevateTab("Profile", index: 1)
///     ElevateTab("Settings", index: 2)
/// }
/// ```
///
/// # iOS Adaptations
/// - Horizontal scrolling for many tabs
/// - Scroll-friendly tap gestures
/// - No hover states (iOS pattern)
/// - Optional close buttons for tabs
/// - VoiceOver support
///
/// # Design Tokens
/// Uses ELEVATE tab component tokens.
@available(iOS 15, *)
public struct ElevateTabBar<Content: View>: View {

    // MARK: - Properties

    @Binding private var selection: Int
    private let size: TabTokens.Size
    private let content: Content

    // MARK: - Computed Properties

    private var sizeConfig: TabTokens.SizeConfig {
        size.config
    }

    // MARK: - Initializer

    /// Creates a tab bar with custom content
    /// - Parameters:
    ///   - selection: Binding to the selected tab index
    ///   - size: The size variant
    ///   - content: The tab items
    public init(
        selection: Binding<Int>,
        size: TabTokens.Size = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self._selection = selection
        self.size = size
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                content
            }
        }
        .frame(height: sizeConfig.height)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Tab bar")
    }
}

/// ELEVATE Tab Item Component
///
/// Individual tab within an ElevateTabBar.
@available(iOS 15, *)
public struct ElevateTab: View {

    // MARK: - Properties

    private let label: String
    private let index: Int
    @Binding private var selection: Int
    private let size: TabTokens.Size
    private let isDisabled: Bool
    private let isCloseable: Bool
    private let onClose: (() -> Void)?

    @State private var isPressed = false

    // MARK: - Computed Properties

    private var sizeConfig: TabTokens.SizeConfig {
        size.config
    }

    private var isSelected: Bool {
        selection == index
    }

    private var textColor: Color {
        TabTokens.textColor(isSelected: isSelected, isDisabled: isDisabled)
    }

    private var underlineColor: Color {
        isSelected ? TabTokens.textSelected : Color.clear
    }

    // MARK: - Initializer

    /// Creates a tab item
    /// - Parameters:
    ///   - label: The tab label
    ///   - index: The tab index
    ///   - selection: Binding to the selected tab index
    ///   - size: The size variant
    ///   - isDisabled: Whether the tab is disabled
    ///   - isCloseable: Whether the tab can be closed
    ///   - onClose: Closure called when close button is tapped
    public init(
        _ label: String,
        index: Int,
        selection: Binding<Int>,
        size: TabTokens.Size = .medium,
        isDisabled: Bool = false,
        isCloseable: Bool = false,
        onClose: (() -> Void)? = nil
    ) {
        self.label = label
        self.index = index
        self._selection = selection
        self.size = size
        self.isDisabled = isDisabled
        self.isCloseable = isCloseable
        self.onClose = onClose
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: sizeConfig.gap) {
                Text(label)
                    .font(Font.custom(ElevateTypographyiOS.fontFamilyPrimary, size: sizeConfig.fontSize).weight(isSelected ? .semibold : .regular))
                    .foregroundColor(textColor)
                    .lineLimit(1)

                if isCloseable, let onClose = onClose {
                    Image(systemName: "xmark")
                        .font(.system(size: sizeConfig.closeIconSize))
                        .foregroundColor(TabTokens.closeIconColor(isDisabled: isDisabled))
                        .scrollFriendlyTap {
                            if !isDisabled {
                                onClose()
                            }
                        }
                }
            }
            .padding(.horizontal, sizeConfig.horizontalPadding)
            .frame(height: sizeConfig.height)
            .frame(minWidth: sizeConfig.minTouchTarget)
            .contentShape(Rectangle())
            .opacity(isPressed && !isDisabled ? 0.7 : 1.0)
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
                        selection = index
                        // Haptic feedback
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                    }
                }
            )

            // Selection indicator
            Rectangle()
                .fill(underlineColor)
                .frame(height: 2)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
        .accessibilityHint(isSelected ? "Selected" : "Double tap to select")
    }
}

// MARK: - Convenience Initializer (Array-based)

@available(iOS 15, *)
extension ElevateTabBar where Content == AnyView {

    /// Creates a tab bar from an array of tab labels
    /// - Parameters:
    ///   - selection: Binding to the selected tab index
    ///   - tabs: Array of tab labels
    ///   - size: The size variant
    public init(
        selection: Binding<Int>,
        tabs: [String],
        size: TabTokens.Size = .medium
    ) {
        self._selection = selection
        self.size = size

        self.content = AnyView(
            ForEach(Array(tabs.enumerated()), id: \.offset) { index, label in
                ElevateTab(label, index: index, selection: selection, size: size)
            }
        )
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateTabBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic Tabs
            PreviewWrapper_Basic()
                .previewDisplayName("Basic Tabs")

            // Sizes
            PreviewWrapper_Sizes()
                .previewDisplayName("Sizes")

            // Closeable Tabs
            PreviewWrapper_Closeable()
                .previewDisplayName("Closeable Tabs")

            // Many Tabs (Scrollable)
            PreviewWrapper_ManyTabs()
                .previewDisplayName("Many Tabs")

            // Dark Mode
            PreviewWrapper_Basic()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }

    struct PreviewWrapper_Basic: View {
        @State private var selectedTab = 0

        var body: some View {
            VStack(spacing: 0) {
                ElevateTabBar(selection: $selectedTab, tabs: ["Home", "Profile", "Settings"])

                TabView(selection: $selectedTab) {
                    Text("Home Content")
                        .tag(0)
                    Text("Profile Content")
                        .tag(1)
                    Text("Settings Content")
                        .tag(2)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }

    struct PreviewWrapper_Sizes: View {
        @State private var selectedSmall = 0
        @State private var selectedMedium = 0
        @State private var selectedLarge = 0

        var body: some View {
            VStack(spacing: 24) {
                VStack(alignment: .leading) {
                    Text("Small").font(.caption)
                    ElevateTabBar(selection: $selectedSmall, tabs: ["Tab 1", "Tab 2"], size: .small)
                }

                VStack(alignment: .leading) {
                    Text("Medium").font(.caption)
                    ElevateTabBar(selection: $selectedMedium, tabs: ["Tab 1", "Tab 2"], size: .medium)
                }

                VStack(alignment: .leading) {
                    Text("Large").font(.caption)
                    ElevateTabBar(selection: $selectedLarge, tabs: ["Tab 1", "Tab 2"], size: .large)
                }

                Spacer()
            }
            .padding()
        }
    }

    struct PreviewWrapper_Closeable: View {
        @State private var selectedTab = 0
        @State private var tabs = ["Documents", "Images", "Downloads", "Recent"]

        var body: some View {
            VStack(spacing: 0) {
                ElevateTabBar(selection: $selectedTab) {
                    ForEach(Array(tabs.enumerated()), id: \.offset) { index, label in
                        ElevateTab(
                            label,
                            index: index,
                            selection: $selectedTab,
                            isCloseable: true,
                            onClose: {
                                removeTab(at: index)
                            }
                        )
                    }
                }

                Spacer()

                Text("Tap X to close tabs")
                    .font(.caption)
                    .foregroundColor(ElevateAliases.Content.General.text_muted)
                    .padding()
            }
        }

        private func removeTab(at index: Int) {
            tabs.remove(at: index)
            if selectedTab >= tabs.count {
                selectedTab = max(0, tabs.count - 1)
            }
        }
    }

    struct PreviewWrapper_ManyTabs: View {
        @State private var selectedTab = 0

        var body: some View {
            VStack(spacing: 0) {
                ElevateTabBar(
                    selection: $selectedTab,
                    tabs: ["All", "Work", "Personal", "Archive", "Starred", "Trash", "Spam", "Drafts"]
                )

                Spacer()

                Text("Selected: Tab \(selectedTab + 1)")
                    .font(.caption)
            }
        }
    }
}
#endif

#endif
