# Table Component

## Overview
Table can be defined in two ways. You can create a table using the `elvt-table-*` elements or using a data provider and a column definition. If you add child elements, the column definition and data provider will be ignored.

**Category:** Display
**Status:** Experimental
**Since:** 0.0.14
**Element:** `elvt-table`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `columns` | `TableColumnDefinition[]` | `[]` | Array of column definitions for dynamic tables |
| `displayedColumns` | `string[]` | `undefined` | Array of column IDs to display (filters columns array) |
| `row` | `TableRowDefinition \| TableRowDefinitionFunction` | `undefined` | Row configuration or function for dynamic tables |
| `scrollMode` | `TableScrollMode` | `TableScrollMode.None` | Scroll mode: none, inner, or virtual |
| `provider` | `TableDataProvider` | `undefined` | Data provider for dynamic tables |
| `rowHeight` | `number` | `0` (auto) | Fixed row height (required for virtual scrolling) |
| `selectable` | `boolean` | `false` | Enable row selection with checkboxes |
| `sortBy` | `TableItemSort` | `undefined` | Current sort configuration |
| `trackBy` | `(item: Type) => string \| number` | default | Function to generate unique identifiers for items |

## Slots

| Slot | Description |
|------|-------------|
| (default) | Table Rows (`elvt-table-row` elements) |
| `head` | Table Columns (`elvt-table-column` elements) |

## Events

| Event | Type | Description |
|-------|------|-------------|
| `elvt-table-row-click` | `TableRowEvent` | Emitted when a clickable row is clicked |
| `elvt-table-selection-change` | `TableSelectionChangeEvent` | Emitted when the selection changes |

## Read-Only Properties

| Property | Type | Description |
|----------|------|-------------|
| `selection` | `TableSelection<Type>` | The selection manager for the table |
| `rowOffset` | `number` | Starting row index of current slice (virtual scroll) |
| `rows` | `TableRow<Type>[]` | Array of all table row elements |

## Types

### TableScrollMode
- `None` - No special scrolling behavior
- `Inner` - Inner scrolling container
- `Virtual` - Virtual scrolling for large datasets

### TableColumnDefinition
Column definition for dynamic tables:
```typescript
{
  id: string;
  label: string | ((column: TableColumnDefinition) => unknown);
  data?: (item: Type, index: number, column: TableColumnDefinition) => unknown;
  width?: string;
  alignment?: TableCellAlignment;
  dataAlignment?: TableCellAlignment;
  sortable?: boolean | TableItemSortDirection | TableItemSortDirection[];
}
```

### TableItemSort
```typescript
{
  column: string;
  direction: TableItemSortDirection;
}
```

### TableItemSortDirection
- `Ascending` - Sort ascending (A-Z, 0-9)
- `Descending` - Sort descending (Z-A, 9-0)

## Data Providers

### ArrayTableDataProvider
A basic table data provider that takes an array with all records and optionally a compare function (for sorting).

```typescript
const provider = new ArrayTableDataProvider(accounts.slice(0, 5), {
  compare: columnCompare
});
```

### PagedTableDataProvider
Using an asynchronous function to fetch slices of data from an API.

```typescript
const provider = new PagedTableDataProvider(
  10, // page size
  async (pageIndex: number, pageSize: number, sortBy?: TableItemSort) => {
    const offset = pageIndex * pageSize;
    let url = `http://example.com/api/endpoint?offset=${offset}&limit=${limit}`;
    if (sortBy) {
      url += `&sortBy=${sortBy.column}|${sortBy.direction}`;
    }
    const response = await fetch(url);
    return {
      items: response.arrayOfItems,
      length: response.absoluteCountOfItems,
    };
  }
);
```

### Custom Table Data Providers
If implementing your own data provider, it must extend the abstract `TableDataProvider` class:

```typescript
import { BehaviourSubject, Subject } from '@inform-elevate/elevate-cdk';
import { TableData, TableProviderStatus } from './table-data-provider';

export abstract class TableDataProvider {
  public readonly status = new BehaviourSubject<TableProviderStatus>(
    TableProviderStatus.Created
  );
  public readonly changes = new Subject<void>();

  public abstract slice(
    start?: number,
    end?: number,
    sortBy?: string
  ): Promise<TableData>;
}
```

## Internationalization

Uses `TableIntl` for internationalized messages:
- `selectAllLabel`: Label for select all checkbox
- `selectNoneLabel`: Label to deselect all
- `selectRowLabel`: Label for selecting a row
- `deselectRowLabel`: Label for deselecting a row

## Dependencies
- `elvt-table-column`
- `elvt-table-row`
- `elvt-table-cell`
- `elvt-checkbox`
- `elvt-progress`

## Usage Examples

### Static Table
```html
<elvt-table>
  <elvt-table-column slot="head">Column Label</elvt-table-column>
  <elvt-table-row>
    <elvt-table-cell>Content</elvt-table-cell>
  </elvt-table-row>
</elvt-table>
```

### Dynamic Table
```typescript
const columns = [
  {
    id: 'name',
    label: 'Name',
    data: (item: TableItem) => html`${item.first_name} ${item.last_name}`,
  },
  {
    id: 'email',
    label: 'Email',
    data: (item: TableItem) => item.email,
  },
  {
    id: 'company',
    label: 'Company',
    data: (item: TableItem) => item.company,
  },
];
const provider = new ArrayDataProvider(records);
```

## Behavioral Notes

- Dynamic tables require both `columns` and `provider` properties
- Virtual scrolling requires `scrollMode="virtual"` and works only with data providers
- Virtual scrolling requires consistent `rowHeight` for proper rendering
- Sorting triggers data provider refresh and clears selection in virtual mode
- The table shows a loading indicator while data is being fetched
- Selection is managed through the `selection` property (TableSelection instance)
- For virtual scroll, the table calculates visible slice based on scroll position and viewport size
- Column sorting is triggered by clicking sortable column headers
- The selection toggle checkbox shows indeterminate state when some (but not all) rows are selected
- Fragment rendering is supported through dependency injection for custom cell content
- Row height is auto-detected from the first row if not explicitly set
- Virtual scroll uses transform for positioning to improve performance
