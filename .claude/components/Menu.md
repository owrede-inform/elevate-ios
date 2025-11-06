# Menu Component - iOS Adaptations

## ELEVATE Web Pattern
Dropdown menu with hover states

## iOS Adaptation
- ✅ Custom container matching ELEVATE design
- ✅ ScrollView for long menus
- ✅ Group labels with styling
- ✅ Shadow and border from tokens
- ✅ Touch-friendly item sizing
- ✅ Dividers between groups

## Reasoning
Custom menu provides ELEVATE styling. ScrollView handles overflow.

## Implementation Notes
Uses MenuTokens
Scrollable content
Group labels with uppercase styling
Min/max width constraints
Border and shadow styling

## Code Example
```swift
ElevateMenu {
    ElevateMenuGroup("Edit") {
        ElevateMenuItem("Copy", icon: "doc.on.doc") {}
        ElevateMenuItem("Paste", icon: "doc.on.clipboard") {}
    }
    Divider()
    ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {}
}
```

## Related Components
MenuItem, Dropdown, Popover
