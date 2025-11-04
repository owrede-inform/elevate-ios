# Input Component

## Overview
An input field for text and various data types.

**Category:** Forms
**Tag Name:** `elvt-input`
**Since:** 0.0.1
**Status:** Preliminary

## Dependencies
- `sl-input` (Shoelace input wrapper)

## Properties

### value
- **Type:** `string | undefined`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** The current value of the input

### type
- **Type:** `InputType`
- **Attribute:** `type`
- **Reflects:** `true`
- **Default:** `'text'`
- **Description:** Input type (as provided by the browser)
- **Valid Values:** `'date' | 'datetime-local' | 'email' | 'number' | 'password' | 'search' | 'tel' | 'text' | 'time' | 'url'`

### placeholder
- **Type:** `string`
- **Attribute:** `placeholder`
- **Reflects:** `true`
- **Description:** Input placeholder text

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the input

### clearable
- **Type:** `boolean`
- **Attribute:** `clearable`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Add a clear button if the value is set

### readonly
- **Type:** `boolean`
- **Attribute:** `readonly`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** If set to `true`, the input is readonly

### autocomplete
- **Type:** `string`
- **Attribute:** `autocomplete`
- **Reflects:** `true`
- **Description:** Specify what if any permission the user agent has to provide automated assistance in filling out the field value

### autocapitalize
- **Type:** `AutoCapitalize`
- **Attribute:** `autocapitalize`
- **Reflects:** `true`
- **Default:** `'none'`
- **Description:** Automatically capitalize text input

### inputMode
- **Type:** `InputMode`
- **Attribute:** `inputmode`
- **Reflects:** `true`
- **Default:** `'none'`
- **Description:** Input mode for virtual keyboards

### enterKeyHint
- **Type:** `EnterKeyHint`
- **Attribute:** `enterkeyhint`
- **Reflects:** `true`
- **Default:** `'enter'`
- **Description:** Defines what action label (or icon) to present for the enter key on virtual keyboards

### spellcheck
- **Type:** `boolean`
- **Attribute:** `spellcheck`
- **Reflects:** `true`
- **Default:** `true`
- **Description:** Enables spell checking on the input

### autofocus
- **Type:** `boolean`
- **Attribute:** `autofocus`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Indicating that an element should be focused on page load

### min
- **Type:** `number | string`
- **Attribute:** `min`
- **Reflects:** `true`
- **Description:** A minimum value for date/number inputs

### max
- **Type:** `number | string`
- **Attribute:** `max`
- **Reflects:** `true`
- **Description:** A maximum value for date/number inputs

### minlength
- **Type:** `number | string`
- **Attribute:** `minlength`
- **Reflects:** `true`
- **Description:** A minimum character length

### maxlength
- **Type:** `number | string`
- **Attribute:** `maxlength`
- **Reflects:** `true`
- **Description:** A maximum character length

### pattern
- **Type:** `string`
- **Attribute:** `pattern`
- **Reflects:** `true`
- **Description:** A regular expression pattern to validate input against

### step
- **Type:** `number`
- **Attribute:** `step`
- **Reflects:** `true`
- **Description:** A step value for date/number inputs

### disabled
- **Type:** `boolean`
- **Inherited from:** `CustomFormField`
- **Description:** If set to `true`, the user can't interact with the component

### required
- **Type:** `boolean`
- **Inherited from:** `CustomFormField`
- **Description:** If set to `true`, the form control is required

### name
- **Type:** `string`
- **Inherited from:** `CustomFormField`
- **Description:** The name of the form control for form submission

## Slots

### prefix
Prefix icon or similar element

### suffix
Suffix icon or similar element

### label
The input's label (provided by CustomFormField)

### help-text
Text that describes how to use the input (provided by CustomFormField)

## Events

### input
- **Type:** `Event`
- **Description:** Emitted when the input value changes

### sl-clear
- **Type:** `CustomEvent`
- **Description:** Emitted when the clear button is clicked (if clearable is true)

## Form Integration
- Extends `CustomFormField<string>`
- Wraps Shoelace's `sl-input` component
- Participates in form validation
- Supports all standard input validation attributes

## Usage Notes
- Wraps Shoelace input for enhanced functionality
- Supports various input types for different data formats
- Clear button is only shown when `clearable` is true and value is set
- Virtual keyboard hints can be customized with `inputMode` and `enterKeyHint`
- Spell checking is enabled by default but can be disabled
