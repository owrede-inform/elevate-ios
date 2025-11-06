# Web-to-iOS Component Translation Guide

## Overview

This guide defines the process for translating ELEVATE Web Components to iOS (SwiftUI + UIKit) implementations. It ensures consistency, maintains API fidelity, and adapts web patterns to iOS best practices.

## Translation Philosophy

### Core Principles

1. **API Fidelity**: Preserve the intent and functionality of web component APIs
2. **Platform Adaptation**: Use iOS patterns where web patterns don't apply
3. **Token Hierarchy**: Always use Component → Alias → Primitive token chain
4. **Dual Implementation**: Provide both SwiftUI (primary) and UIKit (bridging) versions
5. **Accessibility First**: Maintain or exceed web component accessibility

### What NOT to Translate

**Web-Specific Concepts** (Skip these):
- `href`, `target`, `rel`, `download` attributes → Use native navigation patterns
- `type="submit"`, `type="reset"` → Use SwiftUI Form/UIKit delegate patterns
- CSS Parts and CSS Properties → Use SwiftUI modifiers/UIKit properties
- Custom Events → Use SwiftUI bindings/@Binding or UIKit delegates
- Slots → Use ViewBuilder in SwiftUI, composition in UIKit

## Component Translation Matrix

### 1. Properties Translation

| Web Attribute | iOS SwiftUI | iOS UIKit | Notes |
|---------------|-------------|-----------|-------|
| `disabled: boolean` | `disabled: Bool` | `isEnabled: Bool` | Invert logic for UIKit |
| `selected: boolean` | `isSelected: Bool` | `isSelected: Bool` | Standard iOS naming |
| `tone: string` | `tone: Tone` enum | `tone: Tone` enum | Strongly typed enum |
| `size: string` | `size: Size` enum | `size: Size` enum | Strongly typed enum |
| `shape: string` | `shape: Shape` enum | `shape: Shape` enum | Strongly typed enum |
| `padding: string` | `padding: EdgeInsets?` | `contentEdgeInsets` | iOS-native spacing |
| `pulse: boolean` | `isPulsing: Bool` | `isPulsing: Bool` | Animation property |

### 2. Slots Translation

| Web Slot | SwiftUI | UIKit | Pattern |
|----------|---------|-------|---------|
| *(default)* | `label: String` or `content: () -> Content` | `setTitle()` or `contentView` | ViewBuilder or string |
| `prefix` | `prefix: () -> Prefix` | `prefixView: UIView?` | Optional ViewBuilder |
| `suffix` | `suffix: () -> Suffix` | `suffixView: UIView?` | Optional ViewBuilder |

**SwiftUI Pattern:**
```swift
struct Component<Prefix: View, Content: View, Suffix: View> {
    @ViewBuilder var prefix: () -> Prefix
    @ViewBuilder var content: () -> Content
    @ViewBuilder var suffix: () -> Suffix
}
```

**UIKit Pattern:**
```swift
class Component: UIView {
    var prefixView: UIView? { didSet { updateLayout() } }
    var contentView: UIView? { didSet { updateLayout() } }
    var suffixView: UIView? { didSet { updateLayout() } }
}
```

### 3. Events Translation

| Web Event | SwiftUI | UIKit | Pattern |
|-----------|---------|-------|---------|
| `@click` | `action: () -> Void` | `addTarget(_:action:for: .touchUpInside)` | Standard tap |
| `@request-remove` | `onRemove: (() -> Void)?` | `delegate?.didRequestRemove()` | Optional closure/delegate |
| `@request-edit` | `onEdit: (() -> Void)?` | `delegate?.didRequestEdit()` | Optional closure/delegate |
| `@focus` | `@FocusState` | `becomeFirstResponder()` | Focus management |

### 4. Methods Translation

| Web Method | SwiftUI | UIKit | Pattern |
|------------|---------|-------|---------|
| `focus()` | `@FocusState + .focused()` | `becomeFirstResponder()` | Focus programmatically |
| `blur()` | `@FocusState + .focused(false)` | `resignFirstResponder()` | Remove focus |
| `click()` | Invoke `action` closure | `sendActions(for: .touchUpInside)` | Programmatic trigger |

