# Checkbox Component

## Overview
A checkbox allows the user to toggle an option on or off. Unlike the standard HTML checkbox, it changes the value property depending on the checked status, so it can be treated like other form fields.

**Category:** Forms
**Tag Name:** `elvt-checkbox`
**Since:** 0.0.15
**Status:** Unstable

## Dependencies
- `elvt-visually-hidden`
- `elvt-icon`

## Properties

### value
- **Type:** `string | boolean | number | undefined`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** This will be the `checkedValue` if the checkbox is checked, otherwise `undefined`

### checked
- **Type:** `boolean`
- **Attribute:** `checked`
- **Reflects:** `true`
- **Description:** Sets the component in a checked/activated state if true

### checkedValue
- **Type:** `string | boolean | number`
- **Attribute:** `checked-value`
- **Reflects:** `true`
- **Default:** `true`
- **Description:** The value returned by the value property if the control is checked

### indeterminate
- **Type:** `boolean`
- **Attribute:** `indeterminate`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** If `true`, the checkbox will visually appear as indeterminate

### helpText
- **Type:** `string`
- **Attribute:** `help-text`
- **Reflects:** `true`
- **Default:** `''`
- **Description:** The checkbox's help text. If you need to display HTML, use the `help-text` slot instead

### hideLabel
- **Type:** `boolean`
- **Attribute:** `hide-label`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** This will hide the label. A checkbox's label is highly recommended for Accessibility reasons

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the Checkbox Component

### disabled
- **Type:** `boolean`
- **Inherited from:** `CustomFormControl`
- **Description:** If set to `true`, the user can't interact with the component

### required
- **Type:** `boolean`
- **Inherited from:** `CustomFormControl`
- **Description:** If set to `true`, the form control is required

### name
- **Type:** `string`
- **Inherited from:** `CustomFormControl`
- **Description:** The name of the form control for form submission

## Slots

### Default Slot
The checkbox's label.

### help-text
Text that describes how to use the checkbox. Alternatively, you can use the `help-text` attribute.

## Events

### change
- **Type:** `CheckboxChangeEvent` (`CustomEvent<{ checked: boolean }>`)
- **Description:** Emitted when the checked state changes

### blur
- **Type:** `Event`
- **Description:** Emitted when the checkbox loses focus

### input
- **Type:** `Event`
- **Description:** Emitted when the checkbox receives input

## CSS Parts

### form-control-help-text
The help text's wrapper.

## Methods

### focus()
- **Returns:** `void`
- **Description:** Sets focus on the checkbox control

## Form Integration
- Extends `CustomFormControl<string | boolean | number>`
- Participates in form validation
- Value updates based on checked state
- Supports indeterminate state (value becomes `undefined`)

## Usage Notes
- When indeterminate, the value property returns `undefined`
- The value is `checkedValue` when checked, `undefined` when unchecked
- Labels are highly recommended for accessibility
- Icons are used to indicate checked (`mdiCheck`) and indeterminate (`mdiMinus`) states
