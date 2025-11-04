# Icon Button Component

**Web Component:** `<elvt-icon-button>`
**Category:** Navigation
**Status:** Unstable 🟡
**Since:** 0.0.3

## Description

A clickable icon button component that can function as either a button or a link.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `disabled` | Boolean | `false` | Disables the button. |
| `download` | String | `undefined` | Tells the browser to download the linked file (set as `href`) as this filename. |
| `href` | String | `undefined` | Use a link element instead of the button to allow for browser navigation. |
| `icon` | String | `undefined` | The name of the icon to draw. Use the 'icon' slot for more flexibility. |
| `label` | String | `''` | A description that gets read by assistive devices. For optimal accessibility, you should always include a label that describes what the icon button does. |
| `selected` | Boolean | `false` | Show as selected. |
| `shape` | IconShape | `IconShape.Box` | Sets the shape of the icon button, this will be applied to the focus ring. |
| `size` | Size | `undefined` | If set, it applies a font-size to the icon. Otherwise, it will inherit the font-size. |
| `target` | LinkTarget | `undefined` | Target for the `href` if defined. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Default slot, allow for visually hidden content. |
| `icon` | Provide icon elements, use `icon` property for a basic icon. |

## CSS Parts

| Part | Description |
|------|-------------|
| `ground` | The component's base wrapper (button or anchor element). |

## Methods

| Method | Description |
|--------|-------------|
| `blur()` | Removes focus from the icon button. |
| `click()` | Simulates a click on the icon button. |
| `focus(options?: FocusOptions)` | Sets focus on the icon button. |

## Behavior Notes

- Renders as `<a>` tag when `href` is set, otherwise renders as `<button>`
- When used as a link with `href`:
  - Includes `rel="noreferrer noopener"` for security when `target` is set
  - Disabled state uses `aria-disabled` (links cannot be truly disabled)
  - Prevents click when disabled
- The label is visually hidden but announced by screen readers via `elvt-visually-hidden`
- Icon has `aria-hidden="true"` since the label provides the accessible name
- Focus state is tracked internally (`_hasFocus`) for styling
- Selected state is applied via `data-selected` attribute
- Implements `WrappedHtmlButton` interface for form integration

## Design Token Mapping

Styles are defined in `icon-button.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Use `Button` (SwiftUI) or `UIButton` (UIKit) as base
- For link behavior, configure button action to open URL
- Apply SF Symbol for icons with appropriate rendering mode
- Shape options should affect focus/highlight appearance:
  - `circle`: Circular highlight/background
  - `rectangle`/`box`: Rectangular highlight/background
- Size property should map to SF Symbol scales (small, medium, large)
- Selected state should have distinct visual styling
- Ensure minimum tappable area (44x44 points)
- Label must be set as `accessibilityLabel`
- Consider using `UIButton.Configuration` (iOS 15+) for modern styling

## Related Components

- Icon - The icon component used within the icon button
- Visually Hidden - Used to hide label text while keeping it accessible
- Button - Standard button component for comparison
