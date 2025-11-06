# ExpansionPanel Component - iOS Adaptations

## ELEVATE Web Pattern
Collapsible content panel with animation

## iOS Adaptation
- ✅ DisclosureGroup for native behavior
- ✅ Chevron rotation animation
- ✅ Smooth expand/collapse
- ✅ Proper content clipping
- ✅ Touch-friendly header
- ✅ VoiceOver support

## Reasoning
iOS provides DisclosureGroup for expandable content. Native animation feels familiar.

## Implementation Notes
Uses ExpansionPanelComponentTokens
Chevron rotates 180 degrees
Animation duration: 0.3s
Content clipping during animation

## Code Example
```swift
@State private var isExpanded = false

ElevateExpansionPanel(
    "Section Title",
    isExpanded: $isExpanded
) {
    Text("Expandable content")
}
```

## Related Components
Card, Accordion, Disclosure
