# ELEVATE iOS Architecture

## System Overview

ELEVATE iOS is a native iOS UI component library implementing the ELEVATE Design System using a three-tier design token system with automated extraction from source SCSS files.

## Architecture Layers

```
┌─────────────────────────────────────────────────────────┐
│              ELEVATE Design System (SCSS)               │
│                    Source of Truth                      │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│            Token Extraction Pipeline                    │
│         (Python Script + Build Integration)             │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│          Generated Swift Token Files                    │
│   Primitives → Aliases → Component Tokens              │
└────────────────┬────────────────────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────────────────────┐
│           SwiftUI/UIKit Components                      │
│        (Reference tokens, zero hardcoded values)        │
└─────────────────────────────────────────────────────────┘
```

## Key Architectural Decisions

### 1. Three-Tier Token System

**Decision**: Component Tokens → Alias Tokens → Primitive Tokens

**Rationale**:
- Automatic dark mode support
- Single source of truth (ELEVATE SCSS)
- Type-safe Swift enums/structs
- Zero hardcoded values in components

**Details**: See [TOKEN_SYSTEM.md](TOKEN_SYSTEM.md)

### 2. Dual Framework Support

**Decision**: Provide both SwiftUI and UIKit implementations

**Rationale**:
- SwiftUI is primary for modern apps
- UIKit bridges for legacy apps and UIKit-specific features
- Shared token system across both

### 3. Scroll-Friendly Gesture System

**Decision**: UIControl-based touch tracking instead of SwiftUI gestures

**Rationale**:
- Standard gestures block scrolling
- Need instant feedback (<100ms)
- Native iOS button feel

**Details**: See [../.claude/concepts/scroll-friendly-gestures.md](../.claude/concepts/scroll-friendly-gestures.md)

### 4. Build-Time Token Generation

**Decision**: Generate tokens at build time with MD5 caching

**Rationale**:
- Always in sync with ELEVATE source
- Fast incremental builds (<1s cached)
- No manual token maintenance

**Details**: See [AUTOMATION.md](AUTOMATION.md)

### 5. iOS-Specific Theme System

**Decision**: CSS-based theme overlay (extend.css + overwrite.css)

**Rationale**:
- iOS needs tokens not in ELEVATE (e.g., vertical padding, icon sizes)
- Platform-specific overrides (44pt touch targets)
- Easy to sync when ELEVATE adds missing tokens

**Details**: See [../.claude/archived/THEME_BASED_TOKEN_SYSTEM_COMPLETE.md](../.claude/archived/THEME_BASED_TOKEN_SYSTEM_COMPLETE.md)

## Component Architecture

### Component Structure

```swift
// Token Wrapper (Manual)
ButtonTokens.swift
├── Size enum (small, medium, large)
├── SizeConfig struct (heights, padding, gap)
├── Tone enum (primary, success, warning, etc.)
└── ToneColors struct (references Component Tokens)

// SwiftUI Component
ElevateButton+SwiftUI.swift
├── Properties (tone, size, isDisabled)
├── State (@State isPressed)
├── Body (uses tokens via computed properties)
└── Token accessors (state-based color selection)

// UIKit Component
ElevateButton+UIKit.swift
├── UIControl subclass
├── Properties (tone, size, isEnabled)
├── State management (isHighlighted)
└── Layout + styling (uses tokens)
```

### Token Flow

```
User Code
    ↓
Component (ElevateButton)
    ↓
Token Wrapper (ButtonTokens.SizeConfig)
    ↓
Component Tokens (ButtonComponentTokens.fill_primary_default)
    ↓
Alias Tokens (ElevateAliases.Action.Primary.fill_default)
    ↓
Primitive Tokens (ElevatePrimitives.Blue._600)
    ↓
Color.adaptive(light: ..., dark: ...)
    ↓
SwiftUI Color / UIKit UIColor (respects dark mode)
```

**The Iron Rule**: Components → Alias Tokens → NEVER Primitives
See [../.claude/concepts/design-token-hierarchy.md](../.claude/concepts/design-token-hierarchy.md)

## Directory Structure

