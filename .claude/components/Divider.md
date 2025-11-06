# Divider Component - iOS Adaptations

## ELEVATE Web Pattern
Visual separator line, horizontal or vertical

## iOS Adaptation
- ✅ No hover states
- ✅ Horizontal and vertical orientations
- ✅ Five tones
- ✅ Optional label in center
- ✅ Size-based spacing (small, medium, large)
- ✅ Clean Rectangle rendering
- ✅ Proper padding for spacing

## Reasoning
Dividers are static separators. Size-based spacing provides layout flexibility.

## Implementation Notes
Uses Rectangle() for lines
Labeled dividers use HStack with expanding lines
Vertical dividers ignore labels
Stroke width from DividerComponentTokens

## Code Example
```swift
ElevateDivider()

// With label
ElevateDivider("OR", tone: .neutral)

// Vertical
HStack {
    Text("Left")
    ElevateDivider(axis: .vertical)
    Text("Right")
}
```

## Related Components
Card, Stack, Toolbar
