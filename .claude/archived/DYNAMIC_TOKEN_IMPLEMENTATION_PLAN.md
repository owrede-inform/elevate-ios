# Dynamic Token Implementation Plan

## Problem Statement

The current implementation uses **resolved RGB values** instead of **token references**, which:
- ❌ Loses light/dark mode information (ELEVATE has both in alias tokens!)
- ❌ Will require massive refactoring when dark mode is needed
- ❌ Breaks the proper three-tier token hierarchy

## Solution Architecture

### Three-Tier System with DynamicColor

```
┌─────────────────────────────────────────────────────┐
│  PRIMITIVES (Base Values - DynamicColor)            │
│  Blue._600 = DynamicColor(                          │
│    lightRGB: (0.043, 0.361, 0.875),                 │
│    darkRGB: (0.043, 0.361, 0.875)                   │
│  )                                                   │
└─────────────────────────────────────────────────────┘
                    ↓ REFERENCES
┌─────────────────────────────────────────────────────┐
│  ALIASES (Semantic - DynamicColor References)       │
│  Action.StrongPrimary.fill_default = DynamicColor(  │
│    light: ElevatePrimitives.Blue._600,              │
│    dark: ElevatePrimitives.Blue._500                │
│  )                                                   │
└─────────────────────────────────────────────────────┘
                    ↓ REFERENCES
┌─────────────────────────────────────────────────────┐
│  COMPONENTS (Component-Specific - Alias References) │
│  ButtonTokens.primary.background =                  │
│    ElevateAliases.Action.StrongPrimary.fill_default │
└─────────────────────────────────────────────────────┘
```

## Implementation Steps

### Step 1: DynamicColor System ✅ DONE

Created `ElevateUI/Sources/DesignTokens/Core/DynamicColor.swift`:
```swift
public struct DynamicColor {
    let lightColor: Color
    let darkColor: Color

    func resolve(in colorScheme: ColorScheme) -> Color
}
```

### Step 2: Extraction Script v3 ✅ IN PROGRESS

Created `scripts/update-design-tokens-v3.py`:
- ✅ Parses BOTH _light.scss and _dark.scss
- ✅ Extracts token REFERENCES (not just RGB fallbacks)
- ✅ Maps SCSS names to Swift paths
- 🔄 TODO: Generate complete Primitives.swift
- 🔄 TODO: Generate complete Aliases.swift
- 🔄 TODO: Generate ButtonTokens.swift, BadgeTokens.swift, ChipTokens.swift

### Step 3: Regenerate Token Files

#### 3a. ElevatePrimitives.swift

**Current Structure (Wrong):**
```swift
public enum Blue {
    public static let _600 = Color(red: 0.0431, green: 0.3608, blue: 0.8745)
}
```

**New Structure (Correct):**
```swift
public enum Blue {
    public static let _600 = DynamicColor(
        lightRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0),
        darkRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0)
    )
}
```

#### 3b. ElevateAliases.swift

**Current Structure (Wrong):**
```swift
public static let fill_default = Color(red: 0.0431, green: 0.3608, blue: 0.8745)
```

**New Structure (Correct):**
```swift
public static let fill_default = DynamicColor(
    light: ElevatePrimitives.Blue._600,
    dark: ElevatePrimitives.Blue._500
)
```

#### 3c. ButtonTokens.swift (and Badge, Chip)

**Current Structure (Wrong):**
```swift
static let primary = ToneColors(
    background: Color(red: 0.0431, green: 0.3608, blue: 0.8745),  // Hardcoded
    // ...
)
```

**New Structure (Correct - Option A: Direct Reference):**
```swift
static let primary = ToneColors(
    background: ElevateAliases.Action.StrongPrimary.fill_default,  // References alias
    backgroundHover: ElevateAliases.Action.StrongPrimary.fill_hover,
    // ...
)
```

**Or Option B: Component Token Layer:**
```swift
// Component tokens extracted from SCSS
public static let fill_primary_default = ElevateAliases.Action.StrongPrimary.fill_default

static let primary = ToneColors(
    background: ButtonComponentTokens.fill_primary_default,
    // ...
)
```

### Step 4: Update Component Usage

Components need to resolve DynamicColor based on environment:

```swift
public struct ElevateButton<Prefix: View, Suffix: View>: View {
    @Environment(\.colorScheme) var colorScheme

    private var tokenBackgroundColor: Color {
        toneColors.background.resolve(in: colorScheme)  // Resolve DynamicColor
    }

    public var body: some View {
        Button(action: action) {
            // ...
        }
        .background(tokenBackgroundColor)
    }
}
```

