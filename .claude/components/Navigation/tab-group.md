# Tab Group Component

**Web Component:** `<elvt-tab-group>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.1

## Description

A control that renders a number of tabs (`elvt-tab`) and the content of the active tab (`elvt-tab-panel`). Manages tab selection, panel visibility, and visual indicators.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `activeTab` | `String` | `''` | The name of the currently active tab (panel identifier). |
| `direction` | `Direction` | `.row` | Layout direction: `row` (horizontal tabs) or `column` (vertical/side tabs). |
| `immediate` | `Boolean` | `false` | Reserved for future use (likely for animation control). |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The tab panels for the tabs (`elvt-tab-panel` elements). |
| `nav` | The tabs for the tab group (`elvt-tab` elements). |

## CSS Parts

| Part | Description |
|------|-------------|
| `nav` | The navigation container holding the tabs. |
| `active-tab-indicator` | The visual indicator (underline/bar) for the active tab. |

## Methods

| Method | Returns | Description |
|--------|---------|-------------|
| `getAllTabs()` | `TabComponent[]` | Returns all tabs that are direct children of this tab group. |
| `getAllPanels()` | `TabPanelComponent[]` | Returns all panels that are direct children of this tab group. |

## Events

| Event | Detail | Description |
|-------|--------|-------------|
| `elvt-tab-change` | `{ activeTab: string }` | Emitted when the active tab changes. |

## Behavior Notes

- **Tab management**:
  - Automatically synchronizes selected state between tabs and panels
  - Only one tab can be selected at a time
  - First non-disabled tab is selected by default
  - If active tab is removed, falls back to first available tab
  - Can set `activeTab` before tabs are rendered (deferred initialization)
- **Active tab indicator**:
  - Visual bar/line that highlights the selected tab
  - Dynamically positions and sizes based on active tab dimensions
  - Smoothly animates when switching tabs (via CSS transitions)
  - Uses logical properties for RTL support
  - Updates on resize and tab changes
  - Calculated using tab center position and size
- **MutationObserver**:
  - Watches for attribute changes on tabs and panels
  - Responds to: `disabled`, `name`, `panel`, `selected` attributes
  - Automatically syncs when tabs/panels are added or removed
  - Prevents infinite loops by filtering relevant mutations
- **Selection behavior**:
  - Clicking a tab sets it as active
  - Setting `activeTab` property updates all tabs and panels
  - Validates that active tab exists and is not disabled
  - Emits `elvt-tab-change` event when selection changes
- **Layout**:
  - `direction="row"`: Horizontal tabs (typical layout)
  - `direction="column"`: Vertical/side tabs (less common)
  - Direction propagates to child tabs for styling
- **Accessibility**:
  - Tab list has proper `role="tablist"`
  - Individual tabs have `role="tab"`, panels have `role="tabpanel"`
  - ARIA attributes managed automatically

## Design Token Mapping

Styles are defined in `tab-group.styles.scss`

CSS Custom Properties:
- `--tab-group-indicator-size`: Width/height of active tab indicator
- `--tab-group-indicator-offset`: Position offset of indicator

## iOS Implementation Notes

When implementing in iOS:
- **SwiftUI**:
  - Use native `TabView` for simple cases
  - Custom implementation with selection binding for complex cases
  - Consider `Picker` with `.segmentedPickerStyle()` for horizontal tabs
- **UIKit**:
  - Use `UITabBarController` for bottom tabs
  - Use `UISegmentedControl` for segmented tabs
  - Custom implementation with `UICollectionView` for complex layouts
- **Active indicator**:
  - Animate indicator movement between tabs
  - Use spring animation for natural feel
  - Consider using selection indicator view (underline or background)
- **Horizontal tabs** (direction: row):
  - Top placement (typical web pattern)
  - Consider `UISegmentedControl` style
  - Scrollable if many tabs (use `UIScrollView`)
- **Vertical tabs** (direction: column):
  - Side placement (iPad/desktop pattern)
  - Consider sidebar with selection indicator
  - Use split view pattern on iPad
- **Panel management**:
  - Only render active panel (memory optimization)
  - Consider view recycling for many panels
  - Smooth transitions between panels
- **Resize handling**:
  - Update indicator on orientation changes
  - Use `GeometryReader` in SwiftUI
  - Handle size class changes
- **Accessibility**:
  - Use `accessibilityElement(children: .contain)`
  - Set accessibility traits for tab bar and tabs
  - Announce tab changes with VoiceOver
  - Support rotor for quick tab navigation
- **Gestures**:
  - Consider swipe gestures to switch tabs
  - Implement pan gesture to drag between tabs
- **Styling**:
  - Follow iOS Human Interface Guidelines
  - Support light/dark mode
  - Use dynamic type for labels
  - Consider compact/regular size classes

## Related Components

- Tab - Individual tab items in the tab group
- Tab Panel - Content panels associated with tabs
- Resize Observer - Used internally for indicator positioning
