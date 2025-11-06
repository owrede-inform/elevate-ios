# Breadcrumb Component - iOS Adaptations

## ELEVATE Web Pattern
Hierarchical navigation trail with clickable items

## iOS Adaptation
- ✅ Horizontal ScrollView for long trails
- ✅ Scroll-friendly item interactions
- ✅ Automatic SF Symbol separator (chevron.right)
- ✅ Three size variants
- ✅ Array-based convenience initializer
- ✅ Current page highlighting
- ✅ Dynamic text support
- ✅ VoiceOver navigation support

## Reasoning
Breadcrumbs may exceed screen width on mobile, requiring horizontal scroll. Touch targets need proper sizing.

## Implementation Notes
Uses manually defined BreadcrumbTokens
Separator size varies by breadcrumb size
Array initializer auto-generates separators
ScrollView hides indicators by default

## Code Example
```swift
ElevateBreadcrumb(
    items: ["Home", "Products", "Laptops"],
    onItemTap: { index in
        navigateTo(index)
    }
)
```

## Related Components
NavigationItem, TabBar, Link
