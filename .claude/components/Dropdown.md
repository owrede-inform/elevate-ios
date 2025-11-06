# Dropdown Component - iOS Adaptations

## ELEVATE Web Pattern
Select menu with hover states

## iOS Adaptation
- ✅ Native iOS Picker or Menu
- ✅ Touch-based selection
- ✅ No hover states
- ✅ Scrollable long lists
- ✅ Search support for long lists
- ✅ Multi-select option

## Reasoning
iOS provides native selection controls. Picker for standard dropdowns, Menu for contextual actions.

## Implementation Notes
Uses DropdownComponentTokens
Picker for forms
Menu for actions
Searchable modifier for long lists

## Code Example
```swift
@State private var selected = "Option 1"

Picker("Choose", selection: $selected) {
    Text("Option 1").tag("Option 1")
    Text("Option 2").tag("Option 2")
}
```

## Related Components
Select, Menu, Field
