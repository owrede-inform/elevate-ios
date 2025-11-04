# Lightbox Component

## Overview
The lightbox fills the entire window with a backdrop and displays content on top. It provides different (transparent) slots for positioning content. The Card component works well as a visible container inside.

**Category:** Overlays
**Status:** Unstable
**Since:** 0.0.16
**Element:** `elvt-lightbox`

## Properties

This component has no public properties.

## Slots

| Slot | Description |
|------|-------------|
| (default) | The content of the lightbox |
| `header` | The header of the lightbox |
| `footer` | The footer of the lightbox |
| `side-start` | The side start of the lightbox |
| `side-end` | The side end of the lightbox |
| `prefix` | The prefix of the lightbox |
| `suffix` | The suffix of the lightbox |

## Events

| Event | Description |
|-------|-------------|
| `elvt-backdrop-click` | Fired when the backdrop is clicked |
| `elvt-escape-keypress` | Fired when the escape key is pressed |

## Dependencies

None

## Behavioral Notes

- The lightbox creates a full-screen overlay with a backdrop
- Multiple slots allow flexible content positioning across the lightbox area
- Clicking the backdrop fires the `elvt-backdrop-click` event
- Pressing Escape fires the `elvt-escape-keypress` event
- The component listens for keyboard events on the document level
- The backdrop and content are rendered in separate layers
- Use with `elvt-card` or similar components to create visible content containers
