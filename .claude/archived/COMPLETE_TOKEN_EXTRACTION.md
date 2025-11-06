# Complete ELEVATE Token Extraction System

**Version**: 4.0 Final
**Date**: 2025-11-06
**Status**: ✅ Production Complete

---

## What Was Built

A **complete automated extraction system** that converts ELEVATE's SCSS design tokens to type-safe Swift code.

### Key Point: EXTRACTION, Not Generation

**All tokens are DEFINED by ELEVATE designers in SCSS** → Our script **EXTRACTS** them and converts to Swift.

**Nothing is invented or created** - we maintain 100% fidelity to ELEVATE's source of truth.

---

## Complete Extraction Pipeline

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
│  Python Extraction Script (update-design-tokens-v4.py)  │
│  ------------------------------------------------       │
│  1. Parse 2,481 tokens from _light.scss                │
│  2. Parse 2,481 tokens from _dark.scss                 │
│  3. Extract Primitives (63 color tokens)               │
│  4. Extract Aliases (304 semantic tokens)              │
│  5. Extract Component Tokens (51 components)           │
│  6. Convert SCSS → Swift with proper references        │
│  7. Generate adaptive colors for light/dark mode       │
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

---

## Token Hierarchy (3 Tiers)

### Tier 1: Primitive Tokens (EXTRACTED from SCSS)

**ELEVATE Defines** (in `_light.scss` and `_dark.scss`):
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
}
```

**Usage**: ⚠️ **DO NOT USE DIRECTLY** - Use Alias or Component tokens instead

---

### Tier 2: Alias Tokens (EXTRACTED from SCSS)

**ELEVATE Defines** (in `_light.scss`):
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

**Usage**: ✅ **Use when no Component Token exists** (e.g., app background)

---

### Tier 3: Component Tokens (EXTRACTED from SCSS)

**ELEVATE Defines** (in `_light.scss`):
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

**Usage**: ✅ **ALWAYS USE FIRST** - This is the primary API

---

## Complete Token Hierarchy Example

```swift
// SwiftUI Component
struct MyButton: View {
    var body: some View {
        Text("Delete")
            .foregroundColor(
                ButtonComponentTokens.label_danger_default  // Tier 3: Component
            )
            .background(
                ButtonComponentTokens.fill_danger_default   // Tier 3: Component
            )
            .frame(height: ButtonComponentTokens.height_m)  // Tier 3: Dimension
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

---

## Extraction Statistics

### Source (ELEVATE SCSS)
- **2,481 tokens** in `_light.scss`
- **2,481 tokens** in `_dark.scss` (same names, different values)
- **51 component files** with element-specific tokens

### Extracted Output (Swift)
- **54 files total**:
  - 1 ColorAdaptive.swift (1KB - helper extension)
  - 1 ElevatePrimitives.swift (14KB - 63 color primitives)
  - 1 ElevateAliases.swift (40KB - 304 semantic tokens)
  - 51 *ComponentTokens.swift (colors + spacing + dimensions)

### Token Counts
- **63 Primitive color tokens** (Blue, Red, Gray, Green, Orange, etc.)
- **304 Alias tokens** (Action, Content, Surface, Feedback, Layout)
- **Thousands of Component tokens** across 51 components

---

## How Extraction Works

### 1. SCSS Parsing

```python
# Parse a token line from SCSS
line = "$elvt-component-button-fill-danger-active: var(--elvt-alias-action-strong-danger-fill-active, rgb(108 1 1));"

# Extract:
token_name = "elvt-component-button-fill-danger-active"
reference = "elvt-alias-action-strong-danger-fill-active"
fallback_rgb = (0.4235, 0.0039, 0.0039)  # rgb(108 1 1) normalized
```

### 2. Light/Dark Mode Handling

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

### 3. Unit Conversion

```python
# SCSS: 0.5rem
value = 0.5
unit = "rem"

# Swift: 8.0 (1rem = 16pt)
swift_value = value * 16  # → 8.0
output = f"public static let gap_m: CGFloat = {swift_value}"
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

#### Step 3: Extract Tokens
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

#### Step 4: Rebuild App
```bash
swift build
```

**Done!** All components now use ELEVATE v2.5.0.

---

## No Manual Intervention Required

### What Updates Automatically:

✅ **New colors** → Extracted to Primitives/Aliases
✅ **New component tokens** → New Swift file generated
✅ **Changed spacing values** → Updated in Component files
✅ **Dark mode variations** → Extracted and applied
✅ **New components** → Detected and extracted

### What Stays Agile:

✅ **Single source of truth**: ELEVATE SCSS
✅ **No interpretation**: Direct extraction
✅ **No divergence**: Can't get out of sync
✅ **Fast updates**: Run script → Build → Done

---

## File Structure

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

---

## Usage in Components

### ✅ Correct Usage

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

---

### ❌ Wrong Usage (Don't Do This)

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

## Verification

### Check Extraction Worked

```bash
# Count generated files
ls ElevateUI/Sources/DesignTokens/Generated/*.swift | wc -l
# Expected: 54

# Check Primitives extracted
grep "public enum Blue" ElevateUI/Sources/DesignTokens/Generated/ElevatePrimitives.swift
# Expected: "public enum Blue {"

# Check Aliases extracted
grep "StrongDanger" ElevateUI/Sources/DesignTokens/Generated/ElevateAliases.swift
# Expected: "public enum StrongDanger {"

# Check Component tokens extracted
grep "fill_danger_active" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift
# Expected: "public static let fill_danger_active = ..."
```

### Verify Token Hierarchy

```bash
# Check Component → Alias reference
grep "ElevateAliases.Action" ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift
# Expected: Multiple matches

# Check Alias → Primitive reference
grep "ElevatePrimitives.Red" ElevateUI/Sources/DesignTokens/Generated/ElevateAliases.swift
# Expected: Multiple matches

# Verify build works
swift build
# Expected: Build complete! (0.83s)
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

---

## Summary

### What We Built

✅ **Complete extraction pipeline** for all 3 token tiers
✅ **Primitives**: 63 color tokens (14KB Swift)
✅ **Aliases**: 304 semantic tokens (40KB Swift)
✅ **Components**: 51 component files with colors + spacing + dimensions
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
2. ⏳ **Audit components** - Find hardcoded values
3. ⏳ **Refactor components** - Replace hardcoded → tokens
4. ⏳ **Document patterns** - Component refactoring guide

---

**The ELEVATE iOS design system now has a production-ready extraction pipeline that maintains perfect sync with the web component library.**
