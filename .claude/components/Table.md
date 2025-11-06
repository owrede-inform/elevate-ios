# Table Component - iOS Adaptations

## ELEVATE Web Pattern
Data table with sorting and selection

## iOS Adaptation
- ✅ List or Table (iOS 16+) for data
- ✅ Pull-to-refresh support
- ✅ Swipe actions for row actions
- ✅ Selection support (single/multiple)
- ✅ Sort support (iOS 16+)
- ✅ Search integration
- ✅ Sticky header sections

## Reasoning
iOS provides List and Table views optimized for touch and scrolling.

## Implementation Notes
Uses TableComponentTokens
List for iOS 15
Table for iOS 16+ with sorting
SwipeActions for row actions
Searchable modifier
Refreshable for pull-to-refresh

## Code Example
```swift
List(items) { item in
    TableRow(item)
}
.searchable(text: $searchText)
.refreshable {
    await reload()
}
```

## Related Components
List, Grid, DataView
