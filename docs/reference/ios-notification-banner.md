# iOS-Native Notification Banner

## Overview

The ELEVATE notification component has been replaced with an iOS-native banner implementation inspired by the NotificationBanner library. This replaces the web-style in-page notifications with native iOS banners that slide from the top of the screen.

## Key Features

✅ **iOS-Native Presentation**
- Slides from top edge (not inline)
- Respects safe area (notch, Dynamic Island)
- Spring animation (.spring())
- Appears above all content

✅ **User Interactions**
- Tap to dismiss
- Swipe up to dismiss
- Haptic feedback on appear
- Auto-dismiss with timer (5s default)

✅ **ELEVATE Design Consistency**
- Uses `NotificationComponentTokens` for colors
- Maintains danger/info/success/warning tones
- Uses `ElevateTypographyiOS` for text

✅ **SwiftUI-Native**
- No UIKit bridging
- Pure SwiftUI implementation
- Combine-based state management

## Architecture

```
┌──────────────────────────────────────────────────────────┐
│                   File Structure                          │
└──────────────────────────────────────────────────────────┘

ElevateUI/Sources/SwiftUI/
├── Utilities/
│   ├── NotificationBannerManager.swift       (Singleton manager)
│   └── NotificationBannerModifier.swift      (View overlay modifier)
└── Components/
    └── ElevateNotification+SwiftUI.swift     (Public API)
```

### Components

1. **NotificationBannerManager** (`NotificationBannerManager.swift`)
   - Singleton: `NotificationBannerManager.shared`
   - Manages banner presentation state
   - Handles auto-dismiss timers
   - Triggers haptic feedback

2. **NotificationBannerModifier** (`NotificationBannerModifier.swift`)
   - SwiftUI ViewModifier for app-level overlay
   - Handles slide animation
   - Manages swipe-to-dismiss gesture
   - Safe area aware positioning

3. **ElevateNotification** (`ElevateNotification+SwiftUI.swift`)
   - Public API for showing notifications
   - Static methods for convenience
   - Maintains backward compatibility

## Setup

### Step 1: Add Banner Overlay to Root View

Add `.notificationBannerOverlay()` to your app's root view:

```swift
import SwiftUI
import ElevateUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .notificationBannerOverlay()  // ✅ Enable iOS-native banners
        }
    }
}
```

**Important:** This modifier must be added to the root view to ensure banners appear above all content.

### Step 2: Show Notifications

Use the static methods on `ElevateNotification`:

```swift
import ElevateUI

// Basic notification
ElevateNotification.show(
    message: "Operation completed successfully",
    tone: .success,
    duration: 5.0
)

// Convenience methods
ElevateNotification.success("Changes saved")
ElevateNotification.warning("Session expiring soon")
ElevateNotification.danger("Upload failed")
ElevateNotification.info("Update available")
```

## API Reference

### Show Notification

```swift
ElevateNotification.show(
    message: String,                    // Notification message
    tone: NotificationTone = .primary,  // Color scheme
    customIcon: String? = nil,          // Optional SF Symbol name
    duration: TimeInterval = 5.0,       // Auto-dismiss duration (seconds)
    onClose: (() -> Void)? = nil        // Callback when dismissed
)
```

### Notification Tones

```swift
public enum NotificationTone {
    case primary    // Blue info banner
    case success    // Green success banner
    case warning    // Yellow/orange warning banner
    case danger     // Red error banner
    case neutral    // Gray neutral banner
}
```

### Convenience Methods

```swift
// Show success notification (green, checkmark icon)
ElevateNotification.success("Operation completed")

// Show warning notification (yellow, triangle icon)
ElevateNotification.warning("Please review this")

// Show danger notification (red, octagon icon)
ElevateNotification.danger("An error occurred")

// Show info notification (blue, info icon)
ElevateNotification.info("Update available")

// Manually dismiss current banner
ElevateNotification.dismiss()
```

## Examples

### Basic Usage

```swift
// Success message
ElevateNotification.success("Your changes have been saved successfully")

// Error message
ElevateNotification.danger("Failed to upload file. Please try again.")

// Warning with custom duration
ElevateNotification.show(
    message: "Session expiring in 5 minutes",
    tone: .warning,
    duration: 10.0
)
```

### Custom Icons

```swift
// Download complete
ElevateNotification.show(
    message: "Download complete",
    tone: .success,
    customIcon: "arrow.down.circle.fill"
)

// New message
ElevateNotification.show(
    message: "New message received",
    tone: .primary,
    customIcon: "envelope.fill"
)

// Connection lost
ElevateNotification.show(
    message: "Connection lost",
    tone: .danger,
    customIcon: "wifi.slash"
)
```

### With Callbacks

```swift
ElevateNotification.show(
    message: "Item deleted",
    tone: .danger,
    duration: 5.0,
    onClose: {
        print("User dismissed the notification")
        // Perform cleanup or analytics
    }
)
```

### Network Request Example

```swift
func fetchData() {
    isLoading = true

    APIClient.fetch { result in
        isLoading = false

        switch result {
        case .success(let data):
            ElevateNotification.success("Data loaded successfully")
            self.data = data

        case .failure(let error):
            ElevateNotification.danger("Failed to load data: \\(error.localizedDescription)")
        }
    }
}
```

## Design Tokens

The notification banner uses the same ELEVATE design tokens as the web component:

