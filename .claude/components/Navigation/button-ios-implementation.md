# Button Component - iOS Implementation Guide

**Web Component:** `<elvt-button>`
**iOS Components:** `ElevateButton` (SwiftUI), `ElevateUIKitButton` (UIKit)
**Component Tokens:** `ButtonComponentTokens`
**Wrapper Tokens:** `ButtonTokens`

---

## Component Token Mapping

### Token Hierarchy

The button implementation follows the strict 3-tier token hierarchy:

```
Component Tokens (ButtonComponentTokens)
    ↓ references
Alias Tokens (ElevateAliases)
    ↓ references
Primitive Tokens (ElevatePrimitives)
```

**CRITICAL**: Always use Component Tokens first. Never use Primitive Tokens directly.

---

## Anatomy & Token Application

### Visual Structure

```
┌─────────────────────────────────────────┐
│  ┌────────┐                             │ ← Border (border_[tone]_color_[state])
│  │ Prefix │  Label Text  ┌────────┐    │
│  │  Icon  │              │ Suffix │    │
│  └────────┘              │  Icon  │    │
│                          └────────┘    │
└─────────────────────────────────────────┘
       ↑            ↑            ↑
     prefix       label        suffix
       gap    (horizontal)      gap
```

### Token Application Map

| Visual Element | CSS Property | Component Token | iOS Property | iOS Value |
|----------------|--------------|-----------------|--------------|-----------|
| **Container** |
| Background | `background-color` | `fill_[tone]_[state]` | `.background()` | Color |
| Border | `border-color` | `border_[tone]_color_[state]` | `.strokeBorder()` | Color |
| Border width | `border-width` | `border_width_default` | `lineWidth` | CGFloat (1.0) |
| Corner radius | `border-radius` | `border_radius` | `.cornerRadius()` | CGFloat (4.0) |
| Height | `height` | N/A (size-based) | `.frame(height:)` | CGFloat |
| **Typography** |
| Text color | `color` | `label_[tone]_[state]` | `.foregroundColor()` | Color |
| Font size | `font-size` | N/A (size-based) | `.font()` | Font (14-18pt) |
| **Spacing** |
| Horizontal padding | `padding-inline` | N/A (size-based) | `.padding()` | EdgeInsets |
| Icon-text gap | `gap` | N/A (size-based) | `spacing:` | CGFloat |

---

## CSS to iOS Parameter Translation

### Size Configurations

Web uses `rem` units (1rem = 16px). iOS uses **points** directly.

**Translation Rule**: `rem * 16 = pixels` → Adjust for iOS touch targets (minimum 44pt)

| Size | Web Height | iOS Height | Web Padding | iOS Padding | Web Gap | iOS Gap |
|------|-----------|------------|-------------|-------------|---------|---------|
| Small | 2rem (32px) | **36pt** | 0.75rem (12px) | 12pt | 0.25rem (4px) | 4pt |
| Medium | 2.5rem (40px) | **44pt** | 0.75rem (12px) | 12pt | 0.5rem (8px) | 8pt |
| Large | 3rem (48px) | **52pt** | 1.25rem (20px) | 16pt | 0.75rem (12px) | 12pt |

**iOS Adjustment**: Heights increased to meet iOS minimum touch target of 44pt.

### Border Radius

| Shape | Web | iOS |
|-------|-----|-----|
| Box | 0.25rem (4px) | 4pt |
| Pill | 9999px | `.infinity` |

---

## Component Token Reference

### Tone Color Tokens

Each tone has tokens for different states:

#### Primary Tone

```swift
// Fill (background)
ButtonComponentTokens.fill_primary_default
ButtonComponentTokens.fill_primary_hover           // iOS: active state
ButtonComponentTokens.fill_primary_active          // iOS: pressed state
ButtonComponentTokens.fill_primary_disabled_default
ButtonComponentTokens.fill_primary_selected_default
ButtonComponentTokens.fill_primary_selected_active

// Label (text)
ButtonComponentTokens.label_primary_default
ButtonComponentTokens.label_primary_hover
ButtonComponentTokens.label_primary_active
ButtonComponentTokens.label_primary_disabled_default
ButtonComponentTokens.label_primary_selected_default
ButtonComponentTokens.label_primary_selected_active
```

