# Switch Component

## Overview
Switches allow the user to toggle an option on or off.

**Category:** Forms
**Tag Name:** `elvt-switch`
**Since:** 0.0.19
**Status:** Stable

## Dependencies
- `elvt-visually-hidden`

## Properties

### value
- **Type:** `string | boolean | number | undefined`
- **Attribute:** `value`
- **Reflects:** `false`
- **Description:** This will be the `checkedValue` if the switch is checked, otherwise `undefined`

### checked
- **Type:** `boolean`
- **Attribute:** `checked`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Sets the component in a checked/activated state if true

### checkedValue
- **Type:** `string | boolean | number`
- **Attribute:** `checked-value`
- **Reflects:** `true`
- **Default:** `true`
- **Description:** Allows to define the value returned if the control is checked

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
- **Description:** This will hide the label. A label is highly recommended for Accessibility reasons

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the Switch Component

### tone
- **Type:** `SwitchTone` (`'primary' | 'success'`)
- **Attribute:** `tone`
- **Reflects:** `true`
- **Default:** `'primary'`
- **Description:** The switch's tone (color)

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
The switch's label.

### help-text
Text that describes how to use the switch. Alternatively, you can use the `help-text` attribute.

## Events

### change
- **Type:** `SwitchChangeEvent` (`CustomEvent<{ checked: boolean }>`)
- **Description:** Emitted when the checked state changes

### input
- **Type:** `Event`
- **Description:** Emitted when the switch receives input

## CSS Parts

### form-control-help-text
The help text's wrapper.

## Keyboard Interaction
- **ArrowLeft:** Toggle switch off (respects RTL)
- **ArrowRight:** Toggle switch on (respects RTL)
- **Space:** Toggle switch state
- **Enter:** Toggle switch state

## Accessibility
- **Role:** `switch`
- **Attributes:**
  - `aria-checked`: Reflects checked state
  - `aria-describedby`: References help text

## Form Integration
- Extends `CustomFormControl<string | boolean | number>`
- Participates in form validation
- Value updates based on checked state
- Value is `checkedValue` when checked, `undefined` when unchecked

## Usage Notes
- Similar to checkbox but with toggle UI pattern
- Supports directional keyboard navigation with RTL awareness
- Tone affects the visual appearance of the switch when checked
- Labels are highly recommended for accessibility
- The `checkedValue` can be customized to return specific values
