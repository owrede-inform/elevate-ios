# Component Authoring Guide

## Overview

This guide outlines the standardized approach for creating ELEVATE UI components in SwiftUI, ensuring consistency, maintainability, and adherence to ELEVATE design system principles.

## Component Architecture

### Three-Tier Token System
```
ElevateUI Component
       ↓
Component Tokens (semantic wrapper)
       ↓
Generated Component Tokens
       ↓
Alias Tokens → Primitive Tokens
```

**Never bypass this hierarchy.** Always access tokens through the semantic wrapper layer.

## Standard Component Structure

### File Organization
```
ElevateUI/Sources/
├── SwiftUI/Components/
│   └── Elevate{Component}+SwiftUI.swift    # Component implementation
├── UIKit/Components/
│   └── Elevate{Component}+UIKit.swift      # UIKit bridge (optional)
└── DesignTokens/Components/
    └── {Component}Tokens.swift             # Token wrapper
```

### Naming Conventions
- **Component files**: `Elevate{Component}+SwiftUI.swift` (e.g., `ElevateButton+SwiftUI.swift`)
- **Component struct**: `Elevate{Component}` (e.g., `ElevateButton`)
- **Token wrapper**: `{Component}Tokens` (e.g., `ButtonTokens`)
- **Generated tokens**: `{Component}ComponentTokens` (auto-generated)

## Component Template

```swift
#if os(iOS)
import SwiftUI

/// {Component Name} following ELEVATE design system
///
/// Brief description of component purpose and usage.
///
/// Example:
/// ```swift
/// Elevate{Component}(
///     tone: .primary,
///     size: .medium
/// ) {
///     Text("Label")
/// }
/// ```
@available(iOS 15, *)
public struct Elevate{Component}<Content: View>: View {

    // MARK: - Public Properties

    private let tone: {Component}Tokens.Tone
    private let size: {Component}Tokens.Size
    private let content: () -> Content

    // MARK: - State

    @State private var isHovered = false
    @State private var isPressed = false
    @Environment(\.isEnabled) private var isEnabled

    // MARK: - Initialization

    public init(
        tone: {Component}Tokens.Tone = .primary,
        size: {Component}Tokens.Size = .medium,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.tone = tone
        self.size = size
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        let toneColors = tone.colors
        let sizeConfig = size.config

        content()
            .frame(height: sizeConfig.height)
            .padding(.horizontal, sizeConfig.padding)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(sizeConfig.borderRadius)
            .accessibilityAddTraits(isEnabled ? [] : .isButton)
    }

    // MARK: - Computed Properties

    private var backgroundColor: Color {
        let colors = tone.colors
        if !isEnabled { return colors.backgroundDisabled }
        if isPressed { return colors.backgroundActive }
        if isHovered { return colors.backgroundHover }
        return colors.background
    }