#### All Tones Follow Same Pattern

- `primary` - Main call-to-action
- `success` - Positive/confirmation actions
- `warning` - Caution actions
- `danger` - Destructive actions
- `emphasized` - High visibility with border
- `subtle` - Low emphasis
- `neutral` - Default/secondary actions

### Border Tokens

Only `emphasized` and `neutral` tones have borders:

```swift
ButtonComponentTokens.border_emphasized_color_default
ButtonComponentTokens.border_emphasized_color_selected_default
ButtonComponentTokens.border_neutral_color_default
ButtonComponentTokens.border_neutral_color_selected_default
ButtonComponentTokens.border_width_default  // 1.0
```

---

## iOS-Specific Adaptations

### 1. Touch Interaction (Scroll-Friendly Gestures)

**Problem**: Standard SwiftUI gestures block scrolling when touch starts on button.

**Solution**: Custom `UIControl` subclass with instant visual feedback.

**Implementation**:
```swift
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        // Instant state update (synchronous)
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isPressed = pressed
        }
    },
    action: {
        // Fires only if release within 20px of touch start
        action()
    }
)
```

**Behavior**:
- Touch down → Instant visual feedback (no delay)
- Touch moves >20px → Allows scrolling, cancels press
- Touch up within 20px → Fires action
- Scroll starts → System cancels touch automatically

**Reference**: See `.claude/concepts/scroll-friendly-gestures.md` *(to be created)*

### 2. State Mapping

| Web State | iOS State | Notes |
|-----------|-----------|-------|
| `:hover` | `isPressed` | iOS has no hover; uses pressed for touch |
| `:active` | `isPressed` | Combined with hover for single pressed state |
| `:disabled` | `isDisabled` | Same concept |
| `.selected` | `isSelected` | Same concept |

**iOS Simplification**: Web has `hover` AND `active` states. iOS combines these into single `isPressed` state.

### 3. No Link Behavior

Web buttons support `href` attribute for link behavior. iOS buttons are action-only.

**iOS Pattern**: Use `NavigationLink` wrapper or handle navigation in action callback:

```swift
NavigationLink(destination: DetailView()) {
    ElevateButton("Go to Detail", tone: .primary) { }
}

// Or
ElevateButton("Go to Detail", tone: .primary) {
    navigator.push(DetailView())
}
```

### 4. Immediate State Updates

**Web**: Can animate color transitions smoothly with CSS.

**iOS Issue**: SwiftUI animations add perceptible delay to pressed state.

**Solution**: Force immediate updates with `Transaction(disablesAnimations: true)`.

This ensures button feels responsive like native iOS buttons (UIButton).

---

## Implementation Structure

### ButtonTokens.swift

**Purpose**: Wrapper around `ButtonComponentTokens` with convenience methods and size configurations.

**Structure**:
```swift
public struct ButtonTokens {
    // Enums
    public enum Tone { case primary, success, warning, danger, emphasized, subtle, neutral }
    public enum Size { case small, medium, large }
    public enum Shape { case `default`, pill }

    // Size configuration
    public struct SizeConfig {
        let height: CGFloat
        let fontSize: CGFloat
        let horizontalPadding: CGFloat
        let gap: CGFloat
        let minTouchTarget: CGFloat
    }

    // Tone colors (wraps Component Tokens)
    public struct ToneColors {
        let background: Color              // fill_[tone]_default
        let backgroundActive: Color        // fill_[tone]_active
        let backgroundDisabled: Color      // fill_[tone]_disabled_default
        let backgroundSelected: Color      // fill_[tone]_selected_default
        let text: Color                    // label_[tone]_default
        let textActive: Color              // label_[tone]_active
        let textDisabled: Color            // label_[tone]_disabled_default
        // ... etc
    }
}
```

### ElevateButton+SwiftUI.swift

**Purpose**: SwiftUI button component implementation.

**State Management**:
```swift
@State private var isPressed = false

private var tokenBackgroundColor: Color {
    if isDisabled {
        return toneColors.backgroundDisabled
    } else if isSelected {
        return isPressed ? toneColors.backgroundSelectedActive : toneColors.backgroundSelected
    } else if isPressed {
        return toneColors.backgroundActive
    } else {
        return toneColors.background
    }
}
```

