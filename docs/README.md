# ELEVATE iOS Documentation

**Version**: 2.0
**Last Updated**: 2025-11-11
**Automation Status**: 90% (0% → 90% migration complete)

Welcome to the ELEVATE iOS design system documentation. This guide helps you build, maintain, and extend SwiftUI components using the ELEVATE design tokens.

---

## Quick Navigation

### 🚀 Getting Started

**New to ELEVATE iOS?** Start here:

1. **[Token System Overview](systems/token-system.md)** - Understand the three-tier token hierarchy
2. **[Component Development Guide](guides/component-development.md)** - Learn the .wip workflow and component patterns
3. **[Component Status](reference/component-status.md)** - See what's implemented and what's missing

**Quick Links**:
- **Component Templates**: [guides/component-development.md#component-implementation-pattern](guides/component-development.md#component-implementation-pattern)
- **Token Wrapper Guide**: [guides/token-wrapper-guide.md](guides/token-wrapper-guide.md)
- **Web → iOS Translation**: [guides/web-to-ios-translation.md](guides/web-to-ios-translation.md)

---

## Documentation Structure

### 📘 Systems

Core infrastructure and automation:

- **[Token System](systems/token-system.md)** (1460 lines) - Complete token extraction, generation, and automation guide
  - Three-tier hierarchy (Primitives → Aliases → Components)
  - SCSS → Swift extraction pipeline
  - iOS theme customization (overwrite.css, extend.css)
  - MD5 caching and selective regeneration
  - Automation system (0% → 90% achieved)

### 📗 Guides

Step-by-step development workflows:

- **[Component Development](guides/component-development.md)** (1656 lines) - Complete component authoring guide
  - .wip file workflow (incremental development)
  - Component implementation patterns
  - Token wrapper integration
  - Scroll-friendly gesture handling
  - Testing checklist

- **[Token Wrapper Guide](guides/token-wrapper-guide.md)** - Creating semantic token wrappers
  - When to use wrappers vs. generated tokens
  - Tone/Size/State organization patterns
  - Examples: Button, Chip, Badge

- **[Web to iOS Translation](guides/web-to-ios-translation.md)** (1383 lines) - Porting ELEVATE Core UI to iOS
  - Platform-specific adaptations
  - iOS HIG compliance patterns
  - Touch target sizing (44pt minimum)
  - Gesture handling differences

### 📙 Reference

Technical specifications and analyses:

- **[Component Status](reference/component-status.md)** - Implementation progress tracker
  - 36/51 components implemented (71%)
  - 8/51 token wrappers created (16%)
  - Priority recommendations by phase

- **[Architecture](reference/architecture.md)** - System architecture overview
  - Package structure (ElevateUI, ElevateUITests)
  - Design token generation pipeline
  - Testing infrastructure

- **[iOS Adaptations](reference/ios-adaptations.md)** - Platform-specific divergences from web ELEVATE
  - Touch targets (44pt vs 32px)
  - Typography sizing (+15% for iOS)
  - Button instant feedback (20ms vs 200ms)
  - Notification banner positioning

**Technical Solutions**:
- [Button Responsiveness Fix](reference/button-responsiveness-fix.md) - Solving instant feedback requirements
- [Gesture Handling](reference/gesture-handling-solution.md) - Scroll-friendly gesture patterns
- [iOS Notification Banner](reference/ios-notification-banner.md) - Native banner implementation
- [Text Size Adaptations](reference/text-size-adaptations.md) - Typography iOS adjustments
- [Hardcoded Colors Analysis](reference/hardcoded-colors-analysis.md) - Token migration audit

### 📕 Strategy

Automation and update workflows:

- **[ELEVATE Update Strategy](strategy/elevate-update-strategy.md)** - Managing ELEVATE source updates
  - Download and integration workflow
  - Risk assessment and validation
  - Version tracking

- **[Automation](strategy/automation.md)** - Build integration and automation
  - CI/CD workflows (GitHub Actions)
  - Selective regeneration (6x speedup)
  - Risk-based automation (preview → apply → rollback)
  - Validation pipeline

### 📦 Archive

Historical migration documentation:

**[2025-11-migration/](archive/2025-11-migration/)** - November 2025 automation migration (0% → 90%)

**Archived documents**:
- Migration plan and progress tracking
- Implementation summaries and session notes
- Visual regression testing guide
- Intelligent update system architecture
- Token system improvements history

**Why archived**: Migration completed successfully, systems operational, documentation consolidated into active guides.

---

## Key Concepts

### Three-Tier Token Hierarchy

The ELEVATE design system uses strict token hierarchy:

```
Component Tokens (USE FIRST)
    ↓ references
Alias Tokens (USE if no Component Token)
    ↓ references
Primitive Tokens (NEVER use directly)
    ↓ resolves to
RGB Color Values (light/dark mode)
```

**Decision Tree**:
1. Check Component Tokens first (e.g., `ButtonTokens.Tone.primary.colors.fill`)
2. If no component token exists, use Alias (e.g., `ElevateAliases.Action.primary`)
3. Never use Primitives directly (e.g., ~~`ElevatePrimitives.Blue._color_blue_500`~~)

**See**: [systems/token-system.md#three-tier-token-hierarchy](systems/token-system.md#three-tier-token-hierarchy)

### .wip Workflow

Incremental component development without breaking builds:

1. **Create file as `.swift.wip`** - Xcode won't compile it
2. **Develop incrementally** - Test in isolation
3. **Activate when ready** - Rename to `.swift`
4. **Instant rollback** - Rename back to `.wip` if needed

**See**: [guides/component-development.md#quick-start-workflow](guides/component-development.md#quick-start-workflow)

### Automation System (90% Achieved)

**Old Workflow** (4-8 hours):
- Manual ELEVATE updates
- Full token regeneration (all 48 files)
- Manual error fixing and validation
- 100% manual work

**New Workflow** (~6 minutes):
```bash
./scripts/elevate-update.sh preview    # Risk analysis
./scripts/elevate-update.sh apply --selective --auto-commit
```

**Achievements**:
- 120x faster updates (4-8 hours → 6 minutes)
- 6x selective regeneration speedup
- Risk-based automation (LOW/MEDIUM/HIGH/CRITICAL)
- Automated validation pipeline
- One-command rollback

**See**: [strategy/automation.md](strategy/automation.md)

---

## Common Tasks

### Implement a New Component

1. **Check if tokens exist**:
   ```bash
   ls ElevateUI/Sources/DesignTokens/Generated/*ComponentTokens.swift | grep -i "mycomponent"
   ```

2. **Create token wrapper** (optional but recommended):
   ```bash
   cd ElevateUI/Sources/DesignTokens/Components/
   touch MyComponentTokens.swift.wip
   # Follow: guides/token-wrapper-guide.md
   ```

3. **Create component**:
   ```bash
   cd ElevateUI/Sources/SwiftUI/Components/
   touch ElevateMyComponent+SwiftUI.swift.wip
   # Follow: guides/component-development.md#component-implementation-pattern
   ```

4. **Activate when ready**:
   ```bash
   mv MyComponentTokens.swift.wip MyComponentTokens.swift
   mv ElevateMyComponent+SwiftUI.swift.wip ElevateMyComponent+SwiftUI.swift
   swift build  # Verify compilation
   ```

### Update ELEVATE Design Tokens

**Automatic workflow** (recommended):
```bash
# 1. Download latest ELEVATE source to .elevate-src/Elevate-YYYY-MM-DD/

# 2. Preview changes and risk analysis
./scripts/elevate-update.sh preview

# 3. Apply with selective regeneration
./scripts/elevate-update.sh apply --selective --auto-commit

# 4. Rollback if needed
./scripts/elevate-update.sh rollback
```

**Manual workflow** (if needed):
```bash
# Full regeneration
python3 scripts/update-design-tokens-v4.py

# Selective regeneration (6x faster)
python3 scripts/update-design-tokens-v4.py --selective
```

**See**: [systems/token-system.md#staying-in-sync-with-elevate](systems/token-system.md#staying-in-sync-with-elevate)

### Refactor Existing Component

1. **Audit for hardcoded values**:
   - Search for hardcoded colors: `Color.blue`, `UIColor`, hex values
   - Search for hardcoded spacing: magic numbers in padding/spacing
   - See: [reference/hardcoded-colors-analysis.md](reference/hardcoded-colors-analysis.md)

2. **Create token wrapper** (if missing):
   - See: [guides/token-wrapper-guide.md](guides/token-wrapper-guide.md)

3. **Replace hardcoded → tokens**:
   - Follow patterns in existing components
   - Test light/dark mode
   - See: [guides/component-development.md#refactoring-existing-components](guides/component-development.md#refactoring-existing-components)

### Run Tests

```bash
# All tests
swift test

# Token consistency tests
xcodebuild test -scheme ElevateUI \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:ElevateUITests/TokenConsistencyTests

# Visual regression tests (requires baselines)
xcodebuild test -scheme ElevateUI \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:ElevateUITests/VisualRegressionTests
```

**See**: [guides/component-development.md#testing-checklist](guides/component-development.md#testing-checklist)

---

## Scripts Reference

### Token Generation

**`scripts/update-design-tokens-v4.py`** - Main token extraction script
```bash
# Full regeneration
python3 scripts/update-design-tokens-v4.py

# Selective regeneration (6x faster)
python3 scripts/update-design-tokens-v4.py --selective

# Force regeneration (ignore cache)
python3 scripts/update-design-tokens-v4.py --force
```

### Automation System

**`scripts/elevate-update.sh`** - ELEVATE update orchestrator
```bash
./scripts/elevate-update.sh preview    # Preview changes + risk analysis
./scripts/elevate-update.sh apply      # Apply with validation
./scripts/elevate-update.sh rollback   # Rollback last update
./scripts/elevate-update.sh status     # System status
```

**Supporting Scripts**:
- `scripts/detect-elevate-changes.py` - Change detection and risk scoring
- `scripts/scss_change_detector.py` - MD5-based SCSS change detection
- `scripts/token_dependency_graph.py` - Dependency tracking for selective regeneration
- `scripts/benchmark-token-generation.py` - Performance benchmarking

### Build Integration

**`scripts/regenerate-tokens-if-needed.sh`** - Build phase script
- Automatically regenerates tokens if ELEVATE source changes
- Integrated into Xcode build process

---

## Testing Infrastructure

### Test Coverage

**Unit Tests** (65 passing):
- `TokenConsistencyTests.swift` (13 tests) - Token completeness validation
- `DarkModeTests.swift` (15 tests) - Light/dark mode consistency
- `AccessibilityContrastTests.swift` (21 tests) - WCAG contrast compliance
- `VisualRegressionTests/ButtonVisualTests.swift` (15+ tests) - Screenshot comparison

### CI/CD Workflows

**GitHub Actions**:
- `.github/workflows/token-tests.yml` - 5 parallel jobs for token validation
- `.github/workflows/build-and-test.yml` - Multi-device build verification

**See**: [strategy/automation.md#cicd-integration](strategy/automation.md#cicd-integration)

---

## File Locations

### Source Code

```
ElevateUI/Sources/
├── SwiftUI/Components/        # Component implementations
│   └── Elevate{Name}+SwiftUI.swift
├── UIKit/Components/          # UIKit bridges (optional)
│   └── Elevate{Name}+UIKit.swift
├── DesignTokens/
│   ├── Components/            # Token wrappers (semantic layer)
│   │   └── {Name}Tokens.swift
│   └── Generated/             # Auto-generated from SCSS
│       ├── ElevatePrimitives.swift
│       ├── ElevateAliases.swift
│       └── *ComponentTokens.swift
└── Resources/
    └── Fonts/                 # Inter font family
```

### Tests

```
ElevateUITests/
├── TokenConsistencyTests.swift
├── DarkModeTests.swift
├── AccessibilityContrastTests.swift
└── VisualRegression/
    ├── SnapshotTestCase.swift
    └── ButtonVisualTests.swift
```

### ELEVATE Source

```
.elevate-src/
└── Elevate-2025-11-04/
    ├── elevate-design-tokens-main/src/scss/
    ├── elevate-core-ui-main/src/
    └── elevate-icons-main/src/
```

---

## Development Status

### Current State

✅ **Foundation Complete** (71% component coverage):
- 36/51 components implemented
- 8/51 token wrappers created
- 65 passing tests + CI/CD
- 90% automation achieved

⏳ **In Progress**:
- Token wrapper coverage (target: 100%)
- Missing component implementations (18 components)
- Visual regression test expansion

### Roadmap

**Phase 1: Token Wrapper Coverage** (1-2 days)
- Create wrappers for 28 existing components
- Priority: Interactive components (Checkbox, Switch, Radio, Slider)

**Phase 2: Critical Components** (2-3 days)
- Dialog, Drawer, Select, Input
- Essential for full-featured applications

**Phase 3: Layout Components** (2-3 days)
- Table, Tab-group, Split-panel, Tree-item
- Advanced layout capabilities

**See**: [reference/component-status.md#implementation-priority-recommendations](reference/component-status.md#implementation-priority-recommendations)

---

## Contributing Guidelines

### Code Standards

1. **Follow token hierarchy** - Never use Primitives directly
2. **Use .wip workflow** - Incremental development without breaking builds
3. **Create token wrappers** - Semantic layer over generated tokens
4. **Test light/dark mode** - All components support adaptive colors
5. **iOS HIG compliance** - 44pt touch targets, native gestures
6. **Document patterns** - Add examples to component development guide

### Documentation Standards

1. **Keep guides updated** - Sync with code changes
2. **Examples first** - Show working code before explaining
3. **Reference real files** - Link to actual source locations
4. **Semantic organization** - Use lowercase folder names
5. **No numbered prefixes** - Industry standard: flat semantic structure

---

## Support & Resources

### Internal Documentation

All documentation in this `/docs` directory:
- Start with this README for navigation
- Follow links to detailed guides
- Check archive for historical context

### External Resources

**ELEVATE Design System**:
- [ELEVATE Design Tokens](https://github.com/inform-elevate/elevate-design-tokens) - Official token source
- [ELEVATE Core UI](https://github.com/inform-elevate/elevate-core-ui) - Web component library
- [ELEVATE Icons](https://github.com/inform-elevate/elevate-icons) - Icon library

**Apple Documentation**:
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)

---

## Quick Reference Card

| Task | Command |
|------|---------|
| **Create new component** | `.wip` workflow → [guides/component-development.md](guides/component-development.md#quick-start-workflow) |
| **Update ELEVATE tokens** | `./scripts/elevate-update.sh preview` then `apply` |
| **Regenerate tokens manually** | `python3 scripts/update-design-tokens-v4.py --selective` |
| **Run tests** | `swift test` |
| **Check component status** | [reference/component-status.md](reference/component-status.md) |
| **Token hierarchy** | Component → Alias → Primitive (never use Primitive directly) |
| **Rollback update** | `./scripts/elevate-update.sh rollback` |

---

**Welcome to ELEVATE iOS! Start with the [Token System Overview](systems/token-system.md) to understand the foundation, then jump into [Component Development](guides/component-development.md) to start building.**

Last Updated: 2025-11-11 | Documentation Version: 2.0
