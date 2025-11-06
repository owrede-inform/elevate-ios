# Component Hardcoded Values Audit Report

**Date**: 2025-11-06
**Status**: Complete
**Auditor**: Claude Code

---

## Executive Summary

This audit identified hardcoded values in SwiftUI components that should be replaced with ELEVATE design tokens. The primary issues are:

1. **ElevateSpacing references** - Extensively used but file doesn't exist
2. **Hardcoded numeric values** - Colors, spacing, dimensions in component files
3. **Missing token mappings** - Some ELEVATE tokens not being utilized

---

## Critical Issues

### Issue 1: ElevateSpacing File Missing

**Severity**: 🔴 HIGH
**Status**: Build succeeds (likely cached), but source missing

**Problem**:
- ElevateSpacing is referenced in 7 files:
  - `ElevateButton+SwiftUI.swift:160`
  - `ElevateTextField+SwiftUI.swift`
  - `ButtonTokens.swift:38,55,56`
  - `ChipTokens.swift:55,174-202`
  - `BadgeTokens.swift:54,127-142`
  - `ElevateIcon.swift`

**Example Usage**:
```swift
// ButtonTokens.swift:38
public var componentSize: ElevateSpacing.ComponentSize {
    switch self {
    case .small: return .small
    case .medium: return .medium
    case .large: return .large
    }
}

// ButtonTokens.swift:55-56
case .default: return ElevateSpacing.BorderRadius.small
case .pill: return ElevateSpacing.BorderRadius.full

// BadgeTokens.swift:127-132
horizontalPadding: ElevateSpacing.s,
verticalPadding: ElevateSpacing.xs,
iconSize: ElevateSpacing.IconSize.small.value,
gap: ElevateSpacing.xs
```

**File Location**: `ElevateUI/Sources/DesignTokens/Spacing/` (directory exists but empty)

**Solution**:
1. **Option A**: Recreate `ElevateSpacing.swift` with proper token extraction
2. **Option B**: Replace all `ElevateSpacing.*` references with equivalent `ButtonComponentTokens.*`, `ChipComponentTokens.*`, etc.

**Recommended**: Option B - Use extracted component tokens directly

---

## Hardcoded Values by File

### 1. ElevateMenu+SwiftUI.swift

**Location**: Line 82
**Type**: Color
**Issue**: Hardcoded shadow color

```swift
// ❌ CURRENT (Hardcoded)
.shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4)

// ✅ SUGGESTED (Use token or alias)
// Note: ELEVATE may not have shadow tokens, use Alias if no component token exists
.shadow(
    color: ElevateAliases.Layout.Shadow.default_color ?? Color.black.opacity(0.1),
    radius: 8,  // Could extract to MenuComponentTokens if ELEVATE defines it
    x: 0,
    y: 4
)
```

**Priority**: Medium (shadows may not be in ELEVATE token spec)

---

### 2. ElevateButton+SwiftUI.swift

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
    // Check if ButtonComponentTokens has gap_s, gap_m, gap_l
    switch size {
    case .small: return ButtonComponentTokens.gap_s
    case .medium: return ButtonComponentTokens.gap_m
    case .large: return ButtonComponentTokens.gap_l
    }
}
```

**Action Required**: Verify `ButtonComponentTokens` includes `gap_s`, `gap_m`, `gap_l`

**Priority**: High

---

**Location**: Line 160
**Type**: Border width
**Issue**: References missing `ElevateSpacing.BorderWidth.thin`

```swift
// ❌ CURRENT (Missing reference)
private var tokenBorderWidth: CGFloat {
    ElevateSpacing.BorderWidth.thin
}

// ✅ SUGGESTED (Use component token)
private var tokenBorderWidth: CGFloat {
    ButtonComponentTokens.border_width ?? 1.0  // Fallback if not extracted
}
```

**Priority**: High

---

### 3. BadgeTokens.swift

**Location**: Line 56
**Type**: Border radius
**Issue**: Hardcoded pill corner radius

```swift
// ❌ CURRENT (Hardcoded)
case .pill:
    return rank == .major ? 12.0 : 9.0  // Half of height

// ✅ SUGGESTED (Calculate from height or use token)
case .pill:
    return rank == .major
        ? BadgeComponentTokens.border_radius_pill_major  // If extracted
        : BadgeComponentTokens.border_radius_pill_minor
```

**Priority**: Medium

---

**Location**: Lines 125-143
**Type**: Multiple (height, padding, font size, icon size)
**Issue**: Mixed hardcoded and `ElevateSpacing` references

```swift
// ❌ CURRENT (Mixed hardcoded and missing references)
static let major = RankConfig(
    height: 24.0,  // Hardcoded
    horizontalPadding: ElevateSpacing.s,  // Missing file
    verticalPadding: ElevateSpacing.xs,  // Missing file
    fontSize: 14.0,  // Hardcoded
    fontWeight: .semibold,
    iconSize: ElevateSpacing.IconSize.small.value,  // Missing file
    gap: ElevateSpacing.xs  // Missing file
)

