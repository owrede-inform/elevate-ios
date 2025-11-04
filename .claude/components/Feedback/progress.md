# Progress Component

## Overview
Show the progress of an ongoing operation.

**Category:** Feedback
**Status:** Preliminary
**Since:** 0.0.7
**Element:** `elvt-progress`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `indeterminate` | `boolean` | `false` | When true, the percentage is ignored, the label is hidden, and the progress bar is drawn in an indeterminate state |
| `label` | `string` | `''` | A custom label for assistive devices |
| `shape` | `ProgressShape` | `ProgressShape.Bar` | Shape that the component will display: `bar`, `ring`, or `arc` |
| `size` | `Size` | `undefined` | Size of the progress indicator in circular shapes. If not set, depends on font-size. Options: `xs`, `s`, `m`, `l`, `xl` |
| `value` | `number` | `0` | The current progress value, should be between 0 and 1 |

## Slots

| Slot | Description |
|------|-------------|
| (default) | A label to show inside the progress indicator |

## CSS Parts

| Part | Description |
|------|-------------|
| `base` | The progress track (bar shape) |
| `indicator` | The progress indicator that shows completion |
| `label` | The label slot container |

## CSS Custom Properties

| Property | Description |
|----------|-------------|
| `--progress-color` | Define a custom color for the progress indicator |
| `--progress-track-color` | Define a custom color for the progress track |

## Internationalization

To modify labels, extend `ProgressIntl` class:

```typescript
class ProgressIntl {
  label: string;
}
```

Default labels:
- `label`: "Progress indicator"

## Types

### ProgressShape
The shape of the progress indicator:
- `bar` - Horizontal bar
- `ring` - Complete circular ring
- `arc` - Partial circular arc

## Dependencies

None

## Behavioral Notes

- Value should be between 0 and 1 (0% to 100%)
- When `indeterminate` is true, shows animated loading state
- Shape options:
  - **Bar**: Horizontal progress bar
  - **Ring**: Complete circular progress indicator
  - **Arc**: Partial circular arc (semicircle)
- Label behavior:
  - Bar shape: Shows label inside indicator when value >= 0.2 and size is not small
  - Ring/Arc shapes: Shows label in center when not indeterminate
  - Label is hidden in indeterminate state
- Circular shapes (ring/arc) use SVG for rendering
- Bar shape uses div elements with CSS transforms
- Uses CSS custom property `--percentage` for progress value
- Accessible with `role="progressbar"` and ARIA attributes
- ARIA attributes: `aria-valuemin`, `aria-valuemax`, `aria-valuenow`, `aria-label`
