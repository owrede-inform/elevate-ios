# Table Row Component

## Overview
A table row - used inside `elvt-table`.

**Category:** Display
**Status:** Experimental
**Since:** 0.0.20
**Element:** `elvt-table-row`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `item` | `Type \| Record<string, unknown>` | `undefined` | The item represented by the row |
| `label` | `string` | `undefined` | The label is used in the selection checkbox (accessibility). It will be prefixed with the (de)select intl text |
| `clickable` | `boolean` | `false` | A clickable row can receive the focus and trigger 'table-row-click' events |

## Read-Only Properties

| Property | Type | Description |
|----------|------|-------------|
| `selected` | `boolean` | Whether the row is currently selected (based on table selection state) |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Table Cells (`elvt-table-cell` elements) |
| `label` | Checkbox Label (for accessibility) - used in the selection checkbox |

## Events

| Event | Type | Description |
|-------|------|-------------|
| `elvt-table-row-click` | `TableRowEvent` | Emitted when the row is clicked (if clickable is true) |

## Internationalization

Uses `TableIntl` for internationalized messages:
- `selectRowLabel`: Label for selecting a row
- `deselectRowLabel`: Label for deselecting a row

## Dependencies
- `elvt-table-cell`
- `elvt-checkbox`

## Behavioral Notes

- The row automatically finds its parent `elvt-table` by traversing the DOM tree (including shadow roots)
- When the table is selectable, a checkbox is rendered at the start of the row
- Rows without an `item` property show an empty selector placeholder when selectable
- The selection checkbox label combines the select/deselect text with the row label
- Clicking the selection checkbox stops event propagation to prevent row click events
- Clickable rows have `tabindex="0"` and can be triggered with the Space key
- The `selected` state is determined by checking if the item exists in the table's selection
- The row index is calculated using XPath to count preceding sibling rows
- The `elvt-table-row-click` event includes:
  - `index`: The row's position
  - `item`: The row's data item
  - `row`: Reference to the row element
- Clicking a non-clickable row does not emit any events
- The checkbox click handler updates the table's selection state
- Row updates are requested when selection changes to refresh the UI
