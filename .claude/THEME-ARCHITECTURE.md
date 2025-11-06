# ELEVATE Theme Architecture

**Version**: 1.0.0
**Status**: Design Document
**Last Updated**: 2025-11-06

---

## Problem Statement

### Current Issues

1. **❌ Hardcoded Values**
   - `ElevateColors.swift` has hardcoded RGB values
   - `ElevateSpacing.swift` has hardcoded spacing values
   - NO dark mode support in these files
   - NOT referencing ELEVATE design tokens

2. **❌ Broken Token Hierarchy**
   - Should be: Component Tokens → Alias Tokens → Primitive Tokens
   - Actually is: Hardcoded values bypassing the system

3. **❌ No Theme Switching**
   - Can't update to new ELEVATE versions by replacing CSS
   - Can't swap themes (alternative light.css / dark.css)
   - Hardcoded values in Swift code instead of dynamic tokens

4. **❌ Manual Token Management**
   - Updating ELEVATE requires manual Swift code changes
   - Error-prone and time-consuming
   - Doesn't scale

### Required Solution

**GOAL**: When ELEVATE releases new CSS files → Replace CSS → Regenerate tokens → All components automatically use new theme

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    ELEVATE Design Tokens                    │
│                     (CSS/SCSS Source)                        │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│              Token Parser & Generator                        │
│           (Python Script - Enhanced)                         │
│                                                              │
│  • Parses light.css / dark.css                              │
│  • Extracts Primitives, Aliases, Components                │
│  • Generates Swift token files                              │
│  • Caches results for build performance                     │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│              Generated Swift Token Files                     │
│                  (Auto-generated)                            │
│                                                              │
│  ├─ ElevatePrimitives.swift   (Tier 3)                     │
│  ├─ ElevateAliases.swift      (Tier 2)                     │
│  └─ *ComponentTokens.swift    (Tier 1)                     │
└────────────────┬────────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────────┐
│              SwiftUI Components                              │
│            (Reference tokens ONLY)                           │
│                                                              │
│  • NO hardcoded RGB values                                  │
│  • NO hardcoded spacing values                              │
│  • ALL values from Component Tokens                         │
│  • Automatic dark mode support                              │
└─────────────────────────────────────────────────────────────┘
```

---

## CSS Source Structure

### ELEVATE Design Tokens Repository

```
elevate-design-tokens/
├── src/
│   └── scss/
│       ├── values/
│       │   ├── _light.scss          ← Light theme tokens
│       │   └── _dark.scss           ← Dark theme tokens
│       ├── primitives/
│       │   ├── _color.scss          ← Color primitives
│       │   └── _spacing.scss        ← Spacing primitives
│       ├── aliases/
│       │   ├── _action.scss         ← Action aliases (buttons, links)
│       │   ├── _content.scss        ← Content aliases (text, icons)
│       │   ├── _surface.scss        ← Surface aliases (backgrounds)
│       │   └── _feedback.scss       ← Feedback aliases (status colors)
│       └── components/
│           ├── _button.scss         ← Button component tokens
│           ├── _input.scss          ← Input component tokens
│           └── ...
```

### Token Format (SCSS)

```scss
// Primitive (no reference)
$elvt-primitives-color-blue-600: rgb(11 92 223);

// Alias (references primitive, has light/dark)
// light.scss:
$elvt-alias-action-primary-fill-default: var(--elvt-primitives-color-blue-600, rgb(11 92 223));

// dark.scss:
$elvt-alias-action-primary-fill-default: var(--elvt-primitives-color-blue-400, rgb(56 142 255));

