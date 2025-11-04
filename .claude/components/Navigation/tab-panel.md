# Tab Panel Component

**Web Component:** `<elvt-tab-panel>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.1

## Description

A tab panel component that wraps the content of a single tab inside a tab group. The component will only render correctly if used in conjunction with `elvt-tab-group`.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `name` | `String` | `''` | The unique (per tab group) identifier of this tab panel used to associate it with the corresponding tab. |
| `selected` | `Boolean` | `false` | When true, the tab panel will be shown. Managed by parent `elvt-tab-group`. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The tab's content. |

## CSS Parts

None

## Methods

None

## Events

None

## Behavior Notes

- **Visibility**:
  - Only shown when `selected` is `true`
  - Hidden via CSS when not selected (allows for transitions)
  - `aria-hidden` attribute reflects selected state
  - CSS class `selected` added when active
- **Panel association**:
  - `name` property must match corresponding tab's `panel` property
  - Parent `elvt-tab-group` manages selection based on name matching
- **Accessibility**:
  - `role="tabpanel"` automatically set
  - `aria-hidden` reflects visibility state
- **Content lifecycle**:
  - Content remains in DOM when not selected (preserves state)
  - Consider lazy loading for performance if needed
- **Managed by parent**:
  - Selection state controlled by `elvt-tab-group`
  - Do not manually set `selected` property

## Design Token Mapping

Styles are defined in `tab-panel.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- **SwiftUI**:
  - Use within `TabView` with `.tag()` modifier matching name
  - Or use custom container with conditional rendering
  - Consider lazy loading with `LazyVStack` for complex content
- **UIKit**:
  - Use as view controller in `UITabBarController`
  - Or custom container view managed by tab group controller
  - Consider view recycling for memory efficiency
- **Visibility management**:
  - Only display when selected
  - Animate transitions between panels:
    - Fade transition
    - Slide transition
    - Cross-dissolve
  - Use `UIView.transition` or SwiftUI transitions
- **State preservation**:
  - Keep panel content in memory when switching tabs
  - Or implement state restoration for complex panels
  - Consider disk caching for expensive content
- **Layout**:
  - Panel should fill available space
  - Respect safe area insets
  - Handle keyboard appearance
- **Performance**:
  - Lazy load panel content if heavy
  - Only initialize when first selected
  - Cache rendered content
- **Accessibility**:
  - Announce panel changes to VoiceOver
  - Ensure panel content is navigable
  - Set accessibility container type
- **Scrolling**:
  - Each panel typically has its own scroll view
  - Preserve scroll position when switching tabs
  - Consider scroll-to-top behavior

## Related Components

- Tab Group - Parent container that manages panel visibility
- Tab - Associated tab that controls this panel's visibility
