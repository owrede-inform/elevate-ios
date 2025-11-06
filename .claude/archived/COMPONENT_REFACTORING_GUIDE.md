# Component Refactoring Guide: Removing Hardcoded Values

**Version**: 1.0
**Date**: 2025-11-06
**Purpose**: Step-by-step guide for converting hardcoded values to ELEVATE design tokens

---

## Overview

This guide shows you how to refactor existing SwiftUI components to use extracted ELEVATE design tokens instead of hardcoded values.

**Why Refactor?**
- ✅ Automatic dark mode support
- ✅ Consistent with ELEVATE design system
- ✅ Updates automatically when ELEVATE updates
- ✅ Type-safe, compile-time validated
- ✅ No manual RGB value management

---

## Quick Reference: Token Hierarchy

```swift
// ALWAYS start at the highest tier available
Component Tokens (FIRST CHOICE)
    ↓ use when no component token exists
Alias Tokens (SECOND CHOICE)
    ↓ NEVER use directly
Primitive Tokens (DO NOT USE)
```

**Rule of Thumb**:
1. Look for Component token first
2. Use Alias token if no Component token exists
3. Never use Primitive tokens directly

---

## Refactoring Patterns

### Pattern 1: Hardcoded Colors → Component Tokens

#### ❌ Before (Hardcoded)
```swift
struct MyButton: View {
    var body: some View {
        Text("Delete")
            .foregroundColor(Color.white)
            .background(Color(red: 0.8078, green: 0.0039, blue: 0.0039))
    }
}
```

**Problems**:
- No dark mode
- Not linked to ELEVATE
- Breaking when design updates

#### ✅ After (Using Tokens)
```swift
struct MyButton: View {
    var body: some View {
        Text("Delete")
            .foregroundColor(ButtonComponentTokens.label_danger_default)
            .background(ButtonComponentTokens.fill_danger_default)
    }
}
```

**Benefits**:
- Dark mode automatic
- Updates with ELEVATE
- Type-safe

---

### Pattern 2: Hardcoded Spacing → Component Tokens

#### ❌ Before (Hardcoded)
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

#### ✅ After (Using Tokens)
```swift
struct MyButton: View {
    var body: some View {
        Text("Click Me")
            .padding(.horizontal, ButtonComponentTokens.padding_inline_m)
            .padding(.vertical, ButtonComponentTokens.padding_block_m)
            .frame(height: ButtonComponentTokens.height_m)
    }
}
```

---

### Pattern 3: State-Based Colors → Component Tokens

#### ❌ Before (Hardcoded)
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

#### ✅ After (Using Tokens)
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

---

### Pattern 4: Border Styling → Component Tokens

#### ❌ Before (Hardcoded)
```swift
.overlay(
    RoundedRectangle(cornerRadius: 4)
        .stroke(Color.gray, lineWidth: 1)
)
```

#### ✅ After (Using Tokens)
```swift
.overlay(
    RoundedRectangle(cornerRadius: ButtonComponentTokens.border_radius_m)
        .stroke(ButtonComponentTokens.border_default, lineWidth: ButtonComponentTokens.border_width)
)
```

---

### Pattern 5: When No Component Token Exists → Use Alias Tokens

#### ❌ Before (Hardcoded)
```swift
struct AppBackground: View {
    var body: some View {
        Color(red: 0.98, green: 0.98, blue: 0.98)
            .ignoresSafeArea()
    }
}
```

#### ✅ After (Using Alias Token)
```swift
struct AppBackground: View {
    var body: some View {
        ElevateAliases.Layout.LayerAppbackground.default_color
            .ignoresSafeArea()
    }
}
```

**When to use Alias tokens**:
- No component-specific token exists
- App-level styling (backgrounds, global layouts)
- Custom components not in ELEVATE

---

## Step-by-Step Refactoring Process

### Step 1: Identify Hardcoded Values

**Find hardcoded colors**:
```bash
# Search for Color constructors with RGB values
grep -r "Color(red:" ElevateUI/Sources/SwiftUI/Components/
grep -r "Color\\..*blue\\|red\\|green" ElevateUI/Sources/SwiftUI/Components/

# Search for hex colors
grep -r "#[0-9A-Fa-f]\{6\}" ElevateUI/Sources/SwiftUI/Components/
```