// Component (references alias)
$elvt-component-button-fill-primary-default: var(--elvt-alias-action-primary-fill-default, rgb(11 92 223));
```

---

## Token Generation System

### Parser Script (Enhanced)

**Location**: `scripts/generate-tokens.py`

**Features**:
1. **Multi-file parsing**
   - Parse `light.scss` and `dark.scss`
   - Parse primitive, alias, and component SCSS files
   - Extract token definitions and references

2. **Token categorization**
   - Primitives: No references, static values
   - Aliases: References primitives, has light/dark variants
   - Components: References aliases or other components

3. **Swift code generation**
   - Generate type-safe Swift enums and structs
   - Generate `Color.adaptive()` for light/dark support
   - Maintain proper token hierarchy

4. **Caching system**
   - Cache parsed tokens in `.token-cache/`
   - Compare source file timestamps
   - Regenerate only if source changed

5. **Validation**
   - Verify all references resolve correctly
   - Warn on missing references
   - Error on circular references

### Generated File Structure

```
ElevateUI/Sources/DesignTokens/
├── Generated/                      # Auto-generated, DO NOT EDIT
│   ├── .generated-timestamp        # Last generation time
│   ├── ElevatePrimitives.swift    # Tier 3: Static colors/values
│   ├── ElevateAliases.swift       # Tier 2: Semantic tokens
│   └── [Component]ComponentTokens.swift  # Tier 1: Component-specific
│
├── Components/                     # Manual wrappers (as needed)
│   ├── ButtonTokens.swift         # Wraps ButtonComponentTokens
│   ├── TextFieldTokens.swift      # Combines Input + Field tokens
│   └── ...
│
└── ThemeManager.swift              # Theme switching logic
```

---

## Theme Switching

### Theme Definition

```swift
// ThemeManager.swift
public struct ElevateTheme {
    let name: String
    let primitives: ElevatePrimitives
    let aliases: ElevateAliases
    let components: [String: Any]  // Component token sets
}

public class ThemeManager {
    public static let shared = ThemeManager()

    public private(set) var currentTheme: ElevateTheme = .default

    public func switchTheme(_ theme: ElevateTheme) {
        currentTheme = theme
        NotificationCenter.default.post(name: .themeDidChange, object: nil)
    }
}
```

### Usage in Components

```swift
// Before (WRONG - hardcoded):
.background(Color(red: 0.0431, green: 0.3608, blue: 0.8745))

// After (CORRECT - uses tokens):
.background(ButtonComponentTokens.fill_primary_default)
```

### Multiple Themes

Users can define custom themes by:
1. Creating alternative `light-custom.scss` / `dark-custom.scss`
2. Running parser: `python3 generate-tokens.py --theme custom`
3. Generated files: `CustomThemePrimitives.swift`, etc.
4. Switch: `ThemeManager.shared.switchTheme(.custom)`

---

## Build Integration

### Xcode Build Phase

Add Run Script phase **BEFORE** "Compile Sources":

```bash
#!/bin/bash
# Generate Design Tokens

SCRIPT_PATH="${SRCROOT}/scripts/generate-tokens.py"
TOKEN_SOURCE="${ELEVATE_TOKENS_PATH:-/path/to/elevate-design-tokens}"

# Check if source exists
if [ ! -d "$TOKEN_SOURCE" ]; then
    echo "warning: ELEVATE tokens source not found at $TOKEN_SOURCE"
    echo "warning: Set ELEVATE_TOKENS_PATH environment variable or download tokens"
    exit 0
fi

# Check if generator exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "error: Token generator script not found at $SCRIPT_PATH"
    exit 1
fi

# Run generator
echo "Generating design tokens from $TOKEN_SOURCE..."
python3 "$SCRIPT_PATH" --source "$TOKEN_SOURCE" --cache

if [ $? -ne 0 ]; then
    echo "error: Token generation failed"
    exit 1
fi

echo "Design tokens generated successfully"
```

### Cache Strategy

**Cache Location**: `.token-cache/`

**Cache Files**:
```
.token-cache/
├── source-checksums.json      # Source file MD5 hashes
├── parsed-tokens.json         # Parsed token data
└── last-generation.txt        # Timestamp of last generation
```

**Cache Invalidation**:
1. Source file changed (checksum mismatch)
2. Manual regeneration (`--no-cache` flag)
3. Clean build (`Clean Build Folder` in Xcode)

**Performance**:
- Cold generation: ~2-5 seconds
- Cached build: ~0.1 seconds (checksum comparison only)

---

## Migration Plan

### Phase 1: Delete Hardcoded Files

**Delete**:
- ❌ `ElevateUI/Sources/DesignTokens/Colors/ElevateColors.swift`
- ❌ `ElevateUI/Sources/DesignTokens/Spacing/ElevateSpacing.swift`

**Why**: These files contain hardcoded values that bypass the token system.

### Phase 2: Enhanced Token Generator

**Create**: `scripts/generate-tokens.py` (enhanced version)

**Features**:
- Parse SCSS properly (primitives, aliases, components)
- Extract light/dark mode variants
- Generate proper Swift code with `Color.adaptive()`
- Implement caching
- Add validation

### Phase 3: Generate Base Tokens

**Run**:
```bash
python3 scripts/generate-tokens.py \
    --source /path/to/elevate-design-tokens \
    --output ElevateUI/Sources/DesignTokens/Generated \
    --cache
