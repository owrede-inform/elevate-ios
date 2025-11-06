# EmptyState Component - iOS Adaptations

## ELEVATE Web Pattern
Placeholder for empty content areas

## iOS Adaptation
- ✅ SF Symbols for icons
- ✅ Proper vertical spacing
- ✅ Optional action button
- ✅ Centered layout
- ✅ Adaptive to container size

## Reasoning
Empty states guide users when no content. SF Symbols provide consistent iconography.

## Implementation Notes
Uses EmptyStateComponentTokens
Icon, title, description, optional button
Centered in parent container
Custom icon support

## Code Example
```swift
ElevateEmptyState(
    icon: "tray.fill",
    title: "No Items",
    description: "Add your first item to get started",
    actionTitle: "Add Item"
) { addItem() }
```

## Related Components
Card, Skeleton, Progress
