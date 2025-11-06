# Progress Component - iOS Adaptations

## ELEVATE Web Pattern
Progress bar or spinner, determinate/indeterminate

## iOS Adaptation
- ✅ Linear (bar) and circular (ring) styles
- ✅ Indeterminate animation with rotation
- ✅ Three sizes
- ✅ Optional label support
- ✅ Percentage display in circular
- ✅ Clamped value (0.0-1.0)
- ✅ Accessibility progress announcement

## Reasoning
iOS progress uses continuous animation. Circular style common in iOS. Indeterminate uses sine wave.

## Implementation Notes
Indeterminate: sin() for smooth motion
Circular starts from top (-90°)
Line cap .round for smooth ends
Label in center of circular
GeometryReader calculates bar width

## Code Example
```swift
ElevateProgress(value: 0.6, label: "Uploading...")

// Indeterminate
ElevateProgress(isIndeterminate: true, style: .linear)

// Circular
ElevateProgress(value: 0.75, style: .circular)
```

## Related Components
Indicator, Skeleton, Activity