## Component Structure Template

### SwiftUI Component

```swift
#if os(iOS)
import SwiftUI

/// ELEVATE [Component] Component
///
/// [Description from web component]
///
/// **Web Component:** `<elvt-[component]>`
/// **API Reference:** `.claude/components/[Category]/[component].md`
@available(iOS 15, *)
public struct Elevate[Component]<Prefix: View, Suffix: View>: View {

    // MARK: - Properties

    /// [Description]
    public var tone: [Component]Tokens.Tone

    /// [Description]
    public var size: [Component]Tokens.Size

    /// [Description]
    public var isDisabled: Bool

    /// [Description]
    public var isSelected: Bool

    /// [Description]
    public var shape: [Component]Tokens.Shape

    // MARK: - Content

    private let label: String
    private let prefix: () -> Prefix
    private let suffix: () -> Suffix

    // MARK: - Actions

    private let action: (() -> Void)?
    private let onRemove: (() -> Void)?

    // MARK: - Initializers

    /// Create [component] with all options
    public init(
        label: String,
        tone: [Component]Tokens.Tone = .neutral,
        size: [Component]Tokens.Size = .medium,
        shape: [Component]Tokens.Shape = .box,
        isDisabled: Bool = false,
        isSelected: Bool = false,
        action: (() -> Void)? = nil,
        @ViewBuilder prefix: @escaping () -> Prefix = { EmptyView() },
        @ViewBuilder suffix: @escaping () -> Suffix = { EmptyView() }
    ) {
        self.label = label
        self.tone = tone
        self.size = size
        self.shape = shape
        self.isDisabled = isDisabled
        self.isSelected = isSelected
        self.action = action
        self.prefix = prefix
        self.suffix = suffix
    }

    // MARK: - Body

    public var body: some View {
        Button(action: { action?() }) {
            HStack(spacing: tokenSpacing) {
                prefix()
                Text(label)
                    .font(tokenFont)
                suffix()
            }
            .padding(tokenPadding)
        }
        .foregroundColor(tokenTextColor)
        .background(tokenBackgroundColor)
        .cornerRadius(tokenCornerRadius)
        .disabled(isDisabled)
    }

    // MARK: - Token Accessors

    private var tokenBackgroundColor: Color {
        let colors = [Component]Tokens.colors(for: tone)
        if isSelected {
            return colors.backgroundSelected
        }
        return isDisabled ? colors.backgroundDisabled : colors.background
    }

    // ... more token accessors
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension Elevate[Component] where Prefix == EmptyView, Suffix == EmptyView {
    /// Create [component] with label only
    public init(
        _ label: String,
        tone: [Component]Tokens.Tone = .neutral,
        size: [Component]Tokens.Size = .medium,
        action: (() -> Void)? = nil
    ) {
        self.init(
            label: label,
            tone: tone,
            size: size,
            action: action
        )
    }
}

#endif
```

### UIKit Component

```swift
#if os(iOS)
import UIKit

/// ELEVATE [Component] Component (UIKit)
///
/// UIKit wrapper around SwiftUI implementation
@available(iOS 15, *)
@IBDesignable
public class ElevateUIKit[Component]: UIControl {

    // MARK: - Properties

    @IBInspectable
    public var label: String = "" {
        didSet { updateConfiguration() }
    }

    public var tone: [Component]Tokens.Tone = .neutral {
        didSet { updateConfiguration() }
    }

    public var size: [Component]Tokens.Size = .medium {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public override var isEnabled: Bool {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public override var isSelected: Bool {
        didSet { updateConfiguration() }
    }

    // MARK: - Views

    private let hostingController: UIHostingController<Elevate[Component]<AnyView, AnyView>>

    public var prefixView: UIView? {
        didSet { updateConfiguration() }
    }

    public var suffixView: UIView? {
        didSet { updateConfiguration() }
    }

    // MARK: - Initialization

    public override init(frame: CGRect) {
        let swiftUIView = Elevate[Component](label: "")
        self.hostingController = UIHostingController(rootView: swiftUIView)
        super.init(frame: frame)
        setupHostingController()
    }

    required init?(coder: NSCoder) {
        let swiftUIView = Elevate[Component](label: "")
        self.hostingController = UIHostingController(rootView: swiftUIView)
        super.init(coder: coder)
        setupHostingController()
    }

    // MARK: - Setup

    private func setupHostingController() {
        hostingController.view.backgroundColor = .clear
        addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func updateConfiguration() {
        let swiftUIView = Elevate[Component](
            label: label,
            tone: tone,
            size: size,
            isDisabled: !isEnabled,
            isSelected: isSelected,
            action: { [weak self] in
                self?.sendActions(for: .touchUpInside)
            }
        )
        hostingController.rootView = swiftUIView
    }
}

#endif
```

