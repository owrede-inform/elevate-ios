# Contributing to ELEVATE iOS UI Kit

Thank you for your interest in contributing to the ELEVATE iOS UI Kit! This document provides guidelines and instructions for contributing.

## Development Setup

### Prerequisites

- macOS with Xcode 14.0 or later
- Swift 5.7 or later
- Git

### Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-org/elevate-ios.git
   cd elevate-ios
   ```

2. **Open in Xcode**
   ```bash
   open Package.swift
   ```

   Or double-click `Package.swift` in Finder to open the project in Xcode.

3. **Build the framework**
   - Select the `ElevateUI` scheme
   - Press `Cmd + B` to build

4. **Run the example app**
   - Select the `ElevateUIDemo` scheme
   - Press `Cmd + R` to run

5. **Run tests**
   - Select the `ElevateUI` scheme
   - Press `Cmd + U` to run tests

## Project Structure

```
elevate-ios/
├── ElevateUI/
│   └── Sources/
│       ├── DesignTokens/     # Design token definitions
│       │   ├── Colors/
│       │   ├── Typography/
│       │   ├── Spacing/
│       │   └── Components/
│       ├── SwiftUI/          # SwiftUI components
│       │   └── Components/
│       ├── UIKit/            # UIKit components
│       │   └── Components/
│       └── Resources/        # Color assets, fonts, etc.
├── ElevateUITests/           # Unit tests
├── Examples/
│   └── ElevateUIDemo/       # Example app
└── Package.swift            # Swift Package Manager manifest
```

## Adding New Components

### 1. Define Component Tokens

If your component requires specific design tokens, create them in `ElevateUI/Sources/DesignTokens/Components/`:

```swift
// ExampleComponentTokens.swift
import SwiftUI

public struct ExampleComponentTokens {
    public enum Variant {
        case primary
        case secondary
    }

    // Define component-specific tokens here
}
```

### 2. Create SwiftUI Component

Create the SwiftUI component in `ElevateUI/Sources/SwiftUI/Components/`:

```swift
// ElevateExampleComponent.swift
import SwiftUI

public struct ElevateExampleComponent: View {
    // Implementation
}
```

### 3. Create UIKit Component

Create the UIKit component in `ElevateUI/Sources/UIKit/Components/`:

```swift
// ElevateExampleComponent.swift
import UIKit

@IBDesignable
open class ElevateExampleComponent: UIView {
    // Implementation
}
```

### 4. Add Tests

Create tests in `ElevateUITests/`:

```swift
func testExampleComponent() {
    // Test implementation
}
```

### 5. Add to Example App

Add an example to `Examples/ElevateUIDemo/Sources/ContentView.swift` demonstrating the component's usage.

## Design Token Guidelines

### Color Tokens

- Use semantic naming (e.g., `primary`, `success`, `danger`)
- Support both light and dark themes
- Provide UIKit compatibility wrappers

### Typography Tokens

- Follow platform conventions (San Francisco for system, Inter for custom)
- Define all font weights and sizes
- Provide both SwiftUI `Font` and UIKit `UIFont` versions

### Spacing Tokens

- Use a consistent scale (e.g., 4pt, 8pt, 12pt, 16pt)
- Provide semantic names for common use cases
- Include helper extensions for easy application

## Code Style

### Swift Style Guide

- Follow [Swift API Design Guidelines](https://swift.org/documentation/api-design-guidelines/)
- Use descriptive variable and function names
- Add documentation comments for public APIs

### Documentation

All public APIs should have documentation comments:

```swift
/// Brief description of the component
///
/// Longer description explaining the component's purpose,
/// behavior, and any important details.
///
/// Example usage:
/// ```swift
/// ElevateButton(title: "Click me", tone: .primary) {
///     print("Tapped")
/// }
/// ```
///
/// - Parameters:
///   - title: The button's label text
///   - tone: The button's visual style
///   - action: Closure to execute when tapped
public struct ElevateButton: View {
    // ...
}
```

### SwiftUI Best Practices

- Prefer composition over inheritance
- Use `@State` for internal state, `@Binding` for external state
- Separate complex views into smaller, reusable components
- Use view modifiers for reusable styling

### UIKit Best Practices

- Support Interface Builder with `@IBDesignable` and `@IBInspectable`
- Provide proper auto-layout constraints
- Handle dark mode and dynamic type
- Follow accessibility guidelines

## Testing

### Unit Tests

- Test all public APIs
- Test edge cases and error conditions
- Aim for high test coverage (>80%)

### Visual Testing

- Add SwiftUI previews for components
- Test in both light and dark modes
- Test different size classes and device sizes

## Submitting Changes

### Pull Request Process

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Write clear, concise commit messages
   - Follow the code style guidelines
   - Add tests for new functionality

3. **Test your changes**
   ```bash
   # Run tests
   swift test

   # Or in Xcode
   # Cmd + U
   ```

4. **Update documentation**
   - Update README.md if needed
   - Add inline code documentation
   - Update example app if adding new components

5. **Submit pull request**
   - Provide a clear description of changes
   - Reference any related issues
   - Request review from maintainers

### Commit Message Format

```
type(scope): brief description

Longer description explaining the change and why it was made.

Fixes #issue-number
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style changes (formatting, etc.)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

## Design System Alignment

### Staying Aligned with ELEVATE Core UI

This iOS kit is based on the [ELEVATE Core UI](https://github.com/inform-elevate/elevate-core-ui) web component library. When adding or modifying components:

1. **Reference the web implementation**
   - Check how the component is implemented in ELEVATE Core UI
   - Match the design tokens and behavior

2. **Adapt for iOS**
   - Use native iOS patterns and conventions
   - Leverage platform-specific features
   - Ensure the component feels native while maintaining design consistency

3. **Document differences**
   - If the iOS implementation differs from web, document why
   - Note any platform-specific limitations or enhancements

## Questions or Issues?

- **Design questions**: Reference the [ELEVATE Core UI Storybook](https://elevate-core-ui.inform-cloud.io)
- **Technical questions**: Open a discussion on GitHub
- **Bug reports**: Open an issue with reproduction steps

## License

By contributing to ELEVATE iOS UI Kit, you agree that your contributions will be licensed under the project's UNLICENSED license.
