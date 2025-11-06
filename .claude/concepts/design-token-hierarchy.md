# Design Token Hierarchy

**Status**: Core System ✅
**Since**: v0.1.0
**Source**: ELEVATE Design System

---

## Three-Tier Token System

The ELEVATE design system uses a strict **3-tier hierarchy** for design tokens:

```
┌─────────────────────────────────────────┐
│      Component Tokens (Tier 1)         │  ← Use FIRST
│  ButtonComponentTokens.fill_primary    │
│  MenuComponentTokens.border             │
│  InputComponentTokens.text_default      │
└────────────────┬────────────────────────┘
                 │ references
┌────────────────▼────────────────────────┐
│       Alias Tokens (Tier 2)             │  ← Use if no Component Token
│  ElevateAliases.Action.Primary.fill     │
│  ElevateAliases.Content.General.text    │
│  ElevateAliases.Surface.General.bg      │
└────────────────┬────────────────────────┘
                 │ references
┌────────────────▼────────────────────────┐
│     Primitive Tokens (Tier 3)           │  ← NEVER use directly
│  ElevatePrimitives.Blue._600            │
│  ElevatePrimitives.Gray._50             │
│  ElevatePrimitives.White._color_white   │
└─────────────────────────────────────────┘
```

---

## Token Tier Responsibilities

### Tier 1: Component Tokens

**Purpose**: Semantic tokens for specific component elements.

**Characteristics**:
- ✅ Automatically handle dark mode
- ✅ Include all component states (default, hover, active, disabled, etc.)
- ✅ Follow naming pattern: `[element]_[tone/type]_[state]`
- ✅ Generated from SCSS source

**Examples**:
```swift
// Button
ButtonComponentTokens.fill_primary_default
ButtonComponentTokens.label_primary_active
ButtonComponentTokens.border_neutral_color_default

// Input
InputComponentTokens.fill_default
InputComponentTokens.border_color_focused
InputComponentTokens.icon_disabled

// Menu
MenuComponentTokens.fill
MenuComponentTokens.border
MenuComponentTokens.groupLabel_text
```

**When to Use**: **ALWAYS** if a component token exists for your use case.

### Tier 2: Alias Tokens

**Purpose**: Semantic tokens for general UI patterns, used when no component token exists.

**Characteristics**:
- ✅ Handle dark mode (light/dark values)
- ✅ Organized by purpose (Action, Content, Surface, Feedback, etc.)
- ✅ More general than component tokens
- ✅ Reusable across different components

**Structure**:
```swift
ElevateAliases.
    ├── Action          // Interactive elements
    │   ├── Primary
    │   ├── UnderstatedPrimary
    │   ├── StrongNeutral
    │   └── StrongEmphasized
    ├── Content         // Text, icons
    │   └── General
    ├── Surface         // Backgrounds, containers
    │   └── General
    └── Feedback        // Status colors
        └── General
```

**Examples**:
```swift
// Action tokens (buttons, links)
ElevateAliases.Action.Primary.fill_default
ElevateAliases.Action.UnderstatedPrimary.text_default
ElevateAliases.Action.StrongNeutral.fill_hover

// Content tokens (text, icons)
ElevateAliases.Content.General.text_default
ElevateAliases.Content.General.text_muted
ElevateAliases.Content.General.icon_default

// Surface tokens (backgrounds)
ElevateAliases.Surface.General.bg_page
ElevateAliases.Surface.General.bg_canvas

// Feedback tokens (status)
ElevateAliases.Feedback.General.fill_danger
ElevateAliases.Feedback.General.text_success
```

**When to Use**: If **no component token exists** for your specific need (e.g., app background, general text color).

### Tier 3: Primitive Tokens

**Purpose**: Raw color values. **DO NOT USE DIRECTLY**.

**Characteristics**:
- ❌ Static colors, NO dark mode logic
- ❌ No semantic meaning
- ❌ Just named colors (Blue._600, Gray._50, etc.)
- ⚠️ Only referenced by Alias tokens

**Examples**:
```swift
// Light mode primitives
ElevatePrimitives.Blue._600         // rgb(27 80 166)
ElevatePrimitives.Gray._50          // rgb(248 249 250)
ElevatePrimitives.White._color_white // rgb(255 255 255)

// Dark mode primitives
ElevatePrimitives.Gray._950         // rgb(9 11 15)
ElevatePrimitives.Blue._400         // Different shade for dark mode
```

**When to Use**: **NEVER**. Always use Component or Alias tokens.

