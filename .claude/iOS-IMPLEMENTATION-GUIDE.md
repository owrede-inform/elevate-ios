# ELEVATE iOS Implementation Guide

**Version**: 0.1.0
**Last Updated**: 2025-11-06

This guide documents the iOS implementation of the ELEVATE design system, including component token mappings, iOS-specific adaptations, and core concepts.

---

## Documentation Structure

```
.claude/
├── iOS-IMPLEMENTATION-GUIDE.md          ← You are here
├── concepts/                             ← Core iOS patterns & concepts
│   ├── design-token-hierarchy.md        ← 3-tier token system (CRITICAL)
│   ├── scroll-friendly-gestures.md      ← Touch interaction pattern
│   └── ios-touch-guidelines.md          ← iOS touch & accessibility
└── components/                           ← Component-specific docs
    └── Navigation/
        ├── button.md                     ← Original web docs (has absolute colors)
        └── button-ios-implementation.md  ← iOS implementation guide ✅
```

---

## Getting Started

### New to ELEVATE iOS?

Read in this order:

1. **[Design Token Hierarchy](concepts/design-token-hierarchy.md)** (CRITICAL)
   - Understand the 3-tier token system
   - Learn when to use Component vs Alias vs Primitive tokens
   - **Rule**: Always use Component Tokens first, never use Primitives directly

2. **[iOS Touch Guidelines](concepts/ios-touch-guidelines.md)**
   - iOS vs web touch differences
   - Minimum touch target sizes (44pt)
   - Accessibility requirements

3. **[Scroll-Friendly Gestures](concepts/scroll-friendly-gestures.md)**
   - Why standard SwiftUI gestures fail in ScrollViews
   - UIControl-based solution
   - Instant feedback without blocking scrolling

4. **[Button iOS Implementation](components/Navigation/button-ios-implementation.md)** (Example)
   - See complete component implementation guide
   - CSS → iOS parameter mapping
   - Token application examples

### Implementing a New Component?

Follow this workflow:

1. **Read web component docs** (`.claude/components/[Category]/[component].md`)
   - Understand component purpose and behavior
   - **IGNORE absolute RGB colors** - not relevant for iOS
   - **IGNORE CSS values** - need translation to iOS

2. **Check for Component Tokens**
   ```bash
   # Look for auto-generated tokens
   ls ElevateUI/Sources/DesignTokens/Generated/*ComponentTokens.swift
   ```

3. **Analyze token structure**
   - What element types exist? (fill, label, border, icon, etc.)
   - What states exist? (default, hover, active, disabled, selected, etc.)
   - What tones/variants exist? (primary, success, warning, etc.)

4. **Map CSS to iOS**
   - Convert rem to points (1rem = 16px → adjust for 44pt min touch)
   - Map CSS properties to SwiftUI modifiers
   - Document in component iOS implementation guide

5. **Document iOS-specific adaptations**
   - Touch interaction differences
   - State mapping (combine hover + active)
   - iOS-only features (swipe actions, etc.)

---

## Core Concepts

### 1. Design Token Hierarchy ⭐ CRITICAL

**The Iron Rule**: Component Tokens → Alias Tokens → NEVER Primitives

```swift
// ✅ ALWAYS DO THIS
.background(ButtonComponentTokens.fill_primary_default)

// ✅ If no Component Token, use Alias
.background(ElevateAliases.Surface.General.bg_page)

// ❌ NEVER DO THIS
.background(ElevatePrimitives.Blue._600)
.background(Color.white)
.background(Color(red: 0.1, green: 0.3, blue: 0.8))
```

**Why?**
- Primitive tokens have NO dark mode logic
- Component/Alias tokens automatically handle dark mode
- Breaking this rule = broken dark mode

**See**: [design-token-hierarchy.md](concepts/design-token-hierarchy.md)

### 2. Scroll-Friendly Gestures

**Problem**: Standard SwiftUI gestures block scrolling when touch starts on interactive element.

