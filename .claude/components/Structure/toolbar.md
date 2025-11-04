# Toolbar Component

## Overview
A toolbar defines a row of actions and context information with flexible slot-based layout.

**Category:** Structure
**Tag Name:** `elvt-toolbar`
**Since:** 0.0.9
**Status:** Complete

## Properties

### border
- **Type:** `ToolbarBorder`
- **Attribute:** `border`
- **Reflects:** `true`
- **Default:** `'start'`
- **Description:** Border configuration for the toolbar
- **Valid Values:** `'all' | 'start' | 'none' | 'both' | 'end'`

### direction
- **Type:** `Direction`
- **Attribute:** `direction`
- **Reflects:** `true`
- **Default:** `'row'`
- **Description:** Direction of the toolbar layout
- **Valid Values:** `'row' | 'column'`

### layer
- **Type:** `ToolbarLayer`
- **Attribute:** `layer`
- **Reflects:** `true`
- **Default:** `'ground'`
- **Description:** Elevation level of the toolbar
- **Valid Values:** `'ground' | 'elevated' | 'overlay' | 'sunken'`

### gap
- **Type:** `Gap | string | undefined`
- **Attribute:** `gap`
- **Reflects:** `true`
- **Default:** `undefined`
- **Description:** The gap will apply to the toolbar container

### padding
- **Type:** `Padding | string | undefined`
- **Attribute:** `padding`
- **Reflects:** `true`
- **Default:** `undefined`
- **Description:** The padding will apply to the toolbar container. For individual paddings use stack elements inside the parts

## Slots

### (default)
Content positioned after the start slot content

### start
At the start of the toolbar, no padding and stretched item

### center
At the center of the toolbar

### end
At the end of the toolbar

## CSS Parts

- `end` - The end section of the toolbar

## Usage Notes
- Default slot content appears after the `start` slot
- Toolbar uses flexbox layout to distribute slots
- Start slot is stretched and has no padding by default
- Center slot is positioned in the middle
- End slot is aligned to the end
- Border options control which edges have borders
- Layer property controls visual elevation
- Gap and padding can be customized for spacing
- Direction allows vertical toolbar layouts
- Slots automatically hide if empty
