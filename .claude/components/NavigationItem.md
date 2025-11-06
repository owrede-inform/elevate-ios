# NavigationItem Component - iOS Adaptations

## ELEVATE Web Pattern
Navigation link with active state

## iOS Adaptation
- ✅ NavigationLink integration
- ✅ Selected state for active route
- ✅ SF Symbols for icons
- ✅ Badge support for counts
- ✅ Three sizes
- ✅ Touch-friendly sizing
- ✅ Accessibility routing traits

## Reasoning
NavigationLink provides iOS navigation. Selected state shows current location.

## Implementation Notes
Uses NavigationItemTokens
Wraps NavigationLink
Selected state highlights current
Optional icon and badge
Accessibility traits for navigation

## Code Example
```swift
ElevateNavigationItem(
    "Home",
    icon: "house.fill",
    isSelected: currentRoute == .home
) {
    HomeView()
}
```

## Related Components
TabBar, Menu, Link, Breadcrumb
