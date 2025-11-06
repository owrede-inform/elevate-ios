# Input Component - iOS Adaptations

## ELEVATE Web Pattern
Single-line text input with states

## iOS Adaptation
- ✅ TextField-based implementation
- ✅ No hover states
- ✅ Focus state with border highlighting
- ✅ Keyboard type support
- ✅ Text content type for autofill
- ✅ Secure entry for passwords
- ✅ Input accessories (done button)
- ✅ Validation state styling

## Reasoning
iOS TextField provides native input behavior with keyboard management.

## Implementation Notes
Uses InputComponentTokens
keyboardType for different inputs
textContentType for autofill
focused modifier for border states
Toolbar for done button

## Code Example
```swift
@State private var text = ""

ElevateInput(
    text: $text,
    placeholder: "Enter text",
    keyboardType: .emailAddress
)
```

## Related Components
TextField, TextArea, Field
