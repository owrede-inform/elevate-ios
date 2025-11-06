# Drawer Component - iOS Adaptations

## ELEVATE Web Pattern
Side panel overlay with backdrop

## iOS Adaptation
- ✅ Native iOS .sheet() with custom detents
- ✅ Drag-to-dismiss from edge
- ✅ Presentation from edges (leading, trailing, top, bottom)
- ✅ Adaptive width/height based on screen size
- ✅ Haptic feedback
- ✅ Native animation curves

## Reasoning
iOS sheets from edges provide familiar drawer behavior. Native gestures match system apps.

## Implementation Notes
Uses DrawerComponentTokens
Supports all four edges
Custom detents for sizing
Interactive dismiss enabled

## Code Example
```swift
@State private var showDrawer = false

Button("Menu") { showDrawer = true }
.elevateDrawer(isPresented: $showDrawer, edge: .leading) {
    DrawerContent()
}
```

## Related Components
Dialog, NavigationItem, TabBar
