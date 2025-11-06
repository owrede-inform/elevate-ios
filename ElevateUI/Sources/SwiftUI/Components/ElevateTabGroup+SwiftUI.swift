#if os(iOS)
import SwiftUI

/// Tab group component with iOS-native tab patterns
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's horizontal tab bar, this uses:
/// - **Segmented Control (top)**: For view filtering within a page (Picker with .segmented style)
/// - **TabView (bottom)**: For main app navigation (iOS standard)
/// - Never uses web-style horizontal tabs with underline
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// **Position Guidelines**:
/// - **Top placement**: Use segmented control for filtering/switching views
/// - **Bottom placement**: Use native TabView for main navigation
///
/// Example (Segmented Control):
/// ```swift
/// @State private var selectedTab = 0
///
/// ElevateTabGroup.segmented(
///     selection: $selectedTab,
///     tabs: [
///         TabItem(label: "Overview", icon: "chart.bar"),
///         TabItem(label: "Details", icon: "list.bullet")
///     ]
/// ) { index in
///     if index == 0 {
///         OverviewView()
///     } else {
///         DetailsView()
///     }
/// }
/// ```
///
/// Example (Bottom Navigation):
/// ```swift
/// ElevateTabGroup.navigation(
///     tabs: [
///         TabItem(label: "Home", icon: "house"),
///         TabItem(label: "Search", icon: "magnifyingglass"),
///         TabItem(label: "Profile", icon: "person")
///     ]
/// ) { index in
///     switch index {
///     case 0: HomeView()
///     case 1: SearchView()
///     default: ProfileView()
///     }
/// }
/// ```
@available(iOS 15, *)
public struct ElevateTabGroup {

    // This is a namespace struct - not instantiable
    private init() {}

    // MARK: - Segmented Control (Top Tabs)

    /// Segmented control for view filtering (top placement)
    ///
    /// **iOS Adaptation**: Uses native Picker with .segmented style.
    /// This is the iOS pattern for switching views within a page.
    public static func segmented<Content: View>(
        selection: Binding<Int>,
        tabs: [TabItem],
        @ViewBuilder content: @escaping (Int) -> Content
    ) -> some View {
        SegmentedTabGroup(selection: selection, tabs: tabs, content: content)
    }

    // MARK: - Bottom Navigation (TabView)

    /// Bottom navigation with TabView (iOS standard)
    ///
    /// **iOS Adaptation**: Uses native TabView for main app navigation.
    /// This is the recommended iOS pattern for bottom navigation.
    public static func navigation<Content: View>(
        tabs: [TabItem],
        @ViewBuilder content: @escaping (Int) -> Content
    ) -> some View {
        NavigationTabGroup(tabs: tabs, content: content)
    }
}

// MARK: - Tab Item

/// Represents a single tab item
@available(iOS 15, *)
public struct TabItem: Identifiable {
    public let id = UUID()
    public let label: String
    public let icon: String?
    public let badge: String?

    public init(label: String, icon: String? = nil, badge: String? = nil) {
        self.label = label
        self.icon = icon
        self.badge = badge
    }
}

// MARK: - Segmented Tab Group (Top)

@available(iOS 15, *)
private struct SegmentedTabGroup<Content: View>: View {
    @Binding var selection: Int
    let tabs: [TabItem]
    let content: (Int) -> Content

