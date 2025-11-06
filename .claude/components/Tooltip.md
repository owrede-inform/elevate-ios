# Tooltip Component - iOS Adaptations

## ELEVATE Web Pattern
Hover-triggered overlay with positioning

## iOS Adaptation
- ✅ Long press gesture instead of hover
- ✅ Timer-based show/hide (0.5s delay)
- ✅ Four placement options
- ✅ Optional arrow indicator
- ✅ Position calculation from anchor
- ✅ Fade and scale transition
- ✅ GeometryReader for positioning
- ✅ View extension for easy usage

## Reasoning
iOS tooltips use long press since no hover. Timer prevents accidental triggers. Position calculation keeps tooltip on screen.

## Implementation Notes
showTimer: 0.5s before display
hideTimer: 0.2s after gesture end
Triangle() shape for arrow
CGPoint in global coordinates
Overlay with GeometryReader

## Code Example
```swift
Button("Info") {}
    .elevateTooltip("Helpful info")

// With arrow
Image(systemName: "gear")
    .elevateTooltip(
        "Settings",
        arrow: true,
        placement: .bottom
    )
```

## Related Components
Popover, Dialog, Notification
