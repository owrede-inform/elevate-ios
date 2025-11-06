# Dialog Component - iOS Adaptations

## ELEVATE Web Pattern
Fixed modal overlay with backdrop, keyboard/mouse dismissal

## iOS Adaptation
- ✅ Native iOS .sheet() presentation
- ✅ Drag-to-dismiss gesture
- ✅ Adaptive sizing with presentation detents
- ✅ Haptic feedback on actions
- ✅ Native iOS button styles
- ✅ Swipe gesture dismissal
- ✅ Presentation drag indicator
- ✅ View extension for easy usage

## Reasoning
iOS users expect native sheet behavior with drag dismissal. Haptic feedback enhances touch interaction.

## Implementation Notes
Uses DialogComponentTokens
Supports custom content or simple messages
Primary/secondary action buttons
onDismiss callback support
Detents: .medium, .large, custom heights

## Code Example
```swift
@State private var showDialog = false

Button("Show") { showDialog = true }
.elevateDialog(isPresented: $showDialog) {
    ElevateDialog(
        title: "Confirm",
        message: "Are you sure?",
        primaryAction: DialogAction(title: "OK") {}
    )
}
```

## Related Components
Drawer, Lightbox, Tooltip
