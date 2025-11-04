# Tab Component

**Web Component:** `<elvt-tab>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.1

## Description

A tab component that can be used inside tab groups to display the selection status of a tab and toggle it. The component will only render correctly if used in conjunction with `elvt-tab-group`.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `closable` | `Boolean` | `false` | Whether the user can close this tab. If true, a close button will be rendered on the tab. |
| `closeLabel` | `String?` | `nil` | A custom label for assistive devices, used in the close button. |
| `disabled` | `Boolean` | `false` | Whether this tab is disabled (can't be activated). |
| `panel` | `String` | `''` | The unique (per tab group) identifier of the corresponding tab panel. |
| `selected` | `Boolean` | `false` | Whether this tab is selected. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The tab's label. |
| `close-icon` | The tab's close icon (defaults to cancel/X icon). |
| `prefix` | A slot for a prefix icon or element, displayed before the tab label. |
| `suffix` | A slot for a suffix icon or element, displayed after the tab label. |

## CSS Parts

| Part | Description |
|------|-------------|
| `content` | The main content button of the tab. |

## Methods

None

## Events

| Event | Detail | Description |
|-------|--------|-------------|
| `elvt-request-close` | None | Emitted when the tab is `closable` and the close button is clicked. |
| `elvt-tab-select` | `{ panel: string, selected: true }` | Emitted when the tab is selected. |
| `elvt-tab-deselect` | `{ panel: string, selected: false }` | Emitted when the tab is deselected. |

## Internationalization

The component supports internationalization through the `TabIntl` class:

```typescript
abstract class TabIntl {
  abstract readonly closeLabel: string; // Default: "Close tab"
}
```

## Behavior Notes

- **ARIA attributes**:
  - `role="tab"` automatically set
  - `aria-selected` reflects selected state
  - `aria-disabled` reflects disabled state
- **Selection**:
  - Clicking the tab content selects it
  - Parent `elvt-tab-group` manages selection (only one tab selected at a time)
  - Selecting a tab emits `elvt-tab-select` event
  - Deselecting a tab emits `elvt-tab-deselect` event
  - Disabled tabs cannot be selected
  - Disabling a selected tab automatically deselects it
- **Close button**:
  - Only shown when `closable` is `true`
  - Disabled tabs show close icon but not clickable
  - Emits `elvt-request-close` event (parent handles actual removal)
  - Has tooltip with close label
  - Visually hidden label for screen readers
- **Keyboard interaction**:
  - Tab content is focusable (tabindex 0) unless disabled and not selected
  - Disabled non-selected tabs have tabindex -1
- **Layout variations**:
  - Adapts styling when parent tab-group has `direction="column"` (side/vertical tabs)
- **Panel association**:
  - `panel` property links tab to corresponding `elvt-tab-panel`
  - Changing `panel` while selected triggers select event with new panel ID

## Design Token Mapping

Styles are defined in `tab.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- **UIKit**: Use `UISegmentedControl` for simple cases, or custom `UIButton` for complex tabs
- **SwiftUI**: Use native `TabView` or custom implementation with `Button` and selection binding
- For custom implementation:
  - Selected state: Highlight with underline, background, or border
  - Disabled state: Reduce opacity, gray out text
  - Prefix/suffix: Use leading/trailing accessories
  - Close button: Small X button on trailing edge
- **Closable tabs**:
  - Add swipe-to-delete gesture (iOS pattern)
  - Close button appears on hover/long-press
  - Confirm before closing if needed
- **Accessibility**:
  - Use `accessibilityTraits` for `.selected`, `.button`, `.tabBar`
  - Support VoiceOver hints ("double-tap to activate")
  - Announce "selected" state
  - Close button should be separate focusable element
- **Visual design**:
  - Consider using SF Symbols for prefix/suffix icons
  - Use system fonts with appropriate weights
  - Selected tabs should have clear visual distinction
  - Disabled tabs should appear muted
- **Vertical/aside tabs**:
  - Consider using sidebar pattern on iPad
  - Adjust layout for column direction
- **Touch targets**:
  - Ensure minimum 44x44pt tap area
  - Close button should be at least 24x24pt
- **Haptic feedback**:
  - Light impact on tab selection
  - Warning haptic when closing tab (optional)

## Related Components

- Tab Group - Parent container that manages tab selection and layout
- Tab Panel - Associated content panel for each tab
- Tooltip - Used for close button label
- Icon - Used for close icon
