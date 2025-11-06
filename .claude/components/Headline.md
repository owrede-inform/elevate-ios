# Headline Component - iOS Adaptations

## ELEVATE Web Pattern
Heading text with semantic levels (h1-h6)

## iOS Adaptation
- ✅ SF Typography for text styles
- ✅ Dynamic Type support
- ✅ Six levels matching web semantics
- ✅ Accessibility heading traits
- ✅ Color adaptation
- ✅ Weight variants

## Reasoning
Typography is critical for hierarchy. Dynamic Type ensures accessibility.

## Implementation Notes
Uses HeadlineComponentTokens
Maps to .largeTitle, .title, .title2, .title3, .headline, .subheadline
Supports Dynamic Type
Accessibility heading trait

## Code Example
```swift
ElevateHeadline("Page Title", level: .h1)
ElevateHeadline("Section", level: .h2, tone: .muted)
```

## Related Components
Text, Label, Title
