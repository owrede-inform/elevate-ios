# RequiredIndicator Component - iOS Adaptations

## ELEVATE Web Pattern
Asterisk (*) for required fields

## iOS Adaptation
- ✅ SF typography for consistent sizing
- ✅ Danger color from tokens
- ✅ Proper alignment with labels
- ✅ Accessibility hint

## Reasoning
Simple required indicator matches web semantics. Color provides visual cue.

## Implementation Notes
Uses RequiredIndicatorComponentTokens
Text("*") with danger color
Small font size
Accessibility: "required"

## Code Example
```swift
HStack {
    Text("Email")
    ElevateRequiredIndicator()
}
```

## Related Components
Field, Label, Form
