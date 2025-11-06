# Component Development Guide

## Problem Statement

When developing new components incrementally, incomplete token definitions or component implementations can break the entire build, requiring manual file disabling and wasting development time.

## Solution: Conditional Compilation Strategy

Use Swift's conditional compilation to isolate in-development components from stable ones.

---

## Implementation Method

### 1. Use Build Flags for In-Development Components

All new/incomplete components should be wrapped in conditional compilation:

```swift
#if ELEVATE_DEV_COMPONENTS
// Component implementation here
#endif
```

### 2. File Naming Convention

Use a clear naming pattern:

- **Stable Components**: `ElevateButton+SwiftUI.swift`
- **In-Development**: `ElevateRadio+SwiftUI.swift.wip` (renamed to `.swift` when ready)
- **Tokens**: `RadioTokens.swift.wip` (renamed when complete)

### 3. Component Development Checklist

Before implementing a new component, complete these steps **in order**:

#### Phase 1: Token Preparation
- [ ] Generate token definitions from design system
- [ ] Verify all token properties exist in generated files
- [ ] Create wrapper token file (e.g., `RadioTokens.swift`)
- [ ] Test that tokens compile independently
- [ ] Commit tokens to a separate branch

#### Phase 2: Component Scaffolding
- [ ] Create component file with `.wip` extension
- [ ] Wrap all code in `#if ELEVATE_DEV_COMPONENTS`
- [ ] Import required tokens
- [ ] Define basic structure
- [ ] Test compilation with dev flag enabled

#### Phase 3: Implementation
- [ ] Implement component logic
- [ ] Add SwiftUI previews
- [ ] Test in isolation
- [ ] Document usage

#### Phase 4: Activation
- [ ] Remove `.wip` extension
- [ ] Remove `#if ELEVATE_DEV_COMPONENTS` wrapper
- [ ] Update ComponentRegistry to mark as implemented
- [ ] Add to component showcase
- [ ] Commit to main branch

---

## Build Configuration Setup

### Option A: Using .wip Extensions (Recommended for ElevateUI)

**Advantages:**
- No build configuration needed
- Files with `.wip` aren't compiled by Xcode
- Simple to enable: just rename file
- Clear visual indicator in file browser

**Workflow:**
```bash
# Start new component
touch ElevateUI/Sources/SwiftUI/Components/ElevateRadio+SwiftUI.swift.wip
touch ElevateUI/Sources/DesignTokens/Components/RadioTokens.swift.wip

# When ready to test
mv ElevateRadio+SwiftUI.swift.wip ElevateRadio+SwiftUI.swift
mv RadioTokens.swift.wip RadioTokens.swift

# If it breaks something, quickly disable
mv ElevateRadio+SwiftUI.swift ElevateRadio+SwiftUI.swift.wip
mv RadioTokens.swift RadioTokens.swift.wip
```

### Option B: Conditional Compilation Flags

Add to Package.swift or Xcode build settings:

```swift
// In Package.swift
.define("ELEVATE_DEV_COMPONENTS", .when(configuration: .debug))
```

**Workflow:**
```swift
// In component file
#if ELEVATE_DEV_COMPONENTS
@available(iOS 15, *)
public struct ElevateRadio<Content: View>: View {
    // Implementation
}
#endif

// In token file
#if ELEVATE_DEV_COMPONENTS
public struct RadioTokens {
    // Tokens
}
#endif
```

---

## Quick Reference: Adding a New Component

### Recommended Workflow (Using .wip)

1. **Create Token File (WIP)**
```bash
touch ElevateUI/Sources/DesignTokens/Components/NewComponentTokens.swift.wip
```

2. **Implement Tokens**
- Copy from existing component as template
- Update to match design system specs
- Test compilation: `mv ...wip ...; xcodebuild; mv ... ...wip`

3. **Create Component File (WIP)**
```bash
touch ElevateUI/Sources/SwiftUI/Components/ElevateNewComponent+SwiftUI.swift.wip
```

4. **Implement Component**
- Use stable components as reference
- Test incrementally

