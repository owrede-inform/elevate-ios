# iOS Touch Interaction Guidelines

**Status**: Core Guidelines ✅
**Since**: v0.1.0
**Reference**: Apple Human Interface Guidelines

---

## iOS Touch Fundamentals

### Touch vs Click

| Aspect | Web (Mouse/Click) | iOS (Touch) |
|--------|-------------------|-------------|
| **Hover State** | ✅ Mouse can hover | ❌ No hover (finger either touches or doesn't) |
| **Precision** | High (cursor pixel-perfect) | Low (finger ~44pt area) |
| **Feedback** | Visual on hover | Visual on touch |
| **Target Size** | Can be small | Minimum 44pt × 44pt |
| **Scrolling** | Separate scrollbar | Direct manipulation (drag) |

### Key Principles

1. **Direct Manipulation**: User directly touches what they want to interact with
2. **Immediate Feedback**: Visual response must be instant (< 100ms perceived)
3. **Forgiving Targets**: Touch targets must be large enough for fingers
4. **Clear Affordances**: User must know what's tappable

---

## Touch Target Sizing

### Minimum Sizes (Apple HIG)

**Absolute Minimum**: 44pt × 44pt

**Recommended**:
- Buttons: 44pt × 44pt minimum
- Icons: 44pt × 44pt tap area (icon can be smaller inside)
- List items: Full width × 44pt minimum height
- Text fields: Height 44pt minimum

### Implementation

```swift
// ✅ Meets minimum
.frame(minWidth: 44, minHeight: 44)

// ✅ Common pattern: smaller visual, larger tap area
Image(systemName: "trash")
    .font(.system(size: 16))          // 16pt icon
    .frame(width: 44, height: 44)      // 44pt tap target
    .contentShape(Rectangle())         // Full frame tappable

// ❌ Too small
.frame(width: 30, height: 30)
```

### Web to iOS Translation

| Web Size | iOS Adjustment | Reason |
|----------|----------------|--------|
| 32px height | → 36pt | Below minimum, increase to safe size |
| 40px height | → 44pt | Close but below minimum |
| 48px height | → 48pt | Already meets minimum, keep |
| Icon 16px | → 44pt tap area | Icon small, but tap area must be 44pt |

**Formula**: If `webHeight < 44pt`, use `44pt` in iOS.

---

## Visual Feedback Requirements

### Timing Requirements

| Feedback Type | Max Delay | Target |
|---------------|-----------|--------|
| Pressed state | 100ms | < 50ms ideal |
| Action result | 200ms | < 100ms ideal |
| Animation | 300ms | 150-250ms typical |

### Implementation

**❌ Delayed Feedback** (feels unresponsive):
```swift
Button("Tap") { }
    .buttonStyle(.bordered)
// iOS Button has ~150ms delay in pressed state
```

**✅ Instant Feedback** (feels responsive):
```swift
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isPressed = pressed  // Synchronous update
        }
    },
    action: { }
)
```

### Visual State Changes

**Required states**:
- Default (resting)
- Pressed (touch down)
- Disabled (can't interact)

**Optional states**:
- Selected (toggle on)
- Focused (keyboard/VoiceOver)

**Implementation**:
```swift
private var backgroundColor: Color {
    if isDisabled {
        return disabledColor
    } else if isPressed {
        return pressedColor     // MUST be different
    } else if isSelected {
        return selectedColor
    } else {
        return defaultColor
    }
}
```

---

## Gestures & Scrolling

### The Fundamental Conflict

**Problem**: Interactive elements inside scrollable containers.

| User Intent | Start Touch | Movement | End Touch |
|-------------|-------------|----------|-----------|
| **Tap button** | On button | < 20pt | On button |
| **Scroll list** | Anywhere | > 20pt | Anywhere |

**Challenge**: How does system know intent at touch start?

### Wrong Approaches

#### 1. Block Scrolling (Bad UX)

```swift
// ❌ Blocks scrolling
.onTapGesture {
    action()
}
```

**Result**: Can't scroll if finger starts on button.

#### 2. Delay Touch Recognition (Bad UX)

```swift
// ❌ Delayed feedback
Button("Tap") { action() }
```

**Result**: 150ms delay before pressed state appears.

### ✅ Correct Approach: Scroll-Friendly Gestures

**Solution**: Use UIControl tracking with distance threshold.

```swift
.scrollFriendlyTap(
    threshold: 20.0,           // Distance threshold
    onPressedChanged: { pressed in
        isPressed = pressed     // Instant feedback
    },
    action: {
        action()                // Only if <20pt movement
    }
)
```

**Behavior**:
- Touch down → Instant visual feedback
- Drag <20pt → Still pressed, action fires on release
- Drag >20pt → Pressed cancels, scroll starts
- System decides dynamically based on movement

See: `.claude/concepts/scroll-friendly-gestures.md`

---

## Touch vs Hover State Mapping

### Web States

```css
button {
    /* Default */
    background: blue;
}

button:hover {
    /* Mouse over */
    background: lightblue;
}

button:active {
    /* Mouse down */
    background: darkblue;
}
```

### iOS Mapping

iOS has NO `:hover` state. Map like this:

| Web State | iOS State | Implementation |
|-----------|-----------|----------------|
| Default | `!isPressed` | Default colors |
| `:hover` | `isPressed` | Combine with active |
| `:active` | `isPressed` | Same as hover |
| `:disabled` | `isDisabled` | Distinct state |
| `.selected` | `isSelected` | Distinct state |

**Example**:
```swift
// ✅ Combine hover + active into single pressed state
private var buttonColor: Color {
    if isDisabled {
        return disabledColor
    } else if isPressed {
        return hoverColor // Use hover color from web for pressed
    } else {
        return defaultColor
    }
}
```

---

## iOS-Specific Patterns

### 1. Pull to Refresh

**Web**: Usually a button "Refresh".

**iOS**: Pull down gesture at top of list.

```swift
List {
    // items
}
.refreshable {
    await loadData()
}
```

### 2. Swipe Actions

**Web**: Buttons or menus.

**iOS**: Swipe left/right on list items.

```swift
.swipeActions(edge: .trailing) {
    Button("Delete", role: .destructive) {
        delete()
    }
}
```

### 3. Context Menus

**Web**: Right-click menu.

**iOS**: Long-press menu.

```swift
.contextMenu {
    Button("Copy") { copy() }
    Button("Share") { share() }
    Button("Delete", role: .destructive) { delete() }
}
```

### 4. Navigation Gestures

**Web**: Back button clicks.

**iOS**: Swipe from left edge.

Built-in with `NavigationView`/`NavigationStack`.

---

## Accessibility Considerations

### VoiceOver Support

**Required for all interactive elements**:

```swift
.accessibilityElement(children: .combine)
.accessibilityLabel("Submit")          // What it is
.accessibilityHint("Submit the form")  // What it does (optional)
.accessibilityAddTraits(.isButton)     // Type
.accessibilityAddTraits(isSelected ? [.isSelected] : [])
```

**Touch Targets**: Even more critical for accessibility users.

- VoiceOver users navigate by touch exploration
- Larger targets easier to find
- Clear labels essential

### Dynamic Type

Support user font size preferences:

```swift
// ✅ Scales with user preference
Text("Button")
    .font(.body)

// ❌ Fixed size
Text("Button")
    .font(.system(size: 16))
```

### Reduced Motion

Respect user motion preferences:

```swift
@Environment(\.accessibilityReduceMotion) var reduceMotion

var animation: Animation? {
    reduceMotion ? nil : .easeInOut
}

.animation(animation, value: someState)
```

---

## Performance Guidelines

### Touch Response Budget

From touch to visible feedback:

| Phase | Budget | Notes |
|-------|--------|-------|
| Touch detection | 0-5ms | Hardware level |
| Hit testing | 5-10ms | Find touched view |
| Event delivery | 10-15ms | Call touch method |
| State update | 15-20ms | Update @State |
| View re-render | 20-36ms | Next frame (60Hz) |
| **Total perceived** | **~36ms** | **< 100ms feels instant** |

### Optimization Tips

1. **Avoid async in touch handlers**:
   ```swift
   // ❌ Adds delay
   onPressedChanged: { pressed in
       DispatchQueue.main.async {
           isPressed = pressed
       }
   }

   // ✅ Synchronous
   onPressedChanged: { pressed in
       isPressed = pressed
   }
   ```

2. **Disable animations for pressed state**:
   ```swift
   // ✅ No animation delay
   var transaction = Transaction()
   transaction.disablesAnimations = true
   withTransaction(transaction) {
       isPressed = pressed
   }
   ```

3. **Minimize view hierarchy depth**:
   - Fewer views = faster hit-testing
   - Flatten when possible

---

## Common Patterns

### Toggle Button

```swift
struct ToggleButton: View {
    @Binding var isOn: Bool
    @State private var isPressed = false

    var body: some View {
        Text(isOn ? "On" : "Off")
            .padding()
            .background(backgroundColor)
            .scrollFriendlyTap(
                onPressedChanged: { isPressed = $0 },
                action: { isOn.toggle() }
            )
    }

    private var backgroundColor: Color {
        if isOn {
            return isPressed ? selectedPressedColor : selectedColor
        } else {
            return isPressed ? pressedColor : defaultColor
        }
    }
}
```

### Action Sheet Trigger

```swift
struct ActionButton: View {
    @State private var showingActions = false

    var body: some View {
        ElevateButton("More", tone: .neutral) {
            showingActions = true
        }
        .confirmationDialog("Choose action", isPresented: $showingActions) {
            Button("Edit") { edit() }
            Button("Share") { share() }
            Button("Delete", role: .destructive) { delete() }
        }
    }
}
```

### Scroll to Top

```swift
struct ScrollToTopButton: View {
    let scrollProxy: ScrollViewProxy

    var body: some View {
        Button {
            withAnimation {
                scrollProxy.scrollTo("top", anchor: .top)
            }
        } label: {
            Image(systemName: "arrow.up")
        }
    }
}
```

---

## Testing Touch Interactions

### Manual Testing

- [ ] Touch target is minimum 44pt × 44pt
- [ ] Visual feedback appears instantly (< 100ms perceived)
- [ ] Tap fires action reliably
- [ ] Quick taps (< 100ms) register
- [ ] Can scroll when touch starts on element
- [ ] Drag >20pt = scroll, not action
- [ ] Drag <20pt = action fires
- [ ] VoiceOver announces correctly
- [ ] Works with VoiceOver gestures

### Automated Testing

```swift
func testButtonTap() {
    let app = XCUIApplication()
    let button = app.buttons["Submit"]

    XCTAssertTrue(button.exists)
    button.tap()
    XCTAssertTrue(actionWasFired)
}

func testScrolling() {
    let app = XCUIApplication()
    let scrollView = app.scrollViews.firstMatch
    let button = app.buttons["Submit"]

    // Should be able to scroll starting from button
    button.press(forDuration: 0.1, thenDragTo: topOfScreen)
    // Verify scroll happened
}
```

---

## Migration from Web

### Checklist

When converting web component to iOS:

- [ ] Remove `:hover` styles (combine with `:active`)
- [ ] Increase touch targets to 44pt minimum
- [ ] Change click handlers to touch handlers
- [ ] Use scroll-friendly gestures for scrollable content
- [ ] Add VoiceOver accessibility
- [ ] Test with Dynamic Type sizes
- [ ] Consider swipe actions instead of buttons
- [ ] Use native gestures (pull-to-refresh, swipe-back)

### Pattern Translations

| Web Pattern | iOS Pattern |
|-------------|-------------|
| Button hover effect | Button pressed state |
| Right-click menu | Long-press context menu |
| Tooltip on hover | Long-press hint or Help button |
| Drag-and-drop | Drag gesture with visual lift |
| Double-click | Double-tap gesture |
| Keyboard shortcuts | Hardware keyboard support (optional) |

---

## Related Documentation

- **Scroll-Friendly Gestures**: `.claude/concepts/scroll-friendly-gestures.md`
- **Component Implementation**: `.claude/components/Navigation/button-ios-implementation.md`
- **Design Token Hierarchy**: `.claude/concepts/design-token-hierarchy.md`

---

## References

- [Apple Human Interface Guidelines - Gestures](https://developer.apple.com/design/human-interface-guidelines/gestures)
- [Apple HIG - Buttons](https://developer.apple.com/design/human-interface-guidelines/buttons)
- [Apple HIG - Accessibility](https://developer.apple.com/design/human-interface-guidelines/accessibility)
- [UIControl Documentation](https://developer.apple.com/documentation/uikit/uicontrol)
