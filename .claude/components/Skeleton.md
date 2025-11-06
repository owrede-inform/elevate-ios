# Skeleton Component - iOS Adaptations

## ELEVATE Web Pattern
Loading placeholder with shimmer animation

## iOS Adaptation
- ✅ Shimmer animation with gradient
- ✅ Shape variants (text, circle, rect)
- ✅ Size customization
- ✅ Repeat counts for lists
- ✅ Blend mode for shimmer effect
- ✅ Linear gradient animation

## Reasoning
Skeleton screens improve perceived performance. Shimmer indicates loading state.

## Implementation Notes
Uses SkeletonComponentTokens
Linear gradient with animation
Blend mode .screen for shimmer
Repeat animation indefinitely
Shape-specific corner radius

## Code Example
```swift
ElevateSkeleton(width: 200, height: 20, shape: .text)

// Multiple lines
VStack(spacing: 8) {
    ForEach(0..<3) { _ in
        ElevateSkeleton(width: .infinity, height: 16)
    }
}
```

## Related Components
Progress, EmptyState, Loading