```
ElevateUI/Sources/
├── DesignTokens/
│   ├── Generated/              # Auto-generated, DO NOT EDIT
│   │   ├── ElevatePrimitives.swift
│   │   ├── ElevateAliases.swift
│   │   ├── ColorAdaptive.swift
│   │   └── *ComponentTokens.swift (51 files)
│   │
│   ├── Components/             # Manual token wrappers
│   │   ├── ButtonTokens.swift
│   │   ├── ChipTokens.swift
│   │   ├── BadgeTokens.swift
│   │   └── ...
│   │
│   └── Core/
│       ├── ElevateTypography.swift
│       └── ElevateIcon.swift
│
├── SwiftUI/
│   ├── Components/             # SwiftUI components
│   │   ├── ElevateButton+SwiftUI.swift
│   │   ├── ElevateChip+SwiftUI.swift
│   │   ├── ElevateBadge+SwiftUI.swift
│   │   └── ...
│   │
│   └── Utilities/              # SwiftUI helpers
│       └── ScrollFriendlyTap.swift
│
└── UIKit/
    ├── Components/             # UIKit components
    │   ├── ElevateButton+UIKit.swift
    │   └── ...
    │
    └── Utilities/              # UIKit helpers
```

## Build Process

### Token Generation Flow

```
1. Developer runs Xcode build or `swift build`
2. Pre-compile script executes (Xcode) or manual run
3. Check MD5 checksums of source SCSS files
4. If changed: Parse SCSS → Extract tokens → Generate Swift
5. If unchanged: Skip generation (cached, <0.1s)
6. Compile Swift code with generated/cached tokens
```

### Token Extraction Pipeline (v4.0)

```
SCSS Source Files (light.css, dark.css)
    ↓
iOS Theme Overlay (extend.css, overwrite.css)
    ↓
Parse with SCSSUniversalParser
    ↓
Extract tokens by type (colors, spacing, dimensions)
    ↓
Generate Swift code:
    - Primitives (63 tokens)
    - Aliases (304 tokens)
    - Components (51 files, ~2500 tokens total)
    ↓
Write to ElevateUI/Sources/DesignTokens/Generated/
    ↓
Update MD5 cache for incremental builds
```

### Xcode Build Phases

1. **Run Script: Generate Design Tokens** (before compilation)
   - Checks MD5 cache
   - Runs Python extraction script if needed
   - Fast: <0.1s cached, ~2-5s cold

2. **Compile Sources**
   - Compiles generated tokens
   - Compiles components

3. **Link Binary**

4. **Copy Resources** (fonts, assets)

## Design Principles

### 1. Zero Hardcoded Values

**Principle**: All colors, spacing, sizing must come from tokens

**Enforcement**:
- Code review checks
- Grep searches for `Color(red:`, `CGFloat = [0-9]`
- Type system (tokens are structs/enums, not primitives)

### 2. Incremental Development

**Principle**: Work-in-progress code must not break builds

**Enforcement**:
- `.wip` file extensions excluded from compilation
- Feature flags for incomplete components
- Clear separation of stable vs. in-development

