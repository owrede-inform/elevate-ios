# Updating Design Tokens from ELEVATE Core UI

This guide explains how to update ElevateUI when the ELEVATE Design Tokens or Core UI library are updated.

## Quick Start

**For most updates, you only need these steps:**

```bash
# 1. Update ELEVATE design tokens
cd /path/to/elevate-design-tokens && git pull

# 2. Run extraction script
cd /path/to/elevate-ios
python3 scripts/update-design-tokens-v3.py

# 3. Verify build
swift build
```

✅ **The script automatically**: validates paths, extracts tokens, fixes incomplete references, and generates Swift files.

---

## Prerequisites

The extraction script expects ELEVATE design tokens at:
```
/Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main/src/scss
```

**If your tokens are in a different location**, you have two options:

### Option 1: Environment Variable (Recommended)
```bash
export ELEVATE_TOKENS_PATH=/path/to/elevate-design-tokens/src/scss
python3 scripts/update-design-tokens-v3.py
```

### Option 2: Edit Script Directly
Update `ELEVATE_TOKENS_PATH` default value in `scripts/update-design-tokens-v3.py` (line ~30).

## Update Process

### 1. Update ELEVATE Design Tokens

```bash
# Navigate to your elevate-design-tokens directory
cd /Users/wrede/Documents/Elevate-2025-11-04/elevate-design-tokens-main

# Pull latest changes
git pull origin main
```

### 2. Run the Extraction Script

```bash
# From the elevate-ios project root
python3 scripts/update-design-tokens-v3.py
```

The script will automatically:
- **Validate** that all required source files exist
- **Exit with helpful error messages** if paths are incorrect
- **Extract** primitives, aliases, and component tokens from SCSS
- **Fix** incomplete token references automatically (e.g., LayerAppbackground issues)
- **Generate** Swift files in `ElevateUI/Sources/DesignTokens/Generated/`:
  - `ElevatePrimitives.swift` - Base color values
  - `ElevateAliases.swift` - Semantic aliases with light/dark modes
  - `ButtonComponentTokens.swift` - Button-specific tokens
  - `BadgeComponentTokens.swift` - Badge-specific tokens
  - `ChipComponentTokens.swift` - Chip-specific tokens

**Output Example**:
```
=== ELEVATE Design Token Extraction v3 ===
✅ Source files validated

Parsing light mode tokens...
  Found 1312 light mode tokens

Generating Aliases...
  ✅ Generated: ElevateAliases.swift
  📊 Size: 62,607 bytes
  🔧 Fixing incomplete references...
  ✅ Fixed 10 incomplete references

Generating Button Component Tokens...
  ✅ Generated: ButtonComponentTokens.swift
  📊 Size: 28,517 bytes
  📊 Tokens: 113

✅ Extraction complete!
```

### 3. Verify the Build

```bash
swift build
```

**Expected**: Build completes successfully without errors.

### 4. Test Components (Optional)

If you have preview apps or tests:
```bash
# Run tests if available
swift test

# Or build and run your example app
cd Examples/ElevateUIExample
swift run
```

## What Gets Updated Automatically

✅ **Primitives** - All base colors (Red._50, Blue._500, etc.)
✅ **Aliases** - Semantic tokens (Action.StrongPrimary, Layout.General, etc.)
✅ **Component Tokens** - Button, Badge, Chip token sets
✅ **Light/Dark Modes** - DynamicColor resolution

## What Requires Manual Updates

⚠️ **New Components** - If ELEVATE adds a new component (e.g., "Toggle"):
1. Add component name to the `components` list in `update-design-tokens-v3.py` (around line 530)
2. Create a new wrapper file: `ElevateUI/Sources/DesignTokens/Components/ToggleTokens.swift`
3. Follow the pattern from `ButtonTokens.swift` or `ChipTokens.swift`

⚠️ **Breaking Token Name Changes** - If token names change significantly:
1. Check component wrapper files for compile errors
2. Update token references in wrapper files to use new names

