# Lightbox Component - iOS Adaptations

## ELEVATE Web Pattern
Full-screen image viewer with overlay

## iOS Adaptation
- ✅ Fullscreen cover presentation
- ✅ Pinch-to-zoom support
- ✅ Swipe-to-dismiss gesture
- ✅ Tap-to-toggle controls
- ✅ Share button
- ✅ Close button

## Reasoning
iOS users expect pinch zoom and swipe dismissal for image viewers.

## Implementation Notes
Uses LightboxComponentTokens
fullScreenCover modifier
MagnificationGesture for zoom
DragGesture for dismiss
Share sheet integration

## Code Example
```swift
@State private var showLightbox = false

Button("View") { showLightbox = true }
.elevateLightbox(
    isPresented: $showLightbox,
    image: Image("photo")
)
```

## Related Components
Dialog, Image, Gallery
