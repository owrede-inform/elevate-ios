# Avatar Component - iOS Adaptations

## ELEVATE Web Pattern
User avatar with image or initials, optional hover states

## iOS Adaptation
- ✅ No hover states
- ✅ SF Symbols for default icon (person.fill)
- ✅ Initials generation from label text
- ✅ Two shapes: circle and box
- ✅ Three sizes with proper scaling
- ✅ Custom fill color support
- ✅ Border styling from IconComponentTokens
- ✅ Automatic first/last initial extraction
- ✅ Image clipping to shape
- ✅ Selected state support

## Reasoning
Avatars are display components on iOS without hover. Initials provide fallback. SF Symbols ensure native appearance.

## Implementation Notes
Initials: first letter of first two words, or first two letters of single word
Image clipped to shape (Circle or RoundedRectangle)
Icon size is 50% of avatar size
Selected state affects fill and border colors

## Code Example
```swift
ElevateAvatar(label: "John Doe")

// With image
ElevateAvatar(image: Image("profile"), label: "User")

// Selected with custom color
ElevateAvatar(label: "JD", isSelected: true, fillColor: .blue)
```

## Related Components
Icon, Badge, Image
