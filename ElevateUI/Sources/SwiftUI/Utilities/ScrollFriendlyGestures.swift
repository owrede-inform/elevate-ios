#if os(iOS)
import SwiftUI
import UIKit

/// Scroll-Friendly Gesture Utilities
///
/// iOS-specific gesture handling that allows components to be interactive
/// while not blocking scroll gestures. This is critical for components
/// inside ScrollViews or Lists.
///
/// # The Problem
/// Standard `.onTapGesture` and `.gesture()` block scroll gestures when
/// the user starts their swipe on an interactive component (button, switch, etc.).
/// SwiftUI gestures intercept touches and prevent ScrollView from scrolling.
///
/// # The Solution
/// Use UIControl subclass with tracking methods via UIViewRepresentable:
/// - **beginTracking**: Fires SYNCHRONOUSLY on touch down → instant visual feedback (no delay)
/// - **endTracking**: Fires action ONLY if finger released within 20px of start position
/// - **cancelTracking**: Called by system if scroll gesture starts
///
/// UIControl's tracking methods are called synchronously during touch delivery,
/// before gesture recognizers run. This provides instant feedback with zero delay.
/// UIScrollView automatically doesn't delay touches for UIControl subclasses.
///
/// # Usage
/// ```swift
/// Text("Tap Me")
///     .scrollFriendlyTap {
///         print("Tapped!")
///     }
/// ```
@available(iOS 15, *)
public extension View {

    /// Adds a tap gesture that doesn't block scrolling with instant visual feedback.
    ///
    /// Uses native SwiftUI Button which already handles scroll gestures correctly.
    ///
    /// **Behavior:**
    /// - Touch down → Instant pressed state (no delay)
    /// - Scrolling → Press automatically cancels, scroll works
    /// - Tap (no scroll) → Action fires
    ///
    /// This provides true native iOS button behavior - instant feedback and
    /// scrolling works even when touch starts on the button.
    ///
    /// - Parameters:
    ///   - threshold: Unused, kept for API compatibility (Button handles this automatically)
    ///   - onPressedChanged: Optional callback when pressed state changes (for visual feedback)
    ///   - action: The action to perform when tapped
    func scrollFriendlyTap(
        threshold: CGFloat = 20.0,
        onPressedChanged: ((Bool) -> Void)? = nil,
        action: @escaping () -> Void
    ) -> some View {
        self.modifier(
            ScrollFriendlyTapModifier(
                threshold: threshold,
                onPressedChanged: onPressedChanged,
                action: action
            )
        )
    }
}

/// ViewModifier that implements scroll-friendly tap behavior with instant feedback
///
/// # Key Behavior (Native iOS Pattern)
/// 1. **Touch down** → INSTANT pressed state (synchronous, zero delay)
/// 2. **Touch up within 20px** → Action fires
/// 3. **Scroll started** → System cancels touch, no action fires
///
/// Uses UIControl tracking methods which are synchronous and scroll-compatible.
@available(iOS 15, *)
private struct ScrollFriendlyTapModifier: ViewModifier {
    let threshold: CGFloat
    let onPressedChanged: ((Bool) -> Void)?
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .overlay(
                TouchHandlerView(
                    threshold: threshold,
                    onPressedChanged: onPressedChanged,
                    action: action
                )
                .allowsHitTesting(true)
            )
    }
}

/// UIControl-based touch handler that provides instant feedback without blocking scrolling
@available(iOS 15, *)
private struct TouchHandlerView: UIViewRepresentable {
    let threshold: CGFloat
    let onPressedChanged: ((Bool) -> Void)?
    let action: () -> Void

    func makeUIView(context: Context) -> TouchTrackingControl {
        let control = TouchTrackingControl()
        control.threshold = threshold
        control.onPressedChanged = onPressedChanged
        control.onTap = action
        control.backgroundColor = .clear
        control.isUserInteractionEnabled = true
        return control
    }

    func updateUIView(_ uiView: TouchTrackingControl, context: Context) {
        uiView.threshold = threshold
        uiView.onPressedChanged = onPressedChanged
        uiView.onTap = action
    }
}

/// UIControl subclass that handles touches with instant feedback and scroll compatibility
///
/// Simple approach:
/// - beginTracking: Instant pressed state (synchronous, no delay)
/// - endTracking: Fire action ONLY if finger released within 20px of start position
/// - cancelTracking: Clean up if system cancels (e.g., scroll started)
///
/// UIControl subclasses automatically work with UIScrollView without blocking scrolling.
@available(iOS 15, *)
private class TouchTrackingControl: UIControl {
    var threshold: CGFloat = 20.0
    var onPressedChanged: ((Bool) -> Void)?
    var onTap: (() -> Void)?

    private var touchStartLocation: CGPoint?

    /// Called synchronously when touch begins - provides instant feedback
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        touchStartLocation = touch.location(in: self)

        // SYNCHRONOUS callback - instant visual feedback, no delay
        onPressedChanged?(true)

        return true  // Continue tracking
    }

    /// Called as touch moves - just keep tracking
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        return true  // Continue tracking (don't cancel early)
    }

    /// Called when touch ends - fire action ONLY if release position is within threshold
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)

        onPressedChanged?(false)

        // Only fire action if finger released within 20px of start position
        if let touch = touch, let startLocation = touchStartLocation {
            let releaseLocation = touch.location(in: self)
            let distance = hypot(releaseLocation.x - startLocation.x,
                               releaseLocation.y - startLocation.y)

            if distance <= threshold {
                onTap?()
            }
        }

        touchStartLocation = nil
    }

    /// Called when touch is cancelled by system (e.g., scroll gesture started)
    override func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)

        onPressedChanged?(false)
        touchStartLocation = nil
    }
}

