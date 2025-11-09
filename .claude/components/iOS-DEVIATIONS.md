# iOS Implementation Deviations from ELEVATE Web

Central index of all iOS-specific changes to ELEVATE Core UI components. For detailed implementation guides, see individual component files in this directory.

**Last Updated**: 2025-11-09

---

## Table of Contents

- [Universal iOS Adaptations](#universal-ios-adaptations)
- [Component-Specific Deviations](#component-specific-deviations)
- [UIKit Implementation Status](#uikit-implementation-status)
- [Token Adjustments](#token-adjustments)
- [Migration Guide](#migration-guide)
- [Adding New Deviations](#adding-new-ios-deviations)

---

## Universal iOS Adaptations

**All components** apply these iOS-specific changes:

### Touch Targets
- **Web**: 32px × 32px minimum
- **iOS**: 44pt × 44pt minimum (+37.5% increase)
- **Rationale**: Apple Human Interface Guidelines requirement for thumb accessibility

### Typography
- **Web**: Standard rem-based sizes
- **iOS**: +15% larger text sizes, Dynamic Type support
- **Rationale**: Mobile readability and Apple HIG compliance

### Spacing
- **Web**: Standard padding/margins
- **iOS**: Increased by 1.15× for touch target compliance
- **Rationale**: Ensure adequate spacing for touch interactions

### Haptic Feedback
- **Web**: N/A
- **iOS**: Native UIFeedbackGenerator on interactions
- **Rationale**: iOS user expectation for tactile feedback

### Hover States
- **Web**: CSS `:hover` pseudoclass
- **iOS**: Long-press or button state changes
- **Rationale**: Touch devices don't have hover

---

## Component-Specific Deviations

Detailed differences for each implemented component:

| Component | Key Differences | Rationale | Doc Link |
|-----------|-----------------|-----------|----------|
| **Forms** |
| Button | Heights: 36/44/52pt (vs 32/40/48px) | Touch targets | [Button.md](Navigation/button-ios-implementation.md) |
| Button Group | Connected buttons with shared borders, iOS 16+ | UnevenRoundedRectangle API | - |
| Checkbox | Custom SwiftUI toggle with SF Symbols | Native iOS appearance | - |
| Dropzone | File picker via UIDocumentPickerViewController | iOS file system access | - |
| Icon Button | 44pt minimum touch target | iOS HIG compliance | - |
| Radio Button | Custom circle with animation | SwiftUI idiom | - |
| Slider | Native Slider wrapper with ELEVATE styling | iOS gesture handling | - |
| Select | Picker/Menu hybrid based on options count | iOS pattern | - |
| Switch | Native Toggle with ELEVATE colors | iOS user expectation | - |
| Text Field | UITextInputTraits for keyboard types | Platform integration | - |
| Text Area | TextEditor with character count overlay | iOS multiline input | - |
| **Navigation** |
| Breadcrumb | Horizontal scrolling for overflow | Touch-friendly navigation | - |
| Link | Native Link component (iOS 14+) | SwiftUI API | - |
| Menu | Native Menu API (iOS 14+) | iOS context menu pattern | - |
| Paginator | Touch-optimized page indicators | Larger tap targets | - |
| Stepper | Vertical layout option for mobile | Space efficiency | - |
| Tab Bar | Bottom-aligned with SF Symbol icons | iOS navigation pattern | - |
| **Feedback** |
| Dialog | Uses `.sheet()` or `.fullScreenCover()` | iOS modal presentation | - |
| Empty State | Portrait/landscape layout adaptation | Mobile screen orientation | - |
| Notification | Toast-style with auto-dismiss | iOS notification pattern | - |
| Progress | Both determinate and indeterminate styles | iOS loading patterns | - |
| Skeleton | Animated shimmer effect | iOS loading placeholder | - |
| **Overlays** |
| Drawer | Slide-in from edge with gesture dismiss | iOS sheet pattern | - |
| Dropdown | Uses Menu API (iOS 14+) | Native iOS component | - |
| Indicator | Activity indicator + custom views | iOS loading indicator | - |
| Lightbox | Full-screen image viewer with gestures | iOS photo viewing pattern | - |
| Tooltip | Long-press activation | Touch-based trigger | - |
| **Display** |
| Badge | Pill shape uses `.infinity` corner radius | SwiftUI idiom | [Badge.md](Badge.md) |
| Card | Shadow system via ElevateShadow | iOS depth representation | - |
| Chip | Increased horizontal padding | Touch target compliance | [Chip.md](Chip.md) |
| Table | List-based with swipe actions | iOS table view pattern | - |
| Tree | Disclosure groups with animation | SwiftUI hierarchy UI | - |
| **Image & Icon** |
| Avatar | Async image loading | iOS image handling | - |
| Icon | SF Symbols integration | iOS native icons | - |
| **Structure** |
| Application | NavigationView/NavigationStack | iOS navigation container | - |
| Divider | Uses native Divider() | SwiftUI component | - |
| Expansion Panel | DisclosureGroup wrapper | SwiftUI collapsible UI | - |
| Headline | Dynamic Type support | iOS accessibility | - |
| Split Panel | Horizontal split for iPad, vertical for iPhone | Responsive layout | - |
| Stack | Native VStack/HStack | SwiftUI layout | - |
| Toolbar | Uses native .toolbar() modifier | iOS toolbar API | - |

---

## UIKit Implementation Status

### Implemented (3 components)

These components have UIKit wrappers for Interface Builder and legacy app support:

| Component | Implementation Type | Interface Builder | Status |
|-----------|---------------------|-------------------|--------|
| **Button** | Full UIControl wrapper | @IBDesignable/@IBInspectable | ✅ Complete |
| **Badge** | UIView wrapper | @IBDesignable | ✅ Complete |
| **Chip** | UIControl wrapper | @IBDesignable/@IBInspectable | ✅ Complete |

**Pattern**: All UIKit implementations are **wrappers** around SwiftUI components via `UIHostingController`.

### Planned

High-demand components for UIKit app integration:

- Menu (contextual actions)
- Tab Bar (main navigation)
- Navigation Item (navigation bar integration)

### Not Planned

Components tightly coupled to SwiftUI APIs:

- Visually Hidden (accessibility-only, SwiftUI-specific)
- Dynamic layout components (Stack, Split Panel)
- SwiftUI-exclusive modifiers

---

## Token Adjustments

### Typography Scaling

All text sizes increased by **+15%** for mobile readability:

| Web (rem) | Web (px) | iOS (pt) | Change |
|-----------|----------|----------|--------|
| **Display** |
| 3.5rem | 56px | 64pt | +14.3% |
| 2.75rem | 44px | 51pt | +15.9% |
| 2.25rem | 36px | 41pt | +13.9% |
| **Heading** |
| 2rem | 32px | 37pt | +15.6% |
| 1.75rem | 28px | 32pt | +14.3% |
| 1.5rem | 24px | 28pt | +16.7% |
| **Body** |
| 1.125rem | 18px | 21pt | +16.7% |
| 1rem | 16px | 16pt | 0% (Apple minimum) |
| 0.875rem | 14px | 16pt | +14.3% |

See: [`TEXT_SIZE_ADAPTATIONS.md`](../../docs/TEXT_SIZE_ADAPTATIONS.md) for complete table.

### Spacing Adjustments

Touch target padding auto-adjusted to meet 44pt minimum:

```swift
// Web: 0.75rem (12px) padding
// iOS: 12pt base padding + auto-adjustment for 44pt total height

// Example Button heights:
// Small:  36pt (web: 32px) - +12.5%
// Medium: 44pt (web: 40px) - +10%
// Large:  52pt (web: 48px) - +8.3%
```

### Color Implementation

No color **values** change, only implementation:

- Web: CSS color values, media queries for dark mode
- iOS: SwiftUI `Color.adaptive(light:dark:)` for automatic appearance switching

---

## Migration Guide

Converting web implementations to iOS:

### Step 1: Identify Component

Find component doc in `.claude/components/[Category]/`

```
.claude/components/
├── Navigation/
│   └── button-ios-implementation.md
├── Badge.md
├── Chip.md
└── ... (52 component docs)
```

### Step 2: Check Token Mapping

Refer to component-specific doc for token translations:

```markdown
## Token Mapping

| Web Token | iOS Token | Notes |
|-----------|-----------|-------|
| `--button-height-medium` | `ButtonTokens.Size.medium.height` | 44pt (vs 40px) |
| `--button-padding-horizontal` | `ElevateSpacing.l` | 24pt |
```

### Step 3: Apply iOS Adaptations

Implement Universal + Component-Specific changes:

```swift
// Universal: Touch targets
.frame(minHeight: 44)  // iOS requirement

// Universal: Typography
.font(ElevateTypographyiOS.bodyMedium)  // +15% size

// Component-Specific: Button
.frame(height: ButtonTokens.Size.medium.height)  // 44pt
```

### Step 4: Use Token Wrappers

Follow hierarchy: Component Tokens → Aliases → Primitives

```swift
// ✅ Best: Component tokens
ButtonTokens.Size.medium.height

// ✅ Good: Aliases
ElevateAliases.Action.StrongPrimary.fill_default

// ⚠️ Only if needed: Primitives
ElevatePrimitives.Blue._500
```

### Step 5: Test Accessibility

Verify iOS-specific accessibility:

- Dynamic Type (Settings → Accessibility → Display & Text Size)
- VoiceOver (triple-click side button)
- Touch target size (min 44pt × 44pt)
- Dark mode appearance

---

## Adding New iOS Deviations

When documenting new iOS-specific changes:

### 1. Update This Index

Add row to "Component-Specific Deviations" table:

```markdown
| Component Name | Key Differences | Rationale | Doc Link |
|----------------|-----------------|-----------|----------|
| New Component | Changes made | Why changed | [Link.md](path/to/doc.md) |
```

### 2. Create/Update Component Doc

In `.claude/components/[Category]/[component]-ios-implementation.md`:

```markdown
## iOS Adaptations

### Change 1: Touch Target Size
- **Web**: 32px height
- **iOS**: 44pt height
- **Rationale**: Apple HIG requirement

### Change 2: Gesture Handling
- **Web**: Click events
- **iOS**: ScrollFriendlyGestures utility
- **Rationale**: Prevent scroll blocking
```

### 3. Document Rationale

Always include **why** the change was made:

- Apple HIG requirement
- SwiftUI API limitation
- iOS user expectation
- Platform idiom
- Technical constraint

### 4. Include Code Examples

Show both web pattern and iOS implementation:

```swift
// Web pattern (conceptual):
// <button class="elevate-button">Click</button>

// iOS implementation:
ElevateButton("Click", size: .medium, tone: .primary) {
    // action
}
```

### 5. Link Related Components

If changes affect multiple components, cross-reference:

```markdown
See also:
- [Button.md](Navigation/button-ios-implementation.md) - Parent component
- [IconButton.md](IconButton.md) - Related pattern
```

---

## Quick Reference

### Documentation Structure

```
elevate-ios/
├── .claude/components/
│   ├── iOS-DEVIATIONS.md          ← YOU ARE HERE
│   ├── Navigation/
│   │   └── button-ios-implementation.md
│   ├── Badge.md
│   ├── Chip.md
│   └── ... (52 component docs)
├── docs/
│   ├── DIVERSIONS.md               ← Master deviation guide
│   ├── TEXT_SIZE_ADAPTATIONS.md    ← Typography table
│   ├── COMPONENT_STATUS.md         ← Implementation tracking
│   └── WEB_TO_IOS_TRANSLATION.md   ← Translation patterns
└── ElevateUI/Sources/DesignTokens/
    └── USAGE_GUIDE.md              ← Token usage patterns
```

### Key Documentation Files

1. **iOS-DEVIATIONS.md** (this file) - Central index
2. **DIVERSIONS.md** - Master guide with philosophy
3. **USAGE_GUIDE.md** - Design token usage
4. **Component docs** - Detailed implementation per component

---

## Questions?

- **General iOS adaptations**: See [`DIVERSIONS.md`](../../docs/DIVERSIONS.md)
- **Token usage**: See [`USAGE_GUIDE.md`](../../ElevateUI/Sources/DesignTokens/USAGE_GUIDE.md)
- **Component status**: See [`COMPONENT_STATUS.md`](../../docs/COMPONENT_STATUS.md)
- **Update procedure**: See [`DIVERSIONS.md` § Update Procedure](../../docs/DIVERSIONS.md#update-procedure)

**For implementation questions, reference existing component documentation or consult the team.**
