# Menu Component

**Web Component:** `<elvt-menu>`
**Category:** Navigation
**Status:** Preliminary 🟠
**Since:** 0.0.1

## Description

Menus provide a list of options for the user to choose from.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

None

## Slots

| Slot | Description |
|------|-------------|
| (default) | The menu content (items, labels, dividers, ...). |

## CSS Parts

None explicitly defined

## Methods

| Method | Description |
|--------|-------------|
| `setCurrentItem(item: MenuItem)` | Sets the current focused menu item and updates focusable state for all items. |

## Events

| Event | Type | Description |
|-------|------|-------------|
| `elvt-item-select` | `MenuItemSelectEvent` | Fired when a menu item is selected/clicked. |

## Behavior Notes

- Uses `role="menu"` for accessibility
- Implements roving tabindex pattern for keyboard navigation
- Keyboard support:
  - `Enter` or `Space`: Activates the current menu item
  - `ArrowDown`: Moves focus to next item (wraps to first)
  - `ArrowUp`: Moves focus to previous item (wraps to last)
  - `Home`: Moves focus to first item
  - `End`: Moves focus to last item
- Automatically toggles checkbox items when clicked
- Filters menu items by role: `menuitem`, `menuitemcheckbox`, or elements with `isMenuItem` property
- Handles nested submenus (prevents event bubbling from submenu clicks)
- Ignores inert elements when navigating
- First item receives focus by default when menu loads

## Design Token Mapping

Styles are defined in `menu.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- SwiftUI: Use `Menu` or custom list with selection handling
- UIKit: Use `UIMenu` (iOS 14+) or custom table/collection view
- Implement keyboard navigation for external keyboard support
- Support VoiceOver rotor for menu navigation
- Handle checkbox-type items with checkmark indicators
- Consider nested menus/submenus (may need popovers or drill-down)
- Ensure proper focus management and visual feedback
- Map `elvt-item-select` event to appropriate action handlers

## Related Components

- Menu Item - Individual selectable items within the menu
- Menu Label - Section labels within menus
- Popup - May be used to display menus in overlay contexts