// MARK: - Alternative: Button-Style Scroll-Friendly Wrapper

/// A button-style wrapper that provides scroll-friendly tap behavior.
///
/// Use this when you need a simple tappable element that won't block scrolling.
///
/// # Example
/// ```swift
/// ScrollFriendlyButton(action: { print("Tapped") }) {
///     Text("Tap Me")
///         .padding()
///         .background(Color.blue)
/// }
/// ```
@available(iOS 15, *)
public struct ScrollFriendlyButton<Content: View>: View {
    private let action: () -> Void
    private let content: Content

    @State private var isPressed = false

    public init(
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.action = action
        self.content = content()
    }

    public var body: some View {
        content
            .opacity(isPressed ? 0.7 : 1.0)
            .scrollFriendlyTap(
                onPressedChanged: { pressed in
                    isPressed = pressed
                },
                action: action
            )
    }
}

// MARK: - Documentation

/*
 # Design Rationale

 ## Why This Approach?

 1. **Native iOS Feel**: UIButton in UIScrollView works perfectly - instant feedback,
    no scroll blocking. SwiftUI gestures (.onTapGesture, .gesture) block scrolling.

 2. **User Expectation**: Users expect to be able to start a scroll gesture
    anywhere on screen, including on interactive elements.

 3. **Instant Visual Feedback**: UIControl tracking methods are SYNCHRONOUS.
    Called during touch delivery, before gesture recognizers. Zero delay.

 4. **Scroll Compatibility**: UIScrollView doesn't delay touches for UIControl subclasses.
    Built-in iOS behavior - controls work naturally in scroll views.

 5. **Distance-Based Actions**: endTracking checks if release position is within
    20px of start. Action only fires for taps, not swipes.

 ## Technical Implementation

 ### Why UIControl Tracking Works

 UIControl tracking methods are called SYNCHRONOUSLY during touch delivery:
 - `beginTracking`: Called instantly when finger touches screen (before gesture recognizers)
 - `continueTracking`: Track movement to detect scrolling intent
 - `endTracking`: Fire action only if no scroll detected
 - `cancelTracking`: Clean up if system cancels touch

 **Critical Difference from UIView touch methods:**
 - UIControl methods are synchronous (no dispatch queues needed)
 - Called BEFORE gesture recognizers run
 - UIScrollView automatically doesn't delay touches for UIControl subclasses
 - This is how UIButton achieves instant highlighting in scroll views

 ### State Management

 We track touch state using UIControl's tracking lifecycle:
 - `beginTracking`: Store start location, fire onPressedChanged(true) SYNCHRONOUSLY
 - `continueTracking`: Just return true (keep tracking, don't cancel early)
 - `endTracking`: Fire onPressedChanged(false), check release position, fire action if ≤20px from start
 - `cancelTracking`: Fire onPressedChanged(false) when system cancels (scroll started)

 Implementation:
 ```swift
 override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
     touchStartLocation = touch.location(in: self)
     onPressedChanged?(true)  // SYNCHRONOUS - instant, zero delay
     return true
 }

 override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
     return true  // Keep tracking (don't cancel during movement)
 }

 override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
     onPressedChanged?(false)

     // Only fire if finger released within 20px of start position
     let releaseLocation = touch.location(in: self)
     let distance = hypot(releaseLocation.x - startLocation.x,
                         releaseLocation.y - startLocation.y)
     if distance <= 20 {
         action()
     }
 }

 override func cancelTracking(with event: UIEvent?) {
     onPressedChanged?(false)  // Called when scroll gesture starts
 }
 ```

 This provides TRUE instant visual feedback (synchronous callbacks) while allowing
 scrolling to work perfectly (UIControl + UIScrollView integration).

 ## When to Use

 - ✅ Buttons, chips, badges in ScrollViews or Lists
 - ✅ Interactive cards that should scroll
 - ✅ Form controls (switches, checkboxes) in scrollable forms
 - ❌ Components explicitly designed to prevent scrolling (e.g., slider)
 - ❌ Full-screen tap areas where scrolling isn't relevant

 ## Performance

 UIControl tracking is the most efficient approach:
 - Tracking methods called synchronously (no async dispatch overhead)
 - Minimal processing - just distance calculations
 - No gesture recognizer competition or conflict resolution
 - UIScrollView receives touches without interference or delays

 This is the same mechanism UIButton uses, providing native iOS performance
 and the smoothest possible scrolling experience.

 ## Testing

 To test if this is working correctly:
 1. Place component in a ScrollView
 2. Tap component → Visual feedback INSTANT (no delay), action fires on release
 3. Touch component → Visual feedback appears IMMEDIATELY (synchronous)
 4. Touch and drag, release >20px away → No action fires (swipe detected)
 5. Touch and drag, release <20px away → Action fires (still considered tap)
 6. Start scrolling while touching → Pressed state cancels, scroll works
 7. Short quick taps → Action fires reliably every time
 8. No perceptible delay between touch and visual feedback
 9. Scrolling works smoothly even when touch starts on interactive element
 */

#endif
