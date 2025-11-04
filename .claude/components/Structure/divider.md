# Divider Component

## Overview
The divider acts as a separator in a stack of items. By default it will separate the items of a column with a horizontal line.

**Category:** Structure
**Tag Name:** `elvt-divider`
**Since:** 0.0.3
**Status:** Stable

## Properties

### direction
- **Type:** `Direction`
- **Attribute:** `direction`
- **Reflects:** `true`
- **Default:** `'column'`
- **Description:** Let the divider direction matches the container direction
- **Valid Values:** `'row' | 'column'`

### size
- **Type:** `Size | undefined`
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `undefined`
- **Description:** Divider size adds distance before/after the separator depending on the direction. If undefined it will add no distance
- **Valid Values:** `'s' | 'm' | 'l'`

### tone
- **Type:** `DividerTone`
- **Attribute:** `tone`
- **Reflects:** `true`
- **Default:** `'neutral'`
- **Description:** Define a color tone, this will affect the stroke and the content differently
- **Valid Values:** `'neutral' | 'primary' | 'danger' | 'emphasized' | 'subtle'`

### padding
- **Type:** `Padding | string`
- **Attribute:** `padding`
- **Reflects:** `true`
- **Default:** `'0'`
- **Description:** Define padding around the divider line. The padding will be a part of the divider

## Slots

### (default)
Content to display in the divider (creates a labeled divider)

### prefix
Content before the divider line

### suffix
Content after the divider line

## CSS Custom Properties

### --divider-end-length
Length of the divider line before the prefix and after the suffix

### --divider-color
Overwrite divider text color, default `currentColor`

### --divider-stroke-color
Overwrite divider stroke color, default `var(--divider-color)`

## CSS Parts

- `ground` - The divider's container
- `divider` - The divider line element

## Usage Notes
- Direction `column` creates a horizontal line (separates vertical stack)
- Direction `row` creates a vertical line (separates horizontal stack)
- When content is placed in the default slot, the divider becomes labeled
- Tone affects both stroke and content styling
- Size adds spacing before/after the separator based on direction
- Padding creates space around the divider line itself