    var body: some View {
        VStack(spacing: 0) {
            // Segmented control at top
            Picker("", selection: $selection) {
                ForEach(tabs.indices, id: \.self) { index in
                    if let icon = tabs[index].icon {
                        Label(tabs[index].label, systemImage: icon)
                            .tag(index)
                    } else {
                        Text(tabs[index].label)
                            .tag(index)
                    }
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, TabGroupComponentTokens.tabPanel_onStart_padding_inline)
            .padding(.vertical, 12)

            // Divider
            Rectangle()
                .fill(TabGroupComponentTokens.track_color)
                .frame(height: TabGroupComponentTokens.track_width)

            // Content area
            content(selection)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onChange(of: selection) { _ in
            performHaptic()
        }
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Navigation Tab Group (Bottom)

@available(iOS 15, *)
private struct NavigationTabGroup<Content: View>: View {
    @State private var selection = 0
    let tabs: [TabItem]
    let content: (Int) -> Content

    var body: some View {
        TabView(selection: $selection) {
            ForEach(tabs.indices, id: \.self) { index in
                content(index)
                    .tabItem {
                        if let icon = tabs[index].icon {
                            Label(tabs[index].label, systemImage: icon)
                        } else {
                            Text(tabs[index].label)
                        }
                    }
                    .badge(tabs[index].badge)
                    .tag(index)
            }
        }
        .onChange(of: selection) { _ in
            performHaptic()
        }
    }

    private func performHaptic() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

// MARK: - Custom Tab Bar (Web-Style Alternative)

/// Custom tab bar with web-style appearance
///
/// **iOS Adaptation Note**: This provides a web-like tab bar but is NOT
/// recommended for iOS. Use `ElevateTabGroup.segmented()` or
/// `ElevateTabGroup.navigation()` for native iOS patterns.
///
/// Only use this if you specifically need web-style tabs with underline indicator.
@available(iOS 15, *)
public struct ElevateCustomTabBar<Content: View>: View {
    @Binding var selection: Int
    let tabs: [TabItem]
    let content: (Int) -> Content

    public init(
        selection: Binding<Int>,
        tabs: [TabItem],
        @ViewBuilder content: @escaping (Int) -> Content
    ) {
        self._selection = selection
        self.tabs = tabs
        self.content = content
    }

    public var body: some View {
        VStack(spacing: 0) {
            // Custom tab bar
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: TabComponentTokens.gap) {
                    ForEach(tabs.indices, id: \.self) { index in
                        TabButton(
                            item: tabs[index],
                            isSelected: selection == index
                        ) {
                            performHaptic()
                            selection = index
                        }
                    }
                }
                .padding(.horizontal, TabComponentTokens.padding_inline)
            }
            .frame(height: TabComponentTokens.height)

            // Divider
            Rectangle()
                .fill(TabGroupComponentTokens.track_color)
                .frame(height: 1)

            // Content
            content(selection)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Tab Button (Custom Style)

@available(iOS 15, *)
private struct TabButton: View {
    let item: TabItem
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                HStack(spacing: 8) {
                    if let icon = item.icon {
                        Image(systemName: icon)
                            .font(.system(size: 16))
                    }

                    Text(item.label)
                        .font(.subheadline)

                    if let badge = item.badge {
                        Text(badge)
                            .font(.caption2)
                            .foregroundColor(.white)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                .foregroundColor(textColor)

                // Underline indicator
                Rectangle()
                    .fill(isSelected ? TabGroupComponentTokens.marker_color : Color.clear)
                    .frame(height: TabGroupComponentTokens.marker_width)
            }
        }
        .buttonStyle(.plain)
    }

    private var textColor: Color {
        // NOTE: Removed hover state - no hover on iOS per DIVERSIONS.md
        if isSelected {
            return TabComponentTokens.text_color_selected
        }
        return TabComponentTokens.text_color_default
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateTabGroup_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            SegmentedPreview()
                .tabItem {
                    Label("Segmented", systemImage: "rectangle.split.3x1")
                }

            NavigationPreview()
                .tabItem {
                    Label("Navigation", systemImage: "square.grid.2x2")
                }

            CustomPreview()
                .tabItem {
                    Label("Custom", systemImage: "line.3.horizontal")
                }
        }
    }

    // Segmented control example (top tabs)
    struct SegmentedPreview: View {
        @State private var selectedTab = 0

        var body: some View {
            NavigationView {
                ElevateTabGroup.segmented(
                    selection: $selectedTab,
                    tabs: [
                        TabItem(label: "Overview", icon: "chart.bar"),
                        TabItem(label: "Details", icon: "list.bullet"),
                        TabItem(label: "Settings", icon: "gearshape")
                    ]
                ) { index in
                    contentView(for: index)
                }
                .navigationTitle("Segmented Control")
                .navigationBarTitleDisplayMode(.large)
            }
        }

        func contentView(for index: Int) -> some View {
            VStack {
                Spacer()
                Text("Content for tab \(index)")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }
    }

    // Bottom navigation example
    struct NavigationPreview: View {
        var body: some View {
            ElevateTabGroup.navigation(
                tabs: [
                    TabItem(label: "Home", icon: "house"),
                    TabItem(label: "Search", icon: "magnifyingglass"),
                    TabItem(label: "Notifications", icon: "bell", badge: "3"),
                    TabItem(label: "Profile", icon: "person")
                ]
            ) { index in
                NavigationView {
                    VStack {
                        Spacer()
                        Text("Tab \(index + 1) Content")
                            .font(.title)
                        Spacer()
                    }
                    .navigationTitle(["Home", "Search", "Notifications", "Profile"][index])
                }
            }
        }
    }

    // Custom web-style tabs (not recommended)
    struct CustomPreview: View {
        @State private var selectedTab = 0

        var body: some View {
            NavigationView {
                VStack {
                    ElevateCustomTabBar(
                        selection: $selectedTab,
                        tabs: [
                            TabItem(label: "Tab 1", icon: "1.circle"),
                            TabItem(label: "Tab 2", icon: "2.circle"),
                            TabItem(label: "Tab 3", icon: "3.circle", badge: "New")
                        ]
                    ) { index in
                        VStack {
                            Spacer()
                            Text("Custom tab \(index + 1)")
                                .font(.title2)
                            Spacer()
                        }
                    }

                    Text("⚠️ Not recommended for iOS")
                        .font(.caption)
                        .foregroundColor(.orange)
                        .padding()
                }
                .navigationTitle("Custom (Web-Style)")
            }
        }
    }
}
#endif

#endif