```

**Generated files**:
- `ElevatePrimitives.swift` - All primitive colors and spacing
- `ElevateAliases.swift` - All semantic aliases
- `*ComponentTokens.swift` - All component tokens

### Phase 4: Component Audit & Refactor

**Search for hardcoded values**:
```bash
# Find hardcoded colors
grep -r "Color(red:" ElevateUI/Sources/SwiftUI/Components/

# Find hardcoded spacing
grep -r "CGFloat = [0-9]" ElevateUI/Sources/DesignTokens/Components/

# Find Color.white, Color.black, etc.
grep -r "Color\.\(white\|black\|red\|blue\|green\)" ElevateUI/Sources/
```

**Refactor each component**:
1. Replace hardcoded colors → Component Tokens
2. Replace hardcoded spacing → Spacing tokens (from primitives)
3. Verify dark mode works
4. Test thoroughly

### Phase 5: Build Integration

**Add Xcode build phase** (see above)

**Verify**:
1. Clean build works
2. Incremental build uses cache
3. Changing CSS triggers regeneration

### Phase 6: Documentation

**Update**:
- `.claude/THEME-ARCHITECTURE.md` (this file)
- `.claude/concepts/design-token-hierarchy.md`
- `.claude/iOS-IMPLEMENTATION-GUIDE.md`

**Create**:
- `.claude/THEME-SWITCHING-GUIDE.md` - How to create custom themes

---

## Token API Examples

### Primitive Tokens (Generated)

```swift
// ElevatePrimitives.swift (AUTO-GENERATED)
public struct ElevatePrimitives {
    // Colors
    public enum Blue {
        public static let _400 = Color(red: 0.22, green: 0.56, blue: 1.0)  // rgb(56 142 255)
        public static let _600 = Color(red: 0.04, green: 0.36, blue: 0.87) // rgb(11 92 223)
    }

    public enum Gray {
        public static let _50 = Color(red: 0.97, green: 0.98, blue: 0.98)  // rgb(248 249 250)
        public static let _950 = Color(red: 0.04, green: 0.04, blue: 0.06) // rgb(9 11 15)
    }

    // Spacing
    public enum Spacing {
        public static let _0_5 = CGFloat(8)   // 0.5rem = 8pt
        public static let _0_75 = CGFloat(12) // 0.75rem = 12pt
        public static let _1 = CGFloat(16)    // 1rem = 16pt
    }
}
```

### Alias Tokens (Generated)

```swift
// ElevateAliases.swift (AUTO-GENERATED)
public struct ElevateAliases {
    public struct Action {
        public struct Primary {
            // Adaptive color: Blue._600 in light, Blue._400 in dark
            public static let fill_default = Color.adaptive(
                light: ElevatePrimitives.Blue._600,
                dark: ElevatePrimitives.Blue._400
            )

            public static let text_default = Color.adaptive(
                light: ElevatePrimitives.White._color_white,
                dark: ElevatePrimitives.White._color_white
            )
        }
    }

    public struct Content {
        public struct General {
            public static let text_default = Color.adaptive(
                light: ElevatePrimitives.Gray._950,
                dark: ElevatePrimitives.Gray._50
            )
        }
    }
}
```

### Component Tokens (Generated)

```swift
// ButtonComponentTokens.swift (AUTO-GENERATED)
public struct ButtonComponentTokens {
    // References Alias tokens
    public static let fill_primary_default =
        ElevateAliases.Action.Primary.fill_default

    public static let label_primary_default =
        ElevateAliases.Action.Primary.text_default

