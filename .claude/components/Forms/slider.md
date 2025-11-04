# Slider Component

## Overview
A slider allows users to select a value from a range of values or a range.

**Category:** Forms
**Tag Name:** `elvt-slider`
**Since:** 0.0.41
**Status:** Unstable

## Dependencies
- `elvt-visually-hidden`

## Properties

### value
- **Type:** `number | string | undefined`
- **Attribute:** `value`
- **Reflects:** `true`
- **Description:** The slider's value. In `value` mode, returns a single number. In `range` mode, returns a space-separated string of two numbers (start and end)

### mode
- **Type:** `SliderMode` (`'value' | 'range'`)
- **Attribute:** `mode`
- **Reflects:** `true`
- **Default:** `'value'`
- **Description:** In the `range` mode, there will be two thumbs, one for the start value and one for the end value

### min
- **Type:** `number`
- **Attribute:** `min`
- **Reflects:** `true`
- **Default:** `0`
- **Description:** Minimum value of the slider range

### max
- **Type:** `number`
- **Attribute:** `max`
- **Reflects:** `true`
- **Default:** `100`
- **Description:** Maximum value of the slider range

### step
- **Type:** `number`
- **Attribute:** `step`
- **Reflects:** `true`
- **Default:** `1`
- **Description:** The increment/decrement step for the slider

### direction
- **Type:** `Direction` (`'row' | 'column'`)
- **Attribute:** `direction`
- **Reflects:** `true`
- **Default:** `'row'`
- **Description:** The slider's track direction

### size
- **Type:** `Size` (`'s' | 'm' | 'l'`)
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** The slider's size

### tone
- **Type:** `SliderTone` (`'primary' | 'danger' | 'success'`)
- **Attribute:** `tone`
- **Reflects:** `true`
- **Default:** `'primary'`
- **Description:** The slider's tone. This will only affect the progress and thumb, not the track

### disabled
- **Type:** `boolean`
- **Inherited from:** `CustomFormControl`
- **Description:** If set to `true`, the user can't interact with the component

### required
- **Type:** `boolean`
- **Inherited from:** `CustomFormControl`
- **Description:** If set to `true`, the form control is required

### name
- **Type:** `string`
- **Inherited from:** `CustomFormControl`
- **Description:** The name of the form control for form submission

## CSS Parts

### ground
The root container

### track
The slider track

### progress
The filled portion of the track

### thumb
The draggable thumb control

### thumb-start
The start thumb (in range mode)

### thumb-end
The end thumb (in range mode)

## CSS Custom Properties

### --slider-value-start
Calculated percentage position of the start value

### --slider-value-end
Calculated percentage position of the end value

## Keyboard Interaction
- **ArrowRight / ArrowUp:** Increase value by one step
- **ArrowLeft / ArrowDown:** Decrease value by one step
- **Shift + Arrow keys:** Increase/decrease by 10 steps
- Direction awareness: Respects `direction` property and logical properties

## Pointer Interaction
- **Drag:** Click and drag thumb to change value
- Supports both mouse and touch events
- Value updates in real-time while dragging

## Form Integration
- Extends `CustomFormControl`
- Participates in form validation
- Value format:
  - `value` mode: Single number
  - `range` mode: Space-separated string (e.g., "25 75")

## Usage Notes
- In `value` mode, only one thumb is displayed
- In `range` mode, two thumbs are displayed for start and end values
- Values are automatically clamped to `min`/`max` range
- Values snap to the nearest `step` increment
- Supports both horizontal (`row`) and vertical (`column`) orientation
- Uses logical properties for RTL support
- Visual feedback with focus states
- Accessible labels provided via visually hidden content