## Token Usage Patterns

### Component Token Structure

```swift
public struct [Component]Tokens {

    // MARK: - Enums

    public enum Tone {
        case primary, secondary, success, warning, danger, neutral
    }

    public enum Size {
        case small, medium, large
    }

    public enum Shape {
        case box, pill
    }

    // MARK: - Color Configuration

    public struct ColorSet {
        let background: Color
        let backgroundHover: Color
        let backgroundActive: Color
        let backgroundDisabled: Color
        let backgroundSelected: Color
        let text: Color
        let textDisabled: Color
        let border: Color

        // Maps to component tokens that reference aliases
        static let primary = ColorSet(
            background: /* component token → alias → primitive */,
            backgroundHover: /* ... */,
            // ...
        )
    }

    // MARK: - Sizing

    public static func height(for size: Size) -> CGFloat {
        switch size {
        case .small: return 32
        case .medium: return 40
        case .large: return 48
        }
    }

    public static func padding(for size: Size) -> EdgeInsets {
        switch size {
        case .small: return EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12)
        case .medium: return EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        case .large: return EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        }
    }

    public static func cornerRadius(for shape: Shape, size: Size) -> CGFloat {
        switch shape {
        case .box: return 4
        case .pill: return height(for: size) / 2
        }
    }
}
```

## iOS-Specific Adaptations

### 1. Navigation (href/link buttons)

**Web Pattern:**
```html
<elvt-button href="/page" target="_blank">Link</elvt-button>
```

**iOS Pattern:**
```swift
// Don't translate href - use NavigationLink instead
NavigationLink(destination: DestinationView()) {
    ElevateButton("Go to Page")
}

// Or programmatic navigation
ElevateButton("Go to Page") {
    navigationController?.pushViewController(dest, animated: true)
}
```

### 2. Form Submission (type="submit")

**Web Pattern:**
```html
<form>
    <elvt-button type="submit">Submit</elvt-button>
</form>
```

**iOS Pattern:**
```swift
// SwiftUI Form
Form {
    // ... form fields
}
.onSubmit {
    // Handle submission
}

ElevateButton("Submit") {
    handleFormSubmission()
}
```

### 3. Custom Events

**Web Pattern:**
```javascript
chip.addEventListener('elvt-request-remove', (e) => {
    // Handle remove
});
```

**iOS SwiftUI Pattern:**
```swift
ElevateChip("Label", removable: true) {
    // onRemove closure
    handleRemove()
}
```

**iOS UIKit Pattern:**
```swift
protocol ElevateChipDelegate: AnyObject {
    func chipDidRequestRemove(_ chip: ElevateUIKitChip)
}

chip.delegate = self
// Implement delegate method
```

### 4. Animations

**Pulse Animation:**
```swift
// Add animation modifier
.modifier(PulseAnimation(isEnabled: isPulsing))

struct PulseAnimation: ViewModifier {
    let isEnabled: Bool
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isEnabled && isAnimating ? 1.1 : 1.0)
            .opacity(isEnabled && isAnimating ? 0.8 : 1.0)
            .animation(
                isEnabled ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default,
                value: isAnimating
            )
            .onAppear {
                if isEnabled {
                    isAnimating = true
                }
            }
    }
}
```