⚠️ **New Token Categories** - If ELEVATE adds new alias categories:
1. Update `AliasTokensGenerator._organize_aliases()` to handle new prefixes
2. May need to adjust Swift struct hierarchy

## Troubleshooting

### Build Errors After Update

**Problem**: `error: cannot find 'SomeToken' in scope`
**Solution**: Check if the token was renamed or moved in ELEVATE. Update references in component wrapper files.

**Problem**: `error: expected member name following '.'` (e.g., `ElevateAliases.Layout.LayerAppbackground.`)
**Solution**: This should be fixed automatically by the extraction script. If you see this:
1. Re-run `python3 scripts/update-design-tokens-v3.py`
2. The script automatically fixes incomplete LayerAppbackground references
3. You should see: `✅ Fixed 10 incomplete references`

If the error persists, the script may need updating to handle new incomplete references.

### Missing Tokens

**Problem**: Expected tokens not generated
**Solution**:
1. Verify token exists in SCSS: `grep "token-name" /path/to/_light.scss`
2. Check token prefix matches script patterns (elvt-primitives-, elvt-alias-, elvt-component-)
3. Ensure SCSS format is: `--token-name: var(--reference, rgba(...))`

### Path Issues

**Problem**: Script outputs `❌ ERROR: ELEVATE tokens path does not exist`
**Solution**:
```bash
# Set environment variable to correct path
export ELEVATE_TOKENS_PATH=/your/path/to/elevate-design-tokens/src/scss
python3 scripts/update-design-tokens-v3.py

# Or update the default path in the script (line ~30)
```

**Problem**: `❌ ERROR: Light mode file not found` or `❌ ERROR: Dark mode file not found`
**Solution**: Verify the SCSS files exist at:
- `{ELEVATE_TOKENS_PATH}/values/_light.scss`
- `{ELEVATE_TOKENS_PATH}/values/_dark.scss`

The script validates all paths before starting extraction.

## Token Hierarchy

Understanding the hierarchy helps troubleshoot issues:

```
Components (ElevateButton, ElevateBadge, ElevateChip)
    ↓ reference
Component Wrappers (ButtonTokens, BadgeTokens, ChipTokens)
    ↓ reference
Generated Component Tokens (ButtonComponentTokens, etc.)
    ↓ reference
Alias Tokens (ElevateAliases) - Light/Dark differentiation
    ↓ reference
Primitive Tokens (ElevatePrimitives) - Static base colors
```

## Script Maintenance

### Adding a New Component Type

Edit `scripts/update-design-tokens-v3.py`:

```python
# Around line 530, add to the components list:
components = ['button', 'badge', 'chip', 'toggle']  # Add 'toggle'

# Create matching wrapper file:
# ElevateUI/Sources/DesignTokens/Components/ToggleTokens.swift
```

### Changing Token Extraction Logic

Key classes in the script:
- `SCSSReferenceParser` - Parses SCSS token definitions
- `SwiftTokenMapper` - Converts SCSS names to Swift names
- `DynamicColorGenerator` - Creates DynamicColor instances
- `PrimitivesGenerator` - Generates ElevatePrimitives.swift
- `AliasTokensGenerator` - Generates ElevateAliases.swift
- `ComponentTokensGenerator` - Generates component token files

## Version History

- **v3.1** (Current) - Fixed empty subcategory handling (defaults to "General")
- **v3.0** - Full component token extraction with light/dark mode and auto-fix
- **v2.0** - Alias tokens with DynamicColor support
- **v1.0** - Basic primitive token extraction

### v3.1 Changes
- Fixed bug where tokens like `elvt-alias-feedback-text-danger` generated `Feedback..text_danger` (double dot)
- Now correctly generates `Feedback.General.text_danger`
- Empty subcategories default to "General" for consistency

---

**Last Updated**: 2025-11-04
**Script Version**: v3
**Compatible with**: ELEVATE Design Tokens (main branch)
