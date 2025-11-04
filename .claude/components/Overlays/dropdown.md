# Dropdown Component

## Overview
A dropdown uses a trigger component to show a container with additional content.

**Category:** Overlays
**Status:** Preliminary
**Since:** 0.0.1
**Element:** `elvt-dropdown`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `containingElement` | `HTMLElement` | `undefined` | The dropdown will close when the user interacts outside of this element (e.g. clicking). Useful for composing other components that use a dropdown internally. |
| `disabled` | `boolean` | `false` | Disables the dropdown so the panel will not open |
| `distance` | `number` | `undefined` | The distance in pixels from which to offset the panel away from its trigger. If not set a default value defined by a token will be used |
| `hoist` | `boolean` | `false` | Forces the panel to use a fixed positioning strategy, allowing it to break out of the container |
| `open` | `boolean` | `false` | Indicates whether the dropdown is open. You can toggle this attribute to show and hide the dropdown |
| `placement` | `AlignedEdgePlacement` | `AlignedEdgePlacement.BlockEndStart` | The preferred placement of the dropdown panel. Note that the actual placement may vary as needed to keep the panel inside the viewport |
| `skidding` | `number` | `0` | The distance in pixels from which to offset the panel along its trigger |
| `stayOpenOnSelect` | `boolean` | `false` | By default, the dropdown is closed when an item is selected. This attribute will keep it open instead. Useful for dropdowns that allow for multiple interactions |
| `sync` | `PopupSizeSync` | `undefined` | Syncs the dropdown's width or height to that of the anchor element |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The dropdown menu content |
| `trigger` | The dropdown menu trigger |

## Methods

| Method | Description |
|--------|-------------|
| `show()` | Show the menu |
| `hide()` | Hide the menu |
| `reposition()` | Instructs the dropdown menu to reposition. Useful when the position or size of the trigger changes when the menu is activated |
| `focusOnTrigger()` | Focus on the trigger element |

## Events

| Event | Description |
|-------|-------------|
| `elvt-show` | Emitted when the dropdown opens |
| `elvt-after-show` | Emitted after the dropdown opens |
| `elvt-hide` | Emitted when the dropdown closes |
| `elvt-after-hide` | Emitted after the dropdown closes |

## Dependencies
- `elvt-popup`

## Behavioral Notes

- The dropdown uses the `elvt-popup` component for positioning
- Clicking outside the containing element closes the dropdown
- Pressing Escape closes the dropdown
- Tabbing outside the containing element closes the dropdown
- When used with `elvt-menu`, keyboard navigation (ArrowDown, ArrowUp, Home, End) is supported
- The trigger element gets `aria-haspopup="true"` and `aria-expanded` attributes for accessibility
- By default, selecting a menu item closes the dropdown unless `stayOpenOnSelect` is enabled
