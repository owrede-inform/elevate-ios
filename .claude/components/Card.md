# Card Component - iOS Adaptations

## ELEVATE Web Pattern
Container with shadow and border, optional hover effects

## iOS Adaptation
- ✅ No hover states
- ✅ CardComponentTokens for styling
- ✅ Multiple elevation levels (ground, raised, elevated, sunken, overlay, popover)
- ✅ **Multi-layer shadow system** mapped to elevation levels
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

**Shadow System Implementation (2025-11-09)**:
Card elevations now use the ELEVATE shadow system for realistic depth:
- `.ground`: No shadow (flat on surface)
- `.raised`: `ElevateShadow.raised` - 3-layer subtle elevation
  - Contact shadow, outline shadow, soft depth
- `.elevated`: `ElevateShadow.elevated` - 4-layer moderate depth
  - Outline, contact, primary elevation, ambient depth
- `.overlay`: `ElevateShadow.overlay` - 4-layer high elevation for modals
  - Strong shadows for floating above content
- `.popover`: `ElevateShadow.popover` - 4-layer floating appearance
  - Menu/tooltip depth matching ELEVATE design
- `.sunken`: `ElevateShadow.sunken` - Inset appearance (approximation)
  - SwiftUI limitation: no true inset shadows

Each elevation automatically adapts to light/dark mode with appropriate shadow colors and intensities. Implemented via `CardShadowModifier` using `ElevateUI/Sources/DesignTokens/Core/ElevateShadow.swift`

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
