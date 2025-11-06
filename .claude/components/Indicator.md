# Indicator Component - iOS Adaptations

## ELEVATE Web Pattern
Status or notification indicator dot

## iOS Adaptation
- ✅ Small circular view
- ✅ Tone-based coloring
- ✅ Pulse animation option
- ✅ Overlay positioning
- ✅ Badge alternative for counts

## Reasoning
Indicators show status or presence. Pulse draws attention to notifications.

## Implementation Notes
Uses IndicatorComponentTokens
Circle() shape
Pulse animation for active states
Typically overlaid on icons

## Code Example
```swift
ZStack(alignment: .topTrailing) {
    Image(systemName: "bell")
    ElevateIndicator(tone: .danger, isPulsing: true)
}
```

## Related Components
Badge, Notification, Icon
