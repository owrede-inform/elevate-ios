# Claude Code Documentation

This directory contains Claude-specific implementation guides, reference documentation, and work artifacts.

## Directory Structure

```
.claude/
├── iOS-IMPLEMENTATION-GUIDE.md    ⭐ Main guide - START HERE
├── THEME-ARCHITECTURE.md          ⭐ Theme system design
│
├── components/                     # Web component reference docs (61 files)
│   ├── README.md                   # Component catalog
│   ├── Navigation/                 # Buttons, tabs, menus, breadcrumbs
│   ├── Forms/                      # Inputs, textareas, checkboxes, switches
│   ├── Display/                    # Badges, chips, tables, icons
│   ├── Structure/                  # Cards, panels, dividers
│   ├── Overlays/                   # Tooltips, dropdowns, popups
│   └── Feedback/                   # Progress, notifications
│
├── concepts/                       # Core iOS implementation concepts (3 files)
│   ├── design-token-hierarchy.md  ⚠️ CRITICAL - The Iron Rule
│   ├── ios-touch-guidelines.md    # Touch targets, states, accessibility
│   └── scroll-friendly-gestures.md # Gesture handling pattern
│
├── sessions/                       # Session-specific work notes
│   ├── README.md                   # Session index
│   └── YYYY-MM-DD-*.md            # Individual session notes
│
└── archived/                       # Completed work archive
    ├── README.md                   # Archive index
    └── *.md                        # Historical docs
```

## Usage Guide

### For Claude Code Sessions

**Starting a new session?**
1. Read [iOS-IMPLEMENTATION-GUIDE.md](iOS-IMPLEMENTATION-GUIDE.md) first
2. Review relevant [concepts/](concepts/) as needed
3. Reference [components/](components/) for web component specs

**Implementing a component?**
1. Read [concepts/design-token-hierarchy.md](concepts/design-token-hierarchy.md) ⚠️ CRITICAL
2. Check [components/[Category]/[component].md](components/) for web spec
3. Follow patterns in [iOS-IMPLEMENTATION-GUIDE.md](iOS-IMPLEMENTATION-GUIDE.md)

**Working on gestures or touch?**
1. Read [concepts/scroll-friendly-gestures.md](concepts/scroll-friendly-gestures.md)
2. Read [concepts/ios-touch-guidelines.md](concepts/ios-touch-guidelines.md)

### Document Types

**Implementation Guides** (How to build):
- `iOS-IMPLEMENTATION-GUIDE.md` - Main guide with patterns and examples
- `THEME-ARCHITECTURE.md` - Theme system architecture and design

**Reference Docs** (What to build):
- `components/*.md` - Original web component specifications
- **Note**: Ignore absolute RGB colors and CSS specifics; focus on behavior and API

**Core Concepts** (Critical patterns):
- `concepts/*.md` - iOS-specific patterns that MUST be followed

**Session Notes** (Work artifacts):
- `sessions/*.md` - Session-specific implementation notes and decisions

**Archives** (Historical):
- `archived/*.md` - Completed work, no longer active

## Key Files

### ⭐ Start Here

**[iOS-IMPLEMENTATION-GUIDE.md](iOS-IMPLEMENTATION-GUIDE.md)**
- Complete iOS implementation patterns
- Component development workflow
- Token usage examples
- Common mistakes and solutions

### ⚠️ Critical Concepts

**[concepts/design-token-hierarchy.md](concepts/design-token-hierarchy.md)**
- The Iron Rule: Component → Alias → NEVER Primitives
- Why it matters (dark mode, design system consistency)
- **Read this before writing ANY component code**

**[concepts/scroll-friendly-gestures.md](concepts/scroll-friendly-gestures.md)**
- Why standard gestures fail in ScrollViews
- UIControl-based solution
- Instant feedback pattern

**[concepts/ios-touch-guidelines.md](concepts/ios-touch-guidelines.md)**
- 44pt minimum touch targets
- State mapping (hover + active → pressed)
- Accessibility requirements

### 🏗️ Architecture

**[THEME-ARCHITECTURE.md](THEME-ARCHITECTURE.md)**
- Complete theme system design
- Token extraction pipeline
- Build integration strategy
- Future enhancements

## File Organization Rules

### What Goes Where

**Main Guides** (`.claude/` root):
- Comprehensive implementation guides
- Architecture design documents
- Cross-cutting concerns

**Components** (`.claude/components/`):
- Web component reference docs (from ELEVATE)
- Organized by category (Navigation, Forms, Display, etc.)
- Original specifications, not implementation notes

**Concepts** (`.claude/concepts/`):
- Core iOS patterns that apply across components
- Platform-specific guidelines
- Critical rules and principles

**Sessions** (`.claude/sessions/`):
- Date-stamped session notes
- Implementation decisions from specific work sessions
- Component-specific adaptations made during porting

**Archives** (`.claude/archived/`):
- Completed work summaries
- Resolved issues
- Historical context (no longer active)

### Naming Conventions

- **Guides**: `TOPIC-NAME.md` (e.g., `iOS-IMPLEMENTATION-GUIDE.md`)
- **Concepts**: `kebab-case.md` (e.g., `design-token-hierarchy.md`)
- **Sessions**: `YYYY-MM-DD-topic.md` (e.g., `2025-11-06-component-port.md`)
- **Components**: `component-name.md` (e.g., `button.md`, `text-field.md`)

## Cross-References

**For developer docs**, see:
- Root directory documentation (token extraction, component development, etc.)
- `/README.md` - Project overview
- `/INDEX.md` - Complete documentation index

**For implementation examples**, see:
- `ElevateUI/Sources/SwiftUI/Components/` - Implemented components
- `ElevateUI/Sources/DesignTokens/Components/` - Component token wrappers

## Contributing

When adding new documentation:
1. **Guides** → `.claude/` root if comprehensive and cross-component
2. **Concepts** → `.claude/concepts/` if core pattern applicable to all components
3. **Sessions** → `.claude/sessions/` if session-specific work notes
4. **Component Specs** → `.claude/components/[Category]/` (usually from web repo)

Keep this README updated when structure changes.

---

**Last Updated**: 2025-11-06