**Solution**: UIControl-based touch tracking with instant feedback.

```swift
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isPressed = pressed  // Instant, synchronous
        }
    },
    action: {
        action()  // Only fires if <20pt movement
    }
)
```

**Behavior**:
- Touch down → Instant visual feedback (synchronous)
- Drag <20pt → Action fires on release
- Drag >20pt → Scroll starts, no action
- Feels like native iOS buttons

**See**: [scroll-friendly-gestures.md](concepts/scroll-friendly-gestures.md)

### 3. iOS Touch Guidelines

**Key Requirements**:
- **Minimum touch target**: 44pt × 44pt
- **Instant feedback**: < 100ms perceived delay
- **No hover state**: Combine web hover + active → iOS pressed
- **VoiceOver support**: All interactive elements

**Web → iOS State Mapping**:
- `:hover` → `isPressed`
- `:active` → `isPressed` (same as hover)
- `:disabled` → `isDisabled`
- `.selected` → `isSelected`

**See**: [ios-touch-guidelines.md](concepts/ios-touch-guidelines.md)

---

## Component Implementation Pattern

Every component follows this structure:

### 1. Component Tokens File

**Location**: `ElevateUI/Sources/DesignTokens/Components/[Component]Tokens.swift`

**Purpose**: Wrapper around auto-generated Component Tokens with:
- Size configurations (iOS-adjusted from web)
- Convenience methods for state-based color selection
- iOS-specific helpers

**Example** (`ButtonTokens.swift`):
```swift
public struct ButtonTokens {
    public enum Tone { case primary, success, warning, danger, neutral }
    public enum Size { case small, medium, large }
    public enum Shape { case `default`, pill }

    public struct SizeConfig {
        let height: CGFloat          // iOS-adjusted (minimum 44pt)
        let fontSize: CGFloat
        let horizontalPadding: CGFloat
        let gap: CGFloat
        let minTouchTarget: CGFloat  // Always 44pt
    }

    public struct ToneColors {
        let background: Color         // References ButtonComponentTokens
        let backgroundActive: Color
        let text: Color
        // ... etc
    }
}
```

### 2. SwiftUI Component File

**Location**: `ElevateUI/Sources/SwiftUI/Components/[Component]+SwiftUI.swift`

**Structure**:
```swift
public struct ElevateComponent: View {
    // MARK: - Properties
    public var tone: ComponentTokens.Tone
    public var size: ComponentTokens.Size
    public var isDisabled: Bool

    // MARK: - State
    @State private var isPressed = false

    // MARK: - Body
    public var body: some View {
        content
            .background(tokenBackgroundColor)
            .foregroundColor(tokenTextColor)
            .scrollFriendlyTap(
                onPressedChanged: { pressed in
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        isPressed = pressed
                    }
                },
                action: { action() }
            )
    }

    // MARK: - Token Accessors
    private var tokenBackgroundColor: Color {
        if isDisabled {
            return toneColors.backgroundDisabled
        } else if isPressed {
            return toneColors.backgroundActive
        } else {
            return toneColors.background
        }
    }
}
```

### 3. iOS Implementation Documentation

**Location**: `.claude/components/[Category]/[component]-ios-implementation.md`

**Contents**:
- Component Token mapping table
- CSS → iOS parameter translation
- Token application anatomy diagram
- iOS-specific adaptations
- Usage examples
- Common issues & solutions

---

## CSS to iOS Translation Guide

### Size & Spacing

| CSS Unit | iOS Unit | Conversion |
|----------|----------|------------|
| `rem` | `pt` | 1rem = 16pt |
| `px` | `pt` | 1px = 1pt on @1x |
| `%` | Proportional | Use GeometryReader or flexible frames |

### Specific Translations

