# Table Cell Component

## Overview
A table cell - used inside `elvt-table`.

**Category:** Display
**Status:** Experimental
**Since:** 0.0.20
**Element:** `elvt-table-cell`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `alignment` | `TableCellAlignment` | `undefined` | Horizontal alignment of cell content |
| `width` | `string` | `undefined` | Width of the cell (numeric values are converted from px to rem) |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Cell content |

## Types

### TableCellAlignment
Text alignment values (exact values depend on implementation):
- `start` - Align to start (left in LTR, right in RTL)
- `center` - Center alignment
- `end` - Align to end (right in LTR, left in RTL)

## Behavioral Notes

- The `width` property accepts both string values (e.g., "100px", "10rem", "50%") and numeric values
- Numeric values are automatically converted from pixels to rem (divided by 16)
- The width is set as a CSS custom property `--table-cell-width`
- Cell alignment inherits from the column definition unless explicitly set
- Used within `elvt-table-row` to create table cells
- The `alignment` property is not reflected to attributes for performance
