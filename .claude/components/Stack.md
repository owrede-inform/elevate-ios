# Stack Component - iOS Adaptations

## ELEVATE Web Pattern
Flexbox-like container with gap spacing

## iOS Adaptation
- ✅ HStack/VStack based on direction
- ✅ ELEVATE spacing tokens
- ✅ Alignment support
- ✅ Padding support
- ✅ Reverse direction support
- ✅ No wrapping (iOS 15), Layout API wrapping (iOS 16+)

## Reasoning
Stack provides consistent spacing using design tokens. Natural SwiftUI layout pattern.

## Implementation Notes
Uses ElevateSpacing tokens
Direction: row, column, rowReverse, columnReverse
Alignment: leading, center, trailing, stretch
Spacing: xxs, xs, s, m, l, xl, custom

## Code Example
```swift
ElevateStack.vertical(spacing: .m) {
    Text("Item 1")
    Text("Item 2")
}

// Horizontal
ElevateStack.horizontal(alignment: .center, spacing: .l) {
    Image()
    Text()
}
```

## Related Components
Layout, VStack, HStack, Group