| CSS Property | iOS Equivalent | Notes |
|--------------|----------------|-------|
| `height: 2rem` | `frame(height: 32)` | Check 44pt minimum |
| `padding: 0.5rem` | `padding(8)` | 0.5 × 16 = 8pt |
| `gap: 0.25rem` | `spacing: 4` | In HStack/VStack |
| `border-radius: 0.25rem` | `cornerRadius(4)` | |
| `border-width: 1px` | `lineWidth: 1` | |

### Touch Target Adjustment

Web heights that need iOS adjustment:

| Web Height | Needs Adjustment? | iOS Height |
|------------|-------------------|------------|
| 1.5rem (24px) | ✅ Yes | 44pt |
| 2rem (32px) | ✅ Yes | 36-44pt |
| 2.5rem (40px) | ✅ Yes | 44pt |
| 3rem (48px) | ❌ No | 48pt |

**Rule**: If web height < 44pt, increase to minimum 44pt in iOS.

---

## Common Mistakes & Solutions

### ❌ Mistake 1: Using Primitive Tokens

```swift
// ❌ WRONG
.background(ElevatePrimitives.Blue._600)
```

**Why wrong**: Primitives don't have dark mode logic.

**✅ Fix**:
```swift
.background(ButtonComponentTokens.fill_primary_default)
```

### ❌ Mistake 2: Hardcoded Colors

```swift
// ❌ WRONG
.background(Color.white)
.foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.8))
```

**Why wrong**: Breaks dark mode, ignores design system.

**✅ Fix**:
```swift
.background(ComponentTokens.fill_default)
.foregroundColor(ComponentTokens.text_default)
```

### ❌ Mistake 3: Animation Delays

```swift
// ❌ WRONG - Adds perceptible delay
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        isPressed = pressed
    }
)
.animation(.easeInOut(duration: 0.15), value: isPressed)
```

**Why wrong**: Animation adds 150ms delay to feedback.

**✅ Fix**:
```swift
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isPressed = pressed
        }
    }
)
// No .animation() modifier
```

### ❌ Mistake 4: Using onTapGesture in ScrollView

```swift
// ❌ WRONG - Blocks scrolling
.onTapGesture {
    action()
}
```

**Why wrong**: Gesture intercepts touches, prevents scrolling.

**✅ Fix**:
```swift
.scrollFriendlyTap(action: action)
```

### ❌ Mistake 5: Touch Targets Too Small

```swift
// ❌ WRONG - Below 44pt minimum
.frame(width: 30, height: 30)
```

**Why wrong**: Hard to tap, fails accessibility.

**✅ Fix**:
```swift
.frame(width: 44, height: 44)
// Or for small visual elements:
Image(systemName: "icon")
    .font(.system(size: 16))
    .frame(width: 44, height: 44)  // Visual smaller, tap area correct
```

---

## Component Token Coverage

### Auto-Generated (from SCSS)

✅ Complete component token files:

- ButtonComponentTokens
- BadgeComponentTokens
- ChipComponentTokens
- InputComponentTokens
- FieldComponentTokens
- MenuComponentTokens
- TabComponentTokens
- TextareaComponentTokens
- CheckboxComponentTokens
- RadioComponentTokens
- SwitchComponentTokens

### Manually Defined

📝 Manually created (no SCSS extraction):

- BreadcrumbTokens (uses Alias tokens)
- TextFieldTokens (combines Input + Field)
- TextAreaTokens (wraps Textarea component tokens)

### Pending Implementation

Components not yet implemented:

- Dropdown, Tooltip, Popover, Lightbox
- Slider, Dropzone, Select
- Pagination, Radio Button Group
- Badge (tokens exist, component pending)

---

## Development Workflow

### Adding a New Component

1. **Check for Component Tokens**:
   ```bash
   ls ElevateUI/Sources/DesignTokens/Generated/[Component]ComponentTokens.swift
   ```

2. **Create Wrapper Tokens** (if needed):
   - Create `ElevateUI/Sources/DesignTokens/Components/[Component]Tokens.swift`
   - Add Size enum and SizeConfig
   - Add convenience methods

