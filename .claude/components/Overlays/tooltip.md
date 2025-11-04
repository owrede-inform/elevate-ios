# Tooltip Component

## Overview
Display a tooltip next to the wrapped anchor element.

**Category:** Overlays
**Status:** Preliminary
**Since:** 0.0.7
**Element:** `elvt-tooltip`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `arrow` | `boolean` | `false` | Displays an arrow pointing to the tooltip's anchor |
| `arrowPlacement` | `PopupArrowPlacement` | `PopupArrowPlacement.Anchor` | Placement of the arrow relative to the anchor |
| `content` | `string` | `''` | Tooltip content for basic text tooltips. Otherwise, use the slot |
| `disabled` | `boolean` | `false` | Disables the tooltip so it won't show when triggered |
| `hoist` | `boolean` | `false` | Prevents the tooltip from being clipped when inside containers with `overflow: auto\|hidden\|scroll` |
| `immediate` | `boolean` | `false` | Show tooltip immediately, disable delay defined by tokens |
| `placement` | `AlignedEdgePlacement` | `AlignedEdgePlacement.BlockStart` | The preferred placement of the tooltip. Actual placement may vary based on available space |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Tooltip anchor element |
| `content` | Tooltip HTML content. Use content property for basic text tooltips |

## CSS Custom Properties

| Property | Description |
|----------|-------------|
| `--hide-delay` | The amount of time to wait before hiding the tooltip when hovering |
| `--show-delay` | The amount of time to wait before showing the tooltip when hovering |

## Dependencies
- `elvt-popup`

## Behavioral Notes

- Shows on mouse hover and keyboard focus
- Hides on mouse out and blur
- Respects show and hide delays unless `immediate` is enabled
- Uses `elvt-popup` component internally for positioning
- Tooltip has `role="tooltip"` for accessibility
- Anchor gets `aria-describedby` attribute pointing to tooltip when active
- Hover bridge is enabled by default for better mouse interaction
- Flip positioning is enabled to keep tooltip in viewport
- Arrow size and distance can be customized via CSS custom properties
- Delays are parsed from CSS duration values (supports ms and s units)
- When disabled, tooltip won't show regardless of user interaction
