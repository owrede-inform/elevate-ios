# Popup Component

## Overview
A component that places content as a popup next to an anchor. This component is used by components like the Dropdown and Tooltip.

**Category:** Overlays
**Status:** Unstable
**Since:** 0.0.28
**Element:** `elvt-popup`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `active` | `boolean` | `false` | Whether the popup is active and visible |
| `anchor` | `Element \| string` | `undefined` | The element the popup will be anchored to. Can be an element or an ID string |
| `arrow` | `boolean` | `false` | Attaches an arrow to the popup |
| `arrowPadding` | `number` | `10` | The amount of padding between the arrow and the edges of the popup |
| `arrowPlacement` | `PopupArrowPlacement` | `PopupArrowPlacement.Anchor` | The placement of the arrow: `anchor`, `start`, `end`, or `center` |
| `autoSize` | `PopupAutoSize` | `undefined` | Causes the popup to automatically resize to prevent overflow. Options: `block`, `inline`, `both` |
| `autoSizeBoundary` | `Element \| Element[]` | `undefined` | Clipping element(s) for overflow checking when resizing |
| `autoSizePadding` | `number` | `0` | Padding in pixels before auto-size behavior occurs |
| `distance` | `number` | `undefined` | Distance in pixels to offset the panel away from its anchor |
| `flip` | `boolean` | `false` | When set, the popup placement will flip to keep it in view |
| `flipBoundary` | `Element \| Element[]` | `undefined` | Clipping element(s) for overflow checking when flipping |
| `flipFallbackPlacements` | `AlignedEdgePlacement[]` | `[]` | Fallback placements if preferred placement doesn't fit |
| `flipFallbackStrategy` | `PopupFlipFallbackStrategy` | `PopupFlipFallbackStrategy.BestFit` | Strategy when neither preferred nor fallback placements fit: `best-fit` or `initial` |
| `flipPadding` | `number` | `0` | Padding in pixels before flip behavior occurs |
| `hoverBridge` | `boolean` | `false` | Adds an invisible "hover bridge" between anchor and popup |
| `placement` | `AlignedEdgePlacement` | `AlignedEdgePlacement.BlockStart` | The preferred placement of the popup |
| `shift` | `boolean` | `false` | Moves the popup along the axis to keep it in view when clipped |
| `shiftBoundary` | `Element \| Element[]` | `undefined` | Clipping element(s) for overflow checking when shifting |
| `shiftPadding` | `number` | `0` | Padding in pixels before shift behavior occurs |
| `skidding` | `number` | `0` | Distance in pixels to offset the panel along its anchor |
| `strategy` | `PopupPositionStrategy` | `PopupPositionStrategy.Absolute` | Positioning strategy: `absolute` or `fixed` |
| `sync` | `PopupSizeSync` | `undefined` | Syncs the popup's width or height to the anchor: `block`, `inline`, or `both` |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The popup content |
| `anchor` | The element the popup will be anchored to |

## CSS Parts

| Part | Description |
|------|-------------|
| `arrow` | The arrow's container. Useful for styling |
| `popup` | The popup's container. Useful for setting background, box shadow, etc. |
| `hover-bridge` | The hover bridge element. Only available when hover-bridge is enabled |

## CSS Custom Properties

| Property | Description |
|----------|-------------|
| `--fill` | The color of the popup box. Default: overlay layer fill |
| `--border-color` | The border color of the popup box. Default: `transparent` |
| `--border-radius` | The border radius of the popup box. Default: `0px` |
| `--border-width` | The border width of the popup box. Default: `0px` |
| `--arrow-size` | The size of the arrow. Default: `6px` |
| `--arrow-color` | The color of the arrow. Default: same as `--fill` |
| `--auto-size-available-inline` | Read-only property showing maximum inline-size before overflowing |
| `--auto-size-available-block` | Read-only property showing maximum block-size before overflowing |

## Methods

| Method | Description |
|--------|-------------|
| `reposition()` | Manually trigger a repositioning of the popup |

## Events

| Event | Description |
|-------|-------------|
| `elvt-reposition` | Emitted when the popup is repositioned |

## Dependencies

None (uses Floating UI library)

## Types

### PopupPositionStrategy
- `absolute` - Uses absolute positioning
- `fixed` - Uses fixed positioning

### PopupFlipFallbackStrategy
- `best-fit` - Uses best available fit based on space
- `initial` - Uses initially preferred placement

### PopupAutoSize
- `inline` - Auto-size inline dimension
- `block` - Auto-size block dimension
- `both` - Auto-size both dimensions

### PopupSizeSync
- `inline` - Sync inline dimension with anchor
- `block` - Sync block dimension with anchor
- `both` - Sync both dimensions with anchor

### PopupArrowPlacement
- `anchor` - Align arrow to center of anchor
- `start` - Align arrow to start of popup
- `end` - Align arrow to end of popup
- `center` - Align arrow to center of popup

## Behavioral Notes

- Uses Floating UI library for sophisticated positioning
- Automatically updates position when anchor or popup changes
- Supports logical properties for RTL/LTR layouts
- The hover bridge fills gaps between anchor and popup for better mouse event handling
- Auto-update positioning runs continuously while active
- Arrow positioning is dynamic and calculated based on placement
- Cleanup happens automatically on disconnect
- Uses `autoUpdate` from Floating UI for continuous positioning