5. **Activate When Ready**
```bash
mv ElevateUI/Sources/DesignTokens/Components/NewComponentTokens.swift.wip NewComponentTokens.swift
mv ElevateUI/Sources/SwiftUI/Components/ElevateNewComponent+SwiftUI.swift.wip ElevateNewComponent+SwiftUI.swift
```

6. **Update Registry**
```swift
// In ComponentRegistry.swift
ComponentItem(id: "new-component", name: "New Component",
              isImplemented: true, hasSwiftUI: true, hasUIKit: false)
```

---

## Current Component Status

### Stable Components
- ✅ ElevateButton (SwiftUI, UIKit)
- ✅ ElevateBadge (SwiftUI, UIKit)
- ✅ ElevateChip (SwiftUI, UIKit)

### Disabled Components (Missing/Incomplete Tokens)
- ⚠️ ElevateCheckbox - Missing token definitions
- ⚠️ ElevateSwitch - Missing token definitions
- ⚠️ ElevateRadio - Missing token definitions

**To Re-enable:** Fix token generation, then rename `.disabled` files back to `.swift`

---

## Troubleshooting

### Build Fails After Adding Component

**Symptom:** `Cannot find type 'ComponentTokens' in scope`

**Fix:**
```bash
# Quickly disable the problematic files
mv ProblemComponent.swift ProblemComponent.swift.wip
mv ProblemTokens.swift ProblemTokens.swift.wip
```

### Token Mismatch Errors

**Symptom:** `Type 'ComponentTokens' has no member 'propertyName'`

**Cause:** Generated tokens don't match component expectations

**Fix:**
1. Check generated token file structure
2. Update component to match available tokens
3. OR update token generation script
4. Document expected token structure

### Cascade Build Failures

**Symptom:** Many files fail because one component is broken

**Prevention:**
- Always use `.wip` extension during development
- Test token files independently before creating components
- Use git branches for experimental work

---

## Best Practices

1. **Never commit broken components** - Use `.wip` during development
2. **Test tokens first** - Verify they compile before writing components
3. **One component at a time** - Don't develop multiple components in parallel
4. **Document dependencies** - Note which tokens a component needs
5. **Use templates** - Copy from working components, don't start from scratch

---

## File Organization

```
ElevateUI/
├── Sources/
│   ├── DesignTokens/
│   │   ├── Components/
│   │   │   ├── ButtonTokens.swift          ✅ Stable
│   │   │   ├── BadgeTokens.swift           ✅ Stable
│   │   │   ├── RadioTokens.swift.wip       🚧 In Development
│   │   │   └── RadioTokens.swift.disabled  ⚠️ Broken - Needs Fix
│   │   └── Generated/
│   │       └── RadioComponentTokens.swift  ✅ Auto-generated
│   └── SwiftUI/
│       └── Components/
│           ├── ElevateButton+SwiftUI.swift         ✅ Stable
│           ├── ElevateRadio+SwiftUI.swift.wip      🚧 In Development
│           └── ElevateCheckbox+SwiftUI.swift.disabled ⚠️ Broken
```

---

## Token Generation Workflow

When design tokens change:

1. Run token generation script
2. Verify generated files compile
3. Update wrapper token files if needed
4. Test components that depend on changed tokens
5. Fix any breaking changes
6. Commit all together

**Never commit:**
- Generated tokens without testing
- Components without their token dependencies
- Mixed stable + broken components

---

## Summary

**Key Principle:** Isolate in-development work from stable components

**Method:** Use `.wip` file extensions to exclude incomplete code from builds

**Benefit:** No more build breakage, no more manual file disabling, no wasted tokens

**When Ready:** Simply rename `.wip` to `.swift` and the component activates

---

## Scroll-Friendly Gesture Pattern

### The Problem

Interactive components (buttons, chips, switches, etc.) can block scroll gestures when users start their swipe on the component rather than the background. This creates a poor user experience where scrolling only works when swiping on empty space.

### iOS Standard Behavior

In native iOS apps, interactive elements don't block scrolling. Users can start a scroll gesture on a button and the scroll works fine. Only if they tap without moving should the component action fire.

### The Solution

All interactive ELEVATE components use a **scroll-friendly tap gesture** that distinguishes between:

- **Tap**: User touches and releases without significant movement (< 10pt) → Trigger action
- **Scroll**: User touches and moves significantly (≥ 10pt) → Allow scroll, don't trigger action

