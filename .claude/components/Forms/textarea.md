# Textarea Component

## Overview
A textarea field for multi-line text input.

**Category:** Forms
**Tag Name:** `elvt-textarea`
**Since:** 0.0.1
**Status:** Preliminary

## Dependencies
- `sl-textarea` (Shoelace textarea wrapper)

## Properties

### value
- **Type:** `string | undefined`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** The current value of the textarea

### placeholder
- **Type:** `string`
- **Attribute:** `placeholder`
- **Reflects:** `true`
- **Description:** Textarea placeholder text

### readonly
- **Type:** `boolean`
- **Attribute:** `readonly`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** If set to `true`, the textarea is readonly

### resize
- **Type:** `TextareaResize`
- **Attribute:** `resize`
- **Reflects:** `true`
- **Default:** `'none'`
- **Description:** Resize mode
- **Valid Values:** `'auto' | 'both' | 'none' | 'block' | 'inline'`

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the textarea

### autocapitalize
- **Type:** `AutoCapitalize`
- **Attribute:** `autocapitalize`
- **Reflects:** `true`
- **Default:** `'none'`
- **Description:** Automatically capitalize text textarea

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
- **Description:** Enables spell checking on the textarea

### autofocus
- **Type:** `boolean`
- **Attribute:** `autofocus`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Indicating that an element should be focused on page load

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

### label
The textarea's label (provided by CustomFormField)

### help-text
Text that describes how to use the textarea (provided by CustomFormField)

## Events

### input
- **Type:** `Event`
- **Description:** Emitted when the textarea value changes

## Methods

### focus(options?: FocusOptions)
- **Returns:** `void`
- **Description:** Sets focus on the textarea control

### blur()
- **Returns:** `void`
- **Description:** Removes focus from the textarea control

## Form Integration
- Extends `CustomFormField<string>`
- Wraps Shoelace's `sl-textarea` component
- Participates in form validation

## Usage Notes
- Wraps Shoelace textarea for enhanced functionality
- Resize modes: `none`, `auto`, `both`, `block` (vertical), `inline` (horizontal)
- When resize is set to `block`, it maps to Shoelace's `vertical` mode
- Spell checking is enabled by default but can be disabled
- Virtual keyboard hints can be customized with `inputMode` and `enterKeyHint`