    // Spacing references primitives
    public static let padding_horizontal_medium =
        ElevatePrimitives.Spacing._0_75  // 12pt

    public static let gap_medium =
        ElevatePrimitives.Spacing._0_5   // 8pt
}
```

### Component Usage

```swift
// ButtonTokens.swift (Manual wrapper - provides size configs)
public struct ButtonTokens {
    public struct SizeConfig {
        let horizontalPadding: CGFloat
        let gap: CGFloat

        static let medium = SizeConfig(
            // References component tokens (which reference primitives)
            horizontalPadding: ButtonComponentTokens.padding_horizontal_medium,
            gap: ButtonComponentTokens.gap_medium
        )
    }

    public struct ToneColors {
        let background: Color
        let text: Color

        static let primary = ToneColors(
            // References component tokens (which reference aliases)
            background: ButtonComponentTokens.fill_primary_default,
            text: ButtonComponentTokens.label_primary_default
        )
    }
}
```

### SwiftUI Component

```swift
// ElevateButton+SwiftUI.swift
public struct ElevateButton: View {
    private var backgroundColor: Color {
        if isDisabled {
            return ButtonComponentTokens.fill_primary_disabled_default
        } else if isPressed {
            return ButtonComponentTokens.fill_primary_active
        } else {
            return ButtonComponentTokens.fill_primary_default
        }
        // ✅ NO hardcoded values!
        // ✅ Automatic dark mode!
        // ✅ References token hierarchy correctly!
    }

    private var sizeConfig: ButtonTokens.SizeConfig {
        size.config  // References ComponentTokens → Primitives
    }
}
```

---

## Color.adaptive() Implementation

### Extension

```swift
// Generated automatically in token files
extension Color {
    /// Creates a color that adapts to light/dark mode
    static func adaptive(light: Color, dark: Color) -> Color {
        return Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
    }
}
```

### Usage

```swift
// Automatically generated in Alias tokens:
public static let text_default = Color.adaptive(
    light: ElevatePrimitives.Gray._950,  // Dark text in light mode
    dark: ElevatePrimitives.Gray._50     // Light text in dark mode
)

// Component just uses it - dark mode is automatic!
Text("Hello")
    .foregroundColor(ElevateAliases.Content.General.text_default)
```

---

## Validation & Testing

### Token Validation

**Parser validates**:
1. All references resolve (no broken links)
2. No circular references
3. All primitives used by aliases exist
4. All aliases used by components exist

### Build-Time Checks

**Xcode build fails if**:
1. Token source files missing
2. Parse errors in SCSS
3. Unresolved references
4. Cache corruption

### Runtime Testing

**Component tests verify**:
1. Colors change in dark mode
2. No hardcoded values used
3. All states reference correct tokens
4. Spacing uses token values

### Manual Testing Checklist

- [ ] Switch to dark mode → colors change correctly
- [ ] All text is readable (proper contrast)
- [ ] All interactive elements have proper states
- [ ] No hardcoded colors visible
- [ ] Spacing is consistent across components

---

## Developer Workflow

### Updating to New ELEVATE Version

```bash
# 1. Get new ELEVATE design tokens
cd /path/to/elevate-design-tokens
git pull

# 2. Regenerate Swift tokens
cd /path/to/elevate-ios
python3 scripts/generate-tokens.py --no-cache

# 3. Rebuild project
xcodebuild clean build

# 4. Test
# All components automatically use new theme!
```

### Creating Custom Theme

```bash
# 1. Create custom SCSS files
cp elevate-design-tokens/values/_light.scss my-theme/light.scss
cp elevate-design-tokens/values/_dark.scss my-theme/dark.scss

# 2. Edit theme colors/spacing
# Edit my-theme/light.scss and dark.scss

# 3. Generate theme tokens
python3 scripts/generate-tokens.py \
    --source my-theme \
    --theme-name MyCustomTheme \
    --output ElevateUI/Sources/DesignTokens/Themes/MyCustomTheme

# 4. Use custom theme
ThemeManager.shared.switchTheme(.myCustomTheme)
```

### Manual Token Regeneration

```bash
# Force regeneration (ignore cache)
python3 scripts/generate-tokens.py --no-cache

