# Split View Component

## Overview
A dual split view where the size ratio of two containers can be adjusted by the user via a draggable gutter.

**Category:** Structure
**Tag Name:** `elvt-split-view`
**Since:** 0.0.32
**Status:** Unstable

## Properties

### direction
- **Type:** `Direction`
- **Attribute:** `direction`
- **Reflects:** `true`
- **Default:** `'row'`
- **Description:** Direction of the split (horizontal or vertical)
- **Valid Values:** `'row' | 'column'`

### ghostGutter
- **Type:** `boolean`
- **Attribute:** `ghost-gutter`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** When true, shows a ghost gutter during drag instead of resizing in real-time

### disabled
- **Type:** `boolean`
- **Attribute:** `disabled`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** If set to `true`, user can't interact with the component

## Slots

### a
Content for panel A (first panel)

### b
Content for panel B (second panel)

## Behavior

### Drag Interaction
- Click and drag the gutter to resize panels
- Supports pointer events for mouse and touch input
- Respects logical properties (reading direction)

### Resting Points
The gutter snaps to predefined resting points for consistent layouts:

**Row (horizontal split):**
- 0% (panel A collapsed)
- 25%
- Golden ratio (~38%)
- 50% (equal split)
- 1 - Golden ratio (~62%)
- 75%
- 100% (panel B collapsed)

**Column (vertical split):**
- 0% (panel A collapsed)
- Golden ratio (~38%)
- 50% (equal split)
- 1 - Golden ratio (~62%)
- 100% (panel B collapsed)

### Resting Area
- Resting points have a 50px pixel area of influence
- When gutter is released near a resting point, it snaps to that position

## Usage Notes
- Direction `row` creates a horizontal split (panels side-by-side)
- Direction `column` creates a vertical split (panels stacked)
- Ghost gutter mode shows preview position during drag, applying changes on release
- Without ghost gutter, panels resize in real-time during drag
- Disabled state prevents all resize interactions
- Gutter handle includes visual indicator (4 dots)
- Supports RTL layouts automatically via logical properties
- Golden ratio provides aesthetically pleasing default proportions
