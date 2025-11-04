# Select Option Group Component

## Overview
Creates a grouping of select options within a select Component.

**Category:** Forms
**Tag Name:** `elvt-select-option-group`
**Since:** 0.0.30
**Status:** Unstable

## Properties

### label
- **Type:** `string`
- **Attribute:** `label`
- **Reflects:** `true`
- **Default:** `undefined`
- **Description:** A label to use for the group. This won't be displayed on the screen, but it will be announced by assistive devices when interacting with the control and is strongly recommended

## Slots

### Default Slot
One or more options to display in the group (`elvt-select-option` elements).

## Accessibility
- **Role:** `group`
- **Attributes:**
  - `aria-label`: Set to the label property for screen readers

## Usage Notes
- Must be used within an `elvt-select` component
- Groups related select options together
- Label is strongly recommended for accessibility
- Label is announced by screen readers but not visually displayed
- Size is inherited from parent select component
- Can contain multiple `elvt-select-option` elements
