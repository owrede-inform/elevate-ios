# Menu Component - iOS Adaptations

## ELEVATE Web Pattern
Dropdown menu with hover states

## iOS Adaptation
- ✅ Custom container matching ELEVATE design
- ✅ ScrollView for long menus
- ✅ Group labels with styling
- ✅ Shadow and border from tokens
- ✅ **Multi-layer shadow system** (ELEVATE `shadow-popover`)
- ✅ Touch-friendly item sizing
- ✅ Dividers between groups

## Reasoning
Custom menu provides ELEVATE styling. ScrollView handles overflow.

**Shadow Implementation (2025-11-09)**: Menu uses ELEVATE's 4-layer `shadow-popover` shadow via the new shadow system. This provides depth matching web ELEVATE while properly adapting to iOS light/dark mode. Uses `.applyShadow(light: .popover, dark: .popoverDark)` instead of hardcoded shadow values.

## Implementation Notes
Uses MenuTokens
Scrollable content
Group labels with uppercase styling
Min/max width constraints
Border styling from tokens

**Shadow System**:
- Uses `ElevateShadow.popover` (light mode) / `ElevateShadow.popoverDark` (dark mode)
- 4-layer shadow matching ELEVATE design tokens:
  - Layer 1: `0 2px 6px -1px rgba(79,94,113,0.14)` → subtle contact shadow
  - Layer 2: `0 5px 16px rgba(79,94,113,0.2)` → primary depth shadow
  - Layer 3: `0 15px 15px rgba(79,94,113,0.1)` → ambient shadow
  - Layer 4: `0 34px 20px rgba(79,94,113,0.05)` → distant ambient
- Automatically adapts to system appearance (light/dark mode)
- Implemented in: `ElevateUI/Sources/DesignTokens/Core/ElevateShadow.swift`

## Code Example
```swift
ElevateMenu {
    ElevateMenuGroup("Edit") {
        ElevateMenuItem("Copy", icon: "doc.on.doc") {}
        ElevateMenuItem("Paste", icon: "doc.on.clipboard") {}
    }
    Divider()
    ElevateMenuItem("Delete", icon: "trash", isDestructive: true) {}
}
```

## Related Components
MenuItem, Dropdown, Popover