# Regenerate specific category
python3 scripts/generate-tokens.py --only primitives
python3 scripts/generate-tokens.py --only aliases
python3 scripts/generate-tokens.py --only components

# Verbose output for debugging
python3 scripts/generate-tokens.py --verbose
```

---

## Anti-Patterns to Avoid

### ❌ DON'T: Hardcode Colors

```swift
// ❌ WRONG
.background(Color(red: 0.04, green: 0.36, blue: 0.87))
.background(Color.white)
.background(Color.blue)
```

### ✅ DO: Use Component Tokens

```swift
// ✅ CORRECT
.background(ButtonComponentTokens.fill_primary_default)
.background(ElevateAliases.Surface.General.bg_canvas)
```

### ❌ DON'T: Hardcode Spacing

```swift
// ❌ WRONG
.padding(12)
.frame(height: 44)
```

### ✅ DO: Use Token Spacing

```swift
// ✅ CORRECT
.padding(ButtonComponentTokens.padding_horizontal_medium)
.frame(height: ButtonComponentTokens.height_medium)
```

### ❌ DON'T: Create Manual Color Files

```swift
// ❌ WRONG - ElevateColors.swift with hardcoded values
public static let primary = Color(red: 0.04, green: 0.36, blue: 0.87)
```

### ✅ DO: Generate from SCSS

```swift
// ✅ CORRECT - Auto-generated from SCSS
// File: ElevatePrimitives.swift (AUTO-GENERATED)
public static let _600 = Color(red: 0.04, green: 0.36, blue: 0.87)

// File: ElevateAliases.swift (AUTO-GENERATED)
public static let fill_default = Color.adaptive(
    light: ElevatePrimitives.Blue._600,
    dark: ElevatePrimitives.Blue._400
)
```

---

## Future Enhancements

### Phase 7: Real-Time Theme Switching

**Goal**: Switch themes without app restart

**Implementation**:
1. Load multiple theme sets at launch
2. `@ObservableObject` theme manager
3. SwiftUI views react to theme changes
4. Smooth transition animation

### Phase 8: User-Customizable Themes

**Goal**: Let users customize colors

**Implementation**:
1. UI for color picker
2. Override specific tokens
3. Save custom theme to UserDefaults
4. Preview before applying

### Phase 9: Design Token Studio Integration

**Goal**: Visual token editor

**Implementation**:
1. Integrate with Figma tokens plugin
2. Export from Figma → JSON
3. JSON → SCSS converter
4. Auto-regenerate Swift tokens

---

## Success Criteria

### ✅ Project is successful when:

1. **Zero hardcoded values** in component code
2. **Automatic dark mode** for all components
3. **Update ELEVATE** → Replace CSS → Regenerate → Done
4. **Theme switching** works without code changes
5. **Build performance** - cached generation < 1 second
6. **Developer experience** - tokens are easy to find and use
7. **Type safety** - All tokens are type-safe Swift enums/structs

---

## Questions & Answers

**Q: What happens to existing hardcoded files?**
A: Delete `ElevateColors.swift` and `ElevateSpacing.swift`. They're replaced by auto-generated files.

**Q: Can I still have custom wrapper files?**
A: Yes! Keep files like `ButtonTokens.swift` that add size configs and convenience methods. Just make sure they reference generated tokens, not hardcoded values.

**Q: How do I know which token to use?**
A: Follow hierarchy: Component Tokens → Alias Tokens → Primitives. Generated code makes this clear with proper Swift types.

**Q: What if ELEVATE doesn't have a token I need?**
A: File an issue with ELEVATE design system. Temporarily, create a custom alias token that references primitives.

**Q: How often should tokens be regenerated?**
A: Automatically on every clean build. Manually when updating ELEVATE or creating custom themes.

---

## Related Documentation

- `.claude/concepts/design-token-hierarchy.md` - Token tier system
- `.claude/iOS-IMPLEMENTATION-GUIDE.md` - Overall iOS implementation guide
- `scripts/generate-tokens.py` - Token generator script (to be created)
- `ElevateUI/Sources/DesignTokens/Generated/README.md` - Auto-generated files README

---

**This is a living document. Update as the architecture evolves.**
