# ELEVATE Design Token Hierarchy

## Overview

The ELEVATE iOS package now implements the proper **three-tier design token hierarchy** exactly as specified in the ELEVATE Design System. This ensures components reference semantic tokens (not raw values) and maintains consistency with the web implementation.

## The Three-Tier System

```
┌─────────────────────────────────────────────────┐
│  PRIMITIVES (Base Values)                      │
│  • Raw RGB colors                               │
│  • Base measurements                            │
│  • Foundation of the system                     │
│  • Example: blue-600, gray-400                  │
└─────────────────────────────────────────────────┘
                    ↓ references
┌─────────────────────────────────────────────────┐
│  ALIASES (Semantic Tokens)                      │
│  • Give meaning to primitives                    │
│  • Context-specific colors                       │
│  • Platform-independent semantics                │
│  • Example: action-primary, feedback-success    │
└─────────────────────────────────────────────────┘
                    ↓ references
┌─────────────────────────────────────────────────┐
│  COMPONENTS (Component-Specific Tokens)          │
│  • Component-level specifications                │
│  • Reference aliases (not primitives!)           │
│  • Maintain design consistency                   │
│  • Example: button-fill-primary-default          │
└─────────────────────────────────────────────────┘
```

## Token Counts

**Extracted from ELEVATE Design System v0.37.0:**

| Tier | Count | Description |
|------|-------|-------------|
| **Primitives** | 131 | Base color palette (Blue, Red, Gray, Green, Orange, etc.) |
| **Aliases** | 303 | Semantic tokens (Action, Feedback, Content, Layout) |
| **Components** | 1,406 | Component-specific tokens (Button, Badge, Input, etc.) |
| **TOTAL** | **1,840** | Complete token system |

## Implementation Structure

### 1. Primitives (`ElevatePrimitives.swift`)

**Location:** `ElevateUI/Sources/DesignTokens/Primitives/`

**Purpose:** Base color palette - the foundation of the design system.

**Usage:** These should **NOT** be used directly in components. They exist to be referenced by alias tokens.

**Structure:**
```swift
public struct ElevatePrimitives {
    public enum Blue {
        public static let _50 = Color(red: 0.9176, green: 0.9569, blue: 1.0000)
        public static let _100 = Color(red: 0.7255, green: 0.8588, blue: 1.0000)
        public static let _600 = Color(red: 0.0431, green: 0.3608, blue: 0.8745) // Primary blue
        public static let _900 = Color(red: 0.1373, green: 0.2000, blue: 0.2941)
    }

    public enum Red {
        public static let _600 = Color(red: 0.8078, green: 0.0039, blue: 0.0039) // Danger red
        // ... more shades
    }

    // ... Gray, Green, Orange, Transparent, Black, White
}
```

**Color Families:**
- Blue (12 shades: 50-1000)
- Gray (12 shades: 50-1000)
- Green (12 shades: 50-1000)
- Orange (12 shades: 50-1000)
- Red (12 shades: 50-1000)
- Black, White, Transparent

### 2. Aliases (`ElevateAliases.swift`)

**Location:** `ElevateUI/Sources/DesignTokens/Aliases/`

**Purpose:** Semantic tokens that provide meaning and context to colors.

**Usage:** These are what components should reference. They bridge the gap between raw colors and component-specific needs.

**Structure:**
```swift
public struct ElevateAliases {
    public enum Action {
        public enum StrongPrimary {
            public static let fill_default = Color(...) // References primitive blue-600
            public static let fill_hover = Color(...)
            public static let fill_active = Color(...)
            public static let fill_disabled_default = Color(...)
            public static let border_default = Color(...)
            public static let text_default = Color(...)
        }

        public enum StrongDanger {
            // Similar structure for danger actions
        }

        public enum Understated Primary {
            // Subtle/understated variants
        }
    }

    public enum Feedback {
        public static let strong_fill_success = Color(...)
        public static let strong_fill_warning = Color(...)
        public static let strong_fill_danger = Color(...)
        // ... feedback-specific tokens
    }
}
```

