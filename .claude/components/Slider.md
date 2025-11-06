# Slider Component - iOS Adaptations

## ELEVATE Web Pattern
Range input slider with hover states

## iOS Adaptation
- ✅ Native iOS Slider control
- ✅ Touch-based dragging
- ✅ No hover states
- ✅ Min/max labels
- ✅ Value label display
- ✅ Step support
- ✅ Haptic feedback on change
- ✅ Custom track coloring

## Reasoning
iOS Slider provides familiar control. Haptic feedback enhances interaction.

## Implementation Notes
Uses SliderComponentTokens
Binding to numeric value
min/max range
step for increments
onChange callback
Tint color customization

## Code Example
```swift
@State private var value: Double = 50

ElevateSlider(
    value: $value,
    min: 0,
    max: 100,
    step: 1
) { newValue in
    print("Value: \(newValue)")
}
```

## Related Components
Stepper, Input, Range
