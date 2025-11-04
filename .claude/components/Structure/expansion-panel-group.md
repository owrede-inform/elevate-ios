# Expansion Panel Group Component

## Overview
Provides a grouping to behave as an accordion for the expansion panels. Controls whether multiple panels can be expanded simultaneously.

**Category:** Structure
**Tag Name:** `elvt-expansion-panel-group`
**Since:** 0.0.8
**Status:** Complete

## Dependencies
- `elvt-expansion-panel`

## Properties

### allowMultipleExpanded
- **Type:** `boolean`
- **Attribute:** `allow-multiple-expanded`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Indicates whether the panel group should allow multiple expansion panels to be expanded simultaneously

### label
- **Type:** `string`
- **Attribute:** `label`
- **Reflects:** `true`
- **Default:** `''`
- **Description:** A label to use for the expansion panel group. This won't be displayed on the screen, but it will be announced by assistive devices when interacting with the control and is strongly recommended

### gap
- **Type:** `Gap | string`
- **Attribute:** `gap`
- **Reflects:** `true`
- **Default:** `'s'`
- **Description:** Gap between the expansion panels

## Slots

### (default)
The expansion panel elements (`elvt-expansion-panel`)

## Usage Notes
- When `allowMultipleExpanded` is `false` (default), only one panel can be open at a time (accordion behavior)
- When `allowMultipleExpanded` is `true`, multiple panels can be open simultaneously
- The `label` property is important for accessibility and should be set to describe the group
- Gap property controls spacing between individual expansion panels
- Automatically manages the open/close state of child expansion panels based on click events
- Disabled panels within the group are not affected by group behavior
