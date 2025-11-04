# Menu Item Component

**Web Component:** `<elvt-menu-item>`
**Category:** Navigation
**Status:** Unstable 🟡
**Since:** 0.0.1

## Description

Menu-Items provide a list of options for the user to choose from.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `href` | String | `undefined` | When set, the menu item will open the url if clicked. |
| `selected` | Boolean | `false` | Display the item as selected (for navigations). |
| `target` | LinkTarget | `undefined` | Tells the browser where to open the link. Only used when `href` is present. |
| `value` | String | `undefined` | A value to store in the menu item. This can be used as a context when selected. |
| `checked` | Boolean | `false` | Draws the item in a checked state. Can only be used when `type="checkbox"`. |
| `disabled` | Boolean | `false` | Disables the item. |
| `type` | MenuItemType | `'normal'` | Set to `'checkbox'` to create a menu item that will toggle on and off when selected. Options: `'normal'` or `'checkbox'`. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The menu item's label. |
| `prefix` | Prepend an icon or similar element to the menu item. |
| `suffix` | Append an icon or similar element to the menu item. |
| `submenu` | A nested menu. |

## CSS Parts

| Part | Description |
|------|-------------|
| `ground` | The component's base wrapper div. |

## Methods

| Method | Description |
|--------|-------------|
| `setFocusable(value: boolean)` | Sets the tabindex to control keyboard focus (0 for focusable, -1 for not). |
| `isSubmenu()` | Returns true if the menu item contains a submenu slot. |

## Behavior Notes

- When `type="checkbox"`:
  - Uses `role="menuitemcheckbox"`
  - Sets `aria-checked` attribute based on checked state
  - Displays checkmark icon (`elvt-check`) when checked
  - Prevents checked state on non-checkbox types with console error
- When `type="normal"`:
  - Uses `role="menuitem"`
- Submenu indicators:
  - Automatically displays chevron right icon when submenu slot is present
  - Uses `SubmenuController` for submenu expansion/collapse
- Link behavior:
  - Opens href URL when clicked (uses `window.open`)
  - Respects target attribute
  - Prevents default click behavior when href is set
- Disabled state:
  - Sets `aria-disabled` attribute
  - Prevents click events from propagating
- Focus management:
  - Focus triggered on mouseover
  - Part of parent menu's roving tabindex system
- Internal state tracking:
  - Tracks prefix/suffix slot content presence
  - Uses `SlotController` for slot management

## Design Token Mapping

Styles are defined in `menu-item.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- SwiftUI: Use `Button` with label/image configuration, or `Toggle` for checkbox type
- UIKit: Use `UIAction` within `UIMenu`, or custom table cell
- For checkbox type:
  - Display checkmark indicator (use `.checkmark` accessory or SF Symbol)
  - Implement toggle behavior
- For href behavior:
  - Open URLs using appropriate navigation or browser
- For submenus:
  - iOS 14+: Use nested `UIMenu`
  - SwiftUI: Use nested `Menu` views
  - Consider alternative drill-down pattern for complex hierarchies
- Prefix/suffix slots:
  - Map to leading/trailing image configurations
  - Use SF Symbols for icons
- Selected state should be visually distinct
- Disabled state should reduce opacity and prevent interaction
- Ensure minimum tappable area (44x44 points)

## Related Components

- Menu - Parent container for menu items
- Icon - Used for checkbox indicator and submenu chevron
- Popup - Used by SubmenuController for submenu display
