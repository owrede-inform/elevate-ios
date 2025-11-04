# Breadcrumb Item Component

**Web Component:** `<elvt-breadcrumb-item>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.2

## Description

Breadcrumb Items are used inside breadcrumbs to represent a route path.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `href` | String | `undefined` | Optional URL to direct the user to when the breadcrumb item is activated. When set, a link will be rendered internally. |
| `clickable` | Boolean | `false` | Indicates whether the breadcrumb item is clickable. When set, a button will be rendered internally. |
| `target` | LinkTarget | `undefined` | The target attribute for the link, if `href` is set. This determines where the linked document will open. Defaults to `_self`, which opens the link in the same frame as it was clicked. |
| `selected` | Boolean | `false` | Indicates whether the breadcrumb item is selected. This can be used to visually indicate the current page or section. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The breadcrumb item's label. |
| `separator` | Separator element inserted by parent breadcrumb component. |

## CSS Parts

| Part | Description |
|------|-------------|
| `base` | The component's base wrapper (div element). |
| `label` | The label wrapper (can be `<a>`, `<button>`, or `<label>` depending on state). |
| `separator` | The separator wrapper (span element). |

## Methods

None

## Behavior Notes

- Renders different internal elements based on properties:
  - If `href` is set: renders an `<a>` tag with `rel="noreferrer noopener"` for security
  - If `clickable` is true: renders a `<button>` tag
  - If neither: renders a `<label>` tag (non-interactive)
- The `selected` state applies the `item--selected` class for styling
- The separator slot is managed by the parent `elvt-breadcrumb` component
- Link targets default to `_self` (same frame) when not specified

## Design Token Mapping

Styles are defined in `breadcrumb-item.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Use different view types based on interactivity:
  - `Link` (SwiftUI) or `UIButton` configured as link (UIKit) when `href` is set
  - `Button` (SwiftUI) or `UIButton` (UIKit) when clickable
  - `Text` (SwiftUI) or `UILabel` (UIKit) when neither
- Apply selected state styling to the current/active item
- Handle external URL opening with appropriate security (equivalent to `rel="noreferrer noopener"`)
- Ensure proper tappable area sizes for interactive items

## Related Components

- Breadcrumb - Parent container for breadcrumb items
- Link - Similar navigation component for standalone links