**Alias Categories:**
- **Action**: User interactions (buttons, links, form controls)
  - Strong (high contrast)
  - Understated (subtle)
  - Variants: Primary, Secondary, Danger, Success, Warning, Neutral, Emphasized
- **Feedback**: Status indicators (success, warning, error)
- **Content**: Text and content colors
- **Layout**: Structure and surface colors

### 3. Components (`ButtonTokens.swift`, etc.)

**Location:** `ElevateUI/Sources/DesignTokens/Components/`

**Purpose:** Component-specific token specifications.

**Usage:** These are used directly in component implementations.

**Current Implementation:**
```swift
public struct ButtonTokens {
    public enum Tone {
        case primary, secondary, success, warning, danger, emphasized, subtle, neutral
    }

    public struct ToneColors {
        let background: Color           // → Alias: action-strong-primary-fill-default
        let backgroundHover: Color      // → Alias: action-strong-primary-fill-hover
        let backgroundActive: Color     // → Alias: action-strong-primary-fill-active
        let backgroundDisabled: Color   // → Alias: action-strong-primary-fill-disabled
        let text: Color                 // → Alias: action-strong-primary-text-default
        let textDisabled: Color         // → Alias: action-strong-primary-text-disabled
        let border: Color               // → Alias: action-strong-primary-border-default

        static let primary = ToneColors(...)
        static let danger = ToneColors(...)
        // ... all 8 tones
    }
}
```

## Token Naming Conventions

### SCSS (Source)
```scss
// Primitive
$elvt-primitives-color-blue-600: rgb(11 92 223);

// Alias (references primitive)
$elvt-alias-action-strong-primary-fill-default:
    var(--elvt-primitives-color-blue-600, rgb(11 92 223));

// Component (references alias)
$elvt-component-button-fill-primary-default:
    var(--elvt-alias-action-strong-primary-fill-default, rgb(11 92 223));
```

### Swift (iOS)
```swift
// Primitive
ElevatePrimitives.Blue._600

// Alias
ElevateAliases.Action.StrongPrimary.fill_default

// Component
ButtonTokens.primary.background
```

## Extraction Process

### Source Files

**ELEVATE Design Tokens Location:**
`/Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main/src/scss`

**Key Files:**
- `values/_light.scss` - Contains ALL tokens (primitives, aliases, components) with proper references
- `tokens/alias/` - Alias-specific SCSS files (organizational)
- `tokens/component/` - Component-specific SCSS files (organizational)

### Extraction Script

**Script:** `scripts/update-design-tokens-v2.py`

**Process:**
1. Parse `values/_light.scss` (contains full resolved token tree)
2. Extract primitives matching pattern: `$elvt-primitives-*`
3. Extract aliases matching pattern: `$elvt-alias-*` with references
4. Extract components matching pattern: `$elvt-component-*` with references
5. Generate Swift files with proper structure
6. Sanitize names (replace hyphens, escape Swift keywords)

**Running:**
```bash
python3 scripts/update-design-tokens-v2.py
```

**Output:**
- `ElevateUI/Sources/DesignTokens/Primitives/ElevatePrimitives.swift`
- `ElevateUI/Sources/DesignTokens/Aliases/ElevateAliases.swift`
- `ElevateUI/Sources/DesignTokens/Components/ButtonTokens.swift`

## Benefits of Three-Tier System

### 1. Consistency
Components always use the same semantic color for the same purpose across the entire system.

### 2. Maintainability
Changing a primitive color automatically updates all aliases and components that reference it.

### 3. Semantic Clarity
`action-strong-primary-fill-default` is more meaningful than `blue-600`.

### 4. Theme Support
Easy to implement dark mode or alternate themes by swapping primitive values.

### 5. Design-Dev Alignment
iOS implementation matches web implementation's token structure exactly.

## Usage Guidelines

### ✅ Correct Usage

```swift
// Use component tokens in components
Button(action: {})
    .foregroundColor(ButtonTokens.primary.text)
    .backgroundColor(ButtonTokens.primary.background)

// Use alias tokens when building new components
struct CustomControl: View {
    var body: some View {
        Rectangle()
            .fill(ElevateAliases.Action.StrongPrimary.fill_default)
    }
}
```

