# IconButton Component - iOS Adaptations

## ELEVATE Web Pattern
Clickable icon with hover state

## iOS Adaptation
- ✅ Touch-based button tap
- ✅ Press state tracking
- ✅ No hover states
- ✅ Two shapes: circle and box
- ✅ Three sizes
- ✅ Selected state with background fill
- ✅ SF Symbols for icons
- ✅ Accessibility label required
- ✅ Custom button style

## Reasoning
Icon buttons are common in iOS toolbars. Selected state shows active tools.

## Implementation Notes
Custom IconButtonPressableStyle
Background only when selected
Icon size: 16pt/20pt/24pt
Frame size from IconButtonComponentTokens
Disabled opacity: 0.6

## Code Example
```swift
ElevateIconButton(icon: "heart", label: "Like") {
    toggleLike()
}

// Selected
ElevateIconButton(
    icon: "star.fill",
    label: "Favorite",
    isSelected: true,
    shape: .circle
) {}
```

## Related Components
Button, Toolbar, TabBar, NavigationItem