**Find hardcoded spacing**:
```bash
# Search for hardcoded padding/frame values
grep -r "padding.*[0-9]" ElevateUI/Sources/SwiftUI/Components/
grep -r "frame.*height:.*[0-9]" ElevateUI/Sources/SwiftUI/Components/
```

**Example output**:
```
ElevateButton+SwiftUI.swift:45:    .foregroundColor(Color.white)
ElevateButton+SwiftUI.swift:46:    .background(Color.blue)
ElevateButton+SwiftUI.swift:50:    .padding(.horizontal, 12)
ElevateButton+SwiftUI.swift:51:    .frame(height: 40)
```

---

### Step 2: Find the Correct Token

#### For Colors:

1. **Identify the component**: Button, Chip, Card, etc.
2. **Identify the element**: fill (background), label (text), border, etc.
3. **Identify the tone**: primary, secondary, danger, success
4. **Identify the state**: default, hover, active, disabled

**Token naming pattern**:
```
{component}ComponentTokens.{element}_{tone}_{state}

Examples:
ButtonComponentTokens.fill_primary_default
ButtonComponentTokens.label_danger_active
ChipComponentTokens.border_secondary_hover
```

**Search for available tokens**:
```bash
# List all button tokens
grep "public static let" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Search for specific token pattern
grep "fill_danger" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift
```

#### For Spacing/Dimensions:

**Token naming pattern**:
```
{component}ComponentTokens.{property}_{size}

Examples:
ButtonComponentTokens.height_m           // 40pt
ButtonComponentTokens.padding_inline_m   // 12pt
ButtonComponentTokens.gap_s              // 4pt
ButtonComponentTokens.border_radius_m    // 4pt
```

**Size suffixes**:
- `_s` = Small
- `_m` = Medium (default)
- `_l` = Large

---

### Step 3: Apply the Token

#### Example: Refactor ElevateButton

**Original code** (ElevateButton+SwiftUI.swift:42-55):
```swift
struct ElevateButton: View {
    let label: String

    var body: some View {
        Text(label)
            .foregroundColor(Color.white)
            .background(Color.blue)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .frame(height: 40)
            .cornerRadius(4)
    }
}
```

**Refactored code**:
```swift
struct ElevateButton: View {
    let label: String
    let tone: ButtonTone = .primary

    var body: some View {
        Text(label)
            .foregroundColor(ButtonComponentTokens.label_primary_default)
            .background(ButtonComponentTokens.fill_primary_default)
            .padding(.horizontal, ButtonComponentTokens.padding_inline_m)
            .padding(.vertical, ButtonComponentTokens.padding_block_m)
            .frame(height: ButtonComponentTokens.height_m)
            .cornerRadius(ButtonComponentTokens.border_radius_m)
    }
}
```

**Enhanced with state support**:
```swift
struct ElevateButton: View {
    let label: String
    let tone: ButtonTone = .primary
    @State private var isPressed = false

    var body: some View {
        Text(label)
            .foregroundColor(labelColor)
            .background(backgroundColor)
            .padding(.horizontal, ButtonComponentTokens.padding_inline_m)
            .padding(.vertical, ButtonComponentTokens.padding_block_m)
            .frame(height: ButtonComponentTokens.height_m)
            .cornerRadius(ButtonComponentTokens.border_radius_m)
            .onTapGesture {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                }
            }
    }

    private var labelColor: Color {
        switch tone {
        case .primary:
            return isPressed
                ? ButtonComponentTokens.label_primary_active
                : ButtonComponentTokens.label_primary_default
        case .danger:
            return isPressed
                ? ButtonComponentTokens.label_danger_active
                : ButtonComponentTokens.label_danger_default
        }
    }

    private var backgroundColor: Color {
        switch tone {
        case .primary:
            return isPressed
                ? ButtonComponentTokens.fill_primary_active
                : ButtonComponentTokens.fill_primary_default
        case .danger:
            return isPressed
                ? ButtonComponentTokens.fill_danger_active
                : ButtonComponentTokens.fill_danger_default
        }
    }
}

enum ButtonTone {
    case primary
    case danger
    case secondary
    case success
}
```

