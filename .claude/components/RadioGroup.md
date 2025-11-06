# RadioGroup Component - iOS Adaptations

## ELEVATE Web Pattern
Container for radio buttons with fieldset semantics

## iOS Adaptation
- ✅ VStack layout with spacing
- ✅ Optional label with Field integration
- ✅ Legend/label for accessibility
- ✅ Generic value type
- ✅ Size and tone variants
- ✅ Invalid state propagation
- ✅ Disabled state propagation
- ✅ Auto generation from array

## Reasoning
RadioGroup manages shared state. VStack layout is natural for iOS.

## Implementation Notes
Uses RadioGroupComponentTokens
Passes selectedValue to all radios
Optional hint text
Field component integration
Accessibility grouping

## Code Example
```swift
@State private var selected: String?

ElevateRadioGroup(
    "Choose option",
    selectedValue: $selected,
    options: [
        ("opt1", "Option 1"),
        ("opt2", "Option 2")
    ]
)
```

## Related Components
Radio, Field, Checkbox
