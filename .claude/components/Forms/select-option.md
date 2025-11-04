# Select Option Component

## Overview
Options define the selectable items within the Select Component.

**Category:** Forms
**Tag Name:** `elvt-select-option`
**Since:** 0.0.29
**Status:** Unstable

## Dependencies
- `elvt-icon`

## Properties

### value
- **Type:** `string`
- **Attribute:** `value`
- **Reflects:** `true`
- **Default:** `''`
- **Description:** The select option's value. When selected, the containing form control will receive this value. The value must be unique from other options in the same group. Values may not contain spaces

### selected
- **Type:** `boolean`
- **Attribute:** `selected`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Draws the option in a selected state and has aria-selected="true"

### disabled
- **Type:** `boolean`
- **Attribute:** `disabled`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Draws the option in a disabled state, preventing selection

### current
- **Type:** `boolean`
- **Attribute:** `false`
- **Default:** `false`
- **Description:** The user has keyed into the option but hasn't selected it yet (shows a highlight)

## Slots

### Default Slot
The option's label.

### prefix
Used to prepend an icon or similar element to the menu item.

### suffix
Used to append an icon or similar element to the menu item.

## CSS Parts

### base
The component's base wrapper

### checked-icon
The check icon shown when selected

### prefix
The prefix slot wrapper

### label
The label slot wrapper

### suffix
The suffix slot wrapper

## Accessibility
- **Role:** `option`
- **Attributes:**
  - `aria-disabled`: Reflects disabled state
  - `aria-selected`: Reflects selected state

## Methods

### getTextLabel()
- **Returns:** `string`
- **Description:** Returns a plain text label based on the option's content

## Usage Notes
- Must be used within an `elvt-select` or `elvt-select-option-group`
- Value must be unique within the select
- Values should not contain spaces (used as delimiters for multiple values)
- Check icon (`mdiCheck`) is displayed when selected
- Current state indicates keyboard focus without selection
- Size is inherited from parent select component
- Text label is extracted from non-slotted content
