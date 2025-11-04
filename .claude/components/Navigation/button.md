# Button Component

**Web Component:** `<elvt-button>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** v0.0.3

## Description

Buttons represent actions that are available to the user. The button component can function as either a standard button or as a link when the `href` attribute is provided.

## iOS Implementation Status

- ✅ SwiftUI: `ElevateButton`
- ✅ UIKit: `ElevateUIKitButton`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `disabled` | `Boolean` | `false` | If set to `true`, the user can't interact with the component |
| `download` | `String?` | `undefined` | Tells the browser to download the linked file. Only used when `href` is present |
| `href` | `String?` | `undefined` | When set, the underlying button will be rendered as an `<a>` with this `href` instead of a `<button>` |
| `name` | `String?` | `undefined` | The button's name attribute (for form submission) |
| `padding` | `Padding \| String` | `undefined` | Allows modifying the default padding of the button |
| `rel` | `String?` | `"noreferrer noopener"` | Link relationship. Only used when `href` is present |
| `selected` | `Boolean` | `false` | Display the button as selected |
| `shape` | `Shape` | `"box"` | Display the button as a box or pill shape. Options: `"box"`, `"pill"` |
| `size` | `Size` | `"m"` | Size of the button. Options: `"s"`, `"m"`, `"l"` |
| `target` | `LinkTarget?` | `undefined` | Tells the browser where to open the link. Only used when `href` is present |
| `tone` | `ButtonTone` | `"neutral"` | Button tone (color). Options: `"primary"`, `"secondary"`, `"success"`, `"warning"`, `"danger"`, `"emphasized"`, `"subtle"`, `"neutral"` |
| `type` | `ButtonType` | `"button"` | The type of button. Options: `"button"`, `"reset"`, `"submit"` |
| `value` | `String?` | `undefined` | The button's value (for form submission) |

## Slots

| Slot | Description |
|------|-------------|
| *(default)* | The button's label |
| `prefix` | A presentational prefix icon or similar element |
| `suffix` | A presentational suffix icon or similar element |

## CSS Parts

| Part | Description |
|------|-------------|
| `label` | The button's text content |
| `prefix` | The prefix slot wrapper |
| `suffix` | The suffix slot wrapper |

## Methods

| Method | Signature | Description |
|--------|-----------|-------------|
| `focus` | `focus(options?: FocusOptions): void` | Sets focus on the button |

## Behavior Notes

1. **Form Association**: The button is form-associated and can submit or reset forms when `type` is set to `"submit"` or `"reset"`
2. **Link Mode**: When `href` is provided, the button renders as an `<a>` element instead of a `<button>`
3. **Security**: Default `rel` attribute is `"noreferrer noopener"` for security
4. **Selected State**: The `selected` property displays the button in a selected/active state with different colors

## Design Token Mapping

### Tones & States

Each tone has states: `default`, `hover`, `active`, `selected-default`, `selected-hover`, `selected-active`, `disabled`

**Primary:**
- Fill: `rgb(11 92 223)` → hover: `rgb(27 80 166)` → active: `rgb(35 51 75)`
- Label: `rgb(255 255 255)`
- Border: transparent

**Secondary:** (Uses neutral gray tones)

**Success:**
- Fill: `rgb(5 118 61)` → hover: `rgb(5 96 54)` → active: `rgb(16 58 38)`
- Label: `rgb(255 255 255)`

**Warning:**
- Fill: `rgb(248 143 0)` → hover: `rgb(216 120 0)` → active: `rgb(164 77 0)`
- Label: `rgb(36 11 0)` → hover: `rgb(64 19 0)`

**Danger:**
- Fill: `rgb(206 1 1)` → hover: `rgb(171 1 1)` → active: `rgb(108 1 1)`
- Label: `rgb(255 255 255)`

**Emphasized:**
- Fill: `rgb(213 217 225)` → hover: `rgb(190 195 205)`
- Label: `rgb(47 50 64)`
- Border: `rgb(112 122 143)`

**Subtle:**
- Fill: `rgb(234 244 255)` → hover: `rgb(185 219 255)`
- Label: `rgb(11 92 223)`
- Border: transparent

**Neutral:**
- Fill: `rgb(255 255 255)` → hover: `rgb(243 244 247)`
- Label: `rgb(47 50 64)`
- Border: `rgb(163 170 180)`

### Sizes

| Size | Height | Padding Inline | Gap | Border Radius |
|------|--------|----------------|-----|---------------|
| Small (`s`) | `2rem` (32px) | `0.75rem` (12px) | `0.25rem` (4px) | `0.25rem` (4px) |
| Medium (`m`) | `2.5rem` (40px) | `0.75rem` (12px) | `0.5rem` (8px) | `0.25rem` (4px) |
| Large (`l`) | `3rem` (48px) | `1.25rem` (20px) | `0.75rem` (12px) | `0.25rem` (4px) |

### Shapes

- **Box**: `border-radius: 0.25rem` (4px)
- **Pill**: `border-radius: 9999px` (fully rounded)

## iOS Implementation Notes

### Differences from Web

1. **No href support**: iOS buttons don't naturally support link behavior - handle separately with navigation actions
2. **Touch feedback**: Uses scale transform (0.98) for press state instead of pointer cursor
3. **Selected state**: Implemented but needs testing with toggle buttons
4. **Padding customization**: Not implemented in current iOS version

### SwiftUI Example

```swift
ElevateButton(
    title: "Primary Button",
    tone: .primary,
    size: .medium,
    shape: .default,
    isDisabled: false
) {
    print("Button tapped")
}
```

### UIKit Example

```swift
let button = ElevateUIKitButton(tone: .primary, size: .medium)
button.setTitle("Primary Button", for: .normal)
button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
```

## Related Components

- **Button Group**: Groups multiple buttons together
- **Icon Button**: Button variant with only an icon
- **Link**: Text-based navigation element
