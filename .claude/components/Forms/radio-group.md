# Radio Group Component

## Overview
A radio component that allows the user to select a single option from a group.

**Category:** Forms
**Tag Name:** `elvt-radio-group`
**Since:** 0.0.1
**Status:** Complete

## Dependencies
- `elvt-radio`
- `elvt-field`

## Properties

### value
- **Type:** `string | number | boolean | undefined`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** The radio's value. The value of the selected radio option

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the Radio (Group) Component. Add the size attribute to the Field's Group to change the radios' size

### label
- **Type:** `string`
- **Inherited from:** `CustomFormField`
- **Description:** The label for the radio group

### helpText
- **Type:** `string`
- **Inherited from:** `CustomFormField`
- **Description:** Help text for the radio group

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

### Default Slot
The radio elements (`elvt-radio` or `elvt-radio-button`)

### label
The group's label

### help-text
Text that describes how to use the radio group

## Events

### change
- **Type:** `Event`
- **Description:** Emitted when the checked state changes

### input
- **Type:** `Event`
- **Description:** Emitted when the checked state changes

## Methods

### focus()
- **Returns:** `void`
- **Description:** Sets focus on the first radio option

## Keyboard Interaction
- **ArrowUp / ArrowLeft:** Select previous option (wraps to last)
- **ArrowDown / ArrowRight:** Select next option (wraps to first)
- **Space:** Select currently focused option
- **Home:** Select first option
- **End:** Select last option

## Form Integration
- Extends `CustomFormField<string | number | boolean>`
- Participates in form validation
- Manages value state for all child radio elements
- Syncs checked state with child radios

## Usage Notes
- Automatically manages focus and tabindex for child radio elements
- Supports both `elvt-radio` and `elvt-radio-button` as children
- Size property is propagated to all child radio elements
- When a radio is selected, its value becomes the group's value
- Keyboard navigation automatically skips disabled radios
- Uses `elvt-field` component for layout and styling
- Detects whether children are radio buttons for different styling
