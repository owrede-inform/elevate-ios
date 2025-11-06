# Design Tokens Update System

This document describes the automated design token extraction and Swift code generation system for the ElevateUI iOS package.

## Overview

The design token update system automatically extracts design tokens from the ELEVATE SCSS source files and generates iOS-compatible Swift code. This ensures the iOS components stay synchronized with the official ELEVATE Design System.

## Source

**ELEVATE Design Tokens Repository:**
- Location: `/Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main`
- Version: v0.37.0
- Format: SCSS variable files with fallback values

## Scripts

### Main Update Script: `scripts/update-design-tokens.py`

A Python 3 script that:
1. Parses SCSS token files from the ELEVATE source
2. Extracts RGB color values and rem spacing values
3. Converts to Swift Color and CGFloat types
4. Generates complete ButtonTokens.swift and ElevateColors.swift files
5. Creates timestamped backups before updating
6. Verifies the changes compile successfully

**Usage:**
```bash
python3 scripts/update-design-tokens.py
```

**Output Files:**
- `ElevateUI/Sources/DesignTokens/Components/ButtonTokens.swift`
- `ElevateUI/Sources/DesignTokens/Colors/ElevateColors.swift`

**Backups:**
- Stored in: `scripts/backups/[YYYYMMDD_HHMMSS]/`

### Supporting Scripts

#### `scripts/update-design-tokens.sh`
Bash wrapper script that:
- Sources SCSS parsing and Swift generation libraries
- Orchestrates the token extraction workflow
- Verifies Swift build after updates

#### `scripts/lib/scss-parser.sh`
SCSS parsing utilities:
- `parse_rgb_color()` - Convert RGB to Swift Color
- `rem_to_cgfloat()` - Convert rem to CGFloat points
- `extract_button_tokens()` - Extract button tokens
- `extract_spacing_tokens()` - Extract spacing tokens
- `extract_color_tokens()` - Extract color tokens

#### `scripts/lib/swift-generator.sh`
Swift code generation functions:
- `generate_button_tokens_swift()` - Generate ButtonTokens.swift
- `generate_spacing_swift()` - Generate ElevateSpacing.swift
- `generate_colors_swift()` - Generate ElevateColors.swift

## Token Extraction Details

### Buttons (161 tokens extracted)

**Source File:** `elevate-design-tokens-main/src/scss/tokens/component/_button.scss`

**Token Structure:**
```scss
$fill-{tone}-{state}: var(--token-name, rgb(r g b));
$label-{tone}-{state}: var(--token-name, rgb(r g b));
$border-{tone}-color-{state}: var(--token-name, rgba(r g b / a%));
```

**Tones:** primary, secondary, success, warning, danger, emphasized, subtle, neutral

**States:** default, hover, active, disabled-default, selected-default, selected-hover, selected-active

**Generated Swift Structure:**
```swift
public struct ButtonTokens {
    public enum Tone { ... }
    public enum Size { ... }
    public enum State { ... }
    public enum Shape { ... }

    public struct ToneColors {
        let background: Color
        let backgroundHover: Color
        let backgroundActive: Color
        let backgroundDisabled: Color
        let text: Color
        let textDisabled: Color
        let border: Color

        static let primary = ToneColors(...)
        static let secondary = ToneColors(...)
        // ... all 8 tones
    }
}
```

### Colors (258 tokens extracted)

**Source File:** `elevate-design-tokens-main/src/scss/tokens/alias/_action.scss`

**Token Structure:**
```scss
$strong-{tone}-fill-{state}: var(--token-name, rgb(r g b));
$understated-{tone}-fill-{state}: var(--token-name, rgb(r g b));
```

**Generated Swift Structure:**
```swift
public struct ElevateColors {
    // Brand Colors
    public static let primary: Color
    public static let secondary: Color

    // Semantic Colors
    public static let success: Color
    public static let warning: Color
    public static let danger: Color

    // Neutral Colors
    public enum Background { ... }
    public enum Surface { ... }
    public enum Text { ... }
    public enum Border { ... }

    // UIKit Compatibility
    public enum UIKit { ... }
}
```

## Implementation Details

### Color Conversion