### Implementation

ELEVATE provides a reusable `scrollFriendlyTap` modifier in `ScrollFriendlyGestures.swift`:

```swift
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        // Optional: Update visual pressed state
        isPressed = pressed
    },
    action: {
        // Your component action
        print("Tapped!")
    }
)
```

### Usage in Components

#### Button-Like Components (Button, Chip)

Replace `Button` wrapper with direct view + `scrollFriendlyTap`:

```swift
// ❌ Before (blocks scrolling)
Button(action: { doSomething() }) {
    Text("Tap Me")
}

// ✅ After (scroll-friendly)
Text("Tap Me")
    .scrollFriendlyTap(action: { doSomething() })
```

#### Components with Pressed States

Use `onPressedChanged` callback for visual feedback:

```swift
@State private var isPressed = false

var body: some View {
    HStack {
        // ... content
    }
    .scaleEffect(isPressed ? 0.98 : 1.0)
    .scrollFriendlyTap(
        onPressedChanged: { pressed in
            if !isDisabled {
                isPressed = pressed
            }
        },
        action: {
            if !isDisabled {
                performAction()
            }
        }
    )
}
```

#### Remove Buttons and Small Tap Targets

Even small interactive elements should be scroll-friendly:

```swift
// Clear button in TextField
Image(systemName: "xmark.circle.fill")
    .scrollFriendlyTap(action: clearText)
    .accessibilityLabel("Clear text")

// Remove button in Chip
Image(systemName: "xmark")
    .scrollFriendlyTap {
        onRemove?()
    }
```

### When NOT to Use

- **Non-interactive components**: Badge, Divider, etc. don't need gesture handling
- **Native text input**: TextField/TextArea already handle this correctly
- **Explicitly blocking gestures**: Components designed to prevent scrolling (e.g., sliders, custom drag interactions)

### Component Checklist

When implementing a new interactive component:

- [ ] Identify all tappable/interactive areas
- [ ] Replace `Button` wrappers with `scrollFriendlyTap`
- [ ] Replace `.onTapGesture` with `scrollFriendlyTap`
- [ ] Test in a ScrollView - verify both tapping and scrolling work
- [ ] Add disabled state handling in action closure
- [ ] Use `onPressedChanged` for visual pressed feedback if needed

### Testing Your Implementation

Create a test view with multiple components in a ScrollView:

```swift
ScrollView {
    VStack(spacing: 20) {
        ForEach(0..<20) { i in
            ElevateButton("Button \(i)") { print("Tapped \(i)") }
        }
    }
    .padding()
}
```

**Test Cases:**
1. ✅ Tap a button → Action fires
2. ✅ Start swipe on button, move >10pt → Scrolls without firing action
3. ✅ Start swipe on button, move <10pt, release → Action fires (it was a tap)
4. ✅ Disabled components don't respond to taps
5. ✅ Pressed state appears immediately on touch, cancels on scroll

### Technical Details

The `scrollFriendlyTap` modifier uses `DragGesture(minimumDistance: 0)` to track touch movement:

- **10pt threshold**: Experimentally determined to match iOS standard behavior
- **Zero minimum distance**: Allows immediate tracking of touch position
- **Translation distance**: Calculates `sqrt(width² + height²)` to detect movement in any direction
- **State management**: Tracks drag start position, cancels on threshold exceeded

This approach provides native iOS feel while maintaining ELEVATE design system compliance.

---

## Updated Component Implementation Pattern

```swift
#if os(iOS)
import SwiftUI

/// ELEVATE YourComponent
@available(iOS 15, *)
public struct ElevateYourComponent: View {
    // MARK: - Properties
    private let action: () -> Void
    private let isDisabled: Bool

    // MARK: - State
    @State private var isPressed = false

    // MARK: - Body
    public var body: some View {
        HStack {
            // ... content
        }
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .scrollFriendlyTap(
            onPressedChanged: { pressed in
                if !isDisabled {
                    isPressed = pressed
                }
            },
            action: {
                if !isDisabled {
                    action()
                }
            }
        )
        .allowsHitTesting(!isDisabled)
        .accessibilityAddTraits(.isButton)
    }
}
#endif
```
