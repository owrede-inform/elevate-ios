# ButtonGroup Component - iOS Adaptations

## ELEVATE Web Pattern
Container for related buttons with shared spacing

## iOS Adaptation
- ✅ HStack or VStack layout based on direction
- ✅ ELEVATE spacing tokens
- ✅ Equal width distribution option
- ✅ Three size variants
- ✅ Proper button alignment
- ✅ Wrapping support (iOS 16+)

## Reasoning
ButtonGroup provides consistent spacing and layout for related actions. Equal width ensures visual balance.

## Implementation Notes
Uses ButtonGroup spacing tokens
Equal width uses frame(maxWidth: .infinity)
Wrapping requires iOS 16+ Layout API
Direction: horizontal or vertical

## Code Example
```swift
ElevateButtonGroup(spacing: .m) {
    ElevateButton("Cancel", tone: .subtle) {}
    ElevateButton("Save", tone: .primary) {}
}
```

## Related Components
Button, Toolbar, Stack
