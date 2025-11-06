# Radio Component - iOS Adaptations

## ELEVATE Web Pattern
Radio button with hover and keyboard navigation

## iOS Adaptation
- ✅ Touch-based tap gesture
- ✅ Circular shape with center dot
- ✅ Press state tracking
- ✅ No hover states
- ✅ Generic Value type binding
- ✅ Three sizes
- ✅ Invalid state support
- ✅ Hide label option
- ✅ Accessibility value announcement

## Reasoning
iOS radios use touch without hover. Circular shape is standard. Generic type provides type safety.

## Implementation Notes
Uses RadioComponentTokens
Binding to optional generic Value
Only changes if not already selected
Gap spacing: 8pt/12pt/16pt
Handle size proportional to control

## Code Example
```swift
@State private var selected: String? = "option1"

ElevateRadio("Option 1", value: "option1", selectedValue: $selected)
ElevateRadio("Option 2", value: "option2", selectedValue: $selected)
```

## Related Components
RadioGroup, Checkbox, Switch
