# Radio Component

## Overview
A radio component that allows the user to select a single option from a group. Be aware that the radio is not a form field by itself. It needs a radio group.

**Category:** Forms
**Tag Name:** `elvt-radio`
**Since:** 0.0.21
**Status:** Complete

## Dependencies
- `elvt-visually-hidden`

## Properties

### value
- **Type:** `string | boolean | number`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** The radio's value. When selected, the field's group will get this value

### checked
- **Type:** `boolean`
- **Attribute:** `checked`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Whether the radio is currently selected

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the Radio Component. Add the size attribute to the Field's Group to change the radios' size

### hideLabel
- **Type:** `boolean`
- **Attribute:** `hide-label`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** This will hide the label. A radio's label is highly recommended for Accessibility reasons

### disabled
- **Type:** `boolean`
- **Inherited from:** `CustomFormControl`
- **Description:** If set to `true`, the user can't interact with the component

## Slots

### Default Slot
The radio's label.

## Events
Radio elements emit events through their parent radio group.

## Accessibility
- **Role:** `radio`
- **Attributes:**
  - `tabindex`: `0` when checked, `-1` when unchecked
  - `aria-disabled`: Reflects disabled state
  - `aria-checked`: Reflects checked state

## Form Integration
- Extends `CustomFormControl<string | boolean | number>`
- Must be used within an `elvt-radio-group`
- Individual radios don't participate in forms directly
- The parent group manages form integration

## Keyboard Interaction
- **Click:** Toggles checked state (managed by parent group)
- **Focus:** Visual focus indicator shown
- Keyboard navigation is handled by the parent `elvt-radio-group`

## Usage Notes
- Must be used within an `elvt-radio-group` component
- The radio group manages selection state and keyboard navigation
- Labels are highly recommended for accessibility
- Size is typically controlled by the parent radio group
- Checked state is managed by the parent group's value
