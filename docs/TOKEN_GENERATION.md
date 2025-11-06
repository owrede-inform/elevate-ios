# Token Generation System

## Overview

The ELEVATE token generation system automatically converts design tokens from SCSS format to Swift code, maintaining the three-tier token hierarchy and supporting adaptive light/dark mode colors.

## Architecture

### Token Flow
```
ELEVATE Design Tokens (SCSS)
        ↓
Python Parser (update-design-tokens-v4.py)
        ↓
Swift Token Files
        ├── ElevatePrimitives.swift
        ├── ElevateAliases.swift
        └── Component Tokens (51 files)
```

### Three-Tier Hierarchy
```
Primitive Tokens (Color palette, base spacing)
        ↓
Alias Tokens (Semantic names: primary, success, etc.)
        ↓
Component Tokens (Component-specific tokens)
```

## Running Token Generation

### Basic Usage
```bash
python3 scripts/update-design-tokens-v4.py
```

### What It Does
1. Parses SCSS token files from ELEVATE source
2. Extracts light and dark mode values
3. Generates Swift Color.adaptive() calls
4. Creates/updates all token files
5. Uses MD5 caching for incremental builds

### Output Files
```
ElevateUI/Sources/DesignTokens/Generated/
├── ColorAdaptive.swift              # Color.adaptive() extension
├── ElevatePrimitives.swift          # Base colors (63 tokens)
├── ElevateAliases.swift             # Semantic aliases (304 tokens)
└── *ComponentTokens.swift           # 51 component token files
```

## Configuration

### Source Directory
Located at `.elevate-src/` containing ELEVATE design tokens:
```
.elevate-src/
└── Elevate-2025-11-04/
    └── elevate-design-tokens-main/
        └── src/scss/
            ├── elevate.css          # Main tokens file
            ├── elevate.dark.css     # Dark mode tokens
            └── component-tokens/    # Component-specific tokens
```

### iOS Theme Extensions
Located at `ElevateUI/Sources/DesignTokens/`:
```
├── overwrite.css    # iOS-specific token overrides
└── extend.css       # Additional iOS tokens
```

## Token Types

### Color Tokens
Converted to `Color.adaptive(light:dark:)`:
```swift
public static let primary = Color.adaptive(
    light: ElevatePrimitives.Blue._color_blue_500,
    dark: ElevatePrimitives.Blue._color_blue_300
)
```

### Spacing Tokens
Converted to CGFloat:
```swift
public static let padding_m: CGFloat = 16.0
```

### Dimension Tokens
Converted to CGFloat:
```swift
public static let height_m: CGFloat = 44.0
```

## Caching System

### MD5-Based Incremental Builds
The generator uses MD5 hashing to skip unchanged files:

```json
{
  "ElevateUI/Sources/DesignTokens/Generated/ButtonComponentTokens.swift": {
    ".elevate-src/.../button.scss": "abc123...",
    "ElevateUI/Sources/DesignTokens/overwrite.css": "def456..."
  }
}
```

### Cache Location
```
ElevateUI/Sources/DesignTokens/.token_cache.json
```

### Force Regeneration
Delete the cache file to regenerate all tokens:
```bash
rm ElevateUI/Sources/DesignTokens/.token_cache.json
python3 scripts/update-design-tokens-v4.py
```

## Token Deduplication

### Problem
Previous versions generated duplicate tokens:
- Short form: `fill_primary_default`
- Long form: `elvt_component_button_fill_primary_default`

This caused 33% bloat in generated files.

### Solution
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

### Impact
- **582 lines removed** across 12 component files
- **41% size reduction** for ButtonComponentTokens (48KB → 28KB)
- **258KB total** generated code (down from ~420KB)

## Parser Implementation

### Key Classes

#### `SCSSUniversalParser`
Extracts tokens from SCSS files:
- Parses `$variable: value;` syntax
- Handles `rgba()`, hex colors, pixel values
- Detects token references with `var(--token-name)`
- Classifies tokens by type (COLOR, SPACING, DIMENSION)

#### `ComprehensiveComponentGenerator`
Generates component token files:
- Merges light/dark mode values
- Organizes tokens by type (colors, spacing, dimensions)
- Generates `Color.adaptive()` calls
- Applies deduplication logic

#### `PrimitivesGenerator`
Generates ElevatePrimitives.swift:
- Extracts primitive color tokens
- Organizes by color family (Blue, Red, Green, etc.)
- Creates nested struct hierarchy

