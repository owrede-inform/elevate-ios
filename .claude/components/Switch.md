# Switch Component - iOS Adaptations

## ELEVATE Web Pattern
Toggle switch with hover states

## iOS Adaptation
- ✅ Touch-based tap gesture
- ✅ Animated handle transition (spring)
- ✅ Press state tracking
- ✅ No hover states
- ✅ Two tones (primary, success)
- ✅ Three sizes
- ✅ Track and handle color states
- ✅ Accessibility value (On/Off)
- ✅ onChange callback

## Reasoning
iOS switches are familiar UI. Spring animation provides natural toggle feel.

## Implementation Notes
Uses SwitchComponentTokens
Spring: response 0.3, damping 0.7
ZStack with alignment for handle
Track padding for inset
Disabled opacity: 0.6

## Code Example
```swift
@State private var isOn = false

ElevateSwitch("Notifications", isOn: $isOn, tone: .success)
```

## Related Components
Toggle, Checkbox, Radio