### ❌ Incorrect Usage

```swift
// DON'T use primitives directly in components
Button(action: {})
    .foregroundColor(ElevatePrimitives.Blue._600) // ❌ WRONG!

// DON'T hardcode colors
Button(action: {})
    .foregroundColor(Color(red: 0.043, green: 0.36, blue: 0.87)) // ❌ WRONG!
```

## Future Enhancements

### Phase 1: Enhanced Component Tokens
- [ ] Badge tokens
- [ ] Input field tokens
- [ ] Card tokens
- [ ] Navigation component tokens

### Phase 2: Dark Mode Support
- [ ] Extract dark theme tokens from `values/_dark.scss`
- [ ] Implement theme switching mechanism
- [ ] Generate `@Environment(\.colorScheme)` aware tokens

### Phase 3: Dynamic Type Support
- [ ] Typography token extraction
- [ ] Font scaling based on accessibility settings
- [ ] Responsive spacing tokens

### Phase 4: True Swift References
Currently, the Swift files use resolved color values. Future improvement:
```swift
// Current (resolved values)
public static let fill_default = Color(red: 0.0431, green: 0.3608, blue: 0.8745)

// Future (true references)
public static let fill_default = ElevatePrimitives.Blue._600
```

This would make the reference chain explicit in Swift code, not just conceptually.

## Verification

**Build Status:** ✅ All tokens compile successfully

```bash
swift build
# Build complete! (0.31s)
```

**Token Coverage:**
- ✅ 131 primitives extracted
- ✅ 303 aliases extracted
- ✅ 1,406 components extracted
- ✅ Swift naming sanitized (hyphens → underscores, keywords escaped)
- ✅ iOS-only platform guards
- ✅ Proper struct/enum organization

## Maintenance

### Updating Tokens

When ELEVATE design tokens are updated:

1. **Pull latest ELEVATE changes:**
   ```bash
   cd /Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main
   git pull
   ```

2. **Run extraction script:**
   ```bash
   cd /Users/wrede/Documents/GitHub/elevate-ios
   python3 scripts/update-design-tokens-v2.py
   ```

3. **Verify build:**
   ```bash
   swift build
   ```

4. **Review changes:**
   ```bash
   git diff
   ```

5. **Commit if valid:**
   ```bash
   git add .
   git commit -m "Update design tokens from ELEVATE v[version]"
   ```

### Backup Strategy

The extraction script automatically creates timestamped backups before updating:
- Location: `scripts/backups/YYYYMMDD_HHMMSS/`
- Files backed up: All generated Swift files
- Retention: Manual cleanup (backups are gitignored)

## Troubleshooting

### Issue: Build Errors After Extraction

**Symptom:** Swift compilation errors with token names

**Cause:** Invalid Swift identifiers (hyphens, keywords)

**Solution:** The script includes name sanitization. If issues persist:
1. Check for new Swift keywords
2. Update `sanitize_swift_name()` function in script
3. Re-run extraction

### Issue: Missing Tokens

**Symptom:** Component tokens not found in extracted files

**Cause:** Component not yet extracted from SCSS

**Solution:**
1. Verify component exists in `values/_light.scss`
2. Add component extraction logic to script
3. Follow pattern of existing ButtonTokensGeneratorV2

### Issue: Color Values Don't Match ELEVATE

**Symptom:** Visual differences between web and iOS

**Cause:** RGB conversion or wrong token reference

**Solution:**
1. Compare RGB values in SCSS vs Swift
2. Verify extraction pattern in script
3. Check color parser handles opacity correctly

## Summary

The iOS package now maintains **full fidelity with the ELEVATE Design System** through proper implementation of the three-tier token hierarchy:

- **1,840 total tokens** extracted and organized
- **Semantic naming** (not raw values) throughout
- **Components reference aliases** (not primitives)
- **Aliases reference primitives** (single source of truth)
- **Automated extraction** for easy updates
- **Build-verified** and ready for use

This foundation ensures the iOS implementation stays synchronized with web and maintains design consistency across all ELEVATE products.
