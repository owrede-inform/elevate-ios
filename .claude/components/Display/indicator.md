# Indicator Component

## Overview
Attach an indicator to the enclosed component.

**Category:** Overlays
**Status:** Complete
**Since:** 0.0.14
**Element:** `elvt-indicator`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `placement` | `LogicalCorner` | `LogicalCorner.BlockStartInlineEnd` | Position of the indicator relative to the content |
| `tone` | `Tone` | `Tone.Primary` | The tone (color) of the indicator |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Component to attach the indicator to |
| `indicator` | Provide a custom indicator (default is elvt-badge) |

## CSS Custom Properties

| Property | Description |
|----------|-------------|
| `--indicator-offset-block` | Block indicator offset (default: `0.75rem`) |
| `--indicator-offset-inline` | Inline indicator offset (default: `0.75rem`) |

## Types

### LogicalCorner
The `placement` property uses logical positioning that adapts to text direction:
- `BlockStartInlineStart` - Top-left in LTR, top-right in RTL
- `BlockStartInlineEnd` - Top-right in LTR, top-left in RTL
- `BlockEndInlineStart` - Bottom-left in LTR, bottom-right in RTL
- `BlockEndInlineEnd` - Bottom-right in LTR, bottom-left in RTL

## Dependencies
- `elvt-badge`

## Behavioral Notes

- By default, the indicator uses an `elvt-badge` component with the specified tone
- The indicator is positioned absolutely relative to the content using logical properties
- The default placement is in the top-right corner (in LTR layouts)
- Custom indicators can be provided via the `indicator` slot to replace the default badge
- The component uses logical CSS properties for RTL/LTR layout support
