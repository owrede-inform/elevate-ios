# Badge Component - iOS Adaptations

## ELEVATE Web Pattern
Status indicators with optional hover states

## iOS Adaptation
- ✅ No hover states
- ✅ Seven tone variants (neutral, primary, success, warning, danger, emphasized, subtle)
- ✅ Two rank levels: major (prominent) and minor (subtle with border)
- ✅ Two shapes: box (default) and pill
- ✅ Prefix/suffix icon support
- ✅ Pulse animation option for attention
- ✅ Adaptive color scheme support (light/dark mode)
- ✅ SF Symbols for icons

## Reasoning
Badges are informational, so hover removed. Pulse animation draws attention. Rank system provides visual hierarchy.

## Implementation Notes
Uses BadgeTokens for styling
PulseAnimation: scale 1.0-1.05, opacity 1.0-0.85
Animation duration: 1.0s, repeat forever with autoreverse
Minor rank has 1pt border, major has 0pt

## Code Example
```swift
ElevateBadge("New", tone: .primary)

// With icon and pulsing
ElevateBadge("Alert", tone: .danger, isPulsing: true, prefix: {
    Image(systemName: "exclamationmark.triangle.fill")
})
```

## Related Components
Chip, Indicator, Notification
