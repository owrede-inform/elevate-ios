# Component Development Guide

**Version**: 2.0
**Date**: 2025-11-06
**Purpose**: Complete guide for developing and refactoring ELEVATE iOS components

---

## Table of Contents

1. [Quick Start Workflow](#quick-start-workflow)
2. [Incremental Development Strategy](#incremental-development-strategy)
3. [Component Implementation Pattern](#component-implementation-pattern)
4. [Refactoring Existing Components](#refactoring-existing-components)
5. [Component Status & Audit](#component-status--audit)
6. [Scroll-Friendly Gesture Pattern](#scroll-friendly-gesture-pattern)
7. [Testing Checklist](#testing-checklist)
8. [Common Patterns & Best Practices](#common-patterns--best-practices)
9. [Troubleshooting](#troubleshooting)
10. [Related Documentation](#related-documentation)

---

## Quick Start Workflow

### The Problem We Solved

**Before:** Adding new components broke the entire build, requiring manual file disabling and wasting development time.

**Now:** Use `.wip` file extensions to isolate in-development work from stable code.

### The Solution (One Line)

**All new/incomplete components use `.wip` extension - Xcode won't compile them.**

### 5-Step Workflow for New Components

#### Step 1: Create Token File (WIP)
```bash
cd ElevateUI/Sources/DesignTokens/Components/
touch NewComponentTokens.swift.wip
```

#### Step 2: Implement Tokens
- Copy from existing component as template
- Update to match design system specs
- Test compilation: `mv file.wip file.swift; xcodebuild; mv file.swift file.wip`

#### Step 3: Create Component File (WIP)
```bash
cd ElevateUI/Sources/SwiftUI/Components/
touch ElevateNewComponent+SwiftUI.swift.wip
```

#### Step 4: Implement Component
- Use stable components as reference
- Test incrementally in `.wip` state
- Follow [Component Implementation Pattern](#component-implementation-pattern)

#### Step 5: Activate When Ready
```bash
# Activate the component
mv NewComponentTokens.swift.wip NewComponentTokens.swift
mv ElevateNewComponent+SwiftUI.swift.wip ElevateNewComponent+SwiftUI.swift

# Update ComponentRegistry
# In ComponentRegistry.swift:
# ComponentItem(id: "new-component", name: "New Component",
#               isImplemented: true, hasSwiftUI: true, hasUIKit: false)
```

### Quick Disable (Rollback)

If something breaks after activation:

```bash
# Instant rollback
mv NewComponentTokens.swift NewComponentTokens.swift.wip
mv ElevateNewComponent+SwiftUI.swift ElevateNewComponent+SwiftUI.swift.wip
```

### File Extension Reference

| Extension | Meaning | Compiled? |
|-----------|---------|-----------|
| `.swift` | Stable, working code | ✅ Yes |
| `.swift.wip` | Work in progress | ❌ No |
| `.swift.disabled` | Broken, needs fixing | ❌ No |

---

## Incremental Development Strategy

### Why Use .wip Files?

**Advantages:**
- No build configuration needed
- Files with `.wip` aren't compiled by Xcode
- Simple to enable: just rename file
- Clear visual indicator in file browser
- No more build breakage from incomplete work
- Faster development with incremental testing

### The .wip File Pattern

All new components follow this lifecycle:

```
1. Create with .wip extension
   └─> 2. Develop & test in isolation
       └─> 3. Activate by removing .wip
           └─> 4. If breaks, quickly re-disable
```

### Build Integration

**.wip files are automatically excluded:**
- Xcode ignores them during compilation
- No Package.swift changes needed
- No conditional compilation flags required
- Works across all build configurations

### Component Development Checklist

Before implementing a new component, complete these steps **in order**:

#### Phase 1: Token Preparation
- [ ] Generate token definitions from design system
- [ ] Verify all token properties exist in generated files
- [ ] Create wrapper token file (e.g., `RadioTokens.swift.wip`)
- [ ] Test that tokens compile independently
- [ ] Keep as `.wip` until component is ready

#### Phase 2: Component Scaffolding
- [ ] Create component file with `.wip` extension
- [ ] Import required tokens
- [ ] Define basic structure
- [ ] Test compilation with temporary activation

#### Phase 3: Implementation
- [ ] Implement component logic
- [ ] Add SwiftUI previews
- [ ] Test in isolation
- [ ] Document usage
- [ ] Apply scroll-friendly gestures if interactive

#### Phase 4: Activation
- [ ] Remove `.wip` extension from both token and component files
- [ ] Update ComponentRegistry to mark as implemented
- [ ] Add to component showcase
- [ ] Verify build succeeds
- [ ] Test in both light and dark mode
- [ ] Commit to repository

---

## Component Implementation Pattern

### Standard Component Structure

All ELEVATE components follow this pattern:

```swift
#if os(iOS)
import SwiftUI

/// ELEVATE YourComponent - Brief description
///
/// Example:
/// ```swift
/// ElevateYourComponent(action: { print("Tapped") })
/// ```
@available(iOS 15, *)
public struct ElevateYourComponent: View {
    // MARK: - Properties
    private let action: () -> Void
    private let isDisabled: Bool
    private let tone: ComponentTone
    private let size: ComponentSize

    // MARK: - Tokens
    private let tokens = YourComponentTokens.self

    // MARK: - State
    @State private var isPressed = false

    // MARK: - Initialization
    public init(
        tone: ComponentTone = .primary,
        size: ComponentSize = .medium,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.tone = tone
        self.size = size
        self.isDisabled = isDisabled
        self.action = action
    }

    // MARK: - Body
    public var body: some View {
        HStack(spacing: tokenGap) {
            // Component content
            Text("Content")
        }
        .padding(.horizontal, tokenHorizontalPadding)
        .padding(.vertical, tokenVerticalPadding)
        .frame(height: tokenHeight)
        .background(backgroundColor)
        .foregroundColor(labelColor)
        .cornerRadius(tokenCornerRadius)
        .opacity(isDisabled ? 0.5 : 1.0)
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

    // MARK: - Token Accessors
    private var tokenHeight: CGFloat {
        switch size {
        case .small: return tokens.height_s
        case .medium: return tokens.height_m
        case .large: return tokens.height_l
        }
    }

    private var tokenHorizontalPadding: CGFloat {
        switch size {
        case .small: return tokens.padding_inline_s
        case .medium: return tokens.padding_inline_m
        case .large: return tokens.padding_inline_l
        }
    }

    private var tokenVerticalPadding: CGFloat {
        switch size {
        case .small: return tokens.padding_block_s
        case .medium: return tokens.padding_block_m
        case .large: return tokens.padding_block_l
        }
    }

    private var tokenGap: CGFloat {
        switch size {
        case .small: return tokens.gap_s
        case .medium: return tokens.gap_m
        case .large: return tokens.gap_l
        }
    }

    private var tokenCornerRadius: CGFloat {
        tokens.border_radius_m
    }

    // MARK: - Color Accessors
    private var backgroundColor: Color {
        if isDisabled {
            return backgroundColorDisabled
        }
        return isPressed ? backgroundColorActive : backgroundColorDefault
    }

    private var backgroundColorDefault: Color {
        switch tone {
        case .primary: return tokens.fill_primary_default
        case .secondary: return tokens.fill_secondary_default
        case .danger: return tokens.fill_danger_default
        case .success: return tokens.fill_success_default
        }
    }

    private var backgroundColorActive: Color {
        switch tone {
        case .primary: return tokens.fill_primary_active
        case .secondary: return tokens.fill_secondary_active
        case .danger: return tokens.fill_danger_active
        case .success: return tokens.fill_success_active
        }
    }

    private var backgroundColorDisabled: Color {
        switch tone {
        case .primary: return tokens.fill_primary_disabled
        case .secondary: return tokens.fill_secondary_disabled
        case .danger: return tokens.fill_danger_disabled
        case .success: return tokens.fill_success_disabled
        }
    }

    private var labelColor: Color {
        if isDisabled {
            return labelColorDisabled
        }
        return isPressed ? labelColorActive : labelColorDefault
    }

    private var labelColorDefault: Color {
        switch tone {
        case .primary: return tokens.label_primary_default
        case .secondary: return tokens.label_secondary_default
        case .danger: return tokens.label_danger_default
        case .success: return tokens.label_success_default
        }
    }

    private var labelColorActive: Color {
        switch tone {
        case .primary: return tokens.label_primary_active
        case .secondary: return tokens.label_secondary_active
        case .danger: return tokens.label_danger_active
        case .success: return tokens.label_success_active
        }
    }

    private var labelColorDisabled: Color {
        switch tone {
        case .primary: return tokens.label_primary_disabled
        case .secondary: return tokens.label_secondary_disabled
        case .danger: return tokens.label_danger_disabled
        case .success: return tokens.label_success_disabled
        }
    }
}

// MARK: - Supporting Types
public enum ComponentTone {
    case primary
    case secondary
    case danger
    case success
}

public enum ComponentSize {
    case small
    case medium
    case large
}

// MARK: - Previews
#if DEBUG
struct ElevateYourComponent_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // All tones
            ElevateYourComponent(tone: .primary) { print("Primary") }
            ElevateYourComponent(tone: .secondary) { print("Secondary") }
            ElevateYourComponent(tone: .danger) { print("Danger") }
            ElevateYourComponent(tone: .success) { print("Success") }

            // All sizes
            ElevateYourComponent(size: .small) { print("Small") }
            ElevateYourComponent(size: .medium) { print("Medium") }
            ElevateYourComponent(size: .large) { print("Large") }

            // Disabled state
            ElevateYourComponent(isDisabled: true) { print("Disabled") }
        }
        .padding()
    }
}
#endif
#endif
```

### Token Wrapper Structure

Create a wrapper for generated component tokens:

```swift
import SwiftUI

/// Wrapper for generated YourComponentComponentTokens with convenient access
public struct YourComponentTokens {
    // MARK: - Colors - Fill
    public static let fill_primary_default = YourComponentComponentTokens.fill_primary_default
    public static let fill_primary_active = YourComponentComponentTokens.fill_primary_active
    public static let fill_primary_disabled = YourComponentComponentTokens.fill_primary_disabled

    public static let fill_secondary_default = YourComponentComponentTokens.fill_secondary_default
    public static let fill_secondary_active = YourComponentComponentTokens.fill_secondary_active
    public static let fill_secondary_disabled = YourComponentComponentTokens.fill_secondary_disabled

    // MARK: - Colors - Label
    public static let label_primary_default = YourComponentComponentTokens.label_primary_default
    public static let label_primary_active = YourComponentComponentTokens.label_primary_active
    public static let label_primary_disabled = YourComponentComponentTokens.label_primary_disabled

    public static let label_secondary_default = YourComponentComponentTokens.label_secondary_default
    public static let label_secondary_active = YourComponentComponentTokens.label_secondary_active
    public static let label_secondary_disabled = YourComponentComponentTokens.label_secondary_disabled

    // MARK: - Colors - Border
    public static let border_default = YourComponentComponentTokens.border_default
    public static let border_active = YourComponentComponentTokens.border_active

    // MARK: - Dimensions
    public static let height_s: CGFloat = YourComponentComponentTokens.height_s
    public static let height_m: CGFloat = YourComponentComponentTokens.height_m
    public static let height_l: CGFloat = YourComponentComponentTokens.height_l

    public static let padding_inline_s: CGFloat = YourComponentComponentTokens.padding_inline_s
    public static let padding_inline_m: CGFloat = YourComponentComponentTokens.padding_inline_m
    public static let padding_inline_l: CGFloat = YourComponentComponentTokens.padding_inline_l

    public static let padding_block_s: CGFloat = YourComponentComponentTokens.padding_block_s
    public static let padding_block_m: CGFloat = YourComponentComponentTokens.padding_block_m
    public static let padding_block_l: CGFloat = YourComponentComponentTokens.padding_block_l

    public static let gap_s: CGFloat = YourComponentComponentTokens.gap_s
    public static let gap_m: CGFloat = YourComponentComponentTokens.gap_m
    public static let gap_l: CGFloat = YourComponentComponentTokens.gap_l

    public static let border_radius_m: CGFloat = YourComponentComponentTokens.border_radius_m
    public static let border_width: CGFloat = YourComponentComponentTokens.border_width
}
```

---

## Refactoring Existing Components

### Overview

This section shows how to refactor existing components to use ELEVATE design tokens instead of hardcoded values.

**Why Refactor?**
- ✅ Automatic dark mode support
- ✅ Consistent with ELEVATE design system
- ✅ Updates automatically when ELEVATE updates
- ✅ Type-safe, compile-time validated
- ✅ No manual RGB value management

### Token Hierarchy (CRITICAL)

```
Component Tokens (FIRST CHOICE)
    ↓ use when no component token exists
Alias Tokens (SECOND CHOICE)
    ↓ NEVER use directly
Primitive Tokens (DO NOT USE)
```

**Rule of Thumb**:
1. Look for Component token first
2. Use Alias token if no Component token exists
3. Never use Primitive tokens directly (no dark mode support)

### Step-by-Step Refactoring Process

#### Step 1: Identify Hardcoded Values

**Find hardcoded colors:**
```bash
# Search for Color constructors with RGB values
grep -r "Color(red:" ElevateUI/Sources/SwiftUI/Components/
grep -r "Color\\..*blue\\|red\\|green" ElevateUI/Sources/SwiftUI/Components/

# Search for hex colors
grep -r "#[0-9A-Fa-f]\{6\}" ElevateUI/Sources/SwiftUI/Components/
```

**Find hardcoded spacing:**
```bash
# Search for hardcoded padding/frame values
grep -r "padding.*[0-9]" ElevateUI/Sources/SwiftUI/Components/
grep -r "frame.*height:.*[0-9]" ElevateUI/Sources/SwiftUI/Components/
```

#### Step 2: Find the Correct Token

**For Colors:**

Token naming pattern:
```
{component}ComponentTokens.{element}_{tone}_{state}

Examples:
ButtonComponentTokens.fill_primary_default
ButtonComponentTokens.label_danger_active
ChipComponentTokens.border_secondary_hover
```

**Search for available tokens:**
```bash
# List all button tokens
grep "public static let" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Search for specific token pattern
grep "fill_danger" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift
```

**For Spacing/Dimensions:**

Token naming pattern:
```
{component}ComponentTokens.{property}_{size}

Examples:
ButtonComponentTokens.height_m           // 40pt
ButtonComponentTokens.padding_inline_m   // 12pt
ButtonComponentTokens.gap_s              // 4pt
ButtonComponentTokens.border_radius_m    // 4pt
```

**Size suffixes:**
- `_s` = Small
- `_m` = Medium (default)
- `_l` = Large

#### Step 3: Apply the Token

See [Refactoring Patterns](#refactoring-patterns) below for specific examples.

#### Step 4: Verify the Refactoring

**Build Verification:**
```bash
# Ensure it compiles
swift build

# Expected: Build complete! (0.XX s)
```

**Visual Verification:**
```bash
# Run the app in light mode
# Verify colors match ELEVATE design

# Switch to dark mode (Settings → Appearance → Dark)
# Verify dark mode colors work automatically
```

**Token Verification:**
```bash
# Verify token exists in generated file
grep "fill_primary_default" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Expected output:
# public static let fill_primary_default = Color.adaptive(...)
```

### Refactoring Patterns

#### Pattern 1: Hardcoded Colors → Component Tokens

**❌ Before (Hardcoded):**
```swift
struct MyButton: View {
    var body: some View {
        Text("Delete")
            .foregroundColor(Color.white)
            .background(Color(red: 0.8078, green: 0.0039, blue: 0.0039))
    }
}
```

**✅ After (Using Tokens):**
```swift
struct MyButton: View {
    var body: some View {
        Text("Delete")
            .foregroundColor(ButtonComponentTokens.label_danger_default)
            .background(ButtonComponentTokens.fill_danger_default)
    }
}
```

#### Pattern 2: Hardcoded Spacing → Component Tokens

**❌ Before (Hardcoded):**
```swift
struct MyButton: View {
    var body: some View {
        Text("Click Me")
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 40)
    }
}
```

**✅ After (Using Tokens):**
```swift
struct MyButton: View {
    var body: some View {
        Text("Click Me")
            .padding(.horizontal, ButtonComponentTokens.padding_inline_m)
            .padding(.vertical, ButtonComponentTokens.padding_block_m)
            .frame(height, ButtonComponentTokens.height_m)
    }
}
```

#### Pattern 3: State-Based Colors → Component Tokens

**❌ Before (Hardcoded):**
```swift
struct MyButton: View {
    @State private var isPressed = false

    var body: some View {
        Text("Press Me")
            .background(isPressed
                ? Color(red: 0.42, green: 0.0, blue: 0.0)  // Darker red
                : Color(red: 0.81, green: 0.0, blue: 0.0)) // Normal red
    }
}
```

**✅ After (Using Tokens):**
```swift
struct MyButton: View {
    @State private var isPressed = false

    var body: some View {
        Text("Press Me")
            .background(isPressed
                ? ButtonComponentTokens.fill_danger_active
                : ButtonComponentTokens.fill_danger_default)
    }
}
```

**Key Point**: ELEVATE defines separate tokens for each state (default, hover, active, disabled).

#### Pattern 4: Border Styling → Component Tokens

**❌ Before (Hardcoded):**
```swift
.overlay(
    RoundedRectangle(cornerRadius: 4)
        .stroke(Color.gray, lineWidth: 1)
)
```

**✅ After (Using Tokens):**
```swift
.overlay(
    RoundedRectangle(cornerRadius: ButtonComponentTokens.border_radius_m)
        .stroke(ButtonComponentTokens.border_default, lineWidth: ButtonComponentTokens.border_width)
)
```

#### Pattern 5: When No Component Token Exists → Use Alias Tokens

**❌ Before (Hardcoded):**
```swift
struct AppBackground: View {
    var body: some View {
        Color(red: 0.98, green: 0.98, blue: 0.98)
            .ignoresSafeArea()
    }
}
```

**✅ After (Using Alias Token):**
```swift
struct AppBackground: View {
    var body: some View {
        ElevateAliases.Layout.LayerAppbackground.default_color
            .ignoresSafeArea()
    }
}
```

**When to use Alias tokens:**
- No component-specific token exists
- App-level styling (backgrounds, global layouts)
- Custom components not in ELEVATE

### Common Refactoring Scenarios

#### Scenario 1: Multiple Tones (Primary, Danger, Success)

Use computed properties with switch statements:

```swift
struct ElevateButton: View {
    let tone: ButtonTone

    var body: some View {
        Text("Button")
            .foregroundColor(labelColor)
            .background(backgroundColor)
    }

    private var backgroundColor: Color {
        switch tone {
        case .primary:
            return ButtonComponentTokens.fill_primary_default
        case .danger:
            return ButtonComponentTokens.fill_danger_default
        case .secondary:
            return ButtonComponentTokens.fill_secondary_default
        case .success:
            return ButtonComponentTokens.fill_success_default
        }
    }

    private var labelColor: Color {
        switch tone {
        case .primary:
            return ButtonComponentTokens.label_primary_default
        case .danger:
            return ButtonComponentTokens.label_danger_default
        case .secondary:
            return ButtonComponentTokens.label_secondary_default
        case .success:
            return ButtonComponentTokens.label_success_default
        }
    }
}
```

#### Scenario 2: Multiple States (Default, Hover, Active, Disabled)

Use @State and computed properties:

```swift
struct ElevateButton: View {
    let tone: ButtonTone
    @State private var isPressed = false
    @State private var isDisabled = false

    var body: some View {
        Text("Button")
            .foregroundColor(labelColor)
            .background(backgroundColor)
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

    private var backgroundColor: Color {
        if isDisabled {
            return ButtonComponentTokens.fill_primary_disabled
        }
        return isPressed
            ? ButtonComponentTokens.fill_primary_active
            : ButtonComponentTokens.fill_primary_default
    }
}
```

**Note**: SwiftUI doesn't have native hover on iOS. Use `.onLongPressGesture(minimumDuration: 0)` for hover-like effects if needed.

#### Scenario 3: Custom Components (Not in ELEVATE)

Use Alias tokens for semantic meaning:

```swift
struct CustomStatusBadge: View {
    let status: Status

    var body: some View {
        Text(status.rawValue)
            .foregroundColor(textColor)
            .background(backgroundColor)
            .padding(8)
            .cornerRadius(4)
    }

    private var backgroundColor: Color {
        switch status {
        case .success:
            // Use Alias tokens when no Component token exists
            return ElevateAliases.Feedback.Positive.fill_default
        case .error:
            return ElevateAliases.Feedback.Negative.fill_default
        case .warning:
            return ElevateAliases.Feedback.Warning.fill_default
        }
    }

    private var textColor: Color {
        switch status {
        case .success:
            return ElevateAliases.Feedback.Positive.label_default
        case .error:
            return ElevateAliases.Feedback.Negative.label_default
        case .warning:
            return ElevateAliases.Feedback.Warning.label_default
        }
    }
}
```

### Refactoring Checklist

#### Before Starting
- [ ] Run `python3 scripts/update-design-tokens-v3.py` to ensure tokens are up-to-date
- [ ] Verify build is working: `swift build`
- [ ] Create a feature branch: `git checkout -b refactor/component-name-tokens`

#### During Refactoring
- [ ] Identify all hardcoded values (colors, spacing, dimensions)
- [ ] Find correct Component tokens (or Alias if no Component token exists)
- [ ] Replace hardcoded values with token references
- [ ] Remove any unused color/spacing constants
- [ ] Add state support (default, active, disabled) if needed
- [ ] Add tone support (primary, danger, etc.) if needed

#### After Refactoring
- [ ] Build succeeds: `swift build`
- [ ] Visual verification in light mode
- [ ] Visual verification in dark mode
- [ ] All states work (default, active, disabled)
- [ ] All tones work (primary, danger, secondary)
- [ ] No hardcoded values remain
- [ ] Commit changes: `git commit -m "Refactor ComponentName to use ELEVATE tokens"`

### Migration Priority

#### High Priority (User-Facing Components)
1. **Buttons** - Most visible, used everywhere
2. **Chips** - Common UI element
3. **Cards** - Content containers
4. **Form Controls** - Text fields, checkboxes, radio buttons

#### Medium Priority (Navigation)
5. **Tabs** - Navigation elements
6. **Breadcrumbs** - Navigation aids
7. **Menus** - Dropdown/navigation menus

#### Low Priority (Specialized)
8. **Tooltips** - Helper UI
9. **Badges** - Status indicators
10. **Dividers** - Visual separators

---

## Component Status & Audit

### Current Component Status

**Date**: 2025-11-06
**Last Build**: Successful
**iOS Deployment Target**: 26.1

#### ✅ Stable & Working
- **ElevateButton** (SwiftUI + UIKit) - Full token integration
- **ElevateBadge** (SwiftUI + UIKit) - Full token integration
- **ElevateChip** (SwiftUI + UIKit) - Full token integration

#### 🚧 In Development (.wip)
- **ElevateRadio+SwiftUI.swift.wip** - Awaiting token completion

#### ⚠️ Disabled (Broken Token Definitions)
- CheckboxTokens.swift.disabled
- SwitchTokens.swift.disabled
- RadioTokens.swift.disabled
- ElevateCheckbox+SwiftUI.swift.disabled
- ElevateSwitch+SwiftUI.swift.disabled

### Critical Issues

#### Issue 1: ElevateSpacing File Missing

**Severity**: 🔴 HIGH
**Status**: Build succeeds (likely cached), but source missing

**Problem:**
- ElevateSpacing is referenced in 7 files:
  - `ElevateButton+SwiftUI.swift:160`
  - `ElevateTextField+SwiftUI.swift`
  - `ButtonTokens.swift:38,55,56`
  - `ChipTokens.swift:55,174-202`
  - `BadgeTokens.swift:54,127-142`
  - `ElevateIcon.swift`

**Example Usage:**
```swift
// ButtonTokens.swift:38
public var componentSize: ElevateSpacing.ComponentSize {
    switch self {
    case .small: return .small
    case .medium: return .medium
    case .large: return .large
    }
}
```

**Solution:**
Replace all `ElevateSpacing.*` references with equivalent component tokens (e.g., `ButtonComponentTokens.*`, `ChipComponentTokens.*`)

### Hardcoded Values by File

#### 1. ElevateMenu+SwiftUI.swift

**Location**: Line 82
**Type**: Color
**Issue**: Hardcoded shadow color

```swift
// ❌ CURRENT (Hardcoded)
.shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)

// ✅ SUGGESTED (Use token or alias)
.shadow(
    color: ElevateAliases.Layout.Shadow.default_color ?? Color.black.opacity(0.1),
    radius: 8,
    x: 0,
    y: 4
)
```

**Priority**: Medium

#### 2. ElevateButton+SwiftUI.swift

**Location**: Lines 189-192
**Type**: Spacing (gap)
**Issue**: Hardcoded gap values

```swift
// ❌ CURRENT (Hardcoded)
private var tokenGap: CGFloat {
    switch size {
    case .small: return 4.0
    case .medium: return 6.0
    case .large: return 8.0
    }
}

// ✅ SUGGESTED (Use component tokens)
private var tokenGap: CGFloat {
    switch size {
    case .small: return ButtonComponentTokens.gap_s
    case .medium: return ButtonComponentTokens.gap_m
    case .large: return ButtonComponentTokens.gap_l
    }
}
```

**Priority**: High

#### 3. BadgeTokens.swift

**Location**: Lines 125-143
**Type**: Multiple (height, padding, font size, icon size)
**Issue**: Mixed hardcoded and `ElevateSpacing` references

```swift
// ❌ CURRENT (Mixed hardcoded and missing references)
static let major = RankConfig(
    height: 24.0,  // Hardcoded
    horizontalPadding: ElevateSpacing.s,  // Missing file
    fontSize: 14.0,  // Hardcoded
    iconSize: ElevateSpacing.IconSize.small.value,  // Missing file
    gap: ElevateSpacing.xs  // Missing file
)

// ✅ SUGGESTED (Use BadgeComponentTokens)
static let major = RankConfig(
    height: BadgeComponentTokens.height_major,
    horizontalPadding: BadgeComponentTokens.padding_inline_major,
    fontSize: 14.0,  // Typography - may stay hardcoded
    iconSize: BadgeComponentTokens.icon_size_major,
    gap: BadgeComponentTokens.gap_major
)
```

**Priority**: High

#### 4. ButtonTokens.swift

**Location**: Lines 103, 104, 121, 122, 139, 140, 157, 158, 193, 194
**Type**: Color
**Issue**: Using `Color.clear` for missing border tokens

```swift
// ❌ CURRENT (Hardcoded Color.clear)
border: Color.clear, // No border tokens for primary in ELEVATE
borderSelected: Color.clear

// ✅ SUGGESTED (Document why or extract if exists)
// Option 1: If ELEVATE truly doesn't define borders for these tones
border: Color.clear, // ELEVATE design: primary buttons have no border

// Option 2: If borders exist in ELEVATE but weren't extracted
border: ButtonComponentTokens.border_primary_color_default ?? Color.clear
```

**Priority**: Medium

### Action Items Summary

#### Immediate (High Priority)

1. **Resolve ElevateSpacing references** (7 files affected)
   - [ ] Replace all references with component tokens (RECOMMENDED)

2. **Fix Button gap values** (ElevateButton+SwiftUI.swift:189-192)
   - [ ] Verify ButtonComponentTokens has gap_s, gap_m, gap_l
   - [ ] Replace hardcoded 4.0, 6.0, 8.0

3. **Fix Badge hardcoded values** (BadgeTokens.swift:125-143)
   - [ ] Replace hardcoded heights, padding, icon sizes
   - [ ] Verify BadgeComponentTokens extraction

4. **Fix Chip spacing references** (ChipTokens.swift:174-202)
   - [ ] Verify ChipComponentTokens has all size variants
   - [ ] Replace ElevateSpacing references

#### Medium Priority

5. **Fix Menu shadow color** (ElevateMenu+SwiftUI.swift:82)
   - [ ] Check if ELEVATE defines shadow tokens
   - [ ] Use alias token or keep hardcoded with comment

6. **Fix Badge pill corner radius** (BadgeTokens.swift:56)
   - [ ] Extract from ELEVATE or calculate from height

7. **Verify border token extraction** (ButtonTokens.swift)
   - [ ] Check ELEVATE SCSS for border tokens on all tones
   - [ ] Update extraction script if missing

### Token Extraction Gaps

Check if the following tokens exist in ELEVATE SCSS but weren't extracted:

#### ButtonComponentTokens
- [ ] `gap_s`, `gap_m`, `gap_l`
- [ ] `border_width`
- [ ] `border_primary_color_default`
- [ ] `border_success_color_default`
- [ ] `border_warning_color_default`
- [ ] `border_danger_color_default`

#### BadgeComponentTokens
- [ ] `height_major`, `height_minor`
- [ ] `padding_inline_major`, `padding_inline_minor`
- [ ] `padding_block_major`, `padding_block_minor`
- [ ] `icon_size_major`, `icon_size_minor`
- [ ] `gap_major`, `gap_minor`
- [ ] `border_radius_pill_major`, `border_radius_pill_minor`

#### ChipComponentTokens
- [ ] `height_s`, `height_m`, `height_l`
- [ ] `padding_inline_s`, `padding_inline_m`, `padding_inline_l`
- [ ] `padding_block_s`, `padding_block_m`, `padding_block_l`
- [ ] `icon_size_s`, `icon_size_m`, `icon_size_l`
- [ ] `gap_s`, `gap_m`, `gap_l`
- [ ] `remove_button_size_s`, `remove_button_size_m`, `remove_button_size_l`
- [ ] `border_width`

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

## Testing Checklist

### Unit Tests

- [ ] Component renders with default props
- [ ] Component renders with all size variants (small, medium, large)
- [ ] Component renders with all tone variants (primary, secondary, danger, success)
- [ ] Component handles disabled state correctly
- [ ] Token values are correctly applied
- [ ] State changes trigger proper updates

### Integration Tests

- [ ] Component works in ScrollView without blocking scroll
- [ ] Component works in List without blocking scroll
- [ ] Component integrates with navigation
- [ ] Multiple instances don't interfere with each other

### Visual Testing

#### Light Mode
- [ ] Default state matches ELEVATE design
- [ ] Active/pressed state matches ELEVATE design
- [ ] Disabled state matches ELEVATE design
- [ ] All tones render correctly (primary, secondary, danger, success)
- [ ] All sizes render correctly (small, medium, large)
- [ ] Typography is correct
- [ ] Spacing is correct

#### Dark Mode
- [ ] Default state adapts correctly
- [ ] Active/pressed state adapts correctly
- [ ] Disabled state adapts correctly
- [ ] All tones adapt correctly
- [ ] All sizes maintain correct proportions
- [ ] No color artifacts or incorrect colors

### Accessibility Testing

- [ ] Component has proper accessibility label
- [ ] Component has proper accessibility traits (.isButton for interactive)
- [ ] Disabled state prevents interaction (.allowsHitTesting)
- [ ] VoiceOver announces component correctly
- [ ] Touch target is at least 44x44pt (iOS HIG minimum)
- [ ] Component works with Dynamic Type
- [ ] Component works with increased contrast mode

### Performance Testing

- [ ] Component renders quickly (<16ms for 60fps)
- [ ] No memory leaks
- [ ] State updates don't cause unnecessary re-renders
- [ ] Multiple instances don't degrade performance

### Edge Cases

- [ ] Component handles very long text labels
- [ ] Component handles empty or nil values
- [ ] Component handles rapid taps
- [ ] Component handles gesture conflicts (in ScrollView/List)
- [ ] Component handles orientation changes
- [ ] Component handles different screen sizes (iPhone, iPad)

---

## Common Patterns & Best Practices

### Token Usage Patterns

#### Always Use Component Tokens First

```swift
// ✅ CORRECT
ButtonComponentTokens.fill_primary_default

// ❌ WRONG
ElevatePrimitives.Blue._600  // No dark mode
```

#### Fallback to Alias When No Component Token Exists

```swift
// ✅ CORRECT for custom components
ElevateAliases.Feedback.Positive.fill_default

// ❌ WRONG
Color(red: 0.0, green: 0.8, blue: 0.0)  // Hardcoded
```

#### Never Use Primitives Directly

```swift
// ❌ NEVER DO THIS
ElevatePrimitives.Blue._600  // No dark mode support
ElevatePrimitives.Gray._100  // Doesn't adapt
```

### State Management

#### Use Computed Properties for Multi-State Colors

```swift
private var backgroundColor: Color {
    if isDisabled {
        return tokens.fill_primary_disabled
    }
    return isPressed
        ? tokens.fill_primary_active
        : tokens.fill_primary_default
}
```

#### Separate State Logic from View Body

```swift
// ✅ GOOD: Clean separation
var body: some View {
    content
        .background(backgroundColor)
}

private var backgroundColor: Color {
    // State logic here
}

// ❌ BAD: Mixing logic in view
var body: some View {
    content
        .background(isPressed ? tokens.fill_primary_active : tokens.fill_primary_default)
}
```

### Dark Mode Support

#### Automatic via Component Tokens

All Component and Alias tokens have built-in dark mode support via `Color.adaptive()`:

```swift
// This automatically adapts to dark mode
ButtonComponentTokens.fill_primary_default
```

#### Testing Dark Mode

```swift
#if DEBUG
struct Component_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ElevateButton("Light Mode")
                .preferredColorScheme(.light)

            ElevateButton("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
#endif
```

### Touch Targets

#### Minimum Touch Target Size

iOS Human Interface Guidelines require minimum 44x44pt touch targets:

```swift
// ✅ CORRECT: Expandable touch area
Image(systemName: "xmark")
    .frame(width: 16, height: 16)  // Visual size
    .padding(14)  // Expands touch area to 44x44pt
    .scrollFriendlyTap(action: close)
```

#### Testing Touch Targets

```swift
// Visualize touch targets in debug mode
#if DEBUG
.border(Color.red, width: 1)  // Shows actual frame
#endif
```

### Component Composition

#### Prefer Small, Focused Components

```swift
// ✅ GOOD: Composable
struct ElevateButton: View {
    var body: some View {
        ButtonContent(label: label, icon: icon)
            .applyButtonStyle(tone: tone, size: size)
    }
}

// ❌ BAD: Monolithic
struct ElevateButton: View {
    var body: some View {
        // 200 lines of view code...
    }
}
```

#### Extract Reusable Modifiers

```swift
// ✅ GOOD: Reusable modifier
extension View {
    func elevateButtonStyle(tone: ButtonTone, size: ButtonSize) -> some View {
        self
            .padding(.horizontal, horizontalPadding(for: size))
            .padding(.vertical, verticalPadding(for: size))
            .background(backgroundColor(for: tone))
            .cornerRadius(cornerRadius(for: size))
    }
}
```

### Documentation

#### Document Token Mappings

```swift
/// Button component following ELEVATE design system
///
/// Token Mappings:
/// - Background: `ButtonComponentTokens.fill_{tone}_{state}`
/// - Text: `ButtonComponentTokens.label_{tone}_{state}`
/// - Height: `ButtonComponentTokens.height_{size}`
/// - Padding: `ButtonComponentTokens.padding_inline_{size}`
public struct ElevateButton: View {
    // ...
}
```

#### Document Non-Token Values

```swift
/// Corner radius for pill-shaped badges
/// Calculated as height / 2 to create perfect pill shape
/// Note: ELEVATE doesn't define dynamic corner radius tokens
private var pillCornerRadius: CGFloat {
    tokenHeight / 2  // Half of height = pill shape
}
```

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

### Token Not Found

**Error:**
```
error: cannot find 'ButtonComponentTokens' in scope
```

**Solution:**
```bash
# Verify token file exists
ls ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# If missing, regenerate tokens
python3 scripts/update-design-tokens-v3.py --force
```

### Color Shows as Clear/Black

**Cause:** Token reference chain broken (alias or primitive not found)

**Solution:**
```bash
# Check token definition in generated file
grep "fill_primary_default" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# If shows Color.clear, regenerate tokens
python3 scripts/update-design-tokens-v3.py --force
```

### Dark Mode Not Working

**Cause:** Using wrong tier (Primitives instead of Component/Alias)

**Solution:** Use Component or Alias tokens, which have `.adaptive()` built-in

```swift
// ❌ WRONG: No dark mode support
.background(ElevatePrimitives.Blue._600)

// ✅ RIGHT: Automatic dark mode
.background(ButtonComponentTokens.fill_primary_default)
```

### Cascade Build Failures

**Symptom:** Many files fail because one component is broken

**Prevention:**
- Always use `.wip` extension during development
- Test token files independently before creating components
- Use git branches for experimental work

### No Token Exists for My Use Case

**Solution:** Use Alias tokens for semantic meaning

```swift
// Example: Custom success message background
// No SuccessMessageComponentTokens exists, so use Alias:
ElevateAliases.Feedback.Positive.fill_subtle
```

---

## Related Documentation

### Project Documentation

- **TOKEN_SYSTEM.md** - Comprehensive guide to ELEVATE token system (3-tier hierarchy)
- **.claude/docs/PROJECT_STRUCTURE.md** - Overall project organization
- **scripts/README.md** - Token generation and automation scripts

### ELEVATE Design System

- **ELEVATE Web Documentation** - https://elevate-component-library.com/
- **ELEVATE Figma** - Design specifications and token definitions
- **ELEVATE SCSS Source** - Token source files for extraction

### Apple Documentation

- **SwiftUI Documentation** - https://developer.apple.com/documentation/swiftui
- **iOS Human Interface Guidelines** - https://developer.apple.com/design/human-interface-guidelines/ios
- **Accessibility Guidelines** - https://developer.apple.com/accessibility/

### External Resources

- **Three-Tier Token System** - Standard for design token organization
- **Design Tokens W3C Specification** - Community standard for design tokens

---

## File Organization Reference

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
└── Tests/
    └── ElevateUITests/
        └── ElevateUITests.swift

docs/
├── TOKEN_SYSTEM.md
└── COMPONENT_DEVELOPMENT.md  (this file)

scripts/
├── update-design-tokens-v3.py
└── README.md
```

---

## Summary

### Key Principles

1. **Isolation**: Use `.wip` extensions to isolate in-development work
2. **Token Hierarchy**: Component Tokens → Alias Tokens → Never Primitives
3. **Scroll-Friendly**: All interactive components must support scroll gestures
4. **Dark Mode**: Automatic via Component/Alias tokens
5. **Incremental**: Build and test one component at a time
6. **Verification**: Always test in both light and dark mode

### Development Workflow

```
1. Create files with .wip extension
   ↓
2. Implement using Component tokens
   ↓
3. Apply scroll-friendly gestures
   ↓
4. Test in isolation
   ↓
5. Remove .wip when stable
   ↓
6. Test in both light and dark mode
   ↓
7. Commit to repository
```

### Benefits

✅ **No more build breakage** - WIP code is isolated
✅ **Automatic dark mode** - Via token system
✅ **Native iOS feel** - Scroll-friendly gestures
✅ **ELEVATE sync** - Updates when design system updates
✅ **Type safety** - Compile-time validation
✅ **Maintainability** - Single source of truth for design values

---

**For questions or issues, refer to the troubleshooting section or consult TOKEN_SYSTEM.md for token-related questions.**
