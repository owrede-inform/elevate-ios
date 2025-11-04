# Stepper Item Component

**Web Component:** `<elvt-stepper-item>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.34

## Description

Single step within a stepper. Displays a marker, label, optional help text, and nested content. Can be interactive (button or link) or non-interactive.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `disabled` | `Boolean` | `false` | Whether the stepper item is disabled. |
| `helpText` | `String?` | `nil` | The help text for the stepper item. |
| `href` | `String?` | `nil` | Optional URL to direct the user to when the item is activated. When set, a link will be rendered internally. |
| `label` | `String?` | `nil` | The label for the stepper item. |
| `marker` | `String?` | `nil` | The text for the marker. The position (1-based index) will be used if not defined. |
| `target` | `LinkTarget?` | `nil` | The target attribute for the link, if `href` is set. Defaults to `_self`. |
| `tone` | `StepperTone` | `.neutral` | The status/tone of the stepper item: `neutral`, `primary`, `success`, or `danger`. |

## Type Definitions

```typescript
type StepperTone = 'neutral' | 'primary' | 'success' | 'danger';
```

## Slots

| Slot | Description |
|------|-------------|
| (default) | The stepper item's content, which is shown below the label and help-text. |
| `marker` | The stepper item's marker. Alternatively, you can use the `marker` attribute. |
| `help-text` | Text that describes how to use the stepper item. Alternatively, you can use the `help-text` attribute. |
| `label` | The stepper item's label. Alternatively, you can use the `label` attribute. |

## CSS Parts

| Part | Description |
|------|-------------|
| `marker` | The marker element (can be button, link, or div). |
| `label` | The label text container. |
| `help-text` | The help text container. |

## Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `getMarkerCenter()` | `{ x: number, y: number }?` | Returns the center coordinates of the marker element for connector positioning. |

## Computed Properties

- `selected`: Returns `true` when `tone` is `primary`
- `position`: Returns 1-based index within parent stepper

## Behavior Notes

- **Interactive modes**:
  - **With `href` and not disabled**: Renders as link (`<a>`)
  - **Without `href` and not disabled**: Renders as button (`<button>`)
  - **Disabled**: Renders as non-interactive div
- **Marker display**:
  - Shows custom marker text if provided
  - Falls back to position number (1, 2, 3, etc.)
  - Can be completely customized via marker slot
- **Tone/Status indication**:
  - `neutral`: Default, incomplete state
  - `primary`: Current/active step
  - `success`: Completed successfully
  - `danger`: Error or failed step
- **Connector**:
  - First item has no connector (automatically detected)
  - Connector extends from previous item's marker center to this item's marker
- **Layout**:
  - Adapts to parent stepper's direction and size
  - Nested content only shown if default slot has content
- **Accessibility**:
  - `aria-disabled` attribute set when disabled
  - Proper tabindex management (-1 when disabled)
  - Link security: `rel="noreferrer noopener"` on external links

## Design Token Mapping

Styles are defined in `stepper-item.styles.scss`

Tone affects:
- Marker background color
- Marker text color
- Label color
- Connector color

## iOS Implementation Notes

When implementing in iOS:
- Use a circular marker view (similar to page control dots)
- Implement tone/status with different colors:
  - Neutral: Gray/secondary color
  - Primary: Brand color (active state)
  - Success: Green/system success color
  - Danger: Red/system error color
- Label should be prominent, help text should be secondary/smaller
- Support both horizontal and vertical layouts
- For interactive items:
  - Use Button in SwiftUI or UIButton in UIKit
  - Ensure 44x44pt minimum touch target
  - Add appropriate feedback (highlight, haptics)
- For links:
  - Consider navigation or SafariView presentation
- Marker customization:
  - Allow custom text/numbers
  - Support icon markers (via slot equivalent)
- Position calculation should be automatic
- Support dynamic type for text
- Implement smooth state transitions (tone changes)
- Consider using SF Symbols for status icons in markers
- Size variations should scale proportionally
- Nested content can expand below the marker/label

## Related Components

- Stepper - Parent container that manages layout and connectors
- Stack - Used internally for layout
