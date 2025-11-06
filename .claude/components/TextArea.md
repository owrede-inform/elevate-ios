# TextArea Component - iOS Adaptations

## ELEVATE Web Pattern
Multi-line text input with resize

## iOS Adaptation
- ✅ TextEditor for multi-line
- ✅ No hover states
- ✅ Focus state styling
- ✅ Character/word count support
- ✅ Auto-growing height option
- ✅ Toolbar with done button
- ✅ No manual resize handle (auto-size)
- ✅ Validation state styling

## Reasoning
TextEditor provides multi-line input. iOS doesn't support manual resize, uses auto-sizing instead.

## Implementation Notes
Uses TextAreaComponentTokens
TextEditor with binding
focused modifier for styling
Toolbar for done button
frame(minHeight:) for initial size
Auto-grows with content

## Code Example
```swift
@State private var text = ""

ElevateTextArea(
    text: $text,
    placeholder: "Enter description",
    minHeight: 100
)
```

## Related Components
TextField, Input, Field, Editor