static let minor = RankConfig(
    height: 18.0,  // Hardcoded
    horizontalPadding: 6.0,  // Hardcoded
    verticalPadding: ElevateSpacing.xxs,  // Missing file
    fontSize: 12.0,  // Hardcoded
    fontWeight: .medium,
    iconSize: 12.0,  // Hardcoded
    gap: ElevateSpacing.xxs  // Missing file
)

// ✅ SUGGESTED (Use BadgeComponentTokens)
static let major = RankConfig(
    height: BadgeComponentTokens.height_major,
    horizontalPadding: BadgeComponentTokens.padding_inline_major,
    verticalPadding: BadgeComponentTokens.padding_block_major,
    fontSize: 14.0,  // Typography - may stay hardcoded
    fontWeight: .semibold,
    iconSize: BadgeComponentTokens.icon_size_major,
    gap: BadgeComponentTokens.gap_major
)

static let minor = RankConfig(
    height: BadgeComponentTokens.height_minor,
    horizontalPadding: BadgeComponentTokens.padding_inline_minor,
    verticalPadding: BadgeComponentTokens.padding_block_minor,
    fontSize: 12.0,  // Typography - may stay hardcoded
    fontWeight: .medium,
    iconSize: BadgeComponentTokens.icon_size_minor,
    gap: BadgeComponentTokens.gap_minor
)
```

**Action Required**: Verify `BadgeComponentTokens` includes all necessary dimension tokens

**Priority**: High

---

### 4. ButtonTokens.swift

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
border: ButtonComponentTokens.border_primary_color_default ?? Color.clear,
borderSelected: ButtonComponentTokens.border_primary_color_selected ?? Color.clear
```

**Action Required**: Verify with ELEVATE SCSS if border tokens exist for primary, success, warning, danger, subtle tones

**Priority**: Medium (design decision vs missing extraction)

---

### 5. ChipTokens.swift

**Location**: Lines 174-202
**Type**: Multiple (padding, icon size, gap)
**Issue**: References missing `ElevateSpacing`

```swift
// ❌ CURRENT (Missing references)
static let small = SizeConfig(
    height: 24.0,
    horizontalPadding: ElevateSpacing.s,  // Missing
    verticalPadding: ElevateSpacing.xs,  // Missing
    fontSize: 12.0,
    fontWeight: .medium,
    iconSize: ElevateSpacing.IconSize.small.value,  // Missing
    gap: ElevateSpacing.xs,  // Missing
    removeButtonSize: ElevateSpacing.IconSize.small.value  // Missing
)

// ✅ SUGGESTED (Use ChipComponentTokens)
static let small = SizeConfig(
    height: ChipComponentTokens.height_s,
    horizontalPadding: ChipComponentTokens.padding_inline_s,
    verticalPadding: ChipComponentTokens.padding_block_s,
    fontSize: 12.0,  // Typography
    fontWeight: .medium,
    iconSize: ChipComponentTokens.icon_size_s,
    gap: ChipComponentTokens.gap_s,
    removeButtonSize: ChipComponentTokens.remove_button_size_s
)
```

**Action Required**: Verify `ChipComponentTokens` includes all size variants (s, m, l)

**Priority**: High

---

**Location**: Line 209
**Type**: Border width
**Issue**: References missing `ElevateSpacing.BorderWidth.thin`

```swift
// ❌ CURRENT (Missing reference)
return ElevateSpacing.BorderWidth.thin

// ✅ SUGGESTED (Use component token)
return ChipComponentTokens.border_width ?? 1.0
```

**Priority**: High

---

### 6. Preview/Example Code

**Location**: Multiple preview sections
**Type**: Padding, frame, cornerRadius
**Issue**: Hardcoded values in preview code (acceptable for demos)

```swift
// Examples in previews (lines 160, 192, 230, 274, etc.)
.padding()  // Default SwiftUI padding - OK for previews
.frame(width: 250)  // Fixed preview sizes - OK for demos
.cornerRadius(8)  // Preview styling - OK for demos
```

**Priority**: Low (previews can use hardcoded values)

---

## Typography Tokens

### ElevateTypography.swift

**Status**: ✅ ACCEPTABLE (Typography tokens, not design tokens)
**Location**: Lines 84-163

Typography tokens use hardcoded font sizes, but this is expected:
- Display: 57, 45, 36
- Heading: 32, 28, 24, 20
- Title: 22, 16, 14
- Body: 16, 14, 12
- Label: 16, 14, 12, 11

**Justification**: Typography scales are typically defined as fixed point sizes, not extracted from SCSS. Unless ELEVATE defines typography tokens in SCSS, these can remain as-is.

**Action**: Verify if ELEVATE SCSS includes typography token definitions

**Priority**: Low

---

## Summary of Required Actions

### Immediate (High Priority)

1. **Resolve ElevateSpacing references** (7 files affected)
   - [ ] Option A: Recreate ElevateSpacing.swift with extracted tokens
   - [ ] Option B: Replace all references with component tokens (RECOMMENDED)

2. **Fix Button gap values** (ElevateButton+SwiftUI.swift:189-192)
   - [ ] Verify ButtonComponentTokens has gap_s, gap_m, gap_l
   - [ ] Replace hardcoded 4.0, 6.0, 8.0

