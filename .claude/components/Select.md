# Select Component - iOS Adaptations

## ELEVATE Web Pattern
Dropdown select with keyboard navigation

## iOS Adaptation
- ✅ Native iOS Picker
- ✅ Wheel or menu style options
- ✅ Inline or sheet presentation
- ✅ Search support for long lists
- ✅ Multi-select with custom UI
- ✅ Section support

## Reasoning
iOS Picker provides native selection. Different styles for different contexts.

## Implementation Notes
Uses SelectComponentTokens
Picker with binding
.pickerStyle() variants
Searchable for long lists
Custom multi-select needs ForEach

## Code Example
```swift
@State private var selected = "Option 1"

Picker("Select", selection: $selected) {
    ForEach(options, id: \.self) {
        Text($0)
    }
}
.pickerStyle(.menu)
```

## Related Components
Dropdown, Menu, Picker, Field
