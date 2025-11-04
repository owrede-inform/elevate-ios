# Paginator Component

**Web Component:** `<elvt-paginator>`
**Category:** Navigation
**Status:** Unstable
**Since:** 0.0.7

## Description

Paging control bar that allows users to navigate through paginated content. Supports customizable page sizes, page navigation buttons, and internationalization.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `hidePageSize` | `Boolean` | `false` | Hide the page size label and select. |
| `hideRangeStatus` | `Boolean` | `false` | Hide the range status label. |
| `length` | `Number` | `0` | The total number of items. |
| `mode` | `PaginatorMode` | `'offset'` | Display mode: `'page'` or `'offset'`. |
| `pageIndex` | `Number` | `0` | The index of the current page (0-based). |
| `pageSize` | `Number` | `0` | Number of items to display on a page. |
| `pageSizeOptions` | `Number[]` | `[]` | The options for the page size select. |
| `showFirstLastButtons` | `Boolean` | `false` | Whether to show the first/last buttons to the user. |
| `showPageInput` | `Boolean` | `false` | Whether to show the page input field. |
| `size` | `Size` | `.m` | The size of the paginator controls. |

## Slots

None (component is self-contained)

## CSS Parts

None

## Methods

None (interaction is through property changes and event handling)

## Events

| Event | Detail | Description |
|-------|--------|-------------|
| `elvt-page-change` | `{ pageIndex: number, pageSize: number }` | Emitted when the page index or page size changes. |

## Internationalization

The component supports internationalization through the `PaginatorIntl` class:

```typescript
abstract class PaginatorIntl {
  abstract readonly firstPageLabel: string;
  abstract readonly lastPageLabel: string;
  abstract readonly nextPageLabel: string;
  abstract readonly pageSizeLabel: string;
  abstract readonly previousPageLabel: string;
  abstract getRangeLabel(pageIndex: number, pageSize: number, length: number): string;
  abstract readonly currentPagePrefix: string;
  abstract getCurrentPageSuffix(pageSize: number, length: number): string;
}
```

Default English labels:
- First Page
- Last Page
- Next Page
- Previous Page
- Items per Page
- Range format: "0 - 20 of 100"
- Page format: "Page 1 of 5"

## Behavior Notes

- **Navigation buttons**:
  - Previous/Next buttons always shown
  - First/Last buttons shown when `showFirstLastButtons` is `true`
  - Buttons disabled when at boundaries (first/last page)
  - Icons include tooltips with accessible labels
- **Page size control**:
  - Dropdown select when multiple options available
  - Disabled input when only one option
  - Automatically includes current `pageSize` in options if not present
  - Changing page size resets to page 0
- **Page input** (when `showPageInput` is `true`):
  - Allows direct page number entry
  - Validates input on blur or Enter key
  - Clamps values to valid page range
- **Display modes**:
  - `'offset'`: Shows "start - end of total" (e.g., "0 - 20 of 100")
  - `'page'`: Shows "Page X of Y" (e.g., "Page 1 of 5")
- **Validation**:
  - Page index automatically clamped to valid range
  - Updates when `pageSize` or `length` changes
  - Handles edge cases (NaN, negative values)

## Design Token Mapping

Styles are defined in `paginator.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Consider using a toolbar or bottom bar for placement
- Previous/Next buttons should use standard iOS navigation arrows
- Page size selector can use a `Menu` in SwiftUI or `UIMenu` in UIKit
- For page input, consider using a popover with number picker
- Display current range/page in center of control
- Use SF Symbols for navigation icons:
  - `chevron.left` for previous
  - `chevron.right` for next
  - `chevron.left.to.line` for first
  - `chevron.right.to.line` for last
- Ensure touch targets meet minimum size (44x44 points)
- Support dynamic type for labels
- Consider compact/regular size classes for layout
- Implement haptic feedback on page changes
- Support VoiceOver announcements for page changes
- For tablet layouts, consider showing all controls
- For phone layouts, consider hiding page size selector or making it a modal

## Related Components

- Button - Used for navigation controls
- Button Group - Groups navigation buttons
- Select - Used for page size selection
- Input - Used for direct page number entry
- Tooltip - Shows accessible labels for buttons
- Icon - Used for button icons