**SCSS Input:**
```scss
$fill-primary-default: var(--elvt-component-button-fill-primary-default, rgb(11 92 223));
```

**Swift Output:**
```swift
Color(red: 0.0431, green: 0.3608, blue: 0.8745)
```

**Conversion:** RGB values divided by 255 to get 0-1 range

### Spacing Conversion

**SCSS Input:**
```scss
$height-m: var(--elvt-component-button-height-m, 2.5rem);
```

**Swift Output:**
```swift
40.0  // 2.5 * 16 = 40 points
```

**Conversion:** 1 rem = 16 points (iOS standard)

### Alpha/Opacity Handling

**SCSS Input:**
```scss
$border-primary-color-default: var(--token, rgba(255 255 255 / 0%));
```

**Swift Output:**
```swift
Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.0000)
```

## Build Verification

After updating tokens, the script automatically verifies compilation:

```bash
swift build
```

**Last Successful Build:** 2025-11-04 13:47
- Build time: 0.37s
- No errors or warnings

## Token Update Results

### Last Update: 2025-11-04 13:47:43

**Tokens Extracted:**
- 161 button tokens (fill, label, border, sizing)
- 258 color tokens (semantic, action, neutral)

**Files Updated:**
- ButtonTokens.swift: All 8 button tones with 7 states each
- ElevateColors.swift: Brand, semantic, and neutral color palettes

**Backup Location:**
`scripts/backups/20251104_134743/`

### Comparison with Previous Run

| Metric | Before Fix | After Fix |
|--------|-----------|-----------|
| Button tokens | 13 | 161 |
| Color tokens | 2 | 258 |
| Button tones | Fallback gray | All 8 tones with correct colors |

**Issue Fixed:**
The initial regex pattern `[^)]+` couldn't handle nested parentheses in `rgb()` values. Updated to `.+?` (non-greedy match) to properly extract color values.

## Future Enhancements

### Phase 1: Additional Token Types
- [ ] Typography tokens from `_type-alias.scss`
- [ ] Shadow tokens from component files
- [ ] Border radius tokens
- [ ] Animation/transition tokens

### Phase 2: More Components
- [ ] Badge component tokens
- [ ] Input field tokens
- [ ] Card tokens
- [ ] Navigation tokens

### Phase 3: Advanced Features
- [ ] Dark mode token support
- [ ] Accessibility (high contrast) variants
- [ ] Dynamic type scaling
- [ ] Color scheme asset catalog generation

## Usage Guidelines

### When to Update Tokens

1. **After ELEVATE Design System Updates**
   - Pull latest changes from elevate-design-tokens repository
   - Run the update script
   - Review the git diff to verify changes
   - Test affected components

2. **Before Major Component Implementations**
   - Ensure tokens are up-to-date
   - Extract any new component-specific tokens
   - Update the Python script if new token patterns are found

3. **Regular Maintenance**
   - Monthly synchronization check
   - Version alignment verification
   - Token coverage audit

### Verification Checklist

After running the token update script:

- [ ] Check console output for token counts (should be 161+ button, 258+ color)
- [ ] Verify Swift build succeeds with no errors
- [ ] Review git diff for expected changes
- [ ] Test button component with all tones
- [ ] Check color values match ELEVATE source
- [ ] Verify backup was created successfully

### Troubleshooting

**Issue:** Token count lower than expected
- **Cause:** SCSS file structure changed or parsing regex needs update
- **Solution:** Check SCSS source files, update regex pattern in Python script

**Issue:** Build fails after token update
- **Cause:** Syntax error in generated Swift code
- **Solution:** Check backup directory, restore previous version, fix generator code

**Issue:** Colors look incorrect
- **Cause:** RGB conversion issue or wrong source file
- **Solution:** Verify SCSS source values, check ColorParser.parse_rgb() function

## Contact & Support

**Project:** elevate-ios
**Design System:** ELEVATE Core UI v0.0.41-alpha
**Tokens Version:** @inform-elevate/elevate-design-tokens v0.37.0

For issues with:
- **Token extraction:** Review `scripts/update-design-tokens.py`
- **SCSS parsing:** Check `scripts/lib/scss-parser.sh`
- **Swift generation:** Review generator classes in Python script
- **Design system:** Consult ELEVATE Core UI documentation
