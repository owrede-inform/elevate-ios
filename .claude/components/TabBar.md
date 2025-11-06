# TabBar Component - iOS Adaptations

## ELEVATE Web Pattern
Tab navigation bar

## iOS Adaptation
- ✅ Bottom tab bar (iOS standard)
- ✅ Five tab maximum recommended
- ✅ Badge support for notifications
- ✅ SF Symbols for icons
- ✅ Selected state with accent color
- ✅ Haptic feedback on selection
- ✅ More menu for >5 tabs

## Reasoning
iOS tabs are bottom navigation standard. Five tab limit matches system behavior.

## Implementation Notes
Uses TabBarTokens
Bottom positioning
SF Symbols required for icons
Badge values support
More tab for overflow
Selected uses accent color

## Code Example
```swift
TabView {
    HomeView()
        .tabItem {
            Label("Home", systemImage: "house")
        }
    ProfileView()
        .tabItem {
            Label("Profile", systemImage: "person")
        }
}
```

## Related Components
TabView, NavigationItem, TabGroup
