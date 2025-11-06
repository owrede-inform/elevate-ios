# SplitPanel Component - iOS Adaptations

## ELEVATE Web Pattern
Resizable split view with drag handle

## iOS Adaptation
- ✅ Native iOS split view (UISplitViewController wrapper)
- ✅ Adaptive layout (sidebar hides on compact)
- ✅ Three column support on iPad
- ✅ Swipe to reveal sidebar
- ✅ Column visibility control
- ✅ Preferred widths

## Reasoning
iOS provides rich split view behavior. Adapts to screen size automatically.

## Implementation Notes
Uses NavigationSplitView
Adapts to size class
ColumnVisibility for control
preferred column widths
Three-column on iPad

## Code Example
```swift
NavigationSplitView {
    Sidebar()
} detail: {
    DetailView()
}
```

## Related Components
Navigation, Layout, Panel
