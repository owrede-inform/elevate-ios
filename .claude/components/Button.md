# Button Component - iOS Adaptations

## ELEVATE Web Pattern
Clickable button with hover states and mouse events

## iOS Adaptation
- ✅ Replaced hover with touch press states
- ✅ Uses .scrollFriendlyTap() for scroll-safe interactions
- ✅ Immediate visual feedback with Transaction
- ✅ Touch-based gestures instead of mouse
- ✅ SF Symbols for prefix/suffix icons
- ✅ Accessibility traits for selected state
- ✅ All ELEVATE tones supported
- ✅ Shape variants (default, pill)
- ✅ Size variants (small, medium, large)
- ✅ Selected state styling

## Reasoning
iOS requires touch-optimized interactions. Custom gesture prevents scroll conflicts. Transaction-based updates ensure instant feedback.

## Implementation Notes
Uses ButtonComponentTokens
Press state tracked via @State
Custom padding support
Disabled opacity: 0.6
Selected state changes background and text colors

## Code Example
```swift
ElevateButton("Save", tone: .primary) {
    save()
}

// With icon
ElevateButton("Delete", tone: .danger, prefix: {
    Image(systemName: "trash.fill")
}) { delete() }
```

## Related Components
ButtonGroup, IconButton, Link
