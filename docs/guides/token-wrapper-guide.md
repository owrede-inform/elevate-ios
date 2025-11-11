# Token Wrapper Pattern Guide

## Overview

Token wrappers provide semantic, easy-to-use interfaces for accessing ELEVATE design tokens in components. They abstract the flat token namespace into structured enums and types that match component APIs.

## Why Use Token Wrappers?

**Without Wrapper:**
```swift
Button(
    backgroundColor: ButtonComponentTokens.fill_primary_default,
    hoverColor: ButtonComponentTokens.fill_primary_hover,
    textColor: ButtonComponentTokens.label_primary_default
)
```

**With Wrapper:**
```swift
let toneColors = ButtonTokens.Tone.primary.colors
Button(
    backgroundColor: toneColors.background,
    hoverColor: toneColors.backgroundHover,
    textColor: toneColors.text
)
```

## Token Wrapper Architecture

### File Structure
```
ElevateUI/Sources/DesignTokens/
├── Generated/                  # Auto-generated from SCSS
│   ├── ButtonComponentTokens.swift
│   ├── ChipComponentTokens.swift
│   └── ...
└── Components/                 # Manual semantic wrappers
    ├── ButtonTokens.swift
    ├── ChipTokens.swift
    └── ...
```

## Creating a Token Wrapper

### Step 1: Analyze Token Patterns

Examine the generated component tokens file to identify patterns:

```swift
// From ButtonComponentTokens.swift
fill_primary_default
fill_primary_hover
fill_primary_active
fill_primary_disabled_default
fill_success_default
fill_success_hover
// ... etc
```

**Identify dimensions:**
- **Tones**: primary, success, warning, danger, neutral, emphasized, subtle
- **States**: default, hover, active, disabled, selected
- **Properties**: fill (background), label (text), border
- **Sizes**: s, m, l (for sizing tokens)

### Step 2: Create Wrapper Structure

```swift
#if os(iOS)
import SwiftUI

@available(iOS 15, *)
public struct ComponentNameTokens {

    // MARK: - Tone Enum
    public enum Tone {
        case primary, secondary, success, warning, danger, neutral

        public var colors: ToneColors {
            switch self {
            case .primary: return .primary
            case .secondary: return .neutral  // Map semantically
            case .success: return .success
            case .warning: return .warning
            case .danger: return .danger
            case .neutral: return .neutral
            }
        }
    }

    // MARK: - Size Enum
    public enum Size {
        case small, medium, large

        public var config: SizeConfig {
            switch self {
            case .small: return .small
            case .medium: return .medium
            case .large: return .large
            }
        }
    }

    // MARK: - Tone Colors Struct
    public struct ToneColors {
        // Map semantic names to component tokens
        let background: Color
        let backgroundHover: Color
        let backgroundActive: Color
        let backgroundDisabled: Color
        let text: Color
        let textHover: Color
        let textDisabled: Color
        let border: Color

        static let primary = ToneColors(
            background: ComponentNameComponentTokens.fill_primary_default,
            backgroundHover: ComponentNameComponentTokens.fill_primary_hover,
            backgroundActive: ComponentNameComponentTokens.fill_primary_active,
            backgroundDisabled: ComponentNameComponentTokens.fill_primary_disabled_default,
            text: ComponentNameComponentTokens.label_primary_default,
            textHover: ComponentNameComponentTokens.label_primary_hover,
            textDisabled: ComponentNameComponentTokens.label_primary_disabled_default,
            border: ComponentNameComponentTokens.border_primary_color_default
        )

        // ... repeat for each tone
    }

    // MARK: - Size Configuration
    public struct SizeConfig {
        let height: CGFloat
        let padding: CGFloat
        let fontSize: CGFloat

        static let small = SizeConfig(
            height: ComponentNameComponentTokens.height_s,
            padding: ComponentNameComponentTokens.padding_inline_s,
            fontSize: 12.0  // Or from tokens if available
        )

        static let medium = SizeConfig(
            height: ComponentNameComponentTokens.height_m,
            padding: ComponentNameComponentTokens.padding_inline_m,
            fontSize: 14.0
        )

        static let large = SizeConfig(
            height: ComponentNameComponentTokens.height_l,
            padding: ComponentNameComponentTokens.padding_inline_l,
            fontSize: 16.0
        )
    }
}
#endif
```

### Step 3: Add Convenience Methods (Optional)

```swift
extension ComponentNameTokens {
    public static func fillColor(for tone: Tone, isDisabled: Bool) -> Color {
        let colors = tone.colors
        return isDisabled ? colors.backgroundDisabled : colors.background
    }

    public static func textColor(for tone: Tone, isDisabled: Bool) -> Color {
        let colors = tone.colors
        return isDisabled ? colors.textDisabled : colors.text
    }
}
```

## Common Patterns

### Pattern 1: Tone-Based Components
Components with multiple tone variants (Button, Chip, Badge):
- Create `Tone` enum with cases matching ELEVATE tones
- Group tokens by tone into `ToneColors` struct
- Include all state variations (default, hover, active, disabled, selected)

