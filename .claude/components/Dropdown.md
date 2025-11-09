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
- ✅ **System shadow for Menu presentation** (uses iOS native `shadow-elevated` equivalent)

## Reasoning
iOS provides native selection controls. Picker for standard dropdowns, Menu for contextual actions.

**Shadow Note (2025-11-09)**: When using SwiftUI's native `Menu`, the system automatically applies appropriate shadows to the popover presentation. This matches ELEVATE's `shadow-elevated` design (4-layer shadow) but is handled by iOS rather than custom implementation. For custom dropdown containers, use `.applyShadow(light: .elevated, dark: .elevatedDark)` from the shadow system.

## Implementation Notes
Uses DropdownComponentTokens
Picker for forms
Menu for actions
Searchable modifier for long lists

**Shadow System**:
- Native SwiftUI Menu: System-provided shadow (automatically matches iOS design language)
- Custom dropdown containers: Use `ElevateShadow.elevated` (light) / `ElevateShadow.elevatedDark` (dark)
- ELEVATE `shadow-elevated` specification (4 layers):
  - Layer 1: `0 0 1px rgba(41,47,55,0.3)` → subtle outline
  - Layer 2: `0 1px 4px rgba(79,94,113,0.12)` → contact shadow
  - Layer 3: `0 5px 16px -3px rgba(79,94,113,0.12)` → primary elevation
  - Layer 4: `0 8px 24px -5px rgba(79,94,113,0.1)` → ambient depth
- For custom implementations: See `ElevateUI/Sources/DesignTokens/Core/ElevateShadow.swift`

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
