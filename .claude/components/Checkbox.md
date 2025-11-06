# Checkbox Component - iOS Adaptations

## ELEVATE Web Pattern
Standard checkbox with hover and keyboard navigation

## iOS Adaptation
- ✅ Touch-based tap gesture
- ✅ Press state tracking with DragGesture
- ✅ SF Symbols for checkmark and indeterminate
- ✅ No hover states
- ✅ Three states: unchecked, checked, indeterminate
- ✅ Validation states (invalid)
- ✅ Size variants (small, medium, large)
- ✅ Accessibility traits with value announcement
- ✅ onChange callback

## Reasoning
iOS checkboxes use touch without hover. Press states give feedback. SF Symbols provide native icons.

## Implementation Notes
Uses CheckboxComponentTokens
Binding to Bool
Disabled opacity: 0.6
Icon size: 60% of control size
Rounded rectangle shape

## Code Example
```swift
@State private var isChecked = false

ElevateCheckbox("Accept terms", isChecked: $isChecked)

// Indeterminate
ElevateCheckbox("Select all", isChecked: $checked, isIndeterminate: true)
```

## Related Components
Radio, RadioGroup, Switch, Field
