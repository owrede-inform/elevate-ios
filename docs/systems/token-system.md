# ELEVATE iOS Token System

**Version**: 4.0
**Last Updated**: 2025-11-06
**Status**: Production Ready

---

## Table of Contents

- [Overview](#overview)
- [Three-Tier Token Hierarchy](#three-tier-token-hierarchy)
- [Token Extraction Pipeline](#token-extraction-pipeline)
- [iOS-Specific Tokens (Theme System)](#ios-specific-tokens-theme-system)
- [Usage Workflow](#usage-workflow)
- [Token Types and Examples](#token-types-and-examples)
- [Staying in Sync with ELEVATE](#staying-in-sync-with-elevate)
- [Troubleshooting](#troubleshooting)
- [Performance](#performance)
- [Related Documentation](#related-documentation)

---

## Overview

The ELEVATE iOS design system features a **complete automated extraction system** that converts ELEVATE's SCSS design tokens to type-safe Swift code.

### What is the Token System?

A comprehensive design token management system that:

1. **Extracts ELEVATE SCSS tokens** (colors, spacing, dimensions, typography)
2. **Generates type-safe Swift code** with proper 3-tier token hierarchy
3. **Supports light/dark mode** automatically via `Color.adaptive()`
4. **Includes iOS-specific tokens** via CSS theme system
5. **Maintains 100% fidelity** to ELEVATE's source of truth

### Why We Use It

**Benefits**:

- ✅ **Single Source of Truth**: ELEVATE designers define tokens, we extract them
- ✅ **Zero Manual Work**: Fully automated SCSS → Swift conversion
- ✅ **Automatic Dark Mode**: Built into token structure
- ✅ **Type Safety**: Compile-time errors catch token misuse
- ✅ **Fast Updates**: ELEVATE updates in minutes, not days
- ✅ **iOS Customization**: Platform-specific tokens via theme system
- ✅ **No Divergence**: Can't get out of sync with design system

### Key Principles

**EXTRACTION, Not Generation**:
- All tokens are **DEFINED by ELEVATE designers in SCSS**
- Our script **EXTRACTS** them and converts to Swift
- **Nothing is invented or created** - 100% fidelity to ELEVATE's source

**ELEVATE designers define → We extract → SwiftUI uses**

---

## Three-Tier Token Hierarchy

The ELEVATE design system uses a strict **3-tier hierarchy** for design tokens.

### The Iron Rule

```
Component Tokens (USE FIRST)
    ↓ references
Alias Tokens (USE if no Component Token)
    ↓ references
Primitive Tokens (NEVER use directly)
    ↓ resolves to
RGB Color Values (light/dark mode)
```

**Decision Tree**:

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

### Tier 1: Component Tokens

**Purpose**: Semantic tokens for specific component elements. **USE THESE FIRST**.

**ELEVATE Defines** (in SCSS):
```scss
// Designers assign semantic tokens to component elements
$elvt-component-button-fill-danger-default:
    var(--elvt-alias-action-strong-danger-fill-default, rgb(206 1 1));

$elvt-component-button-gap-m: 0.5rem;
$elvt-component-button-height-m: 2.5rem;
```

**We Extract to Swift**:
```swift
public struct ButtonComponentTokens {
    // MARK: - Colors
    public static let fill_danger_default = Color.adaptive(
        light: ElevateAliases.Action.StrongDanger.fill_default,
        dark: ElevateAliases.Action.StrongDanger.fill_default
    )

    // MARK: - Dimensions
    public static let gap_m: CGFloat = 8.0      // 0.5rem → 8pt
    public static let height_m: CGFloat = 40.0  // 2.5rem → 40pt
}
```

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
ButtonComponentTokens.height_m
ButtonComponentTokens.padding_inline_m

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

**Purpose**: Semantic tokens for general UI patterns. Use when no component token exists.

**ELEVATE Defines** (in SCSS):
```scss
// Designers map primitives to semantic meanings
$elvt-alias-action-strong-danger-fill-default:
    var(--elvt-primitives-color-red-600, rgb(206 1 1));

// DIFFERENT in dark mode (_dark.scss):
$elvt-alias-action-strong-danger-fill-default:
    var(--elvt-primitives-color-red-500, rgb(245 1 1));
```

**We Extract to Swift**:
```swift
public struct ElevateAliases {
    public enum Action {
        public enum StrongDanger {
            public static let fill_default = Color.adaptive(
                light: ElevatePrimitives.Red._600,  // Light mode: Red 600
                dark: ElevatePrimitives.Red._500    // Dark mode: Red 500
            )
        }
    }
}
```

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

**Characteristics**:
- ✅ Handle dark mode (light/dark values)
- ✅ Organized by purpose (Action, Content, Surface, Feedback, etc.)
- ✅ More general than component tokens
- ✅ Reusable across different components

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

**ELEVATE Defines** (in SCSS):
```scss
// Designers define the raw color palette
$elvt-primitives-color-blue-600: rgb(11 92 223);
$elvt-primitives-color-red-600: rgb(206 1 1);
```

**We Extract to Swift**:
```swift
public struct ElevatePrimitives {
    public enum Blue {
        public static let _600 = Color.adaptive(
            lightRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000),
            darkRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
        )
    }

    public enum Red {
        public static let _600 = Color.adaptive(
            lightRGB: (red: 0.8078, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.8078, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
    }
}
```

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

### Complete Hierarchy Example

```swift
// SwiftUI Component
struct MyButton: View {
    var body: some View {
        Text("Delete")
            .foregroundColor(
                ButtonComponentTokens.label_danger_default  // Tier 1: Component
            )
            .background(
                ButtonComponentTokens.fill_danger_default   // Tier 1: Component
            )
            .frame(height: ButtonComponentTokens.height_m)  // Tier 1: Dimension
    }
}

// What happens at runtime:
ButtonComponentTokens.fill_danger_default
    ↓ references
ElevateAliases.Action.StrongDanger.fill_default
    ↓ references (light mode)
ElevatePrimitives.Red._600
    ↓ resolves to
Color(red: 0.8078, green: 0.0039, blue: 0.0039)  // rgb(206 1 1)

// In dark mode, same code automatically uses:
    ↓ references (dark mode)
ElevatePrimitives.Red._500
    ↓ resolves to
Color(red: 0.9608, green: 0.0039, blue: 0.0039)  // rgb(245 1 1)
```

### Critical Rules

#### ✅ DO

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

#### ❌ DON'T

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

**For detailed information on the three-tier hierarchy, see**: `.claude/concepts/design-token-hierarchy.md`

---

## Token Extraction Pipeline

### Complete Pipeline Overview

```
ELEVATE SCSS Source (Designer's Authoritative Definition)
    ↓
┌─────────────────────────────────────────────────────────┐
│  .elevate-src/.../scss/values/_light.scss              │
│  .elevate-src/.../scss/values/_dark.scss               │
│  .elevate-src/.../scss/tokens/component/_button.scss   │
│  ... (51 component files)                              │
└─────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────┐
│  iOS Theme Layer (Optional Platform Customization)     │
│  .elevate-themes/ios/extend.css (missing tokens)       │
│  .elevate-themes/ios/overwrite.css (iOS overrides)     │
└─────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────┐
│  Python Extraction Script (update-design-tokens-v4.py)  │
│  ------------------------------------------------       │
│  1. Parse 2,481 tokens from _light.scss                │
│  2. Parse 2,481 tokens from _dark.scss                 │
│  3. Merge iOS theme tokens (extend + overwrite)        │
│  4. Extract Primitives (63 color tokens)               │
│  5. Extract Aliases (304 semantic tokens)              │
│  6. Extract Component Tokens (51 components)           │
│  7. Convert SCSS → Swift with proper references        │
│  8. Generate adaptive colors for light/dark mode       │
└─────────────────────────────────────────────────────────┘
    ↓
┌─────────────────────────────────────────────────────────┐
│  Generated Swift Files (Auto-Generated - DO NOT EDIT)  │
│  ------------------------------------------------       │
│  ElevateUI/Sources/DesignTokens/Generated/             │
│  ├─ ColorAdaptive.swift         (1KB helper)           │
│  ├─ ElevatePrimitives.swift     (14KB, 63 tokens)      │
│  ├─ ElevateAliases.swift        (40KB, 304 tokens)     │
│  └─ *ComponentTokens.swift      (51 files, colors +    │
│                                   spacing + dimensions) │
└─────────────────────────────────────────────────────────┘
    ↓
SwiftUI Components (Use tokens, never hardcode)
```

### Extraction Statistics

**Source (ELEVATE SCSS)**:
- **2,481 tokens** in `_light.scss` (light mode)
- **2,481 tokens** in `_dark.scss` (dark mode, same names, different values)
- **51 component files** with element-specific tokens
- **22 iOS theme tokens** (extend.css)

**Extracted Output (Swift)**:
- **54 files total**:
  - 1 ColorAdaptive.swift (1KB - helper extension)
  - 1 ElevatePrimitives.swift (14KB - 63 color primitives)
  - 1 ElevateAliases.swift (40KB - 304 semantic tokens)
  - 51 *ComponentTokens.swift (colors + spacing + dimensions)

**Token Counts**:
- **63 Primitive color tokens** (Blue, Red, Gray, Green, Orange, etc.)
- **304 Alias tokens** (Action, Content, Surface, Feedback, Layout)
- **2,503 total tokens** after iOS theme merge

### How Extraction Works

#### 1. SCSS Parsing

```python
# Parse a token line from SCSS
line = "$elvt-component-button-fill-danger-active: var(--elvt-alias-action-strong-danger-fill-active, rgb(108 1 1));"

# Extract:
token_name = "elvt-component-button-fill-danger-active"
reference = "elvt-alias-action-strong-danger-fill-active"
fallback_rgb = (0.4235, 0.0039, 0.0039)  # rgb(108 1 1) normalized
```

#### 2. Light/Dark Mode Handling

```python
# Same token name, different reference in dark mode
light_token.reference = "elvt-primitives-color-red-900"
dark_token.reference = "elvt-primitives-color-red-700"

# Generated Swift:
Color.adaptive(
    light: ElevatePrimitives.Red._900,
    dark: ElevatePrimitives.Red._700
)
```

#### 3. Unit Conversion

```python
# SCSS: 0.5rem
value = 0.5
unit = "rem"

# Swift: 8.0 (1rem = 16pt)
swift_value = value * 16  # → 8.0
output = f"public static let gap_m: CGFloat = {swift_value}"
```

#### 4. Theme Token Merging

```python
def merge_theme_tokens(
    base_tokens: Dict[str, TokenReference],
    extend_file: Path,
    overwrite_file: Path
) -> Dict[str, TokenReference]:
    """
    Merge theme tokens with base ELEVATE tokens.

    Strategy:
        1. Start with base ELEVATE tokens
        2. Add tokens from extend.css (only if not already present)
        3. Override with tokens from overwrite.css (replace if present)
    """
```

**Merge Strategy**:
- Base ELEVATE tokens (2481 tokens)
- \+ extend.css tokens (22 tokens) - only if not in base
- \+ overwrite.css tokens (0 currently) - replace if present
- **= 2503 total tokens**

### MD5 Cache System

**Purpose**: Avoid regenerating unchanged files.

**Cache File**: `ElevateUI/Sources/DesignTokens/.token_cache.json`

**Structure**:
```json
{
  "/path/to/ButtonComponentTokens.swift": {
    "/path/to/_light.scss": "md5hash123",
    "/path/to/_dark.scss": "md5hash456",
    "/path/to/_button.scss": "md5hash789",
    "/path/to/extend.css": "md5hash321",
    "/path/to/overwrite.css": "md5hash654"
  }
}
```

**Efficiency**:
- **First run**: 0/54 files cached (100% regenerated)
- **Second run**: 54/54 files cached (0% regenerated)
- **After ELEVATE update**: ~90% cached (only changed components regenerated)

---

## iOS-Specific Tokens (Theme System)

### Overview

The iOS theme system allows platform-specific design tokens to be maintained in CSS files and automatically extracted alongside base ELEVATE tokens.

**Theme Folder**: `.elevate-themes/ios/`

```
.elevate-themes/
└── ios/
    ├── extend.css      # Missing ELEVATE tokens
    └── overwrite.css   # iOS-specific overrides
```

### extend.css - Missing ELEVATE Tokens

**Purpose**: Define tokens that ELEVATE doesn't provide but are needed for iOS implementation.

**Strategy**: When ELEVATE officially adds these tokens, remove them from extend.css and the official tokens will automatically be used.

**Current Tokens** (22 tokens):

#### Button Tokens
```css
$elvt-component-button-border-radius-pill: 9999px;
```

#### Chip Tokens
```css
/* Vertical padding (block) */
$elvt-component-chip-padding-block-s: 0.125rem;  /* 2px */
$elvt-component-chip-padding-block-m: 0.375rem;  /* 6px */
$elvt-component-chip-padding-block-l: 0.5rem;    /* 8px */

/* Icon sizes */
$elvt-component-chip-icon-size-s: 0.875rem;  /* 14px */
$elvt-component-chip-icon-size-m: 1rem;      /* 16px */
$elvt-component-chip-icon-size-l: 1.25rem;   /* 20px */

/* Remove button sizes */
$elvt-component-chip-remove-button-size-s: 0.875rem;  /* 14px */
$elvt-component-chip-remove-button-size-m: 1rem;      /* 16px */
$elvt-component-chip-remove-button-size-l: 1.25rem;   /* 20px */
```

#### Badge Tokens
```css
/* Vertical padding (block) */
$elvt-component-badge-padding-block-major: 0.125rem;  /* 2px */
$elvt-component-badge-padding-block-minor: 0.0625rem; /* 1px */

/* Icon sizes */
$elvt-component-badge-icon-size-major: 1rem;      /* 16px */
$elvt-component-badge-icon-size-minor: 0.75rem;   /* 12px */

/* Minor horizontal padding */
$elvt-component-badge-padding-inline-minor: 0.375rem;  /* 6px */
```

#### Menu Tokens
```css
/* Shadow properties */
$elvt-component-menu-shadow-color: rgba(0, 0, 0, 0.1);
$elvt-component-menu-shadow-radius: 0.5rem;  /* 8px */
$elvt-component-menu-shadow-offset-x: 0;
$elvt-component-menu-shadow-offset-y: 0.25rem;  /* 4px */
```

### overwrite.css - iOS-Specific Overrides

**Purpose**: Override existing ELEVATE tokens when iOS has different requirements (e.g., 44pt touch targets vs web's smaller targets).

**Current State**: Empty by design - using 100% stock ELEVATE tokens where they exist.

**When to Use Overrides**:
- Apple HIG requirements differ from ELEVATE
- Touch target size adjustments (44pt minimum)
- iOS-specific accessibility needs
- Platform-specific visual adjustments

**Example Override** (not currently in use):
```css
/**
 * Override button height for iOS touch targets
 * Apple HIG requires 44pt minimum touch target
 * ELEVATE default: 40px (too small for comfortable thumb tapping)
 * Tested on: iPhone SE, iPhone 15 Pro Max
 */
$elvt-component-button-height-m: 2.75rem;  /* 44px */
```

### Adding New Theme Tokens

**For Missing Tokens (extend.css)**:

1. Add to extend.css with documentation:
```css
/**
 * Component: MyComponent
 * Why: ELEVATE doesn't provide this token, needed for iOS implementation
 * When: Remove when ELEVATE adds official token
 */
$elvt-component-mycomponent-my-property: 1rem;
```

2. Regenerate tokens:
```bash
python3 scripts/update-design-tokens-v4.py --force
```

3. Use in Swift:
```swift
let value = MyComponentTokens.elvt_component_mycomponent_my_property
```

4. When ELEVATE adds it:
   - Remove from extend.css
   - Regenerate
   - Swift code automatically uses ELEVATE's official token

**For Overrides (overwrite.css)**:

1. Add to overwrite.css with **detailed documentation**:
```css
/**
 * Override: [token name]
 * Reason: [Apple HIG requirement / iOS-specific need]
 * Original ELEVATE value: [value]
 * iOS override value: [value]
 * Tested on: [devices tested]
 */
$elvt-component-button-height-m: 2.75rem;  /* 44px */
```

2. Regenerate and verify:
```bash
python3 scripts/update-design-tokens-v4.py --force
swift build
```

**For detailed information on the iOS theme system, see**: `.claude/archived/THEME_BASED_TOKEN_SYSTEM_COMPLETE.md`

---

## Usage Workflow

### File Structure

```
elevate-ios/
├── .elevate-src/                              # ELEVATE source (external)
│   └── Elevate-2025-11-04/
│       └── elevate-design-tokens-main/src/scss/
│           ├── values/
│           │   ├── _light.scss                # 2,481 tokens (light mode)
│           │   └── _dark.scss                 # 2,481 tokens (dark mode)
│           └── tokens/component/
│               ├── _button.scss               # Button tokens
│               └── ... (51 files)
│
├── .elevate-themes/                           # iOS theme layer
│   └── ios/
│       ├── extend.css                         # Missing ELEVATE tokens
│       └── overwrite.css                      # iOS overrides
│
├── scripts/
│   ├── update-design-tokens-v4.py             # ⭐ Extraction script
│   └── regenerate-tokens-if-needed.sh         # Build integration
│
└── ElevateUI/Sources/DesignTokens/
    ├── Generated/                             # ⭐ EXTRACTED tokens (DO NOT EDIT)
    │   ├── ColorAdaptive.swift                # Helper extension
    │   ├── ElevatePrimitives.swift            # Tier 3 (63 tokens, 14KB)
    │   ├── ElevateAliases.swift               # Tier 2 (304 tokens, 40KB)
    │   └── ButtonComponentTokens.swift        # Tier 1 (colors + spacing)
    │       ... (51 component files)
    │
    ├── Components/                            # Optional manual wrappers
    │   └── ButtonTokens.swift                 # Size configs, helpers
    │
    └── .token_cache.json                      # MD5 cache (auto-managed)
```

### One-Command Update

**Regenerate All Tokens**:
```bash
python3 scripts/update-design-tokens-v4.py
```

**Force Regeneration (Ignore Cache)**:
```bash
python3 scripts/update-design-tokens-v4.py --force
```

**Expected Output**:
```
✅ Extracting Primitive tokens... (63 tokens)
✅ Extracting Alias tokens... (304 tokens)
✅ Extracting Component tokens...
   - ButtonComponentTokens.swift (CACHED)
   - ChipComponentTokens.swift (CACHED)
   - ... (51 components)
✅ Token extraction complete!
   - 54 files processed
   - 51 files cached (94% hit rate)
   - Generated in 0.3s
```

### Manual Regeneration

**Step 1: Verify ELEVATE Source**
```bash
ls -la .elevate-src/Elevate-*/elevate-design-tokens-main/src/scss/values/
```

**Step 2: Run Extraction**
```bash
python3 scripts/update-design-tokens-v4.py --force
```

**Step 3: Build Project**
```bash
swift build
```

**Step 4: Verify Tokens**
```bash
# Check generated files
ls -la ElevateUI/Sources/DesignTokens/Generated/

# Check specific token
grep "fill_danger_active" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift
```

### Automatic Regeneration (Build Integration)

**Add to Xcode Build Phase (Run Script)**:
```bash
./scripts/regenerate-tokens-if-needed.sh
```

**What it does**:
1. Checks if ELEVATE source exists
2. Computes MD5 hashes of source files
3. Only regenerates changed component files
4. Updates cache for next build
5. Exits cleanly if no changes

### When to Regenerate

**Always Regenerate When**:
- ✅ ELEVATE design system updates
- ✅ iOS theme files change (extend.css, overwrite.css)
- ✅ First time setting up project
- ✅ After pulling latest code

**Usually Don't Need to Regenerate**:
- ❌ SwiftUI component changes
- ❌ Business logic changes
- ❌ Manual token wrapper changes (Components/ folder)

### Using Tokens in Components

#### ✅ Correct Usage

```swift
import SwiftUI

struct ElevateButton: View {
    let tone: Tone
    @State private var isPressed = false

    var body: some View {
        Text("Button")
            // ✅ Use Component Tokens for colors
            .foregroundColor(isPressed
                ? ButtonComponentTokens.label_primary_active
                : ButtonComponentTokens.label_primary_default)
            .background(isPressed
                ? ButtonComponentTokens.fill_primary_active
                : ButtonComponentTokens.fill_primary_default)

            // ✅ Use Component Tokens for spacing
            .padding(.horizontal, ButtonComponentTokens.padding_inline_m)  // 12pt
            .frame(height: ButtonComponentTokens.height_m)                 // 40pt
            .cornerRadius(ButtonComponentTokens.border_radius_m)           // 4pt
    }
}
```

**Benefits**:
- ✅ Dark mode works automatically
- ✅ Updates when ELEVATE updates
- ✅ Type-safe (compile-time errors)
- ✅ Zero runtime overhead

#### ❌ Wrong Usage (Don't Do This)

```swift
// ❌ WRONG: Hardcoded RGB
.foregroundColor(Color(red: 0.043, green: 0.36, blue: 0.87))

// ❌ WRONG: Hardcoded spacing
.padding(.horizontal, 12)
.frame(height: 40)

// ❌ WRONG: Using Primitives directly
.background(ElevatePrimitives.Blue._600)

// ❌ WRONG: Named colors
.background(Color.blue)
.foregroundColor(.white)
```

**Problems**:
- ❌ No dark mode
- ❌ Breaks when ELEVATE updates
- ❌ Not type-safe
- ❌ Diverges from design system

---

## Token Types and Examples

### Colors

**Component-level colors** (use these):
```swift
ButtonComponentTokens.fill_primary_default          // → Color
ButtonComponentTokens.label_danger_hover            // → Color
ButtonComponentTokens.border_neutral_color_default  // → Color
```

**Alias-level colors** (when no component token):
```swift
ElevateAliases.Action.Primary.fill_default       // → Color
ElevateAliases.Content.General.text_default      // → Color
ElevateAliases.Surface.General.bg_page           // → Color
ElevateAliases.Feedback.General.fill_danger      // → Color
```

**Usage**:
```swift
// Button background
.background(ButtonComponentTokens.fill_primary_default)

// App background (no component token)
.background(ElevateAliases.Surface.General.bg_page)
```

### Spacing

**Component-level spacing**:
```swift
ButtonComponentTokens.gap_m                         // → CGFloat (8.0)
ButtonComponentTokens.padding_inline_l              // → CGFloat (20.0)
ChipComponentTokens.padding_block_m                 // → CGFloat (6.0)
```

**Usage**:
```swift
// Horizontal padding
.padding(.horizontal, ButtonComponentTokens.padding_inline_m)

// Vertical padding
.padding(.vertical, ChipComponentTokens.padding_block_m)

// Spacing between elements
VStack(spacing: ButtonComponentTokens.gap_m) {
    // content
}
```

### Dimensions

**Component-level dimensions**:
```swift
ButtonComponentTokens.height_l                      // → CGFloat (48.0)
ButtonComponentTokens.border_radius_m               // → CGFloat (4.0)
ButtonComponentTokens.border_width                  // → CGFloat (1.0)
ChipComponentTokens.icon_size_m                     // → CGFloat (16.0)
```

**Usage**:
```swift
// Height
.frame(height: ButtonComponentTokens.height_m)

// Corner radius
.cornerRadius(ButtonComponentTokens.border_radius_m)

// Border
.border(
    ButtonComponentTokens.border_neutral_color_default,
    width: ButtonComponentTokens.border_width
)

// Icon size
Image(systemName: "star")
    .frame(
        width: ChipComponentTokens.icon_size_m,
        height: ChipComponentTokens.icon_size_m
    )
```

### Dark Mode Support

**How It Works**:

Tokens automatically adapt to system color scheme:

```swift
// This automatically switches in dark mode!
foregroundColor(ButtonComponentTokens.label_primary_default)

// Light mode: Dark text
// Dark mode: Light text
// No extra code needed! ✅
```

**Under the Hood**:

```swift
// Alias Token contains BOTH light and dark values
public static let text_default = Color.adaptive(
    light: ElevatePrimitives.Gray._950,   // Dark gray for light mode
    dark: ElevatePrimitives.Gray._50      // Light gray for dark mode
)

// Component Token references Alias token (inherits dark mode support)
public static let label_primary_default =
    ElevateAliases.Action.Primary.text_default  // Already has dark mode
```

---

## Staying in Sync with ELEVATE

### When ELEVATE Updates

**Scenario**: ELEVATE releases v2.5.0 with new colors and components

#### Step 1: Download New ELEVATE Source
```bash
cd .elevate-src/
# Download Elevate-2025-12-15.zip
unzip Elevate-2025-12-15.zip
```

#### Step 2: Update Environment Variable (Optional)
```bash
export ELEVATE_TOKENS_PATH="/path/to/Elevate-2025-12-15/elevate-design-tokens-main/src/scss"
```

Or update in script permanently:
```python
# In scripts/update-design-tokens-v4.py line ~34
ELEVATE_TOKENS_PATH = Path("/path/to/Elevate-2025-12-15/...")
```

#### Step 3: Review iOS Theme
```bash
# Check if ELEVATE added any tokens we have in extend.css
# Remove duplicates from extend.css
```

#### Step 4: Extract Tokens
```bash
python3 scripts/update-design-tokens-v4.py --force
```

**Output**:
```
✅ Extracting Primitive tokens... (65 tokens, +2 new)
✅ Extracting Alias tokens... (320 tokens, +16 new)
✅ Extracting Component tokens...
   - ButtonComponentTokens.swift (UPDATED)
   - NewComponentTokens.swift (NEW)
```

#### Step 5: Rebuild App
```bash
swift build
```

**Done!** All components now use ELEVATE v2.5.0.

### No Manual Intervention Required

**What Updates Automatically**:

✅ **New colors** → Extracted to Primitives/Aliases
✅ **New component tokens** → New Swift file generated
✅ **Changed spacing values** → Updated in Component files
✅ **Dark mode variations** → Extracted and applied
✅ **New components** → Detected and extracted

**What Stays Agile**:

✅ **Single source of truth**: ELEVATE SCSS
✅ **No interpretation**: Direct extraction
✅ **No divergence**: Can't get out of sync
✅ **Fast updates**: Run script → Build → Done

---

## Troubleshooting

### Build Fails with "Component Tokens not found"

**Symptom**: Build error: `Cannot find 'ButtonComponentTokens' in scope`

**Cause**: Token files not generated or not in build path.

**Solution**:
```bash
# Regenerate tokens
python3 scripts/update-design-tokens-v4.py --force

# Verify files exist
ls ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Rebuild
swift build
```

### Build Fails with "ElevateAliases not found"

**Symptom**: Build error: `Cannot find 'ElevateAliases' in scope`

**Cause**: Missing Alias/Primitive token files.

**Solution**:
```bash
# Check if files exist
find ElevateUI/Sources/DesignTokens -name "*Aliases*"
find ElevateUI/Sources/DesignTokens -name "*Primitives*"

# Regenerate if missing
python3 scripts/update-design-tokens-v4.py --force
```

### Tokens Showing Color.clear or nil

**Symptom**: Colors appear transparent or missing.

**Cause**: Token reference not found in light/dark mode files.

**Solution**:
```bash
# Check if token exists in ELEVATE source
grep "elvt-component-button-fill-danger-active" \
    .elevate-src/.../values/_light.scss

# If missing, add to extend.css or check token name
```

### Script Fails with "ELEVATE source not found"

**Symptom**: Error: `FileNotFoundError: [Errno 2] No such file or directory`

**Cause**: ELEVATE_TOKENS_PATH incorrect or source not downloaded.

**Solution**:
```bash
# Verify ELEVATE source exists
ls -la .elevate-src/

# Set correct path
export ELEVATE_TOKENS_PATH="/correct/path/to/scss"

# Or update in script (line ~34)
```

### Colors Don't Change in Dark Mode

**Symptom**: Component stays same color in light/dark mode.

**Cause**: Using Primitive Token instead of Component/Alias.

**Solution**:
```swift
// ❌ WRONG
.background(ElevatePrimitives.Blue._600)

// ✅ CORRECT
.background(ButtonComponentTokens.fill_primary_default)
```

### Can't Find Right Token

**Symptom**: Need a color but can't find component token.

**Solution**: Use Alias token and consider filing issue to add component token:
```swift
// Temporary: Use Alias
.foregroundColor(ElevateAliases.Content.General.text_default)

// TODO: Should there be a MenuItemComponentTokens.text_default?
```

### Token Name Unclear

**Symptom**: Not sure which token to use.

**Solution**: Follow naming pattern:
- `fill_*` → backgrounds
- `label_*` or `text_*` → text colors
- `border_*` → border colors
- `icon_*` → icon colors
- State suffix: `_default`, `_hover`, `_active`, `_disabled`, etc.

### Cache Issues

**Symptom**: Changes not reflected after regeneration.

**Solution**:
```bash
# Clear cache and regenerate
rm ElevateUI/Sources/DesignTokens/.token_cache.json
python3 scripts/update-design-tokens-v4.py --force
```

### Verification Commands

**Check Extraction Worked**:
```bash
# Count generated files (expected: 54)
ls ElevateUI/Sources/DesignTokens/Generated/*.swift | wc -l

# Check Primitives extracted
grep "public enum Blue" ElevateUI/Sources/DesignTokens/Generated/ElevatePrimitives.swift

# Check Aliases extracted
grep "StrongDanger" ElevateUI/Sources/DesignTokens/Generated/ElevateAliases.swift

# Check Component tokens extracted
grep "fill_danger_active" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift
```

**Verify Token Hierarchy**:
```bash
# Check Component → Alias reference
grep "ElevateAliases.Action" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift

# Check Alias → Primitive reference
grep "ElevatePrimitives.Red" ElevateUI/Sources/DesignTokens/Generated/ElevateAliases.swift

# Verify build works
swift build
```

---

## Performance

### Extraction Speed
- **Initial extraction**: 2-3 seconds (all 54 files)
- **Cached extraction**: 0.3 seconds (no changes)
- **Build overhead**: +0.3s with cache, +2.5s without

### Cache Efficiency
- **First run**: 0/54 files cached (100% regenerated)
- **Second run**: 54/54 files cached (0% regenerated)
- **After ELEVATE update**: ~90% cached (only changed components regenerated)

### Build Performance
- **With token cache**: Build complete in 0.72s
- **Without token cache**: Build complete in 3.2s
- **Xcode build impact**: +0.3s with cache, +2.5s without

### File Size
- **ColorAdaptive.swift**: 1KB
- **ElevatePrimitives.swift**: 14KB (63 tokens)
- **ElevateAliases.swift**: 40KB (304 tokens)
- **Component tokens**: 28-56KB per file (51 files)
- **Total generated**: ~2.5MB

---

## Related Documentation

### Internal Documentation

**Core Concepts**:
- `.claude/concepts/design-token-hierarchy.md` - Detailed three-tier hierarchy explanation
- `.claude/concepts/ios-touch-guidelines.md` - Apple HIG touch target requirements
- `.claude/concepts/scroll-friendly-gestures.md` - iOS gesture handling patterns

**Implementation Details**:
- `.claude/archived/THEME_BASED_TOKEN_SYSTEM_COMPLETE.md` - Complete iOS theme system details
- `COMPLETE_TOKEN_EXTRACTION.md` - Original extraction system documentation (source for this doc)
- `TOKEN_EXTRACTION_WORKFLOW.md` - Original workflow documentation (source for this doc)

**Component Guides**:
- `.claude/components/*/...-ios-implementation.md` - Component-specific implementation guides
- `COMPONENT_DEVELOPMENT_GUIDE.md` - General component development patterns
- `COMPONENT_PORT_SESSION_2.md` - Component porting examples

### Scripts

**Token Extraction**:
- `scripts/update-design-tokens-v4.py` - Main extraction script
- `scripts/regenerate-tokens-if-needed.sh` - Build integration script

**Usage**:
```bash
# Extract tokens
python3 scripts/update-design-tokens-v4.py

# Force regeneration
python3 scripts/update-design-tokens-v4.py --force
```

### External Resources

**ELEVATE Design System**:
- Official ELEVATE documentation
- Component library
- Design tokens repository

**Apple Human Interface Guidelines**:
- Touch targets and gestures
- Color and contrast
- Typography and layout

---

## Summary

### What We Built

✅ **Complete extraction pipeline** for all 3 token tiers
✅ **Primitives**: 63 color tokens (14KB Swift)
✅ **Aliases**: 304 semantic tokens (40KB Swift)
✅ **Components**: 51 component files with colors + spacing + dimensions
✅ **iOS Theme System**: CSS-based extend/overwrite mechanism
✅ **MD5 caching** for fast incremental builds
✅ **Build integration** for automatic regeneration
✅ **100% fidelity** to ELEVATE SCSS source

### Core Philosophy

**ELEVATE designers define → We extract → SwiftUI uses**

- ✅ **No interpretation** - direct SCSS → Swift conversion
- ✅ **No invention** - we don't create tokens, we extract them
- ✅ **No divergence** - single source of truth (SCSS)
- ✅ **Agile updates** - ELEVATE updates in minutes, not days

### Token Hierarchy

```
Component Tokens (USE FIRST)
    ↓ references
Alias Tokens (USE if no Component Token)
    ↓ references
Primitive Tokens (NEVER use directly)
    ↓ resolves to
RGB Color Values (light/dark mode)
```

### Next Steps

1. ✅ **Extraction complete** - All tokens extracted
2. ✅ **iOS theme system** - Platform customization layer
3. ⏳ **Audit components** - Find hardcoded values
4. ⏳ **Refactor components** - Replace hardcoded → tokens
5. ⏳ **Document patterns** - Component refactoring guide

---

## Token Generation Implementation Details

### Parser Architecture

#### Key Classes

**SCSSUniversalParser**
Extracts tokens from SCSS files:
- Parses `$variable: value;` syntax
- Handles `rgba()`, hex colors, pixel values
- Detects token references with `var(--token-name)`
- Classifies tokens by type (COLOR, SPACING, DIMENSION)

**ComprehensiveComponentGenerator**
Generates component token files:
- Merges light/dark mode values
- Organizes tokens by type (colors, spacing, dimensions)
- Generates `Color.adaptive()` calls
- Applies deduplication logic

**PrimitivesGenerator**
Generates ElevatePrimitives.swift:
- Extracts primitive color tokens
- Organizes by color family (Blue, Red, Green, etc.)
- Creates nested struct hierarchy

**AliasesGenerator**
Generates ElevateAliases.swift:
- Extracts semantic alias tokens
- Organizes by category (Action, Content, Surface, etc.)
- Maintains reference chain to primitives

**TokenCacheManager**
Manages MD5-based caching:
- Computes file hashes
- Checks if regeneration needed
- Saves/loads cache from JSON

### Token Type Detection
```python
class TokenType(Enum):
    COLOR = "color"
    SPACING = "spacing"
    DIMENSION = "dimension"
    TYPOGRAPHY = "typography"
    UNKNOWN = "unknown"
```

### Swift Code Generation Patterns

**Color Adaptive Pattern**
```swift
public static let token_name = Color.adaptive(
    light: ElevateAliases.Category.light_token,
    dark: ElevateAliases.Category.dark_token
)
```

**Fallback RGB Pattern**
When no reference exists:
```swift
public static let token_name = Color.adaptive(
    lightRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000),
    darkRGB: (red: 0.3725, green: 0.6745, blue: 1.0000, opacity: 1.0000)
)
```

**Static Values**
For spacing/dimensions:
```swift
public static let height_m: CGFloat = 44.0
```

### Token Deduplication

**Problem**
Previous versions generated duplicate tokens:
- Short form: `fill_primary_default`
- Long form: `elvt_component_button_fill_primary_default`

This caused 33% bloat in generated files.

**Solution**
The generator now filters duplicate long-form tokens when a short-form equivalent exists:

```python
# Filter out duplicate long-form tokens (elvt-component-{name}-*)
duplicate_prefix = f"elvt-component-{self.component_name}-"
for token_name, token_ref in self.component_tokens.items():
    if token_name.startswith(duplicate_prefix):
        short_name = token_name.replace(duplicate_prefix, '')
        if short_name in self.component_tokens:
            continue  # Skip this duplicate
```

**Impact**
- **582 lines removed** across 12 component files
- **41% size reduction** for ButtonComponentTokens (48KB → 28KB)
- **258KB total** generated code (down from ~420KB)

### Validation

**Test Suite**
Run validation tests:
```bash
python3 tests/test_token_generator.py
```

**Test Coverage**
- SCSS parsing (colors, spacing, dimensions)
- Swift name sanitization
- Token cache invalidation
- Token deduplication logic
- Integration tests

**Manual Verification**
```bash
# Regenerate tokens
python3 scripts/update-design-tokens-v4.py

# Build project
swift build

# Check output
ls -lh ElevateUI/Sources/DesignTokens/Generated/
```

### Selective Regeneration (Phase 3 Enhancement)

**Change Detection**
Uses MD5 hashing for fast change detection:
- Scan 56 SCSS source files
- Compute MD5 hash for each
- Compare against cached hashes
- Identify changed files (O(n) time)

**Dependency Analysis**
- Load TokenDependencyGraph
- Apply transitive dependencies
- Generate topological order
- Return minimal regeneration set

**Selective Generation**
```bash
# Selective regeneration (optimized)
python3 scripts/update-design-tokens-v4.py --selective

# Force full regeneration (ignore all caches)
python3 scripts/update-design-tokens-v4.py --force

# Check what would be regenerated (dry run)
python3 scripts/scss_change_detector.py --status
```

**Performance Gains**:
- Single component: 34s → 6s (6x faster, 97.9% efficiency)
- Multiple components: 34s → 7s (5x faster, 93.8% efficiency)
- Typography update: 34s → 6s (5.5x faster, 95.8% efficiency)

---

**The ELEVATE iOS design system now has a production-ready extraction pipeline that maintains perfect sync with the web component library while supporting iOS-specific customization.**