---

### Step 4: Verify the Refactoring

#### Build Verification
```bash
# Ensure it compiles
swift build

# Expected: Build complete! (0.XX s)
```

#### Visual Verification
```bash
# Run the app in light mode
# Verify colors match ELEVATE design

# Switch to dark mode (Settings → Appearance → Dark)
# Verify dark mode colors work automatically
```

#### Token Verification
```bash
# Verify token exists in generated file
grep "fill_primary_default" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Expected output:
# public static let fill_primary_default = Color.adaptive(...)
```

---

## Common Scenarios

### Scenario 1: Multiple Tones (Primary, Danger, Success)

**Pattern**: Use computed properties with switch statements

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

---

### Scenario 2: Multiple States (Default, Hover, Active, Disabled)

**Pattern**: Use @State and computed properties

```swift
struct ElevateButton: View {
    let tone: ButtonTone
    @State private var isPressed = false
    @State private var isDisabled = false

    var body: some View {
        Text("Button")
            .foregroundColor(labelColor)
            .background(backgroundColor)
            .onTapGesture {
                guard !isDisabled else { return }
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                }
            }
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

---

### Scenario 3: Custom Components (Not in ELEVATE)

**Pattern**: Use Alias tokens for semantic meaning

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

---

### Scenario 4: Gradients and Complex Styles

**Pattern**: Compose tokens for complex effects

```swift
struct GradientButton: View {
    var body: some View {
        Text("Gradient")
            .foregroundColor(ButtonComponentTokens.label_primary_default)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        ButtonComponentTokens.fill_primary_default,
                        ButtonComponentTokens.fill_primary_active
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
    }
}
```

---

## Token Discovery Tools

### Find Available Component Tokens

```bash
# List all available component token files
ls ElevateUI/Sources/DesignTokens/Generated/*ComponentTokens.swift

# Example output:
# ButtonComponentTokens.swift
# ChipComponentTokens.swift
# CardComponentTokens.swift
# ... (51 total)
```

### Search for Specific Tokens

```bash
# Find all "fill" tokens for buttons
grep "public static let fill" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Find all spacing tokens
grep "CGFloat" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Find token by color name
grep -r "danger" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift
```

### Browse Token Structure

```swift
// Open the generated file in Xcode to see all available tokens
ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

// Structure:
public struct ButtonComponentTokens {
    // MARK: - Colors
    public static let fill_primary_default = ...
    public static let fill_primary_hover = ...
    public static let fill_primary_active = ...

    public static let label_primary_default = ...
    public static let label_primary_hover = ...

    // MARK: - Dimensions
    public static let height_s: CGFloat = 32.0
    public static let height_m: CGFloat = 40.0
    public static let height_l: CGFloat = 48.0

    public static let padding_inline_s: CGFloat = 8.0
    public static let padding_inline_m: CGFloat = 12.0
    public static let padding_inline_l: CGFloat = 16.0
}
```

---

## Refactoring Checklist

### Before Starting
- [ ] Run `python3 scripts/update-design-tokens-v4.py` to ensure tokens are up-to-date
- [ ] Verify build is working: `swift build`
- [ ] Create a feature branch: `git checkout -b refactor/component-name-tokens`

### During Refactoring
- [ ] Identify all hardcoded values (colors, spacing, dimensions)
- [ ] Find correct Component tokens (or Alias if no Component token exists)
- [ ] Replace hardcoded values with token references
- [ ] Remove any unused color/spacing constants
- [ ] Add state support (default, active, disabled) if needed
- [ ] Add tone support (primary, danger, etc.) if needed

### After Refactoring
- [ ] Build succeeds: `swift build`
- [ ] Visual verification in light mode
- [ ] Visual verification in dark mode
- [ ] All states work (default, active, disabled)
- [ ] All tones work (primary, danger, secondary)
- [ ] No hardcoded values remain
- [ ] Commit changes: `git commit -m "Refactor ComponentName to use ELEVATE tokens"`

---

## Migration Priority

### High Priority (User-Facing Components)
1. **Buttons** - Most visible, used everywhere
2. **Chips** - Common UI element
3. **Cards** - Content containers
4. **Form Controls** - Text fields, checkboxes, radio buttons

### Medium Priority (Navigation)
5. **Tabs** - Navigation elements
6. **Breadcrumbs** - Navigation aids
7. **Menus** - Dropdown/navigation menus

### Low Priority (Specialized)
8. **Tooltips** - Helper UI
9. **Badges** - Status indicators
10. **Dividers** - Visual separators

---

## Troubleshooting

### Problem: Token Not Found

**Error**:
```
error: cannot find 'ButtonComponentTokens' in scope
```

**Solution**:
```bash
# Verify token file exists
ls ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# If missing, regenerate tokens
python3 scripts/update-design-tokens-v4.py --force
```

---

### Problem: Color Shows as Clear/Black

**Cause**: Token reference chain broken (alias or primitive not found)

**Solution**:
```bash
# Check token definition in generated file
grep "fill_primary_default" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# If shows Color.clear, regenerate tokens
python3 scripts/update-design-tokens-v4.py --force
```

---

### Problem: No Token Exists for My Use Case

**Solution**: Use Alias tokens for semantic meaning

```swift
// Example: Custom success message background
// No SuccessMessageComponentTokens exists, so use Alias:
ElevateAliases.Feedback.Positive.fill_subtle
```

---

### Problem: Dark Mode Not Working

**Cause**: Using wrong tier (Primitives instead of Component/Alias)

**Solution**: Use Component or Alias tokens, which have `.adaptive()` built-in

```swift
// ❌ WRONG: No dark mode support
.background(ElevatePrimitives.Blue._600)

// ✅ RIGHT: Automatic dark mode
.background(ButtonComponentTokens.fill_primary_default)
```

---

## Examples: Real Component Refactoring

### Example 1: ElevateButton

**File**: `ElevateUI/Sources/SwiftUI/Components/ElevateButton+SwiftUI.swift`

**Before** (line 42-55):
```swift
.foregroundColor(Color.white)
.background(Color.blue)
.padding(.horizontal, 12)
.frame(height: 40)
```

**After**:
```swift
.foregroundColor(ButtonComponentTokens.label_primary_default)
.background(ButtonComponentTokens.fill_primary_default)
.padding(.horizontal, ButtonComponentTokens.padding_inline_m)
.frame(height: ButtonComponentTokens.height_m)
```

**Changes**: 4 hardcoded values → 4 token references

---

### Example 2: ElevateChip

**File**: `ElevateUI/Sources/SwiftUI/Components/ElevateChip+SwiftUI.swift`

**Before**:
```swift
.background(Color.gray.opacity(0.2))
.foregroundColor(Color.black)
.padding(.horizontal, 8)
.padding(.vertical, 4)
```

**After**:
```swift
.background(ChipComponentTokens.fill_default)
.foregroundColor(ChipComponentTokens.label_default)
.padding(.horizontal, ChipComponentTokens.padding_inline_s)
.padding(.vertical, ChipComponentTokens.padding_block_s)
```

---

## Summary

### Refactoring Principles

1. **Component Tokens First**: Always look for component-specific tokens
2. **Alias Tokens Second**: Use when no component token exists
3. **Never Use Primitives**: Primitives are low-level, no dark mode support
4. **State Support**: Use ELEVATE's state tokens (default, active, disabled)
5. **Verify Visually**: Test in both light and dark mode

### Benefits of Refactoring

✅ **Automatic dark mode** - No manual theme switching code
✅ **ELEVATE sync** - Updates when design system updates
✅ **Type safety** - Compile-time validation
✅ **Consistency** - All components use same source of truth
✅ **Maintainability** - No scattered RGB values

### Next Steps

1. Use this guide to refactor one component at a time
2. Start with high-priority user-facing components
3. Verify each refactoring with build + visual testing
4. Commit incrementally (one component per commit)

---

**The ELEVATE iOS design system is now ready for systematic component refactoring to achieve 100% token usage.**
