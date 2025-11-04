# Chip Component

## Overview
A chip component is used as labels to organize things or to indicate a selection.

**Category:** Display
**Status:** Unstable
**Since:** 0.0.12
**Element:** `elvt-chip`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `disabled` | `boolean` | `false` | Disable user interaction |
| `tone` | `ChipTone` | `Tone.Neutral` | Chip tone (color) |
| `size` | `Size` | `Size.M` | Size of the Chip Component |
| `shape` | `Shape` | `Shape.Box` | If set to shape `pill`, displays a chip with rounded edges (pill style) |
| `selected` | `boolean` | `false` | Represents the selected state of the chip |
| `removable` | `boolean` | `false` | Shows the remove action and makes the chip removable |
| `editable` | `boolean` | `false` | Makes the chip editable by rendering the content area as a button that emits a request-edit event when clicked |
| `removeLabel` | `string` | `''` | A custom label for assistive devices, used in the remove button |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The chip's content |
| `prefix` | A presentational prefix icon or similar element |
| `suffix` | A presentational suffix icon or similar element |
| `remove-icon` | The chip's icon |

## Events

| Event | Type | Description |
|-------|------|-------------|
| `elvt-request-remove` | `ChipRequestRemoveEvent` | Emitted when the removable prop is enabled and chip icon remove area is clicked |
| `elvt-request-edit` | `ChipRequestEditEvent` | Emitted when the editable prop is enabled and chip content area is clicked |

## CSS Parts

| Part | Description |
|------|-------------|
| `prefix` | The prefix slot container |
| `content` | The content slot container |
| `suffix` | The suffix slot container |

## Types

### ChipTone
Extends `Tone` with additional emphasized option:
- All standard `Tone` values
- `Emphasized` - Emphasized tone variant

## Internationalization

To modify the label and text displayed, define a class extending `ChipIntl` and include it in a `DependencyProvider`.

**ChipIntl Properties:**
- `removeLabel`: string - Label for the remove button (default: "Remove")

## Dependencies
- `elvt-icon`
- `elvt-tooltip`
- `elvt-visually-hidden`

## Behavioral Notes

- When `removable` is true and not `disabled`, a tooltip is shown on the remove icon button
- When `editable` is true, the content area becomes a clickable button
- The remove icon uses `mdiWindowClose` from Material Design Icons by default, but can be customized via the `remove-icon` slot
- The remove button includes visually hidden text for accessibility
