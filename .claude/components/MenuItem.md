# MenuItem Component - iOS Adaptations

## ELEVATE Web Pattern
Individual menu item with hover state

## iOS Adaptation
- ✅ Touch-friendly height
- ✅ Press state styling
- ✅ No hover states
- ✅ SF Symbols for icons
- ✅ Disabled state support
- ✅ Destructive action styling
- ✅ Keyboard shortcut display (iOS 15+)
- ✅ Three size variants

## Reasoning
Menu items need proper touch targets. Press states give feedback.

## Implementation Notes
Uses MenuItemTokens
Min height for touch target
Press state with .scrollFriendlyTap()
Destructive uses danger color
Icon + label + optional shortcut layout

## Code Example
```swift
ElevateMenuItem(
    "Copy",
    icon: "doc.on.doc",
    shortcut: "⌘C"
) {
    copy()
}

// Destructive
ElevateMenuItem(
    "Delete",
    icon: "trash",
    isDestructive: true
) { delete() }
```

## Related Components
Menu, ContextMenu, Button