3. **Implement SwiftUI Component**:
   - Create `ElevateUI/Sources/SwiftUI/Components/Elevate[Component]+SwiftUI.swift`
   - Follow the component pattern above
   - Use `.scrollFriendlyTap()` for interactive elements
   - Use Component Tokens for all colors/spacing

4. **Document Implementation**:
   - Create `.claude/components/[Category]/[component]-ios-implementation.md`
   - Include token mapping table
   - Document CSS → iOS translations
   - List iOS-specific adaptations
   - Add usage examples

5. **Test**:
   - [ ] Meets 44pt minimum touch target
   - [ ] Instant visual feedback (no delay)
   - [ ] Works in ScrollView
   - [ ] Dark mode works
   - [ ] VoiceOver announces correctly

### Updating Existing Component

1. **Identify Issue** (e.g., delayed feedback, wrong colors)

2. **Check Token Usage**:
   ```bash
   # Search for Primitive token usage (should find none)
   grep -r "ElevatePrimitives\." ElevateUI/Sources/SwiftUI/Components/

   # Search for hardcoded colors (should find none)
   grep -r "Color\.white\|Color\.black\|Color\.red" ElevateUI/Sources/SwiftUI/Components/
   ```

3. **Fix and Document**:
   - Update component implementation
   - Update iOS implementation guide
   - Update this guide if pattern changed

4. **Test** (checklist above)

---

## Resources

### Internal Documentation

- **Core Concepts**:
  - [Design Token Hierarchy](concepts/design-token-hierarchy.md)
  - [Scroll-Friendly Gestures](concepts/scroll-friendly-gestures.md)
  - [iOS Touch Guidelines](concepts/ios-touch-guidelines.md)

- **Component Guides**:
  - [Button iOS Implementation](components/Navigation/button-ios-implementation.md)
  - *(More to be added as components are documented)*

### External References

- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [UIKit Documentation](https://developer.apple.com/documentation/uikit/)
- [ELEVATE Design System](https://github.com/elevate-design-system) *(external)*

---

## Version History

### v0.1.0 (2025-11-06)

**Initial comprehensive documentation**:
- ✅ Design token hierarchy documented
- ✅ Scroll-friendly gesture pattern documented
- ✅ iOS touch guidelines documented
- ✅ Button iOS implementation guide created
- ✅ Common mistakes and solutions documented

**Components Implemented**:
- Button, Chip, Badge (UIKit + SwiftUI)
- Menu, MenuItem
- Breadcrumb, BreadcrumbItem
- Tab, TabBar
- TextField, TextArea

**Core Patterns Established**:
- 3-tier token hierarchy (Component → Alias → Primitive)
- Scroll-friendly gestures (UIControl-based)
- Instant feedback (transaction-based state updates)
- iOS touch targets (44pt minimum)

---

## Contributing

When adding components or patterns:

1. **Follow existing patterns** - consistency is critical
2. **Document thoroughly** - future developers will thank you
3. **Use Component Tokens** - never Primitives
4. **Test accessibility** - VoiceOver, Dynamic Type, touch targets
5. **Update this guide** - keep documentation in sync

---

## Questions?

Common questions:

**Q: Can I use `Color.white` for a white background?**
A: ❌ No. Use `ElevateAliases.Surface.General.bg_canvas` or appropriate token.

**Q: My button feels delayed. What's wrong?**
A: Check for `.animation()` modifiers or async state updates. Use transaction-based immediate updates.

**Q: Can scrolling work when touch starts on a button?**
A: Yes! Use `.scrollFriendlyTap()` instead of `.onTapGesture()`.

**Q: How do I know which token to use?**
A: Follow the hierarchy: Check Component Tokens first, then Alias Tokens. Never Primitives.

**Q: Web component has `:hover`. What do I use in iOS?**
A: Combine `:hover` and `:active` into single `isPressed` state in iOS.

---

For detailed answers, see the relevant concept documentation linked throughout this guide.