    private var textColor: Color {
        let colors = tone.colors
        if !isEnabled { return colors.textDisabled }
        if isHovered { return colors.textHover }
        return colors.text
    }
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension Elevate{Component} where Content == Text {
    public init(
        _ title: String,
        tone: {Component}Tokens.Tone = .primary,
        size: {Component}Tokens.Size = .medium
    ) {
        self.init(tone: tone, size: size) {
            Text(title)
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct Elevate{Component}_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Tone variants
            ForEach([
                {Component}Tokens.Tone.primary,
                .success,
                .warning,
                .danger
            ], id: \.self) { tone in
                Elevate{Component}("Label", tone: tone)
            }

            // Size variants
            ForEach([
                {Component}Tokens.Size.small,
                .medium,
                .large
            ], id: \.self) { size in
                Elevate{Component}("Label", size: size)
            }

            // Disabled state
            Elevate{Component}("Disabled", tone: .primary)
                .disabled(true)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif

#endif
```

## Component Checklist

### Required Elements
- [ ] `@available(iOS 15, *)` annotation
- [ ] `#if os(iOS)` / `#endif` platform guards
- [ ] Comprehensive documentation with example
- [ ] Token wrapper integration (`{Component}Tokens`)
- [ ] Size variants (small, medium, large)
- [ ] Tone variants (primary, success, warning, danger, etc.)
- [ ] State handling (default, hover, active, disabled)
- [ ] Accessibility support
- [ ] Preview provider with all variants
- [ ] Convenience initializers (when applicable)

### Optional Elements
- [ ] Shape variants (box, pill)
- [ ] Icon support
- [ ] Selection state
- [ ] Loading state
- [ ] Custom content support via ViewBuilder

## State Management

### Standard States
```swift
@State private var isHovered = false
@State private var isPressed = false
@State private var isFocused = false
@State private var isSelected = false
@Environment(\.isEnabled) private var isEnabled
```

### State Priority
When multiple states are active, apply in this order:
1. **Disabled** (highest priority)
2. **Pressed/Active**
3. **Hovered**
4. **Selected**
5. **Default** (lowest priority)

### State Resolution Pattern
```swift
private var backgroundColor: Color {
    let colors = tone.colors
    if !isEnabled { return colors.backgroundDisabled }
    if isPressed { return colors.backgroundActive }
    if isHovered { return colors.backgroundHover }
    if isSelected { return colors.backgroundSelected }
    return colors.background
}
```

## Accessibility

### Required Accessibility Support
```swift
.accessibilityElement()
.accessibilityLabel(accessibilityLabel)
.accessibilityHint(accessibilityHint)
.accessibilityAddTraits(accessibilityTraits)
.accessibilityValue(accessibilityValue)  // For stateful components
```

### Common Traits
- `.isButton` - For interactive buttons
- `.isSelected` - For selectable components
- `.isHeader` - For heading components
- `.isLink` - For link components

### Accessibility Labels
Provide clear, descriptive labels:
```swift
.accessibilityLabel("\(tone) \(size) button")
.accessibilityHint("Tap to activate")
```

## Preview Guidelines

### Standard Preview Structure
```swift
#if DEBUG
@available(iOS 15, *)
struct Elevate{Component}_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 24) {
                previewSection(title: "Tones", content: toneVariants)
                previewSection(title: "Sizes", content: sizeVariants)
                previewSection(title: "States", content: stateVariants)
            }
            .padding()
        }
        .previewDisplayName("Elevate{Component}")
    }

    @ViewBuilder
    static var toneVariants: some View {
        ForEach(allTones, id: \.self) { tone in
            Elevate{Component}("\(tone)", tone: tone)
        }
    }

    @ViewBuilder
    static var sizeVariants: some View {
        ForEach(allSizes, id: \.self) { size in
            Elevate{Component}("Size \(size)", size: size)
        }
    }

    @ViewBuilder
    static var stateVariants: some View {
        VStack(alignment: .leading, spacing: 12) {
            Elevate{Component}("Default")
            Elevate{Component}("Disabled").disabled(true)
            Elevate{Component}("Selected").selected(true) // If applicable
        }
    }

    @ViewBuilder
    static func previewSection<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content()
        }
    }
}
#endif
```

## Token Integration

### Using Token Wrappers
Always access tokens through semantic wrappers:

```swift
// ✅ CORRECT
let toneColors = ButtonTokens.Tone.primary.colors
let backgroundColor = toneColors.background

// ❌ INCORRECT - Don't access component tokens directly
let backgroundColor = ButtonComponentTokens.fill_primary_default

// ❌ INCORRECT - Never bypass to primitives
let backgroundColor = ElevatePrimitives.Blue._color_blue_500
```

### Token Hierarchy
```
Your Component
    ↓
ComponentTokens (wrapper)
    ↓
Generated ComponentTokens
    ↓
ElevateAliases
    ↓
ElevatePrimitives
```

## Common Patterns

### Pattern 1: Content-Based Components
Components that wrap user content (Button, Card, Chip):
```swift
public struct ElevateComponent<Content: View>: View {
    private let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        content()
            .applyComponentStyle()
    }
}
```

### Pattern 2: Text-Only Components
Components with text-only convenience initializer:
```swift
extension ElevateComponent where Content == Text {
    public init(_ title: String) {
        self.init { Text(title) }
    }
}
```

### Pattern 3: Interactive Components
Components with hover/press states:
```swift
@State private var isHovered = false
@State private var isPressed = false

var body: some View {
    content()
        .onHover { isHovered = $0 }
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
}
```

### Pattern 4: Form Components
Components with binding support:
```swift
public struct ElevateFormComponent: View {
    @Binding private var value: String

    public init(value: Binding<String>) {
        self._value = value
    }
}
```

## Testing Guidelines

### Build Verification
```bash
swift build
```

### Component Checklist
1. All tone variants render correctly
2. All size variants have proper dimensions
3. Disabled state is visually distinct
4. Hover states work on macOS/iPad
5. Accessibility labels are descriptive
6. Dark mode colors adapt correctly
7. Component builds without warnings

## Performance Considerations

### State Management
- Use `@State` for component-local state
- Use `@Binding` for parent-child communication
- Avoid unnecessary state variables
- Use `@Environment` for system-wide state

### View Updates
```swift
// ✅ Efficient - computed once per render
private var backgroundColor: Color {
    resolveColor()
}

// ❌ Inefficient - computed multiple times
.background(resolveColor())
.foregroundColor(resolveColor())
```

### Token Access
```swift
// ✅ Efficient - tokens resolved once
let toneColors = tone.colors
let sizeConfig = size.config

// ❌ Inefficient - repeated token lookups
.frame(height: tone.colors.background)
.padding(tone.colors.padding)
```

## Common Pitfalls

### 1. Direct Token Access
```swift
// ❌ BAD
ButtonComponentTokens.fill_primary_default

// ✅ GOOD
ButtonTokens.Tone.primary.colors.background
```

### 2. Missing Platform Guards
```swift
// ❌ BAD - Works on iOS only
public struct ElevateButton: View { }

// ✅ GOOD - Conditional compilation
#if os(iOS)
@available(iOS 15, *)
public struct ElevateButton: View { }
#endif
```

### 3. Hardcoded Values
```swift
// ❌ BAD
.padding(16)
.cornerRadius(8)

// ✅ GOOD
.padding(sizeConfig.padding)
.cornerRadius(sizeConfig.borderRadius)
```

### 4. State Logic in View Body
```swift
// ❌ BAD
var body: some View {
    Text("Hello")
        .foregroundColor(isEnabled ? .blue : .gray)
}

// ✅ GOOD
var body: some View {
    Text("Hello")
        .foregroundColor(textColor)
}

private var textColor: Color {
    isEnabled ? .blue : .gray
}
```

## Documentation Standards

### Component Documentation
```swift
/// {Component Name} following ELEVATE design system
///
/// {Brief description of component purpose}
///
/// ## Features
/// - Multiple tone variants (primary, success, warning, danger)
/// - Three size options (small, medium, large)
/// - Full state support (default, hover, active, disabled)
/// - Accessibility support
///
/// ## Example
/// ```swift
/// Elevate{Component}(
///     tone: .primary,
///     size: .medium
/// ) {
///     Text("Label")
/// }
/// ```
///
/// ## Accessibility
/// The component provides proper accessibility labels and traits.
/// Use `accessibilityLabel(_:)` to customize the label.
```

### Property Documentation
```swift
/// The visual tone of the component
///
/// Determines the color scheme used. Available tones:
/// - `.primary`: Brand primary colors
/// - `.success`: Success state colors
/// - `.warning`: Warning state colors
/// - `.danger`: Danger/error state colors
private let tone: {Component}Tokens.Tone
```

## Reference Implementations

See these components for complete examples:
- **Simple**: `ElevateBadge`, `ElevateHeadline`
- **Interactive**: `ElevateButton`, `ElevateChip`
- **Form**: `ElevateSwitch`, `ElevateCheckbox`, `ElevateTextField`
- **Layout**: `ElevateCard`, `ElevateStack`
- **Navigation**: `ElevateStepper`, `ElevateBreadcrumb`

## Next Steps

1. Review [Token Wrapper Guide](TOKEN_WRAPPER_GUIDE.md) for token wrapper creation
2. Check existing components for reference
3. Create token wrapper before component implementation
4. Test all variants in Preview
5. Verify accessibility support
6. Build and test
