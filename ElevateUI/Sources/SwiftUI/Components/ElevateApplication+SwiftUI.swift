#if os(iOS)
import SwiftUI

/// Application root container with theme and configuration
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's application wrapper, this provides:
/// - **Theme configuration**: Light/dark mode support
/// - **Safe area management**: Automatic iOS safe areas
/// - **Accessibility settings**: Dynamic Type and VoiceOver support
/// - **Root navigation**: NavigationStack or TabView integration
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// @main
/// struct MyApp: App {
///     var body: some Scene {
///         WindowGroup {
///             ElevateApplication {
///                 ContentView()
///             }
///         }
///     }
/// }
/// ```
@available(iOS 15, *)
public struct ElevateApplication<Content: View>: View {

    private let content: () -> Content
    private let backgroundColor: Color?

    @Environment(\.colorScheme) private var colorScheme

    // MARK: - Initialization

    public init(
        backgroundColor: Color? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        content()
            .background(effectiveBackgroundColor)
            .foregroundColor(ApplicationComponentTokens.text)
            .preferredColorScheme(nil) // Respect system setting
            .dynamicTypeSize(...DynamicTypeSize.xxxLarge) // Support Dynamic Type
    }

    // MARK: - Computed Properties

    private var effectiveBackgroundColor: Color {
        backgroundColor ?? ApplicationComponentTokens.fill
    }
}

// MARK: - Application with Navigation

/// Application wrapper with built-in NavigationStack
///
/// **iOS Adaptation**: Provides standard iOS navigation pattern with swipe-back.
@available(iOS 16, *)
public struct ElevateNavigationApplication<Content: View>: View {

    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        NavigationStack {
            ElevateApplication {
                content()
            }
        }
    }
}

// MARK: - Application with TabView

/// Application wrapper with built-in TabView
///
/// **iOS Adaptation**: Provides standard iOS bottom tab navigation.
@available(iOS 15, *)
public struct ElevateTabApplication: View {

    public struct Tab {
        public let label: String
        public let icon: String
        public let badge: String?
        public let content: AnyView

        public init<Content: View>(
            label: String,
            icon: String,
            badge: String? = nil,
            @ViewBuilder content: () -> Content
        ) {
            self.label = label
            self.icon = icon
            self.badge = badge
            self.content = AnyView(content())
        }
    }

    private let tabs: [Tab]

    public init(tabs: [Tab]) {
        self.tabs = tabs
    }

    public var body: some View {
        TabView {
            ForEach(tabs.indices, id: \.self) { index in
                ElevateApplication {
                    tabs[index].content
                }
                .tabItem {
                    Label(tabs[index].label, systemImage: tabs[index].icon)
                }
                .badge(tabs[index].badge)
            }
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 16, *)
struct ElevateApplication_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic application
            ElevateApplication {
                VStack {
                    Text("Basic Application")
                        .font(.title)
                    Text("Root container with theme support")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .previewDisplayName("Basic")

            // With navigation
            ElevateNavigationApplication {
                List {
                    NavigationLink("Page 1") {
                        Text("Page 1 Content")
                    }
                    NavigationLink("Page 2") {
                        Text("Page 2 Content")
                    }
                }
                .navigationTitle("Navigation App")
            }
            .previewDisplayName("With Navigation")

            // With tabs
            ElevateTabApplication(tabs: [
                .init(label: "Home", icon: "house.fill") {
                    Text("Home Screen")
                },
                .init(label: "Search", icon: "magnifyingglass") {
                    Text("Search Screen")
                },
                .init(label: "Profile", icon: "person.fill", badge: "3") {
                    Text("Profile Screen")
                }
            ])
            .previewDisplayName("With Tabs")

            // Custom background
            ElevateApplication(backgroundColor: Color.blue.opacity(0.1)) {
                VStack {
                    Text("Custom Background")
                        .font(.title)
                    Text("With light blue tint")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .previewDisplayName("Custom Background")
        }
    }
}
#endif

#endif
