# Stepper Component - iOS Adaptations

## ELEVATE Web Pattern
Numeric stepper with increment/decrement buttons

## iOS Adaptation
- ✅ Native iOS Stepper or custom
- ✅ Plus/minus buttons
- ✅ Touch-friendly button sizing
- ✅ Value display
- ✅ Min/max constraints
- ✅ Step value support
- ✅ Haptic feedback on change

## Reasoning
iOS Stepper is standard. Custom version allows ELEVATE styling.

## Implementation Notes
Uses StepperComponentTokens
Native Stepper or custom HStack
SF Symbols: plus.circle, minus.circle
Binding to numeric value
Haptic feedback

## Code Example
```swift
@State private var value = 0

ElevateStepper(value: $value, min: 0, max: 10)
```

## Related Components
Slider, Input, Counter
