# Changelog

All notable changes to the ELEVATE iOS UI Kit will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Planned Features
- Text field component
- Card component
- Badge component
- Avatar component
- Checkbox component
- Radio button component
- Switch component
- Progress indicator component
- Alert/Toast component
- Modal/Dialog component

## [0.1.0] - 2025-01-XX (Initial Release)

### Added

#### Design Tokens
- **Colors**: Complete color system with semantic naming
  - Brand colors (primary, secondary)
  - Semantic colors (success, warning, danger, info)
  - Neutral colors (background, surface, text, border)
  - Component-specific color tokens
  - Support for light and dark themes
  - UIKit compatibility wrappers

- **Typography**: Comprehensive typography system
  - Display styles (large, medium, small)
  - Heading styles (large, medium, small, extra small)
  - Title styles (large, medium, small)
  - Body text styles (large, medium, small)
  - Label styles (large, medium, small, extra small)
  - Code/monospace styles
  - Inter font family (primary)
  - Roboto Mono font family (monospace)
  - UIKit compatibility wrappers

- **Spacing**: Consistent spacing scale
  - Base spacing scale (xxs to xxxl)
  - Semantic spacing (component gap, section gap, margins)
  - Border radius tokens
  - Border width tokens
  - Component size system
  - Icon sizes
  - Elevation/shadow system
  - SwiftUI helper extensions

#### Components

- **ElevateButton (SwiftUI)**
  - 8 tone variants (primary, secondary, success, warning, danger, emphasized, subtle, neutral)
  - 3 size variants (small, medium, large)
  - 2 shape variants (default, pill)
  - State handling (default, hover, active, disabled)
  - Full design token integration
  - Interactive press animations
  - Accessibility support

- **ElevateButton (UIKit)**
  - Same features as SwiftUI version
  - Interface Builder support (@IBDesignable, @IBInspectable)
  - Auto layout constraints
  - Proper state handling
  - Touch event animations
  - Accessibility support

#### Infrastructure

- **Swift Package Manager**: Package.swift for easy integration
- **Example App**: Comprehensive demo app showcasing all components
  - Button examples (all tones, sizes, shapes, states)
  - Typography showcase
  - Color palette viewer
  - Spacing system demonstration
  - Interactive examples

- **Testing**: Unit test suite
  - Design token validation
  - Component initialization tests
  - Size and spacing calculations

- **Documentation**
  - Comprehensive README with usage examples
  - Quick start guide
  - Contributing guidelines
  - Inline code documentation
  - SwiftUI previews for all components

### Design System

- Based on ELEVATE Core UI v0.36.1
- Implements ELEVATE Design System tokens
- Maintains design consistency with web components
- Native iOS patterns and conventions

### Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

---

## Release Notes

### v0.1.0 - Initial Release

This is the first release of the ELEVATE iOS UI Kit, providing a foundation for building iOS applications that follow the ELEVATE Design System. The framework includes:

**Core Features:**
- Complete design token system (colors, typography, spacing)
- Button component for both SwiftUI and UIKit
- Full light and dark theme support
- Comprehensive example application
- Unit test coverage

**Framework Architecture:**
- Dual SwiftUI/UIKit support
- Type-safe design token access
- Extensible component system
- SPM-based distribution

**What's Next:**
The roadmap includes additional form components (text fields, checkboxes, switches), feedback components (alerts, toasts), and container components (cards, modals). See the "Unreleased" section above for the complete planned feature list.

---

[Unreleased]: https://github.com/your-org/elevate-ios/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/your-org/elevate-ios/releases/tag/v0.1.0
