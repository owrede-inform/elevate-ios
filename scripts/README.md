# ElevateUI Scripts

This directory contains scripts for maintaining ElevateUI design tokens and build automation.

## Design Token Extraction

### Quick Update

```bash
# From project root
python3 scripts/update-design-tokens-v3.py
```

This extracts design tokens from ELEVATE SCSS files and generates Swift token files.

### Full Documentation

See [UPDATING_DESIGN_TOKENS.md](./UPDATING_DESIGN_TOKENS.md) for:
- Complete update process
- Path configuration (environment variables)
- Troubleshooting common issues
- Adding new component types
- Token hierarchy explanation

## Scripts Overview

| Script | Purpose | Status |
|--------|---------|--------|
| `update-design-tokens-v3.py` | **Current** - Full token extraction with auto-fixes | ✅ Active |
| `update-design-tokens-v2.py` | Legacy - Alias tokens with DynamicColor | 📦 Archived |
| `update-design-tokens.py` | Legacy - Basic primitive extraction | 📦 Archived |

## Features (v3)

✅ Automatic path validation
✅ Environment variable support (`ELEVATE_TOKENS_PATH`)
✅ Automatic incomplete reference fixing
✅ Comprehensive error messages
✅ Light/dark mode support
✅ Component token extraction (Button, Badge, Chip)

## Requirements

- Python 3.x
- Access to ELEVATE design tokens repository
- Swift Package Manager (for building)

## Contributing

When adding new features to the extraction script:
1. Update the script version number in comments
2. Test extraction on all component types
3. Verify build succeeds: `swift build`
4. Update UPDATING_DESIGN_TOKENS.md if behavior changes
