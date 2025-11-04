# Menu Label Component

**Web Component:** `<elvt-menu-label>`
**Category:** Navigation
**Status:** Unstable 🟡
**Since:** 0.0.29

## Description

A label inside a menu, typically used to organize menu items into logical groups.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

None

## Slots

| Slot | Description |
|------|-------------|
| (default) | The label text content. |

## CSS Parts

None explicitly defined

## Methods

None

## Behavior Notes

- Simple component that renders slotted content
- No role or ARIA attributes defined (non-interactive)
- Intended as a visual grouping element within menus
- Does not participate in menu keyboard navigation

## Design Token Mapping

Styles are defined in `menu-label.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- SwiftUI: Use `Text` with section header styling, or `Section` header
- UIKit: Use table section header or custom label view
- Apply distinct styling to differentiate from interactive menu items:
  - Smaller font size or different weight
  - Muted color (secondary text color)
  - Possibly all caps or different letter spacing
- Non-interactive, should not respond to taps
- Consider using as section headers in grouped menus:
  - SwiftUI `Menu` with `Section` dividers
  - UIKit `UIMenu` with section titles (iOS 14+)
  - Table view section headers for custom implementations

## Related Components

- Menu - Parent container that may contain menu labels
- Menu Item - Interactive items that menu labels help organize