### 5. Focus Management

**Web Pattern:**
```javascript
button.focus();
```

**iOS SwiftUI Pattern:**
```swift
@FocusState private var isFocused: Bool

ElevateButton("Focus Me")
    .focused($isFocused)

// Programmatic focus
isFocused = true
```

**iOS UIKit Pattern:**
```swift
button.becomeFirstResponder()
```

## Testing Checklist

When implementing a component, verify:

- [ ] All properties from web API are translated (or documented why skipped)
- [ ] Component tokens reference aliases (not hardcoded colors)
- [ ] Both SwiftUI and UIKit implementations provided
- [ ] Accessibility labels and hints included
- [ ] VoiceOver navigation works correctly
- [ ] Dynamic Type supported (text scales)
- [ ] Dark mode colors defined (future)
- [ ] All sizes render correctly
- [ ] All tones display proper colors
- [ ] Disabled state clearly visible
- [ ] Selected state distinguishable
- [ ] Animations smooth and appropriate
- [ ] iPad and iPhone layouts work
- [ ] Landscape orientation supported
- [ ] Build compiles without warnings
- [ ] Component documented with examples

## Documentation Template

```markdown
# [Component Name] Component

**Web Component:** `<elvt-[component]>`
**iOS SwiftUI:** `Elevate[Component]`
**iOS UIKit:** `ElevateUIKit[Component]`

## Usage

### SwiftUI

\```swift
Elevate[Component](
    "Label",
    tone: .primary,
    size: .medium
) {
    // Action
}
\```

### UIKit

\```swift
let component = ElevateUIKit[Component]()
component.label = "Label"
component.tone = .primary
component.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
\```

## API Translation

| Web Property | iOS Property | Notes |
|--------------|--------------|-------|
| ... | ... | ... |

## Differences from Web

- **Navigation**: Use `NavigationLink` instead of `href`
- **Events**: Use closures/delegates instead of custom events
- ...
```

## Update Process

When ELEVATE web component is updated:

1. **Check API Documentation**: Review `.claude/components/[Category]/[component].md`
2. **Identify Changes**: Note new properties, removed properties, behavior changes
3. **Update Tokens**: Run token extraction if design tokens changed
4. **Update Implementation**: Modify SwiftUI and UIKit implementations
5. **Update Tests**: Add tests for new functionality
6. **Update Documentation**: Document API changes and iOS adaptations
7. **Verify Build**: Ensure compilation and functionality
8. **Update Version**: Note web component version in documentation

## Common Patterns

### Convenience Initializers

Always provide convenience initializers for common use cases:

```swift
// Full API
ElevateButton(
    label: "Click",
    tone: .primary,
    size: .medium,
    shape: .box,
    isDisabled: false,
    isSelected: false,
    action: { },
    prefix: { EmptyView() },
    suffix: { EmptyView() }
)

// Convenience - most common
ElevateButton("Click", tone: .primary) {
    // action
}

// Convenience - with prefix
ElevateButton("Click", tone: .primary) {
    Image(systemName: "star.fill")
} suffix: {
    EmptyView()
} action: {
    // action
}
```

### Result Builders for Complex Content

```swift
// When default slot needs complex content
struct ComplexContent: View {
    @ViewBuilder
    var body: some View {
        VStack {
            Text("Title")
            Text("Subtitle")
        }
    }
}

// Use in component
ElevateCard {
    ComplexContent()
}
```

### Token-Driven Layout

Always derive layout from tokens:

```swift
// ✅ Good - token-driven
.padding(ComponentTokens.padding(for: size))
.cornerRadius(ComponentTokens.cornerRadius(for: shape, size: size))

// ❌ Bad - hardcoded
.padding(16)
.cornerRadius(8)
```

## Summary

This guide ensures:
- **Consistency** across all component translations
- **Maintainability** when web components update
- **Platform Appropriateness** using iOS patterns
- **Token Fidelity** maintaining design system integrity
- **Accessibility** meeting iOS standards

Follow this guide for all future component implementations to maintain quality and consistency across the ELEVATE iOS package.
