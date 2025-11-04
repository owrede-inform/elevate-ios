# Field Component

## Overview
Outer frame of a form field, with the label and help text.

**Category:** Forms
**Tag Name:** `elvt-field`
**Since:** 0.0.22
**Status:** Unstable

## Dependencies
- `elvt-icon`
- `elvt-indicator`

## Properties

### label
- **Type:** `string`
- **Attribute:** `label`
- **Reflects:** `true`
- **Description:** The forms label text, use slot for complex labels

### helpText
- **Type:** `string`
- **Attribute:** `help-text`
- **Reflects:** `true`
- **Description:** A descriptive text for the select, use the help-text slot for HTML

### required
- **Type:** `boolean`
- **Attribute:** `required`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Show required indicator on label

### disabled
- **Type:** `boolean`
- **Attribute:** `disabled`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Show label / help text as disabled, this will not modify the control

### invalid
- **Type:** `boolean`
- **Attribute:** `invalid`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Show label / help text in error state, this will not modify the control

### group
- **Type:** `boolean`
- **Attribute:** `group`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Group mode for multiple form controls with own labels. This will replace the internal `label` element with a `fieldset` and `legend` avoiding nested label elements

### hideLabel
- **Type:** `boolean`
- **Attribute:** `hide-label`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Visually hide field label

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the field

## Slots

### Default Slot
Form control element(s)

### label
Field label. Alternatively, you can use the `label` attribute.

### help-text
Text that describes how to use the form field. Alternatively, you can use the `help-text` attribute.

### status
Show a status (like character count and limit)

## CSS Parts

### main
The main wrapper (either `<label>` or `<fieldset>`)

### label
The label wrapper

### control
The form control wrapper

### footer
The footer containing help text and status

### help-text
The help text wrapper

### status
The status wrapper

## Usage Notes
- Use `group` mode when wrapping multiple form controls with their own labels (e.g., radio group)
- In group mode, uses `<fieldset>` and `<legend>` instead of `<label>`
- Required indicator shows an asterisk icon (`mdiAsterisk`)
- Help text is referenced by controls via `aria-describedby`
- Label click in group mode focuses the first focusable control
- Footer is only visible when help text or status content is present
- Visual states (disabled, invalid) are for display only and don't affect the control
