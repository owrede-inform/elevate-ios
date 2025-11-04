# Navigation Item Component

**Web Component:** `<elvt-navigation-item>`
**Category:** Navigation
**Status:** Unstable
**Since:** 0.33.0

## Description

A navigation item with optional child items. If it has child items, it is expandable with keyboard and pointer interaction support.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `expanded` | `Boolean` | `false` | Whether the navigation item is expanded to show child items. |
| `href` | `String?` | `nil` | URL to open when the navigation item is clicked. Using this will force the component to 'item' type (with a separate expander element). |
| `selected` | `Boolean` | `false` | Whether this navigation item is currently selected. |
| `target` | `LinkTarget?` | `nil` | Tells the browser where to open the link. Only used when `href` is present. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Label content for the navigation item. |
| `prefix` | A presentational prefix icon or similar element. |
| `suffix` | A presentational suffix icon or similar element. |
| `items` | Nested navigation items (`elvt-navigation-item` elements will be moved to this slot automatically). |

## CSS Parts

None

## Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `hasItems()` | `Boolean` | Returns whether this item has child items. |
| `hasLeafsOnly()` | `Boolean` | Returns whether all child items are leaf nodes (no grandchildren). |
| `isNavigationRoot()` | `Boolean` | Always returns `false` for navigation items. |
| `focus()` | `void` | Focuses the navigation item if it's currently focusable. |

## Events

| Event | Detail | Description |
|-------|--------|-------------|
| `elvt-navigation-item-click` | `{ item: NavigationItem }` | Emitted when the navigation item is clicked. |
| `elvt-navigation-item-expand` | `{ item: NavigationItem }` | Emitted when the navigation item is expanded. |
| `elvt-navigation-item-collapse` | `{ item: NavigationItem }` | Emitted when the navigation item is collapsed. |

## Behavior Notes

- Automatically detects if it has child items and shows an expander icon (chevron)
- The chevron icon rotates 90° when expanded
- Chevron mirrors for RTL languages (`mirror="direction"`)
- Keyboard navigation support:
  - **Enter/Space**: Activates the item (clicks or toggles expansion)
  - **Right arrow** (or logical inline end): Expands if has children
  - **Left arrow** (or logical inline start): Collapses if expanded, or moves focus to parent
- When `href` is present:
  - Renders a separate expander button and content button
  - Clicking the content opens the URL
  - Clicking the expander toggles child items
- When no `href` and has children:
  - Clicking toggles child items (unless item has a click event listener)
- Automatically moves child `elvt-navigation-item` elements to the `items` slot
- Uses roving tabindex pattern (only one item focusable at a time)
- Collapsing an item automatically collapses all its children
- Size is inherited from parent navigation component

## Design Token Mapping

Styles are defined in `navigation-item.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Use disclosure indicator (chevron) for items with children
- Support expand/collapse animations
- Implement indentation for nested items
- In SwiftUI, consider using `DisclosureGroup` for expandable items
- In UIKit, use `UICollectionView` with `.sidebar` or expandable cells
- Support both link navigation and expansion in the same item
- Ensure tappable areas are sufficiently large
- Implement selection state visually
- Support RTL languages with mirrored chevrons
- Maintain accessibility labels and traits
- Use SF Symbols `chevron.right` for expander icon

## Related Components

- Navigation - Parent container for navigation items
- Navigation Label - Section labels for navigation
- Icon - Used for the chevron expander
