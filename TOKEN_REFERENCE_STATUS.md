# Token Reference Status

## Overview

This document tracks the status of token references in the ELEVATE iOS package, distinguishing between **proper token references** and **resolved hardcoded values**.

## ✅ Fixed: Spacing & Sizing References

All component tokens now properly reference global spacing tokens from `ElevateSpacing.swift`:

### ButtonTokens
- ✅ Uses `ElevateSpacing.ComponentSize` for heights and padding
- ✅ Uses `ElevateSpacing.BorderRadius` for corner radius
- ✅ No duplication of sizing structs

**Before (Hardcoded):**
```swift
public struct ComponentSize {
    static let small = ComponentSize(height: 32.0, paddingInline: 12.0)
}

public var borderRadius: CGFloat {
    return 4.0  // Hardcoded!
}
```

**After (Token References):**
```swift
public var componentSize: ElevateSpacing.ComponentSize {
    return .small  // References global token
}

public var borderRadius: CGFloat {
    return ElevateSpacing.BorderRadius.small  // References global token
}
```

### BadgeTokens
- ✅ Uses `ElevateSpacing.s`, `.xs`, `.xxs` for padding
- ✅ Uses `ElevateSpacing.IconSize.small` for icon sizing
- ✅ Uses `ElevateSpacing.BorderRadius.small` for corner radius

### ChipTokens
- ✅ Uses `ElevateSpacing.s`, `.m`, `.l` for padding and gaps
- ✅ Uses `ElevateSpacing.IconSize` for icon and remove button sizing
- ✅ Uses `ElevateSpacing.BorderRadius.small` for corner radius
- ✅ Uses `ElevateSpacing.BorderWidth.thin` for border width

## ⚠️ Known Limitation: Color References

**Issue:** Component token colors currently use **resolved RGB values** instead of referencing primitive or alias tokens.

### Current Implementation (Resolved Values)

```swift
static let primary = ToneColors(
    background: Color(red: 0.0431, green: 0.3608, blue: 0.8745),  // ❌ Hardcoded RGB
    text: Color(red: 1.0000, green: 1.0000, blue: 1.0000),        // ❌ Hardcoded RGB
    // ...
)
```

### Ideal Implementation (Token References)

```swift
static let primary = ToneColors(
    background: ElevatePrimitives.Blue._600,     // ✅ References primitive token
    text: ElevatePrimitives.White._color_white,  // ✅ References primitive token
    // ...
)
```

Or even better, referencing alias tokens:

```swift
static let primary = ToneColors(
    background: ElevateAliases.Action.StrongPrimary.fill_default,  // ✅ References alias
    text: ElevateAliases.Action.StrongPrimary.text_default,        // ✅ References alias
    // ...
)
```

## Why This Limitation Exists

The current token extraction script (`scripts/update-design-tokens-v2.py`) resolves all color values to their final RGB values during extraction from SCSS. This was documented in `DESIGN_TOKEN_HIERARCHY.md` under **Phase 4: True Swift References**.

### Root Cause

The SCSS source uses CSS variables with fallback values:

```scss
$elvt-component-button-fill-primary-default:
    var(--elvt-alias-action-strong-primary-fill-default, rgb(11 92 223));
```

The extraction script currently parses the **fallback value** (RGB) rather than maintaining the **reference** (to alias token).

## Impact

### What Works ✅
- **Semantic naming** is preserved (e.g., `primary.background`, not `blue600`)
- **Visual consistency** is maintained (colors match ELEVATE design system)
- **Token hierarchy structure** exists conceptually
- **Easy updates** via re-running extraction script

### What's Limited ⚠️
- **No explicit reference chain** in Swift code (resolved RGB, not `ElevatePrimitives.Blue._600`)
- **Theme switching difficulty** - Would need to regenerate tokens, not just swap primitives
- **Dark mode** would require separate extraction and conditional logic

## Future Enhancement: Phase 4 Implementation

To implement true Swift token references:

### 1. Update Extraction Script

Modify `scripts/update-design-tokens-v2.py` to:
- Parse the reference part of `var(--reference, fallback)`
- Map SCSS token names to Swift token paths
- Generate Swift code with actual property references

### 2. Example Output

```python
# In TokenExtractor
def resolve_reference(self, scss_reference: str) -> str:
    """Convert SCSS token reference to Swift token path"""
    # elvt-primitives-color-blue-600 → ElevatePrimitives.Blue._600
    # elvt-alias-action-strong-primary-fill → ElevateAliases.Action.StrongPrimary.fill_default
    pass
```

Generated Swift:
```swift
static let primary = ToneColors(
    background: ElevatePrimitives.Blue._600,  // True reference
    backgroundHover: ElevatePrimitives.Blue._700,
    text: ElevatePrimitives.White._color_white,
    // ...
)
```

### 3. Benefits of Implementation

- **Explicit reference chain** visible in code
- **Easier theme switching** (swap primitive values)
- **Better IDE navigation** (click-through to source tokens)
- **Compile-time validation** of token relationships

## Current Token Counts

| Tier | Count | Reference Type |
|------|-------|----------------|
| **Primitives** | 131 | ✅ Raw values (base layer) |
| **Aliases** | 303 | ⚠️ Resolved RGB (should reference primitives) |
| **Components** | 1,406 | ⚠️ Resolved RGB (should reference aliases) |

## Spacing Token Counts

| Category | References |
|----------|-----------|
| **Button Sizes** | ✅ References `ElevateSpacing.ComponentSize` |
| **Badge Sizes** | ✅ References `ElevateSpacing` padding/gaps |
| **Chip Sizes** | ✅ References `ElevateSpacing` padding/gaps/icons |
| **Border Radius** | ✅ References `ElevateSpacing.BorderRadius` |
| **Border Width** | ✅ References `ElevateSpacing.BorderWidth` |
| **Icon Sizes** | ✅ References `ElevateSpacing.IconSize` |

## Verification

```bash
# Verify proper spacing references (should find no hardcoded spacing values)
grep -r "paddingInline: [0-9]" ElevateUI/Sources/DesignTokens/Components/
# Expected: No results (all reference ElevateSpacing)

# Verify hardcoded color values still exist (known limitation)
grep -r "Color(red:" ElevateUI/Sources/DesignTokens/Components/ | wc -l
# Expected: Many results (will be fixed in Phase 4)
```

## Recommendation

**Current state is acceptable for:**
- ✅ Production use with single theme (light mode)
- ✅ Maintaining design consistency
- ✅ Easy token updates via extraction script

**Phase 4 implementation needed for:**
- ⚠️ Multi-theme support (dark mode, brand themes)
- ⚠️ Dynamic theme switching at runtime
- ⚠️ Full token reference transparency

## Summary

**Spacing/Sizing:** ✅ **FIXED** - All components reference global tokens
**Colors:** ⚠️ **LIMITATION** - Using resolved RGB values (Phase 4 future work)

The iOS package now properly follows token hierarchy for sizing and spacing, eliminating duplication and hardcoded values. Color token references remain a documented limitation for future enhancement.
