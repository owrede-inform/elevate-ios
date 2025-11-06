# Scrollbar Component - iOS Adaptations

## ELEVATE Web Pattern
Custom scrollbar styling

## iOS Adaptation
- ✅ Native iOS scrollbar (cannot customize heavily)
- ✅ ScrollView indicator visibility control
- ✅ Flash indicators on appear
- ✅ Bounce behavior control

## Reasoning
iOS provides native scrollbars. Heavy customization not possible due to platform constraints.

## Implementation Notes
Uses ScrollView modifiers
showsIndicators for visibility
flashScrollIndicators() to show
No custom styling available
iOS handles appearance automatically

## Code Example
```swift
ScrollView(.vertical, showsIndicators: true) {
    Content()
}
.onAppear {
    // Flash indicators
}
```

## Related Components
ScrollView, List, Table
