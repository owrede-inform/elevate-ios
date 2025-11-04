# Expansion Panel Component

## Overview
Provides an expandable details view with collapsible content.

**Category:** Structure
**Tag Name:** `elvt-expansion-panel`
**Since:** 0.0.8
**Status:** Complete

## Dependencies
- `elvt-icon`

## Properties

### open
- **Type:** `boolean`
- **Attribute:** `open`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Indicates whether the details are open. You can toggle this attribute to show and hide the details

### size
- **Type:** `Size`
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** Size of the Expansion Panel Component
- **Valid Values:** `'s' | 'm' | 'l'`

### summary
- **Type:** `string | undefined`
- **Attribute:** `summary`
- **Reflects:** `true`
- **Description:** The summary to show in the header

### disabled
- **Type:** `boolean`
- **Attribute:** `disabled`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Disables the panel so it can't be expanded

### layer
- **Type:** `ExpansionPanelLayer`
- **Attribute:** `layer`
- **Reflects:** `true`
- **Default:** `'default'`
- **Description:** Display a different background
- **Valid Values:** `'default' | 'elevated'`

## Slots

### (default)
The details' main content

### summary
The summary to show in the header. If not provided, the details main content will be used as the summary

### expand-icon
Expand icon to use instead of the default chevron (optional)

### collapse-icon
Collapse icon to use instead of the default chevron (optional)

## Events

### change
- **Type:** `ExpansionPanelChangeEvent` (CustomEvent<{ open: boolean }>)
- **Description:** Emitted when the panel opens or closes

## CSS Parts

- `base` - The details element container
- `header` - The summary header element
- `summary` - The summary content
- `summary-icon` - The icon container
- `content` - The expanded content area

## Keyboard Support

### Enter / Space
Toggle panel open/closed state

### ArrowRight / ArrowLeft
Open panel (ArrowRight in LTR, ArrowLeft in RTL) or close panel (opposite)

### ArrowDown
Open the panel

### ArrowUp
Close the panel

## Usage Notes
- Default icon is a chevron that rotates when expanded
- Custom icons can be provided for both expand and collapse states
- Summary can be provided as an attribute or slot content
- Panel respects reading direction (RTL/LTR) for arrow key navigation
- When disabled, panel cannot be interacted with via mouse or keyboard
- Layer property affects background styling
- Suitable for use within `elvt-expansion-panel-group` for accordion behavior
