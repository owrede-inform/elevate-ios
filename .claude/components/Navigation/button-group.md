# Button Group Component

**Web Component:** `<elvt-button-group>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.4

## Description

Button groups can be used to group related buttons into sections.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | String | `''` | A label to use for the button group. This won't be displayed on the screen, but it will be announced by assistive devices when interacting with the control and is strongly recommended. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | One or more buttons to display in the button group. |

## CSS Parts

| Part | Description |
|------|-------------|
| `base` | The component's base wrapper (div with role="group"). |

## Methods

None

## Behavior Notes

- The component automatically applies positional classes to buttons:
  - First button gets `button-group-first` class
  - Middle buttons get `button-group-inner` class
  - Last button gets `button-group-last` class
- Uses `role="group"` for accessibility
- The label is announced by assistive devices via `aria-label`
- Automatically detects and manages slotted `elvt-button` elements

## Design Token Mapping

Styles are defined in `button-group.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Consider using a horizontal `UIStackView` (UIKit) or `HStack` (SwiftUI) with spacing of 0
- Apply different corner radius masking to first, middle, and last buttons
- Ensure the label is used for accessibility via `accessibilityLabel`
- Consider edge cases with a single button

## Related Components

- Button - The primary component used within button groups
