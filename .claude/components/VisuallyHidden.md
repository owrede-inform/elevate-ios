# VisuallyHidden Component - iOS Adaptations

## ELEVATE Web Pattern
Screen reader only content (display:none equivalent)

## iOS Adaptation
- ✅ Accessibility-only modifier
- ✅ Hidden from visual display
- ✅ Readable by VoiceOver
- ✅ Zero frame size
- ✅ Proper semantic structure

## Reasoning
Accessibility content should be available to VoiceOver without visual display.

## Implementation Notes
Uses .accessibilityHidden(false) + .frame(width: 0, height: 0)
VoiceOver can read
Visually hidden
Useful for semantic labels

## Code Example
```swift
Text("Screen reader label")
    .elevateVisuallyHidden()
```

## Related Components
Accessibility, Label, Hidden
