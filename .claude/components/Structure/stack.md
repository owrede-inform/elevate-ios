# Stack Component

## Overview
A container for a stack of child elements with flexible layout options.

**Category:** Structure
**Tag Name:** `elvt-stack`
**Since:** 0.0.1
**Status:** Unstable

## Properties

### direction
- **Type:** `StackDirection`
- **Attribute:** `direction`
- **Reflects:** `true`
- **Default:** `'row'`
- **Description:** Direction of the stack layout
- **Valid Values:** `'row' | 'column' | 'row-reverse' | 'column-reverse' | 'multi-column'`

### alignment
- **Type:** `StackAlignment | undefined`
- **Attribute:** `alignment`
- **Reflects:** `true`
- **Description:** Align the children against the direction axis. Default depends on direction: Rows use `center`, Columns use `stretch`
- **Valid Values:** `'start' | 'center' | 'end' | 'stretch'`

### distribution
- **Type:** `StackDistribution | undefined`
- **Attribute:** `distribution`
- **Reflects:** `true`
- **Description:** Distribute the children on the direction axis. Default depends on direction: Rows use `stretch`, Columns use `start`
- **Valid Values:** `'start' | 'end' | 'overlap' | 'center' | 'stretch' | 'stretch-start' | 'stretch-end' | 'space-between'`

### wrap
- **Type:** `boolean`
- **Attribute:** `wrap`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Allow items to wrap to the next line

### gap
- **Type:** `Gap | string`
- **Attribute:** `gap`
- **Reflects:** `true`
- **Default:** `'s'`
- **Description:** Gap between stack items

### padding
- **Type:** `Padding | string`
- **Attribute:** `padding`
- **Reflects:** `true`
- **Default:** `'0'`
- **Description:** Padding around the stack container

## Slots

### (default)
Stack items

## CSS Custom Properties

### --overlap-indent
Modify indent for overlap mode, default `'40%'`

## Usage Notes
- **Direction options:**
  - `row` - Horizontal layout, left to right
  - `column` - Vertical layout, top to bottom
  - `row-reverse` - Horizontal layout, right to left
  - `column-reverse` - Vertical layout, bottom to top
  - `multi-column` - Multi-column layout

- **Alignment** controls cross-axis positioning (perpendicular to direction)
- **Distribution** controls main-axis positioning (along the direction)
- **Overlap** distribution mode creates overlapping items with configurable indent
- Gap and padding accept distance values like `'s'`, `'m'`, `'l'`, or custom values
- Wrap allows items to flow to multiple lines when space is constrained
- Default alignment/distribution behavior is direction-dependent for optimal UX
