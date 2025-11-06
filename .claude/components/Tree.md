# Tree Component - iOS Adaptations

## ELEVATE Web Pattern
Hierarchical tree view with expand/collapse

## iOS Adaptation
- ✅ OutlineGroup for iOS 14+
- ✅ List with disclosure indicators
- ✅ Recursive child rendering
- ✅ Expand/collapse animation
- ✅ Selection support
- ✅ Lazy loading for performance
- ✅ Search and filter support

## Reasoning
OutlineGroup provides native tree rendering. List fallback for simple cases.

## Implementation Notes
Uses TreeComponentTokens
OutlineGroup with children keypath
DisclosureGroup for manual control
Recursive view rendering
Lazy loading for large trees

## Code Example
```swift
OutlineGroup(treeData, children: \.children) { item in
    Text(item.name)
}
```

## Related Components
List, OutlineGroup, Hierarchy
