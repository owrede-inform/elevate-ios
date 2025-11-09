# ELEVATE Design Tokens - Usage Guide

Complete guide to using ELEVATE design tokens in iOS applications.

## Table of Contents

- [Token Hierarchy](#token-hierarchy)
- [Icon Sizes](#icon-sizes)
- [Spacing Scale](#spacing-scale)
- [Border Radius](#border-radius)
- [Typography](#typography)
- [Colors](#colors)
- [Shadows](#shadows)
- [When to Use Hardcoded Values](#when-to-use-hardcoded-values)
- [Common Patterns](#common-patterns)

---

## Token Hierarchy

ELEVATE tokens follow a 3-tier system:

```
Component Tokens (ButtonTokens, BadgeTokens)
    ↓ references
Alias Tokens (ElevateAliases)
    ↓ references
Primitive Tokens (ElevatePrimitives)
```

**Always use the highest-level token available** for your use case.

---

## Icon Sizes

### ✅ CORRECT - Use Tokenized Sizes

Icon sizes are already tokenized via `ElevateSpacing.IconSize`:

```swift
import ElevateUI

// Using ElevateIcon component (preferred)
ElevateIcon("heart.fill", size: .small)   // 16pt
ElevateIcon("heart.fill", size: .medium)  // 24pt
ElevateIcon("heart.fill", size: .large)   // 32pt
ElevateIcon("heart.fill", size: .xlarge)  // 48pt

// Using SF Symbols directly
Image(systemName: "heart.fill")
    .frame(
        width: ElevateSpacing.IconSize.medium,
        height: ElevateSpacing.IconSize.medium
    )
```

### ❌ INCORRECT - Don't Hardcode Icon Sizes

```swift
// Avoid hardcoded dimensions
Image(systemName: "heart.fill")
    .frame(width: 16, height: 16)  // ❌ Use ElevateSpacing.IconSize.small

Image(systemName: "star")
    .font(.system(size: 24))  // ❌ Use ElevateIcon("star", size: .medium)
```

---

## Spacing Scale

Use `ElevateSpacing` for all padding, margins, and gaps:

### Available Sizes

```swift
ElevateSpacing.xxxs  // 2pt  - Minimal spacing
ElevateSpacing.xxs   // 4pt  - Very small spacing
ElevateSpacing.xs    // 8pt  - Extra small
ElevateSpacing.s     // 12pt - Small
ElevateSpacing.m     // 16pt - Medium (default)
ElevateSpacing.l     // 24pt - Large
ElevateSpacing.xl    // 32pt - Extra large
ElevateSpacing.xxl   // 48pt - Very large
ElevateSpacing.xxxl  // 64pt - Maximum spacing
```

### ✅ CORRECT

```swift
VStack(spacing: ElevateSpacing.m) {
    Text("Title")
        .padding(ElevateSpacing.l)

    Divider()
        .padding(.horizontal, ElevateSpacing.xl)

    Button("Action") {}
        .padding(.vertical, ElevateSpacing.s)
}
```

### ❌ INCORRECT

```swift
VStack(spacing: 16) {  // ❌ Use ElevateSpacing.m
    Text("Title")
        .padding(24)  // ❌ Use ElevateSpacing.l
}
```

---

## Border Radius

Use `ElevateSpacing.BorderRadius` for consistent corner rounding:

```swift
// Available values
ElevateSpacing.BorderRadius.small   // 4pt
ElevateSpacing.BorderRadius.medium  // 8pt
ElevateSpacing.BorderRadius.large   // 12pt
ElevateSpacing.BorderRadius.xlarge  // 16pt
```

### ✅ CORRECT

```swift
RoundedRectangle(cornerRadius: ElevateSpacing.BorderRadius.medium)
    .fill(Color.blue)

Text("Badge")
    .padding(ElevateSpacing.s)
    .background(Color.red)
    .cornerRadius(ElevateSpacing.BorderRadius.small)
```

### ❌ INCORRECT

```swift
RoundedRectangle(cornerRadius: 8)  // ❌ Use ElevateSpacing.BorderRadius.medium

Text("Badge")
    .cornerRadius(4)  // ❌ Use ElevateSpacing.BorderRadius.small
```

---

## Typography

Use `ElevateTypography` for web-standard sizes or `ElevateTypographyiOS` for iOS-optimized sizes (+15% larger).

### Available Styles

```swift
// Display (largest)
ElevateTypography.displayLarge
ElevateTypography.displayMedium
ElevateTypography.displaySmall

// Headings
ElevateTypography.headingLarge
ElevateTypography.headingMedium
ElevateTypography.headingSmall

// Titles
ElevateTypography.titleLarge
ElevateTypography.titleMedium
ElevateTypography.titleSmall

// Body
ElevateTypography.bodyLarge
ElevateTypography.bodyMedium
ElevateTypography.bodySmall

// Labels
ElevateTypography.labelLarge
ElevateTypography.labelMedium
ElevateTypography.labelSmall
ElevateTypography.labelXSmall
```

### ✅ CORRECT

```swift
Text("Page Title")
    .font(ElevateTypographyiOS.headingLarge)  // iOS-optimized

Text("Section Title")
    .font(ElevateTypography.titleMedium)      // Web-standard

Text("Body content goes here")
    .font(ElevateTypographyiOS.bodyMedium)    // iOS-optimized
```

### ❌ INCORRECT

```swift
Text("Title")
    .font(.system(size: 24))  // ❌ Use ElevateTypography

Text("Emoji 🎉")
    .font(.system(size: 48))  // ⚠️ Acceptable for non-text content
```

**Note**: Hardcoded font sizes are acceptable for:
- Emoji displays
- Decorative numbers (countdown timers, scores)
- Icon sizing via `.font(.system(size:))`

---

## Colors

Use `ElevateAliases` for semantic colors that adapt to light/dark mode:

### Color Structure

```swift
ElevateAliases.Content.General.text_default      // Primary text
ElevateAliases.Content.General.text_understated  // Secondary text
ElevateAliases.Content.General.text_muted        // Tertiary text

ElevateAliases.Layout.Layer.ground               // Background
ElevateAliases.Layout.Layer.elevated             // Raised surfaces
ElevateAliases.Layout.Layer.overlay              // Overlays

ElevateAliases.Action.StrongPrimary.fill_default // Button fill
ElevateAliases.Action.StrongPrimary.text_default // Button text
ElevateAliases.Action.StrongPrimary.border_default // Button border

ElevateAliases.Feedback.General.text_success     // Success messages
ElevateAliases.Feedback.General.text_danger      // Error messages
ElevateAliases.Feedback.General.text_warning     // Warning messages
```

### ✅ CORRECT

```swift
Text("Title")
    .foregroundColor(ElevateAliases.Content.General.text_default)
    .background(ElevateAliases.Layout.Layer.ground)

Button("Action") {}
    .foregroundColor(ElevateAliases.Action.StrongPrimary.text_default)
    .background(ElevateAliases.Action.StrongPrimary.fill_default)
```

### ❌ INCORRECT

```swift
Text("Title")
    .foregroundColor(.black)  // ❌ Doesn't adapt to dark mode

Button("Action") {}
    .foregroundColor(.white)
    .background(.blue)  // ❌ Use semantic aliases
```

**Exception**: Demo-specific colors (category badges, illustrations) can use hardcoded values if documented in `DemoConfiguration`.

---

## Shadows

Use `ElevateShadow` for consistent depth effects:

```swift
// Available shadow types
ElevateShadow.small    // Subtle depth
ElevateShadow.medium   // Standard elevation
ElevateShadow.large    // Prominent elevation
ElevateShadow.xlarge   // Maximum elevation
ElevateShadow.dialog   // Modal overlays
```

### ✅ CORRECT

```swift
RoundedRectangle(cornerRadius: ElevateSpacing.BorderRadius.medium)
    .fill(Color.white)
    .shadow(
        color: ElevateShadow.medium.color,
        radius: ElevateShadow.medium.radius,
        x: ElevateShadow.medium.x,
        y: ElevateShadow.medium.y
    )
```

---

## When to Use Hardcoded Values

Hardcoded values are acceptable in these scenarios:

### ✅ Demo-Specific UI

Use `DemoConfiguration` for demo app constants:

```swift
// In DemoConfiguration.swift
public struct DemoConfiguration {
    public struct CategoryColors {
        public static let forms = Color(red: 0.0, green: 0.6, blue: 0.6)
    }
}

// In your demo view
CategoryCard(color: DemoConfiguration.CategoryColors.forms)
```

### ✅ Component-Specific Logic

Component tokens can define their own dimensions:

```swift
// In ButtonTokens.swift
public struct ButtonTokens {
    public enum Size {
        case small, medium, large

        public var height: CGFloat {
            switch self {
            case .small: return 36
            case .medium: return 44
            case .large: return 52
            }
        }
    }
}
```

### ✅ One-Off Designs

For unique layouts with documented rationale:

```swift
// Special case: Hero banner with specific dimensions
Image("hero")
    .frame(height: 300)  // ✅ Documented design requirement
```

### ✅ Non-Text Content

Emoji, decorative elements, and illustrations:

```swift
Text("🎉")
    .font(.system(size: 60))  // ✅ Emoji display size
```

---

## Common Patterns

### Card Layout

```swift
VStack(alignment: .leading, spacing: ElevateSpacing.m) {
    Text("Card Title")
        .font(ElevateTypography.titleMedium)
        .foregroundColor(ElevateAliases.Content.General.text_default)

    Text("Card description goes here")
        .font(ElevateTypography.bodySmall)
        .foregroundColor(ElevateAliases.Content.General.text_understated)
}
.padding(ElevateSpacing.l)
.background(ElevateAliases.Layout.Layer.elevated)
.cornerRadius(ElevateSpacing.BorderRadius.medium)
```

### Button with Icon

```swift
Button(action: { /* action */ }) {
    HStack(spacing: ElevateSpacing.s) {
        ElevateIcon("plus.circle.fill", size: .small)

        Text("Add Item")
            .font(ElevateTypography.labelMedium)
    }
    .padding(.horizontal, ElevateSpacing.l)
    .padding(.vertical, ElevateSpacing.m)
    .foregroundColor(ElevateAliases.Action.StrongPrimary.text_default)
    .background(ElevateAliases.Action.StrongPrimary.fill_default)
    .cornerRadius(ElevateSpacing.BorderRadius.small)
}
```

### List Item

```swift
HStack(spacing: ElevateSpacing.m) {
    Circle()
        .fill(ElevateAliases.Feedback.Strong.fill_success)
        .frame(
            width: ElevateSpacing.IconSize.small,
            height: ElevateSpacing.IconSize.small
        )

    VStack(alignment: .leading, spacing: ElevateSpacing.xxs) {
        Text("Item Title")
            .font(ElevateTypography.titleSmall)
            .foregroundColor(ElevateAliases.Content.General.text_default)

        Text("Subtitle")
            .font(ElevateTypography.labelSmall)
            .foregroundColor(ElevateAliases.Content.General.text_muted)
    }

    Spacer()

    Image(systemName: "chevron.right")
        .foregroundColor(ElevateAliases.Content.General.text_understated)
}
.padding(ElevateSpacing.m)
```

---

## Additional Resources

- **Design Token Generation**: `/scripts/update-design-tokens-v4.py`
- **iOS Deviations**: `/.claude/components/iOS-DEVIATIONS.md`
- **Component Status**: `/docs/COMPONENT_STATUS.md`
- **Main Documentation**: `/docs/DIVERSIONS.md`

---

## Questions?

If a token doesn't exist for your use case:

1. Check if it's demo-specific → Use `DemoConfiguration`
2. Check if it's component-specific → Add to `ComponentTokens`
3. Check if it's truly universal → Propose adding to `ElevateSpacing` or `ElevateAliases`
4. Document rationale inline if hardcoding is necessary

**When in doubt, ask in the team discussion or reference existing component implementations.**
