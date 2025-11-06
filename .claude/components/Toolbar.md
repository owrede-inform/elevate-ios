# Toolbar Component - iOS Adaptations

## ELEVATE Web Pattern
Action toolbar with buttons

## iOS Adaptation
- ✅ Native toolbar with placement
- ✅ Leading/trailing positioning
- ✅ Principal (center) placement
- ✅ IconButton integration
- ✅ Menu support
- ✅ Overflow menu for many items
- ✅ Keyboard shortcuts (iOS 15+)

## Reasoning
iOS toolbar provides standard action placement. Placement variants handle different positions.

## Implementation Notes
Uses .toolbar() modifier
ToolbarItem with placement
placements: .navigation Leading/Trailing, .principal
ToolbarItemGroup for multiple
Menu for overflow

## Code Example
```swift
.toolbar {
    ToolbarItem(placement: .navigationBarLeading) {
        ElevateIconButton(icon: "line.3.horizontal", label: "Menu") {}
    }
    ToolbarItem(placement: .navigationBarTrailing) {
        ElevateIconButton(icon: "plus", label: "Add") {}
    }
}
```

## Related Components
NavigationBar, ButtonGroup, IconButton
