# Notification Component - iOS Adaptations

## ELEVATE Web Pattern
Toast notification with auto-dismiss

## iOS Adaptation
- ✅ Slide-in animation from top
- ✅ Swipe-to-dismiss gesture
- ✅ Auto-dismiss timer
- ✅ Four tones (info, success, warning, danger)
- ✅ Icon support
- ✅ Action button support
- ✅ Haptic feedback
- ✅ Safe area aware positioning

## Reasoning
iOS notifications appear from top with native feel. Swipe dismissal matches system behavior.

## Implementation Notes
Uses NotificationComponentTokens
Slide animation from top edge
Swipe threshold for dismiss
Haptic feedback on appear
ZStack overlay for positioning
Timer for auto-dismiss

## Code Example
```swift
@State private var showNotification = false

ElevateNotification(
    isPresented: $showNotification,
    tone: .success,
    title: "Success",
    message: "Item saved"
)
```

## Related Components
Toast, Alert, Dialog, Banner
