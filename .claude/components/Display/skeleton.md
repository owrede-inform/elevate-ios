# Skeleton Component

## Overview
Skeletons are used to provide a visual representation of where content will eventually load.

For the default `lines` shape, `line-count` controls how many text lines are rendered, and `line-width` only affects the last line. The `font` attribute sets the typography scale used to compute each line's height and the gap between lines.

For other shapes (block, circle, square), the overall size is derived from the chosen font's line height and the specified `line-count` (e.g., a block with `line-count=3` will have the height of three lines with gaps).

Changing the `font` increases or decreases the visual line height and spacing, letting you match the skeleton to the eventual text style.

**Category:** Feedback
**Status:** Complete
**Since:** 0.0.1
**Element:** `elvt-skeleton`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `effect` | `SkeletonEffect` | `SkeletonEffect.None` | The effect the skeleton will have |
| `font` | `SkeletonFont` | `SkeletonFont.Content` | Font style of the content that is represented by the skeleton. This is used to define the base height and gap of the skeleton |
| `lineCount` | `number` | `1` | The number of lines to display when the shape is `lines`. For `block` it defines the height in line units (with gaps) |
| `lineWidth` | `number` | `100` | The width of the last line, by default, it takes 100% of its container. This does not affect the `circle` and `square` shapes. The value is interpreted as a percentage from 0 to 100 |
| `shape` | `SkeletonShape` | `SkeletonShape.Lines` | The shape of the skeleton |
| `size` | `Size` | `Size.M` | The component size of the skeleton element. This will influence the applied font properties |
| `padding` | `Padding \| string` | `'0'` | Padding around the skeleton |

## Types

### SkeletonEffect
- `None` - No animation effect
- `Pulse` - Pulsing opacity animation
- `Sheen` - Shimmer/sheen animation

### SkeletonShape
- `Block` - Solid rectangular block
- `Circle` - Circular shape
- `Square` - Square shape
- `Lines` - Multiple text lines

### SkeletonFont
Typography scale used for sizing:
- `Annotation` - Smallest text size
- `Label` - Label text size
- `Content` - Content/body text size
- `Headline` - Headline text size

## Dependencies
- `sl-skeleton` (internal dependency)

## Behavioral Notes

- For `lines` shape, multiple skeleton elements are rendered (lineCount - 1 full-width lines + 1 line with lineWidth)
- The `font` property determines the line height and gap between lines based on typography scale
- For `block`, `circle`, and `square` shapes, the `lineCount` property determines the overall height in multiples of line height
- The `lineWidth` property only affects the last line in `lines` shape and is ignored for other shapes
- CSS custom properties are used internally:
  - `--skeleton-line-width`: Set from `lineWidth` percentage
  - `--skeleton-line-count`: Set from `lineCount` number
- The `padding` property accepts Padding objects or string values like "0", "1rem", "1rem 2rem", etc.
- Different effects can be applied: none, pulse (opacity animation), or sheen (shimmer effect)
