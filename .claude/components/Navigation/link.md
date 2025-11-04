# Link Component

**Web Component:** `<elvt-link>`
**Category:** Navigation
**Status:** Complete ✅
**Since:** 0.0.5

## Description

A link that redirects to a URL if clicked.

## iOS Implementation Status

- ⏳ SwiftUI: Not implemented
- ⏳ UIKit: Not implemented

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `usage` | LinkUsage | `'internal'` | How the link is used, e.g. if it's an external link. Determines the visual style of the link. Options: `'internal'` or `'external'`. |
| `href` | String | (required) | The URL the link is referring to. |
| `target` | LinkTarget | `undefined` | Tells the browser where to open the link. |

## Slots

| Slot | Description |
|------|-------------|
| (default) | The link label. |

## CSS Parts

None explicitly defined (uses classes instead)

## Methods

None

## Behavior Notes

- External links automatically display an "open in new" icon (using `@mdi/js` `mdiOpenInNew`)
- External links include `rel="noopener noreferrer"` for security
- CSS class applied based on usage: `elvt-link-internal` or `elvt-link-external`
- Uses `delegatesFocus: true` in shadow root options for focus management
- Falls back to `'internal'` usage if an invalid usage value is provided

## Design Token Mapping

Styles are defined in `link.styles.scss`

## iOS Implementation Notes

When implementing in iOS:
- Use SwiftUI `Link` or UIKit attributed string with link detection
- For external links:
  - Display an SF Symbol trailing icon (e.g., `arrow.up.forward.square` or `safari`)
  - Consider opening in `SFSafariViewController` or default browser
- For internal links:
  - Use navigation within the app (NavigationLink/push navigation)
- Apply distinct styling for internal vs external links
- Ensure underline or other visual indication of interactivity
- Consider tappable area sizing for accessibility

## Related Components

- Icon - Used to display the external link indicator
- Breadcrumb Item - Similar navigation component with link capability
- Icon Button - Alternative clickable navigation element
