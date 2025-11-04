# Select Component

## Overview
A select field that allows you to choose options from a menu.

**Category:** Forms
**Tag Name:** `elvt-select`
**Since:** 0.0.34
**Status:** Unstable

## Dependencies
- `elvt-select-option`
- `elvt-select-option-group`
- `elvt-popup`
- `elvt-chip`
- `elvt-field`
- `elvt-icon`

## Properties

### value
- **Type:** `string | string[] | undefined`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** The current value of the select. When `multiple` is true, this is an array of selected values

### defaultValue
- **Type:** `string | string[]`
- **Attribute:** `value`
- **Default:** `''`
- **Description:** The default value of the form control. Primarily used for resetting the form control

### options
- **Type:** `(SelectOption | SelectOptionItem | SelectOptionGroup)[]`
- **Attribute:** `false`
- **Description:** Options to display in the select dropdown (alternative to using slot)

### placeholder
- **Type:** `string`
- **Attribute:** `placeholder`
- **Reflects:** `true`
- **Description:** Select placeholder text

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the control

### multiple
- **Type:** `boolean`
- **Attribute:** `multiple`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Allows more than one option to be selected

### clearable
- **Type:** `boolean`
- **Attribute:** `clearable`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Add a clear button if the value is set

### open
- **Type:** `boolean`
- **Attribute:** `open`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Indicates whether the select is open. You can toggle this attribute to show and hide the menu

### hoist
- **Type:** `boolean`
- **Attribute:** `hoist`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Enable to prevent the list box from being clipped when inside containers with `overflow: auto|scroll`

### maxOptionsVisible
- **Type:** `number`
- **Attribute:** `max-options-visible`
- **Reflects:** `true`
- **Default:** `3`
- **Description:** The maximum number of selected options to show when `multiple` is true. After the maximum, "+n" will be shown. Set to 0 to remove the limit

### label
- **Type:** `string`
- **Attribute:** `label`
- **Reflects:** `true`
- **Default:** `''`
- **Description:** The label of the Select Component

### helpText
- **Type:** `string`
- **Attribute:** `help-text`
- **Reflects:** `true`
- **Default:** `''`
- **Description:** The Help Text for the Select Component

### hideLabel
- **Type:** `boolean`
- **Attribute:** `hide-label`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** This will hide the label. A label is highly recommended for Accessibility reasons

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
Dropdown contents (`elvt-select-option` and `elvt-select-option-group` elements)

### prefix
Prefix icon or similar element

### suffix
Suffix icon or similar element

### label
The input's label

### help-text
Text that describes how to use the select

## Events

### input
- **Type:** `SelectInputEvent`
- **Description:** Emitted when an option has been clicked

### change
- **Type:** `SelectChangeEvent`
- **Description:** Emitted when an option has been clicked

### elvt-clear
- **Type:** `CustomEvent`
- **Description:** Emitted when the clear button is clicked

## CSS Parts

### form-control
The form control wrapper

### display-input
The input that displays the selected value

### chips
Container for chips when multiple is true

### chip
Individual chip element

### clear-button
The clear button

### expand-icon
The expand/collapse icon

## Methods

### focus(options?: FocusOptions)
- **Returns:** `void`
- **Description:** Sets focus on the control

## Keyboard Interaction
- **Enter / Space:** Open dropdown or select current option
- **Escape:** Close dropdown
- **ArrowDown / ArrowUp:** Navigate options
- **Home / End:** Jump to first/last option
- **Type-to-select:** Type characters to find matching options
- **Backspace:** Delete last character in type-to-select buffer
- **Tab:** Close dropdown and move to next field

## Form Integration
- Extends `CustomFormControl<string | string[] | undefined>`
- Participates in form validation
- Supports single and multiple selection modes
- Value is space-separated string when multiple selections exist

## Usage Notes
- Uses popup component for dropdown positioning
- Supports type-to-select functionality
- In multiple mode, displays selected count or chips
- Clear button only shown when clearable and value is set
- Dropdown closes when clicking outside or pressing Escape
- Uses `CloseWatcher` API when available for better UX
- Options can be provided via slot or `options` property
- Supports option grouping with `elvt-select-option-group`
- Hoist mode uses fixed positioning to avoid clipping issues
