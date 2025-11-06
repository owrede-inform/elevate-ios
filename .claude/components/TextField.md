# TextField Component - iOS Adaptations

## ELEVATE Web Pattern
Single-line text input

## iOS Adaptation
- ✅ Native iOS TextField
- ✅ No hover states
- ✅ Focus state with border
- ✅ Keyboard type variants
- ✅ Text content type for autofill
- ✅ Secure entry option
- ✅ Clear button
- ✅ Validation state styling
- ✅ Input accessories

## Reasoning
TextField is standard iOS input. Keyboard types optimize input experience.

## Implementation Notes
Uses TextFieldComponentTokens
TextField with binding
keyboardType variants
textContentType for autofill
secureField for passwords
Toolbar for accessories

## Code Example
```swift
@State private var email = ""

ElevateTextField(
    text: $email,
    placeholder: "Email",
    keyboardType: .emailAddress
)
```

## Related Components
Input, TextArea, Field, SecureField
