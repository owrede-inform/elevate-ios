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

**Shadow System (Optional Enhancement)**:
- Card elevations could use the shadow system for depth:
  - `.ground`: No shadow (flat on surface)
  - `.raised`: Use `ElevateShadow.raised` (subtle elevation)
  - `.elevated`: Use `ElevateShadow.elevated` (moderate depth)
  - `.overlay`: Use `ElevateShadow.overlay` (high elevation, for modals)
  - `.popover`: Use `ElevateShadow.popover` (floating menus/tooltips)
  - `.sunken`: Use `ElevateShadow.sunken` (inset appearance)
- Currently not implemented - Card uses border/background for elevation
- To implement: Add `.applyShadow(light: .raised, dark: .raisedDark)` based on elevation level
- Shadow system available: `ElevateUI/Sources/DesignTokens/Core/ElevateShadow.swift`

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
