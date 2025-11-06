# StepperItem Component - iOS Adaptations

## ELEVATE Web Pattern
Individual step in a stepper progression

## iOS Adaptation
- ✅ Circle indicator for step number
- ✅ Line connecting to next step
- ✅ Three states: incomplete, active, complete
- ✅ Checkmark for completed steps
- ✅ Touch-friendly tap area
- ✅ Vertical or horizontal layout

## Reasoning
Stepper shows progress through multi-step process. Visual indicators show status.

## Implementation Notes
Uses StepperItemComponentTokens
Circle with number or checkmark
Connecting line to next item
State-based styling
Optional tap action

## Code Example
```swift
VStack {
    ElevateStepperItem(number: 1, state: .complete, label: "Step 1")
    ElevateStepperItem(number: 2, state: .active, label: "Step 2")
    ElevateStepperItem(number: 3, state: .incomplete, label: "Step 3")
}
```

## Related Components
Stepper, Progress, Wizard
