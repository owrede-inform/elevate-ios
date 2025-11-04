# Notification Component

## Overview
Used to display important messages inline or as toast notifications.

**Category:** Feedback
**Status:** Unstable
**Since:** 0.0.11
**Element:** `elvt-notification`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `closable` | `boolean` | `false` | Enables a close button that allows the user to dismiss the notification |
| `duration` | `number` | `Infinity` | The length of time in milliseconds the notification will show before closing itself. If the user interacts with it, the timer restarts |
| `open` | `boolean` | `false` | Indicates whether the notification is open. Toggle to show/hide |
| `tone` | `Tone` | `Tone.Primary` | The notification's tone (color). Options: `primary`, `success`, `warning`, `danger`, `neutral` |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The notification's main content |
| `icon` | An icon to show in the notification |

## Events

| Event | Description |
|-------|-------------|
| `change` | Emitted when the notification opens or closes. Detail: `{ open: boolean }` |

## Dependencies
- `elvt-icon`
- `elvt-stack`
- `elvt-icon-button`

## Internationalization

To modify labels, extend `NotificationIntl` class:

```typescript
class NotificationIntl {
  closeLabel: string;
}
```

Default labels:
- `closeLabel`: "Close notification"

## Behavioral Notes

- Auto-hides after specified duration (if not Infinity)
- Timer pauses when mouse enters notification
- Timer resumes when mouse leaves notification
- Displays default icon based on tone if no custom icon provided
- Icon mapping:
  - Primary: Information outline
  - Success: Check circle outline
  - Warning: Alert outline
  - Danger: Alert octagon outline
  - Neutral: Cog outline
- Countdown bar shows remaining time when duration is set
- Animates in/out with opacity and scale transitions
- Sets `aria-hidden` attribute based on open state
- Uses `role="alert"` for accessibility
- Close button only appears when `closable` is true
- Countdown animation pauses/resumes with timer