3. **Fix Badge hardcoded values** (BadgeTokens.swift:125-143)
   - [ ] Replace hardcoded heights, padding, icon sizes
   - [ ] Verify BadgeComponentTokens extraction

4. **Fix Chip spacing references** (ChipTokens.swift:174-202)
   - [ ] Verify ChipComponentTokens has all size variants
   - [ ] Replace ElevateSpacing references

### Medium Priority

5. **Fix Menu shadow color** (ElevateMenu+SwiftUI.swift:82)
   - [ ] Check if ELEVATE defines shadow tokens
   - [ ] Use alias token or keep hardcoded with comment

6. **Fix Badge pill corner radius** (BadgeTokens.swift:56)
   - [ ] Extract from ELEVATE or calculate from height

7. **Verify border token extraction** (ButtonTokens.swift)
   - [ ] Check ELEVATE SCSS for border tokens on all tones
   - [ ] Update extraction script if missing

### Low Priority

8. **Typography token extraction** (ElevateTypography.swift)
   - [ ] Verify if ELEVATE SCSS has typography tokens
   - [ ] Extract if available (not urgent)

---

## Verification Checklist

After refactoring, verify:

- [ ] Build succeeds without warnings
- [ ] All components render correctly in light mode
- [ ] All components render correctly in dark mode
- [ ] No `ElevateSpacing` references remain (if Option B chosen)
- [ ] All numeric literals justified with comments
- [ ] Component tokens used wherever available
- [ ] Alias tokens used only when no component token exists

---

## Token Extraction Gaps

Check if the following tokens exist in ELEVATE SCSS but weren't extracted:

### ButtonComponentTokens
- [ ] `gap_s`, `gap_m`, `gap_l` (currently hardcoded in Button component)
- [ ] `border_width` (currently references missing ElevateSpacing)
- [ ] `border_primary_color_default` (currently uses Color.clear)
- [ ] `border_success_color_default` (currently uses Color.clear)
- [ ] `border_warning_color_default` (currently uses Color.clear)
- [ ] `border_danger_color_default` (currently uses Color.clear)
- [ ] `border_subtle_color_default` (currently uses Color.clear)

### BadgeComponentTokens
- [ ] `height_major`, `height_minor`
- [ ] `padding_inline_major`, `padding_inline_minor`
- [ ] `padding_block_major`, `padding_block_minor`
- [ ] `icon_size_major`, `icon_size_minor`
- [ ] `gap_major`, `gap_minor`
- [ ] `border_radius_pill_major`, `border_radius_pill_minor`

### ChipComponentTokens
- [ ] `height_s`, `height_m`, `height_l`
- [ ] `padding_inline_s`, `padding_inline_m`, `padding_inline_l`
- [ ] `padding_block_s`, `padding_block_m`, `padding_block_l`
- [ ] `icon_size_s`, `icon_size_m`, `icon_size_l`
- [ ] `gap_s`, `gap_m`, `gap_l`
- [ ] `remove_button_size_s`, `remove_button_size_m`, `remove_button_size_l`
- [ ] `border_width`

### MenuComponentTokens
- [ ] Shadow color/opacity tokens (if ELEVATE defines them)

---

## Recommendations

### Short Term
1. **Focus on ElevateSpacing replacement first** - This is a blocker for future development
2. **Use component tokens wherever possible** - This maintains proper token hierarchy
3. **Document hardcoded values** - If a value must be hardcoded, add a comment explaining why

### Long Term
1. **Enhance extraction script** - Ensure all ELEVATE spacing/dimension tokens are extracted
2. **Create spacing alias tokens** - If ELEVATE defines generic spacing scales (xs, s, m, l, xl)
3. **Automate audit** - Create a lint rule or script to detect hardcoded design values

---

## Files Requiring Refactoring

### Critical (Broken References)
1. `ElevateUI/Sources/DesignTokens/Components/ButtonTokens.swift` (ElevateSpacing refs)
2. `ElevateUI/Sources/DesignTokens/Components/ChipTokens.swift` (ElevateSpacing refs)
3. `ElevateUI/Sources/DesignTokens/Components/BadgeTokens.swift` (ElevateSpacing refs)
4. `ElevateUI/Sources/SwiftUI/Components/ElevateButton+SwiftUI.swift` (ElevateSpacing refs, hardcoded gaps)

### High Priority (Hardcoded Values)
5. `ElevateUI/Sources/SwiftUI/Components/ElevateMenu+SwiftUI.swift` (shadow color)

### Review (Verify Token Availability)
6. All `*ComponentTokens.swift` files - check against ELEVATE SCSS for missing tokens

---

## Next Steps

1. ✅ Audit complete - All hardcoded values documented
2. ⏳ **NEXT**: Verify which tokens exist in ELEVATE SCSS
3. ⏳ Update extraction script to include missing tokens (if available)
4. ⏳ Refactor components to use extracted tokens
5. ⏳ Remove or recreate ElevateSpacing with proper token references
6. ⏳ Final verification build and visual testing

---

**Audit completed on 2025-11-06. Total files audited: 10 component files + 10 SwiftUI view files.**
