# Chip Component - iOS Adaptations

## ELEVATE Web Pattern
Interactive labels with hover, remove actions, mouse events

## iOS Adaptation
- ✅ Touch-based selection
- ✅ Press state with .scrollFriendlyTap()
- ✅ No hover states
- ✅ Removable with X button
- ✅ Selected state styling
- ✅ Three sizes
- ✅ Two shapes (box, pill)
- ✅ Six tones
- ✅ Prefix/suffix icon support
- ✅ onEdit callback support

## Reasoning
Chips are interactive, requiring touch feedback. Separate tap handler for remove prevents conflicts.

## Implementation Notes
Uses ChipTokens
Remove button size varies by chip size
Action is optional (can be non-interactive)
Disabled prevents action and removal

## Code Example
```swift
@State private var isSelected = false
ElevateChip("Filter", tone: .primary, isSelected: isSelected) {
    isSelected.toggle()
}

// Removable
ElevateChip("Tag", removable: true) {} onRemove: {
    removeTag()
}
```

## Related Components
Badge, ButtonGroup, TabBar
