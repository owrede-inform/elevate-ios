# ELEVATE iOS Documentation Index

Quick navigation to all project documentation.

## Getting Started

- [README](README.md) - Project overview
- [QUICKSTART](QUICKSTART.md) - Get up and running in 5 minutes
- [SETUP](SETUP.md) - Detailed setup instructions
- [CONTRIBUTING](CONTRIBUTING.md) - How to contribute

## Core Documentation (Essential Reading)

Located in `/docs/`:

- **[Architecture Overview](docs/ARCHITECTURE.md)** - System architecture and design decisions
- **[Token System](docs/TOKEN_SYSTEM.md)** - Complete token extraction and generation guide ⭐
- **[Component Development](docs/COMPONENT_DEVELOPMENT.md)** - How to build and refactor components ⭐
- **[Web-to-iOS Translation](docs/WEB_TO_IOS_TRANSLATION.md)** - Web component porting guide
- **[Automation](docs/AUTOMATION.md)** - Build automation and scripts

## Claude Implementation Guides

Located in `.claude/`:

- **[iOS Implementation Guide](.claude/iOS-IMPLEMENTATION-GUIDE.md)** ⭐ **START HERE for Claude**
- [Theme Architecture](.claude/THEME-ARCHITECTURE.md) - Theme system design
- [Component Reference](.claude/components/README.md) - Web component docs

### Core Concepts (Critical Reading)

- **[Design Token Hierarchy](.claude/concepts/design-token-hierarchy.md)** ⚠️ **MUST READ**
- [iOS Touch Guidelines](.claude/concepts/ios-touch-guidelines.md)
- [Scroll-Friendly Gestures](.claude/concepts/scroll-friendly-gestures.md)

### Session Notes

- [Session Index](.claude/sessions/README.md) - Implementation session notes

### Archived Work

- [Archive Index](.claude/archived/README.md) - Completed work and resolved issues

## Quick Reference

### Common Tasks

- **Add new component**: See [Component Development](docs/COMPONENT_DEVELOPMENT.md#quick-start-workflow)
- **Update design tokens**: Run `python3 scripts/update-design-tokens-v4.py` ([details](docs/AUTOMATION.md#one-command-token-update))
- **Port web component**: See [Web-to-iOS Translation](docs/WEB_TO_IOS_TRANSLATION.md)
- **Fix token issues**: See [Token System Troubleshooting](docs/TOKEN_SYSTEM.md#troubleshooting)
- **Understand architecture**: See [Architecture Overview](docs/ARCHITECTURE.md)

### Key Rules

1. **Token Hierarchy**: Component → Alias → NEVER Primitives ([details](.claude/concepts/design-token-hierarchy.md))
2. **Touch Targets**: Minimum 44pt × 44pt ([details](.claude/concepts/ios-touch-guidelines.md))
3. **Scroll Gestures**: Use `.scrollFriendlyTap()` ([details](.claude/concepts/scroll-friendly-gestures.md))
4. **Incremental Dev**: Use `.wip` file extensions ([details](docs/COMPONENT_DEVELOPMENT.md#incremental-development-strategy))

## Project Structure

```
elevate-ios/
├── .claude/               # Claude implementation guides & artifacts
│   ├── components/        # Web component reference docs (61 files)
│   ├── concepts/          # Core iOS patterns (3 files)
│   ├── sessions/          # Session-specific work notes
│   └── archived/          # Completed work archive
├── docs/                  # (Future) Consolidated technical docs
├── ElevateUI/             # Main framework
├── ElevateUIExample/      # Example application
└── scripts/               # Automation scripts
```

## External Resources

- [ELEVATE Core UI (Web)](https://github.com/inform-elevate/elevate-core-ui)
- [Apple HIG](https://developer.apple.com/design/human-interface-guidelines/)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)

---

**Last Updated**: 2025-11-06
