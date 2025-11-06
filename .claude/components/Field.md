# Field Component - iOS Adaptations

## ELEVATE Web Pattern
Form field container with label and validation

## iOS Adaptation
- ✅ VStack layout for label/input/hint
- ✅ Required indicator support
- ✅ Validation state styling
- ✅ Helper text support
- ✅ Error message display
- ✅ Proper spacing using tokens

## Reasoning
Field provides consistent form layout. Validation states guide user input.

## Implementation Notes
Uses FieldComponentTokens
Label, input, hint/error text
Required indicator (*)
Validation tones
Accessibility grouping

## Code Example
```swift
ElevateField(
    "Email",
    isRequired: true,
    validationState: .invalid,
    errorMessage: "Email is required"
) {
    ElevateInput(text: $email)
}
```

## Related Components
Input, TextField, TextArea, Checkbox
