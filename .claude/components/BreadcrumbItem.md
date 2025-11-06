# BreadcrumbItem Component - iOS Adaptations

## ELEVATE Web Pattern
Individual breadcrumb navigation item

## iOS Adaptation
- ✅ Touch-friendly tap gesture
- ✅ Press state tracking
- ✅ No hover states
- ✅ Current page styling (non-interactive)
- ✅ SF Symbols support
- ✅ Three sizes matching parent breadcrumb
- ✅ Scroll-safe interaction handling

## Reasoning
Individual items need touch optimization. Current page is non-interactive to show location.

## Implementation Notes
isCurrentPage makes item non-interactive
Uses .scrollFriendlyTap() for gesture handling
Press state provides visual feedback
Must match parent Breadcrumb size

## Code Example
```swift
ElevateBreadcrumbItem("Home") {
    navigateToHome()
}

ElevateBreadcrumbItem("Current", isCurrentPage: true)
```

## Related Components
Breadcrumb, NavigationItem
