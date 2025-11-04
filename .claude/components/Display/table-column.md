# Table Column Component

## Overview
A table column - used inside `elvt-table`.

**Category:** Display
**Status:** Experimental
**Since:** 0.0.20
**Element:** `elvt-table-column`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `alignment` | `TableCellAlignment` | `undefined` | Horizontal alignment of column header and cells |
| `sortable` | `TableItemSortDirection[]` | `undefined` | Array of allowed sort directions for the column |
| `sorted` | `TableItemSortDirection` | `undefined` | Current sort direction (if column is sorted) |
| `width` | `string` | `undefined` | Width of the column (numeric values are converted from px to rem) |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Column header label |

## Types

### TableCellAlignment
Text alignment values:
- `start` - Align to start (left in LTR, right in RTL)
- `center` - Center alignment
- `end` - Align to end (right in LTR, left in RTL)

### TableItemSortDirection
- `Ascending` - Sort ascending (A-Z, 0-9)
- `Descending` - Sort descending (Z-A, 9-0)

## Behavioral Notes

- When `sortable` is set and contains sort directions, the column header is rendered as a clickable `<button>`
- When not sortable, the header is rendered as a `<span>`
- The `sortable` property is stored as an array of `TableItemSortDirection` values
- The attribute converter handles space-separated sort direction values (e.g., `sortable="asc desc"`)
- The `width` property accepts both string values (e.g., "100px", "10rem", "50%") and numeric values
- Numeric width values are automatically converted from pixels to rem (divided by 16)
- The width is set as a CSS custom property `--table-column-width`
- The `sorted` attribute visually indicates the current sort direction
- Used in the `head` slot of `elvt-table` to define column headers
- Clicking a sortable column header triggers sorting logic in the parent table
