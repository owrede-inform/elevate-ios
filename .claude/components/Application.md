# Application Component - iOS Adaptations

## ELEVATE Web Pattern
Top-level application container with routing and layout

## iOS Adaptation
- ✅ WindowGroup-based iOS app structure
- ✅ NavigationStack for navigation hierarchy
- ✅ Scene-based lifecycle management
- ✅ iOS-specific app delegate integration
- ✅ State restoration support
- ✅ Deep linking with URL schemes

## Reasoning
iOS apps use SwiftUI's WindowGroup and Scene structure instead of web routing. Navigation managed by NavigationStack.

## Implementation Notes
Uses ApplicationComponentTokens
Integrates with iOS app lifecycle
Supports multiple scenes on iPad

## Code Example
```swift
ElevateApplication {
    MainView()
}
.preferredColorScheme(.dark)
```

## Related Components
Window, Scene, Navigation
