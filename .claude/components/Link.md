# Link Component - iOS Adaptations

## ELEVATE Web Pattern
Hyperlink with hover underline, visited state

## iOS Adaptation
- ✅ Touch-based tap
- ✅ Visited state tracking
- ✅ Press state feedback
- ✅ Always underlined (no hover change)
- ✅ SF Symbol for external links
- ✅ Internal vs external usage types
- ✅ Custom action support
- ✅ Environment openURL for browser

## Reasoning
iOS links use touch, not hover. External indicator helps users. Visited state shows navigation history.

## Implementation Notes
PlainButtonStyle for custom appearance
hasBeenVisited with @State
Press state shows subtle background
openURL for external links
Custom action for in-app navigation

## Code Example
```swift
ElevateLink(
    url: URL(string: "https://example.com")!,
    label: "Visit Site",
    usage: .external
)

// Internal with action
ElevateLink(
    "https://app.com/profile",
    label: "Profile",
    usage: .internal
) { navigate() }
```

## Related Components
Button, NavigationItem, Menu
