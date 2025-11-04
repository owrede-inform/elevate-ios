# Breadcrumb Component

**Web Component:** `<elvt-breadcrumb>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.2

## Description

Breadcrumbs provide a group of links so users can easily navigate a website's hierarchy.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

None

## Slots

| Slot | Description |
|------|-------------|
| (default) | The breadcrumb items to display. |
| `separator` | To be used between breadcrumb items. |

## CSS Parts

| Part | Description |
|------|-------------|
| `base` | The component's base wrapper (nav element). |

## Methods

None

## Behavior Notes

- Automatically manages separators between breadcrumb items
- Uses `elvt-chevron-right-thin` icon as default separator with RTL support (`mirror="direction"`)
- Clones and inserts separators between items automatically
- Preserves custom separators if provided by the user
- The last breadcrumb item automatically gets `aria-current="page"` for accessibility
- Only accepts `elvt-breadcrumb-item` elements as children
- Uses `<nav>` element with `role="navigation"` semantics

## Design Token Mapping

Styles are defined in `breadcrumb.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Use a horizontal layout (HStack/UIStackView)
- Include chevron separators between items (use SF Symbols `chevron.right`)
- Support RTL languages by mirroring the chevron direction
- Mark the last item visually distinct as the current page
- Consider truncation strategies for long breadcrumb trails
- Ensure tappable areas meet minimum size requirements

## Related Components

- Breadcrumb Item - Individual items within the breadcrumb trail
- Icon - Used for the default separator
