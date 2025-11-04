# Visually Hidden Component

## Overview
Makes content accessible to assistive devices without displaying it on the screen. If an element inside has the focus, the component will be visible.

**Category:** Display
**Status:** Stable
**Since:** 0.0.7
**Element:** `elvt-visually-hidden`

## Properties

This component has no configurable properties.

## Slots

| Slot | Description |
|------|-------------|
| (default) | Content that should be visually hidden but accessible to screen readers |

## Behavioral Notes

- Content is hidden from visual display but remains accessible to assistive technologies
- If any element inside receives focus, the component becomes visible
- Uses CSS techniques to hide content visually while keeping it in the accessibility tree
- Commonly used for:
  - Screen reader-only labels
  - Skip navigation links
  - Additional context for assistive technologies
  - Form labels that are visually represented by placeholders or icons
- The component automatically shows when focused, ensuring keyboard navigation remains visible
