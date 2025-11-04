# Radio Button Component

## Overview
Radio buttons allow the user to select a single option from a group of options using a button-like component.

**Category:** Forms
**Tag Name:** `elvt-radio-button`
**Since:** 0.0.36
**Status:** Unstable

## Dependencies
- `elvt-visually-hidden`

## Properties

### value
- **Type:** `string | boolean | number`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** The radio button's value. When selected, the field's group will get this value

### checked
- **Type:** `boolean`
- **Attribute:** `checked`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Whether the radio button is currently selected

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the Radio Component. Add the size attribute to the Field's Group to change the radio button's size

### disabled
- **Type:** `boolean`
- **Attribute:** `disabled`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** If set to `true`, the user can't interact with the component

## Slots

### Default Slot
The radio button's label.

### prefix
Content to prepend before the label

### suffix
Content to append after the label

## CSS Parts

### prefix
The prefix slot wrapper

### label
The label slot wrapper

### suffix
The suffix slot wrapper

## Accessibility
- **Role:** `radio`
- **Attributes:**
  - `aria-checked`: Reflects checked state
  - `aria-disabled`: Reflects disabled state

## Events
Radio button elements emit events through their parent radio group.

## Usage Notes
- Must be used within an `elvt-radio-group` component
- Renders as a button-style toggle instead of a traditional radio circle
- The parent radio group manages selection state and form integration
- Supports prefix and suffix slots for icons or additional content
- Visual focus indicator shown when not disabled
- Button styling adapts based on checked and focused states
