# Icon Component - iOS Adaptations

## ELEVATE Web Pattern
SVG icon display

## iOS Adaptation
- ✅ SF Symbols for all icons
- ✅ Resizable with aspectRatio
- ✅ Color tinting support
- ✅ Size variants
- ✅ Weight variants (thin, regular, bold)
- ✅ Rendering modes (monochrome, multicolor)

## Reasoning
SF Symbols provide 5000+ native icons with perfect iOS integration.

## Implementation Notes
Uses IconComponentTokens
Image(systemName:) for SF Symbols
Custom images via Image()
Resizable() + frame() for sizing
foregroundColor() for tinting

## Code Example
```swift
ElevateIcon("heart.fill", size: .medium, color: .red)

// Custom size
ElevateIcon("star", size: .custom(32))
```

## Related Components
IconButton, Badge, Avatar
