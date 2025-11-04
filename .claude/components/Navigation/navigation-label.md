# Navigation Label Component

**Web Component:** `<elvt-navigation-label>`
**Category:** Navigation
**Status:** Unstable
**Since:** 0.33.0

## Description

A label item to separate parts of a navigation. Used to provide section headers within navigation hierarchies.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

None

## Slots

| Slot | Description |
|------|-------------|
| (default) | Label text content. |
| `prefix` | A presentational prefix icon or similar element. |
| `suffix` | A presentational suffix icon or similar element. |

## CSS Parts

None

## Methods

None

## Events

None

## Behavior Notes

- Non-interactive element (no click or keyboard interaction)
- Automatically inherits size from parent navigation component
- Typically styled differently from navigation items (e.g., different font, color, spacing)
- Used to create visual and semantic separation between groups of navigation items
- Should not be used as a clickable element

## Design Token Mapping

Styles are defined in `navigation-label.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- In SwiftUI: Use a text label with section header styling
- In UIKit: Use `UICollectionView` section headers or `UILabel` with custom styling
- Style with smaller font size, different color (often muted/secondary)
- Add appropriate spacing above/below
- Consider all-caps or different font weight for emphasis
- Not interactive - ensure it's not focusable
- Support dynamic type for accessibility
- Respect size variations from parent navigation
- Consider using SF Symbols for prefix/suffix slots

## Related Components

- Navigation - Parent container
- Navigation Item - Navigational items that this label organizes
