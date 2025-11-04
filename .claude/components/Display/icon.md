# Icon Component

## Overview
Display an icon component that renders SVG symbols from a registry or an image source, with optional emblem badges, mirroring, rotation/spin, shaped backgrounds, and color fill. It can also derive and render initials from an accessible label when no icon or image is provided, and exposes extensive styling hooks via CSS custom properties and parts for full theming.

**Category:** Display
**Status:** Complete
**Since:** 0.0.1
**Element:** `elvt-icon`

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `aspectRatio` | `string` | `'1 / 1'` | Set an aspect ratio for the icon element. The icon will be centered |
| `fill` | `string` | `undefined` | Set a background color for the icon as a hexadecimal color code. The icon/initials color will depend on the lightness of the color |
| `image` | `string` | `undefined` | Use an image instead of an icon. The image will be scaled to fit the icon size |
| `mirror` | `IconMirror` | `undefined` | Mirror the icon, 'direction' will mirror the icon depending on the reading direction |
| `mirrorEmblem` | `IconMirror` | `undefined` | Mirror the emblem, 'direction' will mirror the emblem icon depending on the reading direction |
| `raised` | `boolean` | `false` | Add a shadow to the icon |
| `rotate` | `number` | `undefined` | Icon rotation (0-360 degrees) |
| `rotateEmblem` | `number` | `undefined` | Emblem rotation (0-360 degrees) |
| `selected` | `boolean` | `false` | Show the icon in a selected state |
| `shape` | `IconShape` | `IconShape.Box` | Set the icon shape, depending on the motive, this might only be visible for filled or selected icons |
| `spin` | `IconSpin` | `undefined` | Spin the icon (direction, inverse, cw, ccw) |
| `spinEmblem` | `IconSpin` | `undefined` | Spin the emblem icon (direction, inverse, cw, ccw) |
| `tone` | `Tone` | `undefined` | Set the icon tone, depending on the motive, this might not be visible for filled icons |
| `emblem` | `string` | `undefined` | The emblem is a second icon that will be put in a cutout in the lower right corner of the primary icon |
| `icon` | `string` | `undefined` | The icon can be provided as a svg path, an encoded JSON or a URL. Paths are expected to use raster of 24x24 px |
| `label` | `string` | `undefined` | The label will be visually hidden, but still available for screen readers. Additionally, it will be used to create initials if no icon or image is provided |
| `registry` | `IconRegistry` | `undefined` | Custom icon registry to use for resolving icon names |

## CSS Custom Properties

| Property | Description |
|----------|-------------|
| `--icon-size` | The icon element size (default: `1em`) |
| `--icon-symbol-size` | The icon symbol size (percentage) |
| `--icon-scale` | Scale icon motive (with transform filter) |
| `--icon-alignment` | Vertical alignment |
| `--icon-color` | The icon color |
| `--icon-color-on-dark` | Icon color on a dark fill color |
| `--icon-color-on-light` | Icon color on a light fill color |
| `--image-fill` | Icon Image background color (for transparent images) |
| `--emblem-padding` | Cutout padding for the emblem (default: `0.125rem`) |

## CSS Parts

| Part | Description |
|------|-------------|
| `icon` | The icon container element |
| `emblem` | The emblem container element |
| `icon-svg` | The icon `<svg/>` element (not in mask mode) |
| `emblem-svg` | The emblem `<svg/>` element (not in mask mode) |
| `icon-mask` | The icon span with the mask image (only in mask mode) |
| `emblem-mask` | The emblem span with the mask image (only in mask mode) |
| `image` | The image span (when using image mode) |

## Types

### IconShape
- `Box` - Box-shaped icon background
- `Circle` - Circle-shaped icon background

### IconMirror
- `Direction` - Mirror based on reading direction
- `Block` - Mirror on the block axis
- `Inline` - Mirror on the inline axis

### IconSpin
- `Direction` - Spin based on reading direction
- `Inverse` - Spin in reverse direction
- `CW` - Clockwise spin
- `CCW` - Counter-clockwise spin

## Icon Value Formats

The `icon` and `emblem` properties support multiple formats:

- **SVG Path**: Direct SVG path string (24x24 viewBox)
- **Blob URL**: `blob:` prefixed URL
- **HTTP URL**: `http://` or `https://` URL
- **Data URI**: `data:` prefixed data URI
- **URL Reference**: `url:` prefixed URL
- **Mask Reference**: `mask:` prefixed mask URL
- **Registry Name**: Name from icon registry (with optional library prefix `library:name`)
- **Path Prefix**: `path:` prefixed SVG path

## Dependencies
- `elvt-visually-hidden`

## Behavioral Notes

- Icons are rendered using CSS masks for flexible styling
- When no icon or image is provided but a label exists, the component generates initials (up to 2 characters)
- Initials are generated from the label by extracting first letters of words
- Background color for initials is automatically generated from the label string for consistency
- Icon/text color automatically adjusts based on fill color lightness (dark/light)
- Emblems appear in the lower right corner with a cutout effect
- The component supports global icon registry via dependency injection
- Rotation values are clamped between 0-360 degrees
- If `aria-hidden="true"`, the label is not rendered
- The component sets `role="presentation"` when no label is present