**Details**: See [COMPONENT_DEVELOPMENT.md#incremental-development-strategy](COMPONENT_DEVELOPMENT.md#incremental-development-strategy)

### 3. Platform-Native Feel

**Principle**: iOS components must feel like native iOS, not web ports

**Implementation**:
- 44pt minimum touch targets
- Instant visual feedback (<100ms)
- Native gestures (scroll, swipe, long-press)
- VoiceOver support
- Dynamic Type support

**Details**: See [../.claude/concepts/ios-touch-guidelines.md](../.claude/concepts/ios-touch-guidelines.md)

### 4. Single Source of Truth

**Principle**: ELEVATE SCSS is the authoritative source for all design tokens

**Implementation**:
- Extraction (not generation) from SCSS
- No manual token definitions (except iOS-specific theme tokens)
- Update ELEVATE → Re-extract → Done

## Testing Strategy

### Unit Tests

- Token resolution (all references valid)
- Component state logic
- Size calculations (44pt minimum)
- Token wrapper behavior

### Integration Tests

- Dark mode switching
- Theme consistency
- Touch target validation
- Cross-component integration

### Manual Testing

- Visual regression (screenshot comparison)
- Accessibility (VoiceOver, Dynamic Type)
- Scroll behavior in lists
- Gesture responsiveness

## Performance Considerations

### Token Generation

- **Cold build**: ~2-5 seconds (full SCSS parsing + Swift generation)
- **Cached build**: ~0.1 seconds (MD5 match, skip generation)
- **Cache invalidation**: MD5 checksum comparison of all source files
- **Incremental**: Only changed components regenerate

### Runtime

- **Token lookups**: Compile-time constants (zero overhead)
- **Color adaptation**: UIKit native (system-optimized)
- **Component rendering**: Standard SwiftUI/UIKit performance
- **Memory**: Tokens are static constants (minimal footprint)

## Technology Stack

### Languages & Frameworks
- **Swift 5.5+**: Main implementation language
- **SwiftUI**: Primary UI framework (iOS 15+)
- **UIKit**: Legacy support and advanced features
- **Python 3.8+**: Token extraction scripts

### Build Tools
- **Xcode 14+**: Primary IDE and build system
- **Swift Package Manager**: Dependency management
- **Git**: Version control

### Design System
- **ELEVATE Core UI**: Source design system (SCSS)
- **CSS/SCSS**: Token source files
- **Figma**: Design reference (not automated)

## Future Architecture Plans

### Phase 1: Real-Time Theme Switching (Planned)

- Multiple theme loading at launch
- ObservableObject theme manager
- SwiftUI automatic re-rendering
- UserDefaults persistence

### Phase 2: Custom Theme Support (Planned)

- User-defined theme overlays
- Theme preview
- Theme editor
- Import/export themes

### Phase 3: Figma Integration (Research)

- Figma Tokens plugin
- JSON → SCSS converter
- Automated design-to-code pipeline
- Real-time sync

### Phase 4: Component Library Expansion

- Complete all 51 ELEVATE components
- Additional iOS-specific components
- Custom component builder API
- Component composition patterns

## Component Status

**Implemented** (12 components):
- Button (SwiftUI + UIKit)
- Chip (SwiftUI)
- Badge (SwiftUI)
- Icon (SwiftUI)
- TextField (SwiftUI)
- Breadcrumb (SwiftUI)
- BreadcrumbItem (SwiftUI)
- Menu (SwiftUI)
- MenuItem (SwiftUI)
- Tab (SwiftUI)
- TextArea (SwiftUI)
- Scroll-friendly gesture utility

**In Progress** (see session notes in `.claude/sessions/`):
- Form controls (Checkbox, Radio, Switch)
- Navigation components
- Advanced inputs

**Planned** (39 components):
- See [WEB_TO_IOS_TRANSLATION.md](WEB_TO_IOS_TRANSLATION.md) for complete roadmap

## Related Documentation

### Core Documentation
- [TOKEN_SYSTEM.md](TOKEN_SYSTEM.md) - Complete token system documentation
- [COMPONENT_DEVELOPMENT.md](COMPONENT_DEVELOPMENT.md) - Component development guide
- [WEB_TO_IOS_TRANSLATION.md](WEB_TO_IOS_TRANSLATION.md) - Web-to-iOS porting guide
- [AUTOMATION.md](AUTOMATION.md) - Build automation guide

### Claude Implementation Guides
- [../.claude/iOS-IMPLEMENTATION-GUIDE.md](../.claude/iOS-IMPLEMENTATION-GUIDE.md) - Main implementation guide
- [../.claude/THEME-ARCHITECTURE.md](../.claude/THEME-ARCHITECTURE.md) - Detailed theme design
- [../.claude/concepts/design-token-hierarchy.md](../.claude/concepts/design-token-hierarchy.md) - The Iron Rule
- [../.claude/concepts/scroll-friendly-gestures.md](../.claude/concepts/scroll-friendly-gestures.md) - Gesture handling
- [../.claude/concepts/ios-touch-guidelines.md](../.claude/concepts/ios-touch-guidelines.md) - Touch UI guidelines

### External Resources
- [ELEVATE Core UI (Web)](https://github.com/inform-elevate/elevate-core-ui)
- [Apple HIG](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)

---

**Last Updated**: 2025-11-06
**Architecture Version**: 1.0
**Token System Version**: 4.0
