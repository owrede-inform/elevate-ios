# TabGroup Component - iOS Adaptations

## ELEVATE Web Pattern
Container for tab panels

## iOS Adaptation
- ✅ TabView wrapper for iOS
- ✅ Swipe gesture navigation
- ✅ Page indicator dots
- ✅ Lazy loading of tab content
- ✅ Programmatic tab selection
- ✅ Customizable tab bar positioning

## Reasoning
TabView provides native iOS tab behavior with swipe gestures.

## Implementation Notes
Uses TabGroupComponentTokens
TabView with selection binding
Swipe enabled by default
.tabViewStyle() for appearance
Lazy loading with .tag()

## Code Example
```swift
@State private var selected = 0

TabView(selection: $selected) {
    ForEach(tabs) { tab in
        TabContent(tab)
            .tag(tab.id)
    }
}
```

## Related Components
TabBar, TabView, Pager
