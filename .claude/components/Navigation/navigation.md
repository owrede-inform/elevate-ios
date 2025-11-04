# Navigation Component

**Web Component:** `<elvt-navigation>`
**Category:** Navigation
**Status:** Unstable
**Since:** 0.33.0

## Description

Define a navigation with nested navigation items. Provides keyboard navigation and focus management for hierarchical navigation structures.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `label` | `String?` | `nil` | A label to use for the navigation. This won't be displayed on the screen, but it will be announced by assistive devices when interacting with the control and is strongly recommended. |
| `size` | `Size` | `.m` | Navigation size (propagates to items and labels). |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Navigation items and labels. |

## CSS Parts

None

## Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `hasItems()` | `Boolean` | Returns whether the navigation has any items. |
| `hasLeafsOnly()` | `Boolean` | Returns whether all items in the navigation are leaf nodes (no child items). |
| `isNavigationRoot()` | `Boolean` | Always returns `true` for the navigation component. |

## Events

The navigation component listens to events from child navigation items:
- `elvt-navigation-item-click`
- `elvt-navigation-item-expand`
- `elvt-navigation-item-collapse`

## Behavior Notes

- Uses `<nav>` element with `role="navigation"` semantics
- Provides keyboard navigation support:
  - Up/Down arrows (or logical block start/end) navigate between visible items
  - Navigation wraps around (from last to first and vice versa)
- Manages focus state across all navigation items
- Only one item can be focusable at a time (roving tabindex pattern)
- Automatically tracks the focused item when items are clicked or expanded/collapsed
- The selected item (or first item) receives focus on initial render
- Size property propagates to all child `elvt-navigation-item` and `elvt-navigation-label` elements

## Design Token Mapping

Styles are defined in `navigation.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Use a vertical stack layout (VStack/UIStackView)
- Implement hierarchical navigation with disclosure indicators
- Support keyboard navigation via accessibility features
- Maintain focus management with VoiceOver
- Consider using `List` in SwiftUI or `UICollectionView` with hierarchical data source in UIKit
- Support RTL languages
- Implement roving focus pattern for keyboard navigation
- Ensure accessibility labels are properly set
- Size variations should affect item heights and font sizes

## Related Components

- Navigation Item - Individual items within the navigation
- Navigation Label - Section labels within the navigation