**Why They Exist**: To be referenced by Alias tokens which add dark mode logic.

---

## Token Selection Decision Tree

```
Need a color/spacing value?
    │
    ▼
Is this for a standard component element?
    │
    ├─ YES → Check Component Tokens
    │           │
    │           ├─ Token exists? → ✅ USE IT
    │           │
    │           └─ No token? → Continue to Alias
    │
    └─ NO → Is this a general UI element?
                │
                ├─ Action (button, link)? → Alias.Action.*
                ├─ Text/Icon? → Alias.Content.*
                ├─ Background? → Alias.Surface.*
                ├─ Status/Feedback? → Alias.Feedback.*
                │
                └─ None fit? → ❌ DON'T use Primitive
                              → Create new Alias token or use closest match
```

---

## Critical Rules

### ✅ DO

1. **Use Component Tokens first**
   ```swift
   // ✅ Correct
   background(ButtonComponentTokens.fill_primary_default)
   ```

2. **Use Alias Tokens if no Component Token**
   ```swift
   // ✅ Correct (no component token for app background)
   background(ElevateAliases.Surface.General.bg_page)
   ```

3. **Trust the token names**
   ```swift
   // ✅ Correct - token name describes purpose
   foregroundColor(ButtonComponentTokens.label_primary_active)
   ```

### ❌ DON'T

1. **NEVER use Primitive Tokens directly**
   ```swift
   // ❌ WRONG - breaks dark mode
   background(ElevatePrimitives.Blue._600)
   ```

2. **Don't hardcode colors**
   ```swift
   // ❌ WRONG
   background(Color.white)
   foregroundColor(Color(red: 0.1, green: 0.3, blue: 0.8))
   ```

3. **Don't skip tiers**
   ```swift
   // ❌ WRONG - use Component Token instead
   background(ElevateAliases.Action.Primary.fill_default)
   // when:
   background(ButtonComponentTokens.fill_primary_default)  // ✅ exists
   ```

---

## Dark Mode Handling

### How It Works

**Primitive Tokens**: Static colors, no logic.

**Alias Tokens**: Contain BOTH light and dark values.

```swift
public static let text_default = Color(
    light: ElevatePrimitives.Gray._950,   // Dark gray for light mode
    dark: ElevatePrimitives.Gray._50      // Light gray for dark mode
)
```

**Component Tokens**: Reference Alias tokens (inherit dark mode support).

```swift
public static let label_primary_default =
    ElevateAliases.Action.Primary.text_default  // Already has dark mode
```

### What You Get

When you use Component or Alias tokens:

```swift
// This automatically switches in dark mode!
foregroundColor(ButtonComponentTokens.label_primary_default)

// Light mode: Dark text
// Dark mode: Light text
// No extra code needed! ✅
```

---

## Token Naming Conventions

### Component Tokens

Pattern: `[element]_[tone/variant]_[state]`

Examples:
```swift
fill_primary_default         // Background, primary tone, default state
fill_primary_hover           // Background, primary tone, hover state
fill_primary_active          // Background, primary tone, active/pressed
fill_primary_disabled_default // Background, primary tone, disabled state

label_success_active         // Text, success tone, active state
border_neutral_color_default // Border, neutral tone, default state
icon_warning_hover           // Icon, warning tone, hover state
```

### Alias Tokens

Pattern: `[category].[subcategory].[property]_[state]`

Examples:
```swift
Action.Primary.fill_default
Action.Primary.text_active
Content.General.text_muted
Surface.General.bg_canvas
Feedback.General.fill_danger
```

### Primitive Tokens

Pattern: `[color]._[shade/name]`

Examples:
```swift
Blue._600
Gray._50
White._color_white
Green._500
```

---

## Component Token Coverage

### Fully Covered Components

Components with complete token sets:

- ✅ **Button**: `ButtonComponentTokens`
- ✅ **Badge**: `BadgeComponentTokens`
- ✅ **Chip**: `ChipComponentTokens`
- ✅ **Input**: `InputComponentTokens`
- ✅ **Field**: `FieldComponentTokens`
- ✅ **Menu**: `MenuComponentTokens`
- ✅ **Tab**: `TabComponentTokens`
- ✅ **Textarea**: `TextareaComponentTokens`
- ✅ **Checkbox**: `CheckboxComponentTokens`
- ✅ **Radio**: `RadioComponentTokens`
- ✅ **Switch**: `SwitchComponentTokens`

### Manually Defined

