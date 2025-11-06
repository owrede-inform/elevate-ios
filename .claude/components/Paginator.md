# Paginator Component - iOS Adaptations

## ELEVATE Web Pattern
Page navigation with prev/next buttons

## iOS Adaptation
- ✅ Native page controls for iOS
- ✅ Swipe gestures for navigation
- ✅ Dot indicators for current page
- ✅ Numbered pagination option
- ✅ Infinite scroll support
- ✅ Pull-to-refresh integration

## Reasoning
iOS pagination often uses PageTabViewStyle or custom ScrollView. Swipe is primary interaction.

## Implementation Notes
Uses PaginatorComponentTokens
PageTabViewStyle for tabs
ScrollView + offset for custom
Dot indicators for page count
Binding for current page

## Code Example
```swift
@State private var currentPage = 0

TabView(selection: $currentPage) {
    ForEach(0..<pages.count) { index in
        PageView(page: pages[index])
            .tag(index)
    }
}
.tabViewStyle(.page)
```

## Related Components
Carousel, TabView, ScrollView