### Pattern 2: Size-Based Components
Components with sizing variations:
- Create `Size` enum (small, medium, large)
- Create `SizeConfig` struct with sizing properties
- Map to `_s`, `_m`, `_l` suffixed tokens

### Pattern 3: Shape Variants
Components with shape options (Button: default/pill, Chip: box/pill):
- Create `Shape` enum
- Compute corner radius based on size and shape
- Use tokens when available, calculate otherwise

### Pattern 4: State Management
Components with interactive states:
- Create `State` enum (default, hover, active, disabled)
- Include selected variants when applicable
- Group state-specific tokens in ToneColors

## Token Naming Conventions

ELEVATE tokens follow these patterns:

### Color Tokens
- `fill_{tone}_{state}` - Background colors
- `label_{tone}_{state}` - Text colors
- `border_{tone}_color_{state}` - Border colors
- `text_color_{tone}_{state}` - Alternative text naming

### Sizing Tokens
- `height_{size}` - Component heights
- `padding_inline_{size}` - Horizontal padding
- `padding_block_{size}` - Vertical padding
- `gap_{size}` - Spacing between elements
- `border_radius_{size}` - Corner radii

### Size Suffixes
- `_s` - Small
- `_m` - Medium
- `_l` - Large

### State Suffixes
- `_default` - Default state
- `_hover` - Hover state
- `_active` - Active/pressed state
- `_disabled_default` - Disabled state
- `_selected_default` - Selected state
- `_selected_hover` - Selected + hover
- `_selected_active` - Selected + active

## Component Integration

### Using Token Wrappers in Components

```swift
@available(iOS 15, *)
public struct ElevateButton<Content: View>: View {
    private let tone: ButtonTokens.Tone
    private let size: ButtonTokens.Size
    private let shape: ButtonTokens.Shape
    @State private var isHovered = false
    @Environment(\.isEnabled) private var isEnabled

    public var body: some View {
        let toneColors = tone.colors
        let sizeConfig = size.componentSize

        content()
            .frame(height: sizeConfig.height)
            .padding(.horizontal, sizeConfig.paddingInline)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .cornerRadius(shape.borderRadius)
    }

    private var backgroundColor: Color {
        let colors = tone.colors
        if !isEnabled {
            return colors.backgroundDisabled
        }
        return isHovered ? colors.backgroundHover : colors.background
    }

    private var textColor: Color {
        let colors = tone.colors
        if !isEnabled {
            return colors.textDisabled
        }
        return isHovered ? colors.textHover : colors.text
    }
}
```

## Best Practices

### 1. Semantic Naming
Use semantic property names in wrappers:
- ✅ `background`, `text`, `border`
- ❌ `fill`, `label`, `borderColor`

### 2. State Logic
Keep state resolution in components, not wrappers:
```swift
// ✅ Good: Component decides state
let color = isDisabled ? colors.backgroundDisabled : colors.background

// ❌ Bad: Wrapper has state logic (use convenience methods instead)
```

### 3. Tone Mapping
Map semantic component tones to ELEVATE tokens:
```swift
case .secondary: return .neutral  // When no secondary tone exists
```

### 4. Fallback Values
Provide sensible fallbacks for missing tokens:
```swift
border: Color.clear  // When no border token exists
fontSize: 14.0       // When font size not in tokens
```

### 5. Documentation
Document token mapping decisions:
```swift
border: Color.clear  // No border tokens for primary in ELEVATE
fontSize: 14.0       // Font size not available in design tokens
```

## Examples

### Complete Examples
- **Button**: `ElevateUI/Sources/DesignTokens/Components/ButtonTokens.swift`
- **Chip**: `ElevateUI/Sources/DesignTokens/Components/ChipTokens.swift`
- **Switch**: `ElevateUI/Sources/DesignTokens/Components/SwitchTokens.swift`
- **Card**: `ElevateUI/Sources/DesignTokens/Components/CardTokens.swift`

### Minimal Example
For simple components with few tokens:
```swift
public struct SimpleComponentTokens {
    public static let backgroundColor = SimpleComponentComponentTokens.fill_default
    public static let textColor = SimpleComponentComponentTokens.text_color_default
    public static let padding = SimpleComponentComponentTokens.padding_m
}
```

## Token Hierarchy

Always respect the three-tier hierarchy:
```
Component Tokens → Alias Tokens → Primitive Tokens
```

**Never** access `ElevatePrimitives` directly from components. Always use:
1. **ComponentTokens** (preferred) - Component-specific tokens
2. **ElevateAliases** (fallback) - Semantic aliases
3. **ElevatePrimitives** (avoid) - Raw color values

## Maintenance

### When Tokens Change
Token wrappers require manual updates when:
1. New tones are added to ELEVATE
2. Token naming conventions change
3. New states are introduced
4. Sizing system changes

### Verification
After creating a wrapper:
1. Build the project to verify compilation
2. Check all tokens exist in ComponentTokens
3. Verify semantic mapping matches design intent
4. Test with component in Preview

## Future Enhancements

Potential improvements to the wrapper system:
- Code generation for boilerplate structures
- Validation tool for missing tone/size combinations
- Documentation generator from token patterns
- Automated testing for token accessibility
