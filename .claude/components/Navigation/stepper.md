# Stepper Component

**Web Component:** `<elvt-stepper>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.34

## Description

Steppers allow the user to navigate through a sequence of steps. Provides visual progress indication and manages the layout and connectors between stepper items.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `direction` | `Direction` | `.row` | The direction of the stepper items (horizontal or vertical). |
| `size` | `Size` | `.m` | The size of the stepper items. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The stepper's steps (`elvt-stepper-item` elements). |

## CSS Parts

| Part | Description |
|------|-------------|
| `base` | The component's base wrapper (nav element). |

## Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `steps` | `StepperItem[]` | Returns array of direct child stepper items. |

## Events

None (stepper items emit their own events)

## Behavior Notes

- Uses `<nav>` element for semantic structure
- Automatically sets `aria-current="step"` on the selected/active step
- Manages connector lines between steps:
  - Calculates connector length based on marker positions
  - Updates on resize and property changes
  - Uses logical properties for RTL support
  - First item has no connector
- Direction controls layout:
  - `row`: Horizontal layout (default)
  - `column`: Vertical layout
- Size propagates to all child stepper items
- Uses `ResizeObserver` to maintain accurate connector lengths
- Connectors dynamically adjust when items are added/removed
- Uses `requestAnimationFrame` for smooth connector updates

## Design Token Mapping

Styles are defined in `stepper.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- In SwiftUI: Use HStack (horizontal) or VStack (vertical) for layout
- In UIKit: Use UIStackView with appropriate axis
- Implement custom connector lines between items:
  - Use CAShapeLayer or UIView for connectors
  - Calculate positions based on marker centers
  - Update on layout changes
- Consider using `GeometryReader` in SwiftUI for dynamic positioning
- Support both horizontal and vertical orientations
- Ensure connectors align with marker centers
- Use appropriate spacing between items
- Implement smooth animations when steps change
- Support RTL layouts by mirroring horizontal steppers
- Consider using iOS standard progress indicators as inspiration
- Ensure adequate touch targets for interactive items
- Support dynamic type for accessibility
- Size variations should affect:
  - Marker size
  - Connector thickness
  - Text size
  - Overall spacing

## Related Components

- Stepper Item - Individual steps within the stepper