Components without SCSS extraction (manually defined using Alias tokens):

- 📝 **Breadcrumb**: `BreadcrumbTokens` (uses Alias tokens)
- 📝 **TextField**: `TextFieldTokens` (combines Input + Field tokens)
- 📝 **TextArea**: `TextAreaTokens` (uses Textarea component tokens)

---

## Examples by Use Case

### Styling a Button

```swift
// ✅ Use Component Tokens
struct MyButton: View {
    @State private var isPressed = false

    var body: some View {
        Text("Tap Me")
            .padding()
            .foregroundColor(
                isPressed
                    ? ButtonComponentTokens.label_primary_active
                    : ButtonComponentTokens.label_primary_default
            )
            .background(
                isPressed
                    ? ButtonComponentTokens.fill_primary_active
                    : ButtonComponentTokens.fill_primary_default
            )
    }
}
```

### Styling App Background

```swift
// ✅ Use Alias Token (no component token for app background)
struct AppView: View {
    var body: some View {
        NavigationView {
            // content
        }
        .background(ElevateAliases.Surface.General.bg_page)
    }
}
```

### Styling Custom Component Text

```swift
// ✅ Use Alias Token for general text
struct CustomCard: View {
    var body: some View {
        VStack {
            Text("Title")
                .foregroundColor(ElevateAliases.Content.General.text_default)

            Text("Subtitle")
                .foregroundColor(ElevateAliases.Content.General.text_muted)
        }
    }
}
```

### ❌ Wrong Approaches

```swift
// ❌ WRONG - Using primitive directly
.background(ElevatePrimitives.Blue._600)

// ❌ WRONG - Hardcoded color
.background(Color.white)

// ❌ WRONG - Using Alias when Component Token exists
.background(ElevateAliases.Action.Primary.fill_default)
// Should use:
.background(ButtonComponentTokens.fill_primary_default)

// ❌ WRONG - RGB values
.foregroundColor(Color(red: 0.18, green: 0.31, blue: 0.65))
```

---

## Token Organization in Codebase

```
ElevateUI/Sources/DesignTokens/
├── Generated/                      # Auto-generated Component Tokens
│   ├── ButtonComponentTokens.swift
│   ├── BadgeComponentTokens.swift
│   ├── InputComponentTokens.swift
│   ├── MenuComponentTokens.swift
│   └── ...
├── Components/                     # Wrapper/manual Component Tokens
│   ├── ButtonTokens.swift         # Wraps ButtonComponentTokens
│   ├── BreadcrumbTokens.swift     # Manual (uses Alias)
│   ├── TextFieldTokens.swift      # Manual (combines Input + Field)
│   └── ...
├── ElevateAliases.swift           # Tier 2: Alias Tokens
└── ElevatePrimitives.swift        # Tier 3: Primitive Tokens
```

---

## Debugging Token Issues

### Issue: Colors Don't Change in Dark Mode

**Symptom**: Component stays same color in light/dark mode.

**Cause**: Using Primitive Token instead of Component/Alias.

**Solution**:
```swift
// ❌ WRONG
.background(ElevatePrimitives.Blue._600)

// ✅ CORRECT
.background(ButtonComponentTokens.fill_primary_default)
```

### Issue: Can't Find Right Token

**Symptom**: Need a color but can't find component token.

**Solution**: Use Alias token and consider filing issue to add component token:
```swift
// Temporary: Use Alias
.foregroundColor(ElevateAliases.Content.General.text_default)

// TODO: Should there be a MenuItemComponentTokens.text_default?
```

### Issue: Token Name Unclear

**Symptom**: Not sure which token to use.

**Solution**: Follow naming pattern:
- `fill_*` → backgrounds
- `label_*` or `text_*` → text colors
- `border_*` → border colors
- `icon_*` → icon colors
- State suffix: `_default`, `_hover`, `_active`, `_disabled`, etc.

---

## Related Concepts

- **Component Implementation**: `.claude/components/*/...-ios-implementation.md`
- **iOS Touch Guidelines**: `.claude/concepts/ios-touch-guidelines.md`
- **Scroll-Friendly Gestures**: `.claude/concepts/scroll-friendly-gestures.md`

---

## Summary

1. ✅ **Always use Component Tokens first**
2. ✅ **Use Alias Tokens if no Component Token exists**
3. ❌ **NEVER use Primitive Tokens directly**
4. ✅ **Tokens handle dark mode automatically**
5. ✅ **Follow naming patterns to find right token**