**Token Resolution Flow**:
1. Determine state (disabled, selected, pressed, default)
2. Get `ToneColors` for current tone
3. Select appropriate color token for state
4. Apply to view

---

## Design Principles

### Token Usage

1. **Always use Component Tokens first**
   - ✅ `ButtonComponentTokens.fill_primary_default`
   - ❌ `ElevateAliases.Action.Primary.fill_default`
   - ❌ `ElevatePrimitives.Blue._600`

2. **Use Alias Tokens only when Component Tokens don't exist**
   - Example: App background color (no component token exists)

3. **Never use Primitive Tokens directly**
   - They don't handle dark mode
   - Break the design system hierarchy

### iOS Touch Guidelines

1. **Minimum Touch Target**: 44pt × 44pt (iOS HIG requirement)
2. **Instant Feedback**: Visual response must be synchronous (no delay)
3. **Scroll Compatibility**: Buttons in ScrollViews must allow scrolling
4. **Clear States**: Disabled, selected, and pressed states must be visually distinct

### Accessibility

```swift
.accessibilityElement(children: .combine)
.accessibilityLabel(label)
.accessibilityAddTraits(isSelected ? [.isSelected] : [])
.accessibilityAddTraits(.isButton)
.allowsHitTesting(!isDisabled)
```

VoiceOver will announce: "[Label], button, selected" (if selected).

---

## Testing Checklist

### Visual States

- [ ] Default state matches design tokens
- [ ] Pressed state appears instantly (no delay)
- [ ] Selected state visually distinct
- [ ] Disabled state clearly muted
- [ ] Dark mode uses correct token values

### Interaction

- [ ] Tap fires action reliably
- [ ] Quick taps register (no missed taps)
- [ ] Can scroll when touch starts on button
- [ ] Touch >20px from start = scroll, not action
- [ ] Touch <20px from start = action fires

### Accessibility

- [ ] VoiceOver announces button correctly
- [ ] VoiceOver announces selected state
- [ ] Disabled buttons not interactive
- [ ] Touch targets meet 44pt minimum

---

## Common Issues & Solutions

### Issue: Delayed Visual Feedback

**Symptom**: Button doesn't feel responsive, delay before pressed state appears.

**Cause**: SwiftUI animations or async state updates.

**Solution**:
```swift
var transaction = Transaction()
transaction.disablesAnimations = true
withTransaction(transaction) {
    isPressed = pressed
}
```

### Issue: Can't Scroll When Touch Starts on Button

**Symptom**: ScrollView won't scroll if finger starts on button.

**Cause**: SwiftUI gesture blocking ScrollView gesture.

**Solution**: Use `.scrollFriendlyTap()` instead of `.onTapGesture()`.

### Issue: Colors Don't Change in Dark Mode

**Symptom**: Button stays light in dark mode.

**Cause**: Using Primitive Tokens instead of Component/Alias Tokens.

**Solution**: Always use Component Tokens → Alias Tokens → Primitives hierarchy.

---

## Related Concepts

- **Scroll-Friendly Gestures**: `.claude/concepts/scroll-friendly-gestures.md`
- **Design Token Hierarchy**: `.claude/concepts/design-token-hierarchy.md`
- **iOS Touch Targets**: `.claude/concepts/ios-touch-guidelines.md`

---

## Example Usage

### Basic Button

```swift
ElevateButton(
    label: "Submit",
    tone: .primary,
    size: .medium,
    action: {
        submitForm()
    }
)
```

### Button with Icons

```swift
ElevateButton(
    label: "Add Item",
    tone: .success,
    size: .large,
    action: { addItem() },
    prefix: {
        Image(systemName: "plus")
            .font(.system(size: 18))
    }
)
```

### Selected Toggle Button

```swift
@State private var isBookmarked = false

ElevateButton(
    label: "Bookmark",
    tone: .neutral,
    isSelected: isBookmarked,
    action: {
        isBookmarked.toggle()
    },
    prefix: {
        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
    }
)
```

### Disabled Button

```swift
ElevateButton(
    label: "Unavailable",
    tone: .neutral,
    isDisabled: true,
    action: { }
)
```
