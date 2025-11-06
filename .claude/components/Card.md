# Card Component - iOS Adaptations

## ELEVATE Web Pattern
Container with shadow and border, optional hover effects

## iOS Adaptation
- ✅ No hover states
- ✅ CardComponentTokens for styling
- ✅ Multiple elevation levels (ground, raised, elevated, sunken, overlay, popover)
- ✅ Optional header and footer sections
- ✅ Tone-based coloring
- ✅ Header and footer separators
- ✅ Proper VStack spacing

## Reasoning
Cards are static containers on iOS. Elevation and tone provide visual hierarchy without hover.

## Implementation Notes
EmptyView checks for optional sections
Footer background matches tone
Border radius from tokens
Header separator at bottom, footer at top

## Code Example
```swift
ElevateCard(elevation: .raised, tone: .primary) {
    Text("Content")
} header: {
    Text("Title")
}
```

## Related Components
Stack, Divider, ExpansionPanel
