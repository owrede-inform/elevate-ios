# Badge Component

**Web Component:** `<elvt-badge>`
**Category:** Display
**Status:** Complete ✅
**Since:** v0.0.1

## Description

A badge component that is used to draw attention and display statuses or counts. Typically used for notifications, status indicators, or labeling.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `padding` | `Padding \| String` | `undefined` | Allows to modify the default padding of the badge |
| `pulse` | `Boolean` | `false` | If true, the badge will pulse to draw attention |
| `rank` | `BadgeRank` | `"major"` | Badge prominence level. Options: `"major"`, `"minor"` |
| `shape` | `Shape` | `"pill"` | Shape of the badge. Options: `"box"`, `"pill"` |
| `tone` | `Tone` | `"neutral"` | The badge's tone (color). Options: `"primary"`, `"secondary"`, `"success"`, `"warning"`, `"danger"`, `"neutral"` |

## Slots

| Slot | Description |
|------|-------------|
| *(default)* | The badge's content (text, number, etc.) |
| `prefix` | A presentational prefix icon or similar element |
| `suffix` | A presentational suffix icon or similar element |

## CSS Parts

| Part | Description |
|------|-------------|
| `content` | The default slot wrapper containing the badge content |
| `prefix` | The prefix slot wrapper |
| `suffix` | The suffix slot wrapper |

## Behavior Notes

1. **Rank System**:
   - `major`: Full prominence, standard sizing
   - `minor`: Reduced prominence, smaller sizing

2. **Pulse Animation**: When enabled, the badge animates with a pulsing effect to draw user attention

3. **Shape**: Default is `pill` (fully rounded) but can be `box` for squared corners

## Design Token Mapping

### Tones

Badges use similar color schemes to buttons but typically with lighter backgrounds:

- **Primary**: Blue tone
- **Secondary**: Gray tone
- **Success**: Green tone
- **Warning**: Orange tone
- **Danger**: Red tone
- **Neutral**: Neutral gray

### Ranks

| Rank | Use Case |
|------|----------|
| `major` | Primary status indicators, important notifications |
| `minor` | Secondary indicators, less prominent labels |

## iOS Implementation Notes

### Suggested Implementation

```swift
struct ElevateBadge: View {
    let content: String
    var tone: ButtonTokens.Tone = .neutral
    var rank: BadgeRank = .major
    var shape: ButtonTokens.Shape = .pill
    var pulse: Bool = false

    enum BadgeRank {
        case major
        case minor
    }

    var body: some View {
        Text(content)
            .font(rank == .major ? ElevateTypography.labelSmall : ElevateTypography.labelXSmall)
            .foregroundColor(textColor)
            .padding(.horizontal, rank == .major ? 8 : 6)
            .padding(.vertical, rank == .major ? 4 : 2)
            .background(backgroundColor)
            .cornerRadius(shape == .pill ? 100 : 4)
            // Add pulse animation if needed
    }
}
```

### SwiftUI Example

```swift
HStack {
    Text("Notifications")
    ElevateBadge(content: "3", tone: .danger, rank: .major, pulse: true)
}
```

### Use Cases

- Notification counts
- Status indicators (online, offline, etc.)
- Category labels
- Achievement badges
- Unread message counters

## Related Components

- **Chip**: Similar but more interactive, often dismissible
- **Icon**: Can be used inside badges for icon-only indicators
- **Indicator**: Simpler dot-based status indicator
