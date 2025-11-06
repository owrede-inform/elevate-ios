# Tab Component - iOS Adaptations

## ELEVATE Web Pattern
Individual tab in tab group

## iOS Adaptation
- ✅ Button-based or TabView integration
- ✅ Selected state highlighting
- ✅ Badge support for counts
- ✅ Icon support with SF Symbols
- ✅ Touch-friendly sizing
- ✅ Accessibility selected trait

## Reasoning
Tabs are common iOS navigation. Selected state shows active tab.

## Implementation Notes
Uses TabTokens
Button or TabView item
Selected state styling
Optional icon and badge
Min touch target size

## Code Example
```swift
@State private var selected = 0

TabView(selection: $selected) {
    View1().tag(0)
    View2().tag(1)
}
```

## Related Components
TabBar, TabGroup, NavigationItem