#### `AliasesGenerator`
Generates ElevateAliases.swift:
- Extracts semantic alias tokens
- Organizes by category (Action, Content, Surface, etc.)
- Maintains reference chain to primitives

#### `TokenCacheManager`
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

## Swift Code Generation

### Color Adaptive Pattern
```swift
public static let token_name = Color.adaptive(
    light: ElevateAliases.Category.light_token,
    dark: ElevateAliases.Category.dark_token
)
```

### Fallback RGB Pattern
When no reference exists:
```swift
public static let token_name = Color.adaptive(
    lightRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000),
    darkRGB: (red: 0.3725, green: 0.6745, blue: 1.0000, opacity: 1.0000)
)
```

### Static Values
For spacing/dimensions:
```swift
public static let height_m: CGFloat = 44.0
```

## Validation

### Test Suite
Run validation tests:
```bash
python3 tests/test_token_generator.py
```

### Test Coverage
- SCSS parsing (colors, spacing, dimensions)
- Swift name sanitization
- Token cache invalidation
- Token deduplication logic
- Integration tests

### Manual Verification
```bash
# Regenerate tokens
python3 scripts/update-design-tokens-v4.py

# Build project
swift build

# Check output
ls -lh ElevateUI/Sources/DesignTokens/Generated/
```

## Troubleshooting

### Issue: Token Not Found
**Problem**: Component uses token that doesn't exist in generated file

**Solution**:
1. Check if token exists in ELEVATE source SCSS
2. Verify token naming matches ELEVATE conventions
3. Check overwrite.css/extend.css for iOS-specific tokens
4. Force regenerate: `rm .token_cache.json && python3 scripts/update-design-tokens-v4.py`

### Issue: Wrong Colors
**Problem**: Colors don't match ELEVATE design

**Solution**:
1. Verify ELEVATE source is up-to-date
2. Check light/dark mode files match
3. Verify Color.adaptive() reference paths
4. Check for iOS overrides in overwrite.css

### Issue: Build Errors
**Problem**: Swift compilation fails after token generation

**Solution**:
1. Check for syntax errors in generated files
2. Verify all referenced tokens exist
3. Check platform guards (`#if os(iOS)`)
4. Verify token names are valid Swift identifiers

### Issue: Cache Not Invalidating
**Problem**: Changes not reflected despite regeneration

**Solution**:
```bash
rm ElevateUI/Sources/DesignTokens/.token_cache.json
python3 scripts/update-design-tokens-v4.py
```

## Updating ELEVATE Source

### When ELEVATE Releases New Version

1. **Download new ELEVATE source**:
```bash
# Update .elevate-src/ directory with new version
```

2. **Clear cache and regenerate**:
```bash
rm ElevateUI/Sources/DesignTokens/.token_cache.json
python3 scripts/update-design-tokens-v4.py
```

3. **Verify changes**:
```bash
git diff ElevateUI/Sources/DesignTokens/Generated/
```

4. **Test build**:
```bash
swift build
```

5. **Update component wrappers** if token structure changed

### iOS-Specific Customizations

Edit these files to customize tokens for iOS:
- `overwrite.css` - Replace ELEVATE tokens with iOS values
- `extend.css` - Add new tokens not in ELEVATE

## Performance

### Generation Speed
- **Initial run**: ~2-3 seconds (51 components)
- **Cached run**: ~0.5 seconds (all files cached)
- **Partial update**: ~1 second (few changed files)

### File Sizes
- **Total generated**: 258KB (51 files)
- **Primitives**: 14.8KB (63 tokens)
- **Aliases**: 41.5KB (304 tokens)
- **Largest component**: ButtonComponentTokens.swift (28KB)

### Memory Usage
- **Peak**: ~50MB during parsing
- **Average**: ~20MB

## Future Improvements

Potential enhancements:
1. **Modular Package Structure** - Split 973-line script into modules
2. **Wrapper Auto-Generation** - Generate semantic token wrappers
3. **Validation Suite** - Automated token consistency checks
4. **W3C Format Support** - Import tokens from JSON format
5. **Documentation Generation** - Auto-generate token documentation
6. **CI/CD Integration** - Automated token updates in pipeline

## See Also

- [Token Wrapper Guide](TOKEN_WRAPPER_GUIDE.md) - Creating semantic wrappers
- [Component Authoring Guide](COMPONENT_AUTHORING_GUIDE.md) - Using tokens in components
- [Test Suite](../tests/test_token_generator.py) - Validation tests