### Colors
- `NotificationComponentTokens.fill_primary/success/warning/danger/neutral`
- `NotificationComponentTokens.border_color_primary/success/warning/danger/neutral`
- `NotificationComponentTokens.icon_color_primary/success/warning/danger/neutral`
- `NotificationComponentTokens.text_color`
- `NotificationComponentTokens.icon_color_closable`

### Typography
- `ElevateTypographyiOS.bodyMedium` (16pt scaled from 14pt web)

## Differences from Web Component

| Feature | Web (In-page) | iOS (Banner) |
|---------|---------------|--------------|
| **Presentation** | Inline VStack | Top overlay slide |
| **Position** | Within view hierarchy | Above all content |
| **Dismissal** | Close button only | Tap, swipe up, or auto-dismiss |
| **Animation** | Fade + scale | Spring slide |
| **Haptics** | None | UIImpactFeedback on appear |
| **Safe Area** | N/A | Respects notch/Dynamic Island |
| **iOS HIG** | ❌ Web pattern | ✅ iOS-native |

## Migration from Old API

The old inline notification component used a `@Binding` for `isOpen`. The new iOS-native API uses static methods instead:

**Before (Inline):**
```swift
@State private var showNotification = false

ElevateNotification(
    isOpen: $showNotification,
    message: "Success",
    tone: .success
)

// Show
showNotification = true
```

**After (iOS-Native):**
```swift
// Show
ElevateNotification.success("Success")

// No @State needed - manager handles state
```

## Implementation Details

### Singleton Pattern

The `NotificationBannerManager` is a singleton that manages app-wide notification state:

```swift
@ObservableObject
public class NotificationBannerManager {
    public static let shared = NotificationBannerManager()

    @Published public var currentBanner: NotificationBannerItem?
    @Published public var isPresented: Bool = false

    public func show(...) { ... }
    public func dismiss() { ... }
}
```

### View Modifier

The `.notificationBannerOverlay()` modifier adds a top-aligned overlay to the view:

```swift
struct NotificationBannerModifier: ViewModifier {
    @StateObject private var manager = NotificationBannerManager.shared

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                if manager.isPresented, let banner = manager.currentBanner {
                    NotificationBannerView(item: banner)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .gesture(/* swipe-to-dismiss */)
                }
            }
    }
}
```

### Gestures

**Swipe Up to Dismiss:**
```swift
DragGesture()
    .onChanged { value in
        if value.translation.height < 0 {
            dragOffset = value.translation.height
        }
    }
    .onEnded { value in
        if value.translation.height < -50 {
            manager.dismiss()
        }
        dragOffset = 0
    }
```

**Tap to Dismiss:**
```swift
.onTapGesture {
    NotificationBannerManager.shared.dismiss()
}
```

## Best Practices

1. **Always add `.notificationBannerOverlay()` to root view**
   - Ensures banners appear above all content
   - Only add once at app entry point

2. **Keep messages concise**
   - One sentence preferred
   - Aim for < 80 characters

3. **Use appropriate tones**
   - `.success` for completed actions
   - `.danger` for errors
   - `.warning` for important warnings
   - `.primary` for general info

4. **Customize duration based on message length**
   - Short messages: 3-5 seconds
   - Long messages: 7-10 seconds
   - Critical warnings: 10+ seconds

5. **Use callbacks for analytics**
   - Track which notifications users dismiss
   - Measure notification effectiveness

## Testing

The implementation includes Xcode previews for visual testing:

```swift
struct ElevateNotification_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
            .notificationBannerOverlay()
    }

    // Interactive preview with test buttons
}
```

Run previews in Xcode to see:
- All notification tones
- Custom icons
- Different durations
- Tap/swipe interactions

## Troubleshooting

### Banner not appearing

**Problem:** Called `ElevateNotification.show()` but nothing happens

**Solution:** Ensure `.notificationBannerOverlay()` is added to root view:

```swift
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .notificationBannerOverlay()  // ✅ Add this
        }
    }
}
```

### Banner appears behind content

**Problem:** Banner is hidden behind other views

**Solution:** The overlay modifier must be at the root level. Don't add it to nested views.

### Multiple banners at once

**Problem:** Want to queue multiple notifications

**Current Behavior:** Only one banner shown at a time. New banner replaces current one.

**Future Enhancement:** Queue system can be added to `NotificationBannerManager` if needed.

## iOS HIG Compliance

This implementation follows Apple's Human Interface Guidelines:

✅ **Temporary overlays** - Slides in from top, auto-dismisses
✅ **Spring animation** - Uses `.spring()` for natural motion
✅ **Haptic feedback** - UIImpactFeedbackGenerator on appear
✅ **Safe area awareness** - Respects notch and Dynamic Island
✅ **Gesture-based dismissal** - Swipe up to dismiss
✅ **Accessible** - VoiceOver compatible

## Future Enhancements

Potential improvements for future releases:

- Queue system for multiple banners
- Bottom presentation option
- Custom animation styles
- Progress indicator during async operations
- Persistent banners (don't auto-dismiss)
- Action buttons within banner
- Rich content support (images, multiple lines)

## Credits

Inspired by [NotificationBanner](https://github.com/Daltron/NotificationBanner) by Daltron Software, adapted to pure SwiftUI for ELEVATE design system.

---

**Last Updated:** 2025-11-09
**Version:** 1.0.0
**iOS Requirement:** iOS 15+
