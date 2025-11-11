# Web-to-iOS Translation Guide

**Version**: 1.0.0
**Last Updated**: 2025-11-06

This guide provides comprehensive patterns and strategies for translating ELEVATE web components to native iOS implementations, ensuring platform appropriateness while preserving the design system's visual identity.

---

## Table of Contents

- [Translation Philosophy](#translation-philosophy)
- [Component Translation Matrix](#component-translation-matrix)
- [API Mapping Rules](#api-mapping-rules)
- [State Translation](#state-translation)
- [CSS to Swift Conversion](#css-to-swift-conversion)
- [Touch Target Adjustments](#touch-target-adjustments)
- [Platform-Specific Adaptations](#platform-specific-adaptations)
- [Component Categories by Adaptation Needs](#component-categories-by-adaptation-needs)
- [Implementation Priority Matrix](#implementation-priority-matrix)
- [Translation Examples](#translation-examples)
- [Component Design Checklist](#component-design-checklist)
- [Related Documentation](#related-documentation)

---

## Translation Philosophy

### Core Principles

1. **API Fidelity**: Preserve the intent and functionality of web component APIs
2. **Platform Adaptation**: Replace web patterns with iOS-native equivalents where appropriate
3. **Token Hierarchy**: Always use Component → Alias → Primitive token chain
4. **Dual Implementation**: Provide both SwiftUI (primary) and UIKit (bridging) versions
5. **Accessibility First**: Maintain or exceed web component accessibility standards
6. **Visual Consistency**: Preserve ELEVATE's visual DNA using design tokens

### What to Preserve vs. Adapt

**✅ Preserve (Visual Identity)**:
- Color schemes (via Component Tokens)
- Typography system (Inter font, token-based sizes)
- Spacing scale (convert rem to pt)
- Icon system (web icons → SF Symbols)
- Component tones (primary, success, warning, danger, neutral)
- Visual shapes (box, pill, etc.)

**🔄 Adapt (Interaction Patterns)**:
- Hover states → Touch pressed states
- Click events → Tap gestures with haptic feedback
- Tooltips → Long-press popovers or help buttons
- Right-click menus → Long-press context menus
- Keyboard shortcuts → Optional hardware keyboard support
- Focus outlines → Native VoiceOver focus rings

**❌ Skip (Platform-Specific)**:
- `href`, `target`, `rel` attributes → Use NavigationLink or programmatic navigation
- `type="submit"`, `type="reset"` → Use Form/delegate patterns
- CSS Parts and CSS Properties → Use SwiftUI modifiers
- Custom web events → Use closures/@Binding or delegates
- Slots → Use @ViewBuilder or UIKit composition

### Platform-Specific vs. Universal

| Aspect | Web | iOS | Decision |
|--------|-----|-----|----------|
| Touch Targets | 24-32px | 44pt minimum | **Adapt**: Increase all interactive elements |
| Hover State | Yes | No | **Adapt**: Combine hover + active → pressed |
| Scrolling | Mouse/trackpad | Touch gestures | **Adapt**: Use scroll-friendly tap patterns |
| Navigation | Links (href) | NavigationStack/modals | **Adapt**: Use native navigation |
| Forms | Submit buttons | Keyboard done actions | **Adapt**: iOS form patterns |
| Color Mode | CSS media query | SwiftUI environment | **Universal**: Token system handles both |
| Typography | CSS font properties | SwiftUI .font() | **Universal**: Map via tokens |
| Spacing | rem/px | pt | **Universal**: Convert systematically |

---

## Component Translation Matrix

### 1. Properties Translation

| Web Attribute | iOS SwiftUI | iOS UIKit | Notes |
|---------------|-------------|-----------|-------|
| `disabled: boolean` | `isDisabled: Bool` | `isEnabled: Bool` | Invert logic for UIKit |
| `selected: boolean` | `isSelected: Bool` | `isSelected: Bool` | Standard iOS naming |
| `tone: string` | `tone: Tone` enum | `tone: Tone` enum | Strongly typed enum (primary, success, warning, danger, neutral) |
| `size: string` | `size: Size` enum | `size: Size` enum | Strongly typed enum (small, medium, large) |
| `shape: string` | `shape: Shape` enum | `shape: Shape` enum | Strongly typed enum (box, pill, etc.) |
| `padding: string` | `padding: EdgeInsets?` | `contentEdgeInsets` | iOS-native spacing |
| `pulse: boolean` | `isPulsing: Bool` | `isPulsing: Bool` | Animation property |
| `removable: boolean` | `removable: Bool` | `removable: Bool` | Component-specific |
| `href: string` | N/A | N/A | Use NavigationLink or programmatic navigation |
| `target: string` | N/A | N/A | Not applicable to iOS |

### 2. Slots Translation

| Web Slot | SwiftUI | UIKit | Pattern |
|----------|---------|-------|---------|
| *(default)* | `label: String` or `content: () -> Content` | `setTitle()` or `contentView` | ViewBuilder or string |
| `prefix` | `prefix: () -> Prefix` | `prefixView: UIView?` | Optional ViewBuilder |
| `suffix` | `suffix: () -> Suffix` | `suffixView: UIView?` | Optional ViewBuilder |
| `icon` | `icon: () -> Icon` | `iconView: UIView?` | Optional ViewBuilder |

**SwiftUI Pattern**:
```swift
struct ElevateComponent<Prefix: View, Content: View, Suffix: View>: View {
    @ViewBuilder var prefix: () -> Prefix
    @ViewBuilder var content: () -> Content
    @ViewBuilder var suffix: () -> Suffix

    var body: some View {
        HStack {
            prefix()
            content()
            suffix()
        }
    }
}
```

**UIKit Pattern**:
```swift
class ElevateComponent: UIView {
    var prefixView: UIView? { didSet { updateLayout() } }
    var contentView: UIView? { didSet { updateLayout() } }
    var suffixView: UIView? { didSet { updateLayout() } }

    private func updateLayout() {
        // Reconstruct stack with new views
    }
}
```

### 3. Events Translation

| Web Event | SwiftUI | UIKit | Pattern |
|-----------|---------|-------|---------|
| `@click` | `action: () -> Void` | `addTarget(_:action:for: .touchUpInside)` | Standard tap |
| `@request-remove` | `onRemove: (() -> Void)?` | `delegate?.didRequestRemove()` | Optional closure/delegate |
| `@request-edit` | `onEdit: (() -> Void)?` | `delegate?.didRequestEdit()` | Optional closure/delegate |
| `@focus` | `@FocusState` | `becomeFirstResponder()` | Focus management |
| `@blur` | `@FocusState` | `resignFirstResponder()` | Unfocus |
| `@change` | `@Binding` or callback | `addTarget(for: .valueChanged)` | Value change |
| `@input` | `@Binding` | `delegate?.textDidChange()` | Text input |
| Custom events | Closures | Delegate protocol | iOS patterns |

### 4. Methods Translation

| Web Method | SwiftUI | UIKit | Pattern |
|------------|---------|-------|---------|
| `focus()` | `@FocusState + .focused()` | `becomeFirstResponder()` | Focus programmatically |
| `blur()` | `@FocusState + .focused(false)` | `resignFirstResponder()` | Remove focus |
| `click()` | Invoke `action` closure | `sendActions(for: .touchUpInside)` | Programmatic trigger |
| `scrollIntoView()` | `ScrollViewReader.scrollTo()` | `scrollRectToVisible()` | Scroll to element |

---

## API Mapping Rules

### Props → SwiftUI Properties

**Pattern**: Web props become SwiftUI init parameters with strongly-typed enums.

```swift
// Web: <elvt-button tone="primary" size="large" disabled>
// iOS SwiftUI:
ElevateButton(
    label: "Click Me",
    tone: .primary,      // enum Tone { case primary, ... }
    size: .large,        // enum Size { case small, medium, large }
    isDisabled: true     // Bool (renamed for clarity)
)
```

**Guidelines**:
- Use Swift naming conventions (isDisabled vs disabled)
- Convert string enums to Swift enums
- Provide sensible defaults for optional parameters
- Use @Binding for two-way state binding

### Events → Closures

**Pattern**: Web events become Swift closures or delegate methods.

```swift
// Web: <elvt-chip @click="handleClick" @request-remove="handleRemove">
// iOS SwiftUI:
ElevateChip(
    label: "Tag",
    removable: true,
    action: { handleClick() },
    onRemove: { handleRemove() }
)
```

**Guidelines**:
- Primary action: `action: () -> Void`
- Optional actions: `onAction: (() -> Void)?`
- For UIKit: Use delegate protocols for multiple events
- Include haptic feedback in action handlers

### Slots → ViewBuilder

**Pattern**: Web slots become @ViewBuilder closures.

```swift
// Web: <elvt-button><span slot="prefix">👍</span>Click</elvt-button>
// iOS SwiftUI:
ElevateButton("Click") {
    Text("👍")  // prefix
} suffix: {
    EmptyView()
} action: {
    handleClick()
}
```

**Convenience Initializers**:
```swift
// Simple case (no slots)
extension ElevateButton where Prefix == EmptyView, Suffix == EmptyView {
    init(_ label: String, tone: Tone = .neutral, action: @escaping () -> Void) {
        self.init(
            label: label,
            tone: tone,
            action: action,
            prefix: { EmptyView() },
            suffix: { EmptyView() }
        )
    }
}
```

### CSS Classes → Token-Based Styling

**Pattern**: CSS classes map to token-based style configurations.

```swift
// Web: class="button--primary button--large"
// iOS: Handled via tone and size enums

let colors = ButtonTokens.colors(for: .primary)
let sizeConfig = ButtonTokens.sizeConfig(for: .large)

.background(colors.background)
.foregroundColor(colors.text)
.frame(height: sizeConfig.height)
.padding(.horizontal, sizeConfig.horizontalPadding)
```

**Never Hardcode**:
```swift
// ❌ WRONG
.background(Color.blue)
.frame(height: 48)

// ✅ RIGHT
.background(ButtonComponentTokens.fill_primary_default)
.frame(height: ButtonTokens.sizeConfig(for: size).height)
```

---

## State Translation

### Web States vs iOS States

| Web State | CSS Selector | iOS State | Implementation |
|-----------|--------------|-----------|----------------|
| Default | `:root` | `default` | Base state properties |
| Hover | `:hover` | `isPressed` | Touch down (no hover on iOS) |
| Active | `:active` | `isPressed` | Same as hover (combined) |
| Focus | `:focus` | `@FocusState` | Keyboard/VoiceOver focus |
| Disabled | `:disabled` | `isDisabled: Bool` | Non-interactive state |
| Selected | `.selected` | `isSelected: Bool` | Toggle/selection state |

### hover → .pressed State

**Problem**: iOS has no hover. Users must touch to interact.

**Solution**: Combine web's `:hover` and `:active` into single `isPressed` state.

```swift
@State private var isPressed = false

var tokenBackgroundColor: Color {
    if isDisabled {
        return colors.backgroundDisabled
    } else if isPressed {
        // Combines both web hover and active states
        return colors.backgroundActive
    } else {
        return colors.background
    }
}

// Use scroll-friendly tap for instant feedback
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isPressed = pressed  // Instant, synchronous
        }
    },
    action: { action() }
)
```

**Token Mapping**:
```swift
// Web CSS:
// --button-fill-primary-default: var(--alias-bg-brand);
// --button-fill-primary-hover: var(--alias-bg-brand-hover);
// --button-fill-primary-active: var(--alias-bg-brand-active);

// iOS: Use active for pressed state
let colors = ButtonComponentTokens(
    background: ButtonComponentTokens.fill_primary_default,
    backgroundActive: ButtonComponentTokens.fill_primary_active,  // Both hover + active
    backgroundDisabled: ButtonComponentTokens.fill_primary_disabled
)
```

### focus → @FocusState

**Pattern**: Web focus management maps to SwiftUI @FocusState or UIKit first responder.

```swift
// SwiftUI
@FocusState private var isFocused: Bool

TextField("Enter text", text: $text)
    .focused($isFocused)

// Programmatic focus
isFocused = true

// UIKit
class ElevateTextField: UITextField {
    func focus() {
        becomeFirstResponder()
    }

    func blur() {
        resignFirstResponder()
    }
}
```

### Active States

**State Priority Order** (highest to lowest):

1. **Disabled**: Always shows disabled appearance
2. **Pressed**: Shows while touch is down
3. **Selected**: Shows for toggle/selection state
4. **Default**: Base state

```swift
private var currentState: ComponentState {
    if isDisabled { return .disabled }
    if isPressed { return .pressed }
    if isSelected { return .selected }
    return .default
}

private var tokenBackgroundColor: Color {
    switch currentState {
    case .disabled: return colors.backgroundDisabled
    case .pressed: return colors.backgroundActive
    case .selected: return colors.backgroundSelected
    case .default: return colors.background
    }
}
```

### Disabled States

**Behavior Changes**:
- Visual: Reduced opacity/desaturated colors
- Interactive: Blocks all gestures
- Accessibility: Announces "dimmed" or "disabled" to VoiceOver

```swift
.disabled(isDisabled)
.opacity(isDisabled ? 0.6 : 1.0)  // Optional additional dimming
.allowsHitTesting(!isDisabled)
```

---

## CSS to Swift Conversion

### rem → pt (Points)

**Base Conversion**: 1rem = 16pt (web default)

| CSS rem | Web px | iOS pt | Notes |
|---------|--------|--------|-------|
| 0.25rem | 4px | 4pt | Small gap |
| 0.5rem | 8px | 8pt | Standard gap |
| 0.75rem | 12px | 12pt | Medium padding |
| 1rem | 16px | 16pt | Base unit |
| 1.5rem | 24px | 24pt | Too small for touch target |
| 2rem | 32px | 32pt | Adjust to 36-44pt |
| 2.5rem | 40px | 40pt | Adjust to 44pt |
| 3rem | 48px | 48pt | Acceptable |

**Touch Target Adjustments**:
```swift
// Web: height: 2rem (32px)
// iOS: Increase to meet 44pt minimum

let webHeight: CGFloat = 32  // 2rem × 16
let iosHeight: CGFloat = max(44, webHeight)  // Minimum 44pt
```

### Flexbox → VStack/HStack

**Patterns**:

| CSS Flexbox | SwiftUI | Notes |
|-------------|---------|-------|
| `display: flex; flex-direction: row` | `HStack` | Horizontal stack |
| `display: flex; flex-direction: column` | `VStack` | Vertical stack |
| `gap: 0.5rem` | `spacing: 8` | Stack spacing |
| `justify-content: space-between` | `Spacer()` | Place spacers between items |
| `justify-content: center` | Stack with Spacer() before/after | Center alignment |
| `align-items: center` | `alignment: .center` | Cross-axis alignment |
| `flex-wrap: wrap` | `FlowLayout` or multiple stacks | Wrap to next line |

**Example**:
```swift
// Web CSS:
// display: flex;
// flex-direction: row;
// gap: 0.5rem;
// align-items: center;

// iOS SwiftUI:
HStack(spacing: 8) {  // gap: 0.5rem = 8pt
    prefix()
    Text(label)
    suffix()
}
.frame(alignment: .center)  // align-items: center
```

### Grid → LazyVGrid

```swift
// Web CSS Grid:
// display: grid;
// grid-template-columns: repeat(3, 1fr);
// gap: 1rem;

// iOS SwiftUI:
LazyVGrid(
    columns: [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ],
    spacing: 16
) {
    ForEach(items) { item in
        ItemView(item)
    }
}
```

### Position → ZStack/overlay

**Patterns**:

| CSS Position | SwiftUI | Notes |
|--------------|---------|-------|
| `position: relative` | Default | SwiftUI views are relative by default |
| `position: absolute; top: 0; right: 0` | `.overlay(alignment: .topTrailing)` | Position within parent |
| `z-index: 10` | `.zIndex(10)` | Layering order |
| `position: fixed` | N/A | Use environment/root placement |

**Example**:
```swift
// Web: Badge positioned top-right of avatar
// <div style="position: relative">
//   <img src="avatar.png">
//   <span style="position: absolute; top: 0; right: 0">3</span>
// </div>

// iOS:
Image("avatar")
    .overlay(alignment: .topTrailing) {
        ElevateBadge(count: 3)
            .offset(x: 4, y: -4)  // Fine-tune position
    }
```

### Typography

**Font Size Conversion**:

| CSS | Web px | iOS pt | SwiftUI .font() |
|-----|--------|--------|-----------------|
| `font-size: 0.75rem` | 12px | 12pt | `.caption` or custom |
| `font-size: 0.875rem` | 14px | 14pt | `.subheadline` or custom |
| `font-size: 1rem` | 16px | 16pt | `.body` |
| `font-size: 1.125rem` | 18px | 18pt | `.title3` or custom |
| `font-size: 1.25rem` | 20px | 20pt | `.title2` or custom |

**Font Weight Conversion**:

| CSS font-weight | SwiftUI .fontWeight() |
|-----------------|----------------------|
| 300 | `.light` |
| 400 | `.regular` |
| 500 | `.medium` |
| 600 | `.semibold` |
| 700 | `.bold` |

**Example**:
```swift
// Web CSS: font-size: 0.875rem; font-weight: 600;
// iOS:
Text(label)
    .font(.system(size: 14, weight: .semibold))

// Or use token:
Text(label)
    .font(ButtonTokens.font(for: size))  // Token-based
```

### Border & Corner Radius

```swift
// Web CSS:
// border: 1px solid var(--color);
// border-radius: 0.25rem;

// iOS SwiftUI:
RoundedRectangle(cornerRadius: 4)  // 0.25rem = 4pt
    .stroke(borderColor, lineWidth: 1)
    .background(backgroundColor)

// Or use .overlay:
content
    .background(backgroundColor)
    .cornerRadius(4)
    .overlay(
        RoundedRectangle(cornerRadius: 4)
            .stroke(borderColor, lineWidth: 1)
    )
```

### Shadow/Elevation

```swift
// Web CSS:
// box-shadow: 0 2px 4px rgba(0,0,0,0.1);

// iOS SwiftUI:
.shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)

// Token-based:
.shadow(
    color: ElevateAliases.Shadow.shadow_color,
    radius: ElevateAliases.Shadow.shadow_radius,
    x: 0,
    y: ElevateAliases.Shadow.shadow_offset_y
)
```

---

## Touch Target Adjustments

### 44pt Minimum Rule

**Apple HIG Requirement**: All interactive elements must have a minimum 44pt × 44pt touch target.

**Web vs iOS**:

| Component | Web Height | iOS Minimum | iOS Recommended |
|-----------|-----------|-------------|-----------------|
| Button Small | 32px (2rem) | 44pt | 44pt |
| Button Medium | 40px (2.5rem) | 44pt | 44pt |
| Button Large | 48px (3rem) | 44pt | 48pt |
| Chip | 24-32px | 44pt | 36pt visual, 44pt tap area |
| Checkbox | 16-20px | 44pt | 20pt visual, 44pt tap area |
| Icon Button | 32px | 44pt | 24pt icon, 44pt tap area |

### Visual Size vs. Tap Area

**Pattern**: Small visual elements can have expanded tap areas.

```swift
// Visual element smaller than 44pt
Image(systemName: "xmark")
    .font(.system(size: 16))  // Visual: 16pt icon
    .frame(width: 44, height: 44)  // Tap area: 44pt
    .contentShape(Rectangle())  // Ensure entire frame is tappable
```

**Example: Chip with Remove Button**:
```swift
HStack(spacing: 8) {
    Text(label)

    if removable {
        Button(action: onRemove) {
            Image(systemName: "xmark")
                .font(.system(size: 12))  // Small visual icon
                .frame(width: 20, height: 20)  // Visual boundary
        }
        .frame(width: 44, height: 44)  // Tap target (meets minimum)
        .contentShape(Rectangle())
    }
}
.frame(height: 36)  // Chip visual height
.padding(.horizontal, 12)
```

### Padding vs. Tap Area

**Approach 1: Increase Component Height**
```swift
// Web: height 32pt → iOS: height 44pt
.frame(height: 44)
.padding(.horizontal, 16)
```

**Approach 2: Expand Tap Area, Keep Visual**
```swift
// Visual stays small, tap area expands
content
    .frame(height: 32)  // Visual height
    .padding(.horizontal, 16)
    .contentShape(Rectangle())
    .frame(minHeight: 44)  // Minimum tap target
```

### Accessibility Considerations

**VoiceOver Touch Areas**:
- VoiceOver users need clear element boundaries
- Elements too close together are hard to distinguish
- Provide minimum 8pt spacing between interactive elements

```swift
VStack(spacing: 8) {  // Minimum 8pt between buttons
    ElevateButton("First")
    ElevateButton("Second")
    ElevateButton("Third")
}
```

**Dynamic Type**:
- Text may grow larger with accessibility settings
- Ensure touch targets scale proportionally

```swift
Text(label)
    .font(.body)  // Scales with Dynamic Type
    .frame(minHeight: 44)  // Minimum maintained
```

**High Contrast**:
- Increase border visibility in high contrast mode
- Use environment value to detect

```swift
@Environment(\.accessibilityReduceTransparency) var reduceTransparency

.border(
    borderColor,
    width: reduceTransparency ? 2 : 1  // Thicker border for high contrast
)
```

---

## Platform-Specific Adaptations

### Scroll Behavior

**Problem**: Standard SwiftUI gestures block scrolling when touch starts on interactive element.

**Solution**: Use scroll-friendly tap pattern (see `.claude/concepts/scroll-friendly-gestures.md`).

```swift
.scrollFriendlyTap(
    onPressedChanged: { pressed in
        var transaction = Transaction()
        transaction.disablesAnimations = true
        withTransaction(transaction) {
            isPressed = pressed  // Instant feedback
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

### Gesture Handling

**Navigation Gestures**:

| Web Pattern | iOS Pattern | Implementation |
|-------------|-------------|----------------|
| Click link | Tap NavigationLink | `NavigationLink(destination:)` |
| Back button | Swipe from edge | Built into NavigationStack |
| Hover menu | Long-press menu | `.contextMenu` |

**Example**:
```swift
// Web: <a href="/detail">View Details</a>
// iOS:
NavigationLink(destination: DetailView()) {
    ElevateButton("View Details")
}

// Or programmatic:
ElevateButton("View Details") {
    navigationPath.append(DetailRoute.detail)
}
```

**Context Menus**:
```swift
// Replace web hover/right-click menu
ElevateCard()
    .contextMenu {
        Button("Edit", action: handleEdit)
        Button("Share", action: handleShare)
        Button("Delete", role: .destructive, action: handleDelete)
    }
```

### Safe Area Insets

**Handle Notch/Home Indicator**:

```swift
// Respect safe areas
VStack {
    content
}
.safeAreaInset(edge: .bottom) {
    // Content that should appear above home indicator
}

// Or ignore safe areas selectively
.ignoresSafeArea(.container, edges: .horizontal)
```

### Dynamic Type Support

**Ensure Text Scales**:

```swift
// ✅ Scales with user preference
Text(label)
    .font(.body)

// ❌ Fixed size (use only for icons)
Text(label)
    .font(.system(size: 16))  // Won't scale
```

**Adjust Layout for Larger Text**:
```swift
@Environment(\.dynamicTypeSize) var dynamicTypeSize

var useVerticalLayout: Bool {
    dynamicTypeSize >= .accessibility1
}

Group {
    if useVerticalLayout {
        VStack { /* ... */ }
    } else {
        HStack { /* ... */ }
    }
}
```

### Dark Mode

**Token-Based Dark Mode**:

The design token system handles dark mode automatically. Never use hardcoded colors.

```swift
// ✅ Automatically handles dark mode
.background(ButtonComponentTokens.fill_primary_default)

// ❌ Breaks dark mode
.background(Color.white)
```

**Manual Dark Mode Detection** (if needed):
```swift
@Environment(\.colorScheme) var colorScheme

var isDarkMode: Bool {
    colorScheme == .dark
}
```

### Haptic Feedback

**Add Tactile Responses**:

```swift
// Light impact: Toggles, selections
let generator = UIImpactFeedbackGenerator(style: .light)
generator.impactOccurred()

// Medium impact: Button taps
let generator = UIImpactFeedbackGenerator(style: .medium)
generator.impactOccurred()

// Selection feedback: Picker changes
let generator = UISelectionFeedbackGenerator()
generator.selectionChanged()

// Notification feedback: Success/error
let generator = UINotificationFeedbackGenerator()
generator.notificationOccurred(.success)
```

**Example Integration**:
```swift
ElevateButton("Submit") {
    let generator = UIImpactFeedbackGenerator(style: .medium)
    generator.impactOccurred()
    handleSubmit()
}
```

---

## Component Categories by Adaptation Needs

### 🟢 Category A: Direct Translation (Minimal Adaptation)

**These components translate well to iOS with minor touch target adjustments.**

| Component | iOS Equivalent | Adaptation Notes | Priority |
|-----------|----------------|------------------|----------|
| **Switch** | UISwitch | Already native-like, adjust touch targets to 44pt minimum | **HIGH** |
| **Checkbox** | Custom (no native) | Increase touch target, add haptic feedback | **HIGH** |
| **Radio** | Custom (no native) | Increase touch target, group management | **HIGH** |
| **Progress** | UIProgressView | Linear progress bar, determinate/indeterminate | **MEDIUM** |
| **Slider** | UISlider | Native iOS pattern, range mode needs adaptation | **MEDIUM** |
| **Divider** | Separator | Simple line, no interaction | **LOW** |
| **Avatar** | Custom | Circle/square image view, no hover states | **MEDIUM** |
| **Indicator** | Badge-like | Numeric/dot indicators, similar to badge | **LOW** |
| **Skeleton** | Shimmer | Loading placeholder, animation focus | **LOW** |
| **Icon** | SF Symbols | Already implemented via ElevateIcon | **DONE** |

**Guidelines**:
- Expand touch targets from 24-32px to 44pt minimum
- Remove hover states, add pressed states
- Add haptic feedback for state changes
- Use Component Tokens for all styling

### 🟡 Category B: Moderate Adaptation (Rethink Interaction)

**These components need significant touch interaction redesign but keep visual style.**

| Component | Web Pattern | iOS Adaptation | Priority |
|-----------|-------------|----------------|----------|
| **Dropdown** | Click → Menu | Use native UIMenu/Menu with proper tap targets | **HIGH** |
| **Select** | Dropdown list | Use UIPickerView or native List with search | **HIGH** |
| **Tabs** | Horizontal tabs | Use UISegmentedControl or native TabView, consider scrolling | **HIGH** |
| **Dialog/Modal** | Overlay + backdrop | Use sheet presentation styles (.sheet, .fullScreenCover) | **HIGH** |
| **Drawer** | Side panel | Use native sidebar or modal sheet from edge | **MEDIUM** |
| **Tooltip** | Hover-based | Replace with long-press popovers or help buttons | **LOW** |
| **Popup** | Hover/click | Use UIPopoverController or Menu with context | **MEDIUM** |
| **Menu** | Hover navigation | Use UIMenu or ContextMenu for touch | **HIGH** |
| **Breadcrumb** | Clickable path | Use NavigationStack with back buttons | **LOW** |
| **Pagination** | Click buttons | Use native scroll + page control or pull-to-refresh | **MEDIUM** |
| **Stepper** | Number +/- | Use UIStepper or custom with proper touch targets | **MEDIUM** |
| **Expansion Panel** | Click to expand | Use DisclosureGroup, ensure touch target on entire row | **MEDIUM** |
| **Card** | Hover effects | Remove hover, add tap gesture, use shadow elevation | **MEDIUM** |
| **Link** | Hover underline | Use Button with link styling, proper touch target | **LOW** |

**Key Adaptations**:
- **Hover → Touch**: Replace all hover with tap/long-press
- **Touch Targets**: Minimum 44×44pt (web ~32px = 21pt)
- **Native Patterns**: Use iOS conventions over web patterns
- **Context Menus**: Long-press replaces right-click

**Critical Insights**:
- **Tabs**: Web tabs often 40px tall; iOS needs 44pt minimum + scrolling for overflow
- **Dropdowns**: Web dropdowns problematic on iOS - use native pickers or sheets
- **Tooltips**: Hover-based help doesn't work - use (i) buttons with popovers

### 🔴 Category C: Major Reconceptualization (iOS-Specific Design)

**These components need fundamental rethinking for iOS touch patterns.**

| Component | Why Problematic | iOS Alternative | Priority |
|-----------|----------------|-----------------|----------|
| **Table** | Complex hover, sorting, selection | Use native List or UITableView with swipe actions | **HIGH** |
| **Dropdown Menu** | Nested hover menus | Flatten hierarchy, use UIMenu with nested actions | **MEDIUM** |
| **Split View** | Mouse resize handles | Use native UISplitViewController or fixed ratios | **LOW** |
| **Lightbox** | Click to zoom images | Use native fullscreen image viewer with gestures | **LOW** |
| **Dropzone** | Drag-and-drop files | Use native file picker + photo picker, no drag-drop | **LOW** |
| **Toolbar** | Hover tooltips | Use UIToolbar or bottom tab bar, no hover | **MEDIUM** |
| **Navigation** | Hover mega-menus | Use NavigationStack, sidebar, or tab bar | **HIGH** |
| **Textarea** | Auto-resize | Use TextEditor with proper keyboard handling | **MEDIUM** |
| **Field** | Inline validation | Use native form patterns with proper error display | **HIGH** |
| **Input** | Focus states | Native TextField with keyboard types and toolbar | **HIGH** |

**iOS-Specific Considerations**:
- **Tables**: Web tables have hover, tooltips, inline editing → iOS needs swipe actions, drill-down, sheets
- **Drag-Drop**: iOS drag-drop different from web → use system pickers instead
- **Navigation**: Web uses hover mega-menus → iOS uses hierarchical navigation or tabs
- **Forms**: Web inline validation → iOS prefers field-level errors and keyboard toolbars

**Additional Requirements**:
- **Keyboard Management**: TextField/TextEditor need keyboard avoidance, return key handling, input accessory views
- **Swipe Actions**: Replace hover actions with leading/trailing swipe on lists
- **Sheets vs Popovers**: Use sheets on iPhone, popovers on iPad (size class aware)
- **Safe Areas**: Respect notch, home indicator, dynamic island

### ⚫ Category D: Not Applicable for iOS

**These components are web-specific and shouldn't be ported.**

| Component | Why Not Applicable | iOS Alternative |
|-----------|-------------------|-----------------|
| **Scrollbar** | iOS has native scroll indicators | Use native UIScrollView indicators |
| **Visually Hidden** | Web accessibility pattern | Use SwiftUI .accessibilityHidden() |
| **Focus Management** | Web keyboard navigation | Use native VoiceOver and focus engine |
| **Direction (LTR/RTL)** | CSS-based | SwiftUI handles automatically with .environment(\.layoutDirection) |
| **Logical Properties** | CSS box model | Use SwiftUI modifiers (.padding, .frame) |
| **Enter Key Hint** | Web input attribute | Use .submitLabel() modifier |
| **Auto-capitalize** | Web text input | Use .textInputAutocapitalization() modifier |
| **Input Mode** | Virtual keyboard hint | Use .keyboardType() modifier |

**Rationale**: These are web platform abstractions or CSS concepts. SwiftUI/UIKit have native equivalents or handle automatically.

---

## Implementation Priority Matrix

### Phase 1: Essential Form Controls (Week 1-2)

**Focus**: Components needed for 90% of iOS apps

| Component | Reason | Estimated Effort | Status |
|-----------|--------|-----------------|--------|
| **Switch** | Core form control, native pattern | 4 hours | Pending |
| **Checkbox** | Essential for forms | 6 hours | Pending |
| **Radio** | Essential for forms | 6 hours | Pending |
| **TextField/Input** | Critical for all apps | 8 hours | Implemented |
| **TextArea** | Multi-line input | 6 hours | Implemented |

**Total**: ~30 hours

### Phase 2: Navigation & Structure (Week 3-4)

**Focus**: App structure and navigation

| Component | Reason | Estimated Effort | Status |
|-----------|--------|-----------------|--------|
| **Tabs** | Primary navigation pattern | 6 hours | Implemented |
| **Navigation** | Hierarchical navigation | 8 hours | Partial |
| **Dialog/Sheet** | Modal content presentation | 6 hours | Pending |
| **Menu** | Context actions | 6 hours | Implemented |
| **Toolbar** | Action organization | 4 hours | Pending |

**Total**: ~30 hours

### Phase 3: Data Display (Week 5-6)

**Focus**: Lists, tables, cards

| Component | Reason | Estimated Effort | Status |
|-----------|--------|-----------------|--------|
| **List/Table** | Core data display | 12 hours | Pending |
| **Card** | Content container | 4 hours | Pending |
| **Avatar** | User representation | 3 hours | Pending |
| **Divider** | Visual separation | 2 hours | Pending |
| **Progress** | Loading states | 4 hours | Pending |

**Total**: ~25 hours

### Phase 4: Advanced Controls (Week 7-8)

**Focus**: Specialized interactions

| Component | Reason | Estimated Effort | Status |
|-----------|--------|-----------------|--------|
| **Slider** | Value selection | 6 hours | Pending |
| **Stepper** | Numeric increment | 4 hours | Pending |
| **Select/Picker** | Option selection | 8 hours | Pending |
| **Dropdown** | Action/selection menu | 6 hours | Pending |
| **Pagination** | Data navigation | 4 hours | Pending |

**Total**: ~28 hours

### Phase 5: Polish & Enhancement (Week 9-10)

**Focus**: Nice-to-have and decorative

| Component | Reason | Estimated Effort | Status |
|-----------|--------|-----------------|--------|
| **Skeleton** | Loading placeholders | 4 hours | Pending |
| **Expansion Panel** | Collapsible content | 5 hours | Pending |
| **Breadcrumb** | Navigation context | 3 hours | Implemented |
| **Tooltip/Popover** | Contextual help | 6 hours | Pending |
| **Drawer** | Auxiliary content | 6 hours | Pending |

**Total**: ~24 hours

**Grand Total**: ~137 hours (≈3.5 weeks of full-time development)

---

## Translation Examples

### Example 1: Button (Simple Component)

**Web Component**:
```html
<elvt-button
    tone="primary"
    size="large"
    disabled
    @click="handleClick">
    Click Me
</elvt-button>
```

**iOS SwiftUI**:
```swift
ElevateButton(
    "Click Me",
    tone: .primary,
    size: .large,
    isDisabled: true
) {
    handleClick()
}
```

**Key Translations**:
- `tone="primary"` → `tone: .primary` (string → enum)
- `size="large"` → `size: .large` (string → enum)
- `disabled` → `isDisabled: true` (attribute → Bool)
- `@click` → `action: { }` (event → closure)

### Example 2: Chip with Slots (Complex Component)

**Web Component**:
```html
<elvt-chip tone="success" removable @request-remove="handleRemove">
    <span slot="prefix">✓</span>
    Active
</elvt-chip>
```

**iOS SwiftUI**:
```swift
ElevateChip(
    label: "Active",
    tone: .success,
    removable: true,
    onRemove: { handleRemove() }
) {
    Text("✓")  // prefix slot
} suffix: {
    EmptyView()
}
```

**Key Translations**:
- Default slot → `label: String`
- `slot="prefix"` → `prefix: () -> View`
- `@request-remove` → `onRemove: (() -> Void)?`
- `removable` → `removable: Bool`

### Example 3: Navigation Adaptation

**Web Component** (href pattern):
```html
<elvt-button href="/settings" target="_blank">
    Go to Settings
</elvt-button>
```

**iOS SwiftUI** (NavigationLink):
```swift
// Approach 1: Declarative navigation
NavigationLink(destination: SettingsView()) {
    ElevateButton("Go to Settings")
}

// Approach 2: Programmatic navigation
ElevateButton("Go to Settings") {
    navigationPath.append(AppRoute.settings)
}
```

**Key Adaptations**:
- `href` attribute → `NavigationLink` wrapper
- `target="_blank"` → `.sheet()` or separate window (iPad)
- Web navigation → iOS navigation patterns

### Example 4: Hover to Touch

**Web CSS**:
```css
.button {
    background: var(--button-fill-primary-default);
}

.button:hover {
    background: var(--button-fill-primary-hover);
}

.button:active {
    background: var(--button-fill-primary-active);
}
```

**iOS SwiftUI**:
```swift
@State private var isPressed = false

var body: some View {
    content
        .background(backgroundColor)
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

private var backgroundColor: Color {
    if isPressed {
        // Combines both :hover and :active states
        return ButtonComponentTokens.fill_primary_active
    } else {
        return ButtonComponentTokens.fill_primary_default
    }
}
```

**Key Adaptations**:
- `:hover` + `:active` → single `isPressed` state
- CSS pseudo-classes → SwiftUI state-based logic
- Hover detection → Touch down/up events

### Example 5: Form Submission

**Web Pattern**:
```html
<form @submit="handleSubmit">
    <elvt-input label="Email" type="email"></elvt-input>
    <elvt-button type="submit">Submit</elvt-button>
</form>
```

**iOS SwiftUI**:
```swift
@State private var email = ""

Form {
    ElevateTextField(
        label: "Email",
        text: $email
    )
    .keyboardType(.emailAddress)
    .submitLabel(.done)
}
.onSubmit {
    handleSubmit()
}

ElevateButton("Submit") {
    handleSubmit()
}
```

**Key Adaptations**:
- `<form>` → `Form { }` container
- `type="email"` → `.keyboardType(.emailAddress)`
- `type="submit"` → `.onSubmit { }` or button action
- `@submit` event → `.onSubmit` modifier

---

## Component Design Checklist

When implementing a component, verify:

### ✅ Touch & Interaction
- [ ] Minimum 44×44pt touch target for all interactive elements
- [ ] Haptic feedback on appropriate interactions (light/medium/heavy impact)
- [ ] Long-press context menus where applicable
- [ ] No hover-dependent functionality (replaced with press/long-press)
- [ ] Proper disabled state (visual + interaction blocking)
- [ ] Scroll-friendly tap pattern (doesn't block scrolling)
- [ ] Instant visual feedback (<100ms perceived delay)

### ✅ Visual Design
- [ ] Maintains ELEVATE color tokens (Component → Alias → Primitive chain)
- [ ] Uses ELEVATE spacing scale (converted from rem to pt)
- [ ] Uses ELEVATE typography (Inter font, token-based sizes)
- [ ] Uses ELEVATE icon system (SF Symbols)
- [ ] Respects safe areas (notch, home indicator, dynamic island)
- [ ] Dark mode support (automatic via token system)
- [ ] Corner radius and shadows match design system

### ✅ Accessibility
- [ ] VoiceOver labels and hints provided
- [ ] Dynamic Type support (text scaling)
- [ ] Sufficient color contrast (WCAG AA minimum)
- [ ] Focus indicators for keyboard navigation
- [ ] Semantic roles (.button, .header, .textField, etc.)
- [ ] Reduced motion support (disable animations if needed)
- [ ] High contrast mode support (thicker borders, clearer boundaries)

### ✅ Performance
- [ ] Smooth 60fps scrolling
- [ ] Efficient SwiftUI view updates (avoid unnecessary redraws)
- [ ] Proper list virtualization (LazyVStack/LazyHStack)
- [ ] Image loading optimization (async, caching)
- [ ] Minimal state changes (only update when needed)

### ✅ Code Quality
- [ ] Component Tokens used for all styling (never Primitives)
- [ ] No hardcoded colors, sizes, or spacing
- [ ] Follows SwiftUI naming conventions
- [ ] Convenience initializers for common use cases
- [ ] UIKit variant provided (if high-demand component)
- [ ] Proper documentation with usage examples

### ✅ Testing
- [ ] SwiftUI Previews for all states (default, pressed, disabled, selected)
- [ ] Unit tests for business logic
- [ ] UI tests for critical flows
- [ ] Tested on iPhone SE (smallest screen)
- [ ] Tested on iPad (largest screen)
- [ ] Tested in light and dark mode
- [ ] Tested with VoiceOver enabled
- [ ] Tested with large text sizes (Dynamic Type)

### ✅ Documentation
- [ ] iOS implementation guide created (`.claude/components/.../[component]-ios-implementation.md`)
- [ ] Token mapping table documented
- [ ] CSS → iOS translations documented
- [ ] iOS-specific adaptations documented
- [ ] Usage examples provided
- [ ] Common issues and solutions documented

---

## Related Documentation

### Core Concepts

- **[iOS Implementation Guide](.claude/iOS-IMPLEMENTATION-GUIDE.md)**
  - Master guide for iOS implementation
  - Design token hierarchy (CRITICAL)
  - Scroll-friendly gestures pattern
  - iOS touch guidelines

- **[Design Token Hierarchy](.claude/concepts/design-token-hierarchy.md)**
  - 3-tier token system (Component → Alias → Primitive)
  - When to use each tier
  - Dark mode handling
  - Token usage rules

- **[Scroll-Friendly Gestures](.claude/concepts/scroll-friendly-gestures.md)**
  - Why standard gestures fail in ScrollViews
  - UIControl-based solution
  - Instant feedback pattern
  - Implementation guide

- **[iOS Touch Guidelines](.claude/concepts/ios-touch-guidelines.md)**
  - iOS vs web touch differences
  - 44pt minimum touch target
  - State mapping (hover → pressed)
  - Accessibility requirements

### Component Guides

- **[Button iOS Implementation](.claude/components/Navigation/button-ios-implementation.md)**
  - Complete component implementation example
  - Token mapping tables
  - CSS → iOS parameter translation
  - Real-world usage examples

### Additional Resources

- **[Component Development Guide](../docs/COMPONENT_DEVELOPMENT.md)**
  - Step-by-step component creation workflow
  - Development patterns and conventions
  - Testing strategies

- **[Token System Guide](../docs/TOKEN_SYSTEM.md)**
  - Design token extraction process
  - Token file organization
  - Auto-generation workflow

### External References

- [Apple Human Interface Guidelines - Layout](https://developer.apple.com/design/human-interface-guidelines/layout)
- [Apple HIG - Touch Targets](https://developer.apple.com/design/human-interface-guidelines/inputs)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [UIKit Documentation](https://developer.apple.com/documentation/uikit/)

---

## Summary

This guide ensures:

- **Consistency**: All component translations follow the same patterns
- **Platform Appropriateness**: iOS-native patterns over web patterns
- **Visual Fidelity**: ELEVATE design system preserved via tokens
- **Accessibility**: Meets or exceeds iOS accessibility standards
- **Maintainability**: Clear rules for future updates and additions

**Key Philosophy**:
> "Make it feel iOS-native with ELEVATE's visual DNA, not a web app wrapped in native chrome."

**Golden Rules**:

1. **Always use Component Tokens** (never Primitives or hardcoded values)
2. **44pt minimum touch targets** (expand from web's 24-32px)
3. **No hover states** (combine hover + active → pressed)
4. **Scroll-friendly interactions** (don't block scrolling)
5. **Instant feedback** (<100ms perceived delay)
6. **Native patterns** (NavigationLink, sheets, context menus)
7. **Accessibility first** (VoiceOver, Dynamic Type, contrast)

Follow this guide for all component implementations to maintain quality and consistency across the ELEVATE iOS package.

---

**Version History**:
- **v1.0.0** (2025-11-06): Initial consolidated guide merging adaptation strategy and component translation patterns