### Step 5: Update ToneColors Structure

**Current:**
```swift
public struct ToneColors {
    let background: Color  // ❌ Static Color
}
```

**New:**
```swift
public struct ToneColors {
    let background: DynamicColor  // ✅ Dynamic Color
}
```

## Migration Strategy

### Phase 1: Generate New Token Files (DON'T REPLACE YET)
1. Run v3 extraction script
2. Generate to NEW directory: `DesignTokens/Generated/`
3. Verify structure and references
4. Test compilation in isolation

### Phase 2: Create Compatibility Layer
1. Keep old Color-based tokens temporarily
2. Add DynamicColor-based tokens alongside
3. Components can opt-in gradually

### Phase 3: Switch Components
1. Update Button component to use DynamicColor
2. Test light/dark mode switching
3. Update Badge and Chip components
4. Verify all visual states

### Phase 4: Remove Old Tokens
1. Once all components migrated
2. Delete old Color-based token files
3. Remove compatibility layer

## File Changes Required

### New Files:
- ✅ `DesignTokens/Core/DynamicColor.swift`
- ✅ `scripts/update-design-tokens-v3.py`
- 🔄 `DesignTokens/Generated/ElevatePrimitives.swift` (new version)
- 🔄 `DesignTokens/Generated/ElevateAliases.swift` (new version)
- 🔄 `DesignTokens/Components/ButtonTokens.swift` (updated)
- 🔄 `DesignTokens/Components/BadgeTokens.swift` (updated)
- 🔄 `DesignTokens/Components/ChipTokens.swift` (updated)

### Modified Files:
- 🔄 `SwiftUI/Components/ElevateButton+SwiftUI.swift`
- 🔄 `SwiftUI/Components/ElevateBadge+SwiftUI.swift`
- 🔄 `SwiftUI/Components/ElevateChip+SwiftUI.swift`
- 🔄 `UIKit/Components/ElevateButton+UIKit.swift`
- 🔄 `UIKit/Components/ElevateBadge+UIKit.swift`
- 🔄 `UIKit/Components/ElevateChip+UIKit.swift`

## Testing Plan

### 1. Token Reference Verification
```bash
# Verify no hardcoded RGB in components
grep -r "Color(red:" ElevateUI/Sources/DesignTokens/Components/
# Should return ZERO results

# Verify proper token references
grep -r "ElevatePrimitives\|ElevateAliases" ElevateUI/Sources/DesignTokens/Components/
# Should find many references
```

### 2. Build Verification
```bash
swift build
# Must compile without errors
```

### 3. Visual Testing
- Create demo app
- Toggle between light and dark mode
- Verify all component tones display correctly
- Check disabled, selected, hover states

## Timeline Estimate

- ✅ **Step 1-2 (DynamicColor + Script):** 1 hour (DONE)
- ⏱️ **Step 3 (Generate Tokens):** 2 hours
- ⏱️ **Step 4-5 (Update Components):** 2 hours
- ⏱️ **Testing & Verification:** 1 hour

**Total:** ~6 hours for complete implementation

## Success Criteria

✅ All primitive colors use DynamicColor with light/dark values
✅ All alias tokens REFERENCE primitives (not RGB)
✅ All component tokens REFERENCE aliases (not RGB)
✅ Components resolve colors based on @Environment(\.colorScheme)
✅ Build completes without errors
✅ Light mode displays correctly
✅ Dark mode displays correctly
✅ All component states work in both modes

## Risk Assessment

**LOW RISK:**
- Primitives generation (straightforward RGB → DynamicColor)
- DynamicColor system (well-tested pattern)

**MEDIUM RISK:**
- Alias token reference mapping (complex SCSS parsing)
- Component token structure changes (affects all components)

**HIGH RISK:**
- Breaking existing components during migration
- Missing edge cases in reference resolution

**Mitigation:**
- Generate to separate directory first
- Keep old files until migration complete
- Comprehensive testing before replacing

## Current Status

- ✅ DynamicColor system created
- ✅ Extraction script v3 created and tested
- ✅ Token reference parsing working
- 🔄 **NEXT:** Complete script to generate full Primitives.swift
- ⏸️ Then: Generate Aliases.swift
- ⏸️ Then: Update Component tokens
- ⏸️ Finally: Update all components to use DynamicColor

---

**Last Updated:** 2025-11-04
**Status:** IN PROGRESS - Script framework complete, generation code needed
