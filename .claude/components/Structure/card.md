# Card Component

## Overview
A card is a visual container for related subjects. The content of a card will stretch if the height is set.

**Category:** Structure
**Tag Name:** `elvt-card`
**Since:** 0.0.2
**Status:** Unstable

## Dependencies
- `elvt-stack`
- `elvt-icon-button`
- `elvt-icon`

## Properties

### border
- **Type:** `CardBorder`
- **Attribute:** `border`
- **Reflects:** `true`
- **Default:** `'rounded'`
- **Description:** Border style of the card
- **Valid Values:** `'box' | 'none' | 'rounded'`

### closeable
- **Type:** `boolean`
- **Attribute:** `closeable`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Add a close button to the upper end corner of the card

### closeLabel
- **Type:** `string | undefined`
- **Attribute:** `close-label`
- **Reflects:** `true`
- **Description:** Label for the close button (for accessibility)

### layer
- **Type:** `CardLayer`
- **Attribute:** `layer`
- **Reflects:** `true`
- **Default:** `'ground'`
- **Description:** Elevation level of the card
- **Valid Values:** `'ground' | 'raised' | 'elevated' | 'popover' | 'overlay' | 'sunken'`

### tone
- **Type:** `Tone`
- **Attribute:** `tone`
- **Reflects:** `true`
- **Default:** `'neutral'`
- **Description:** Color tone of the card

### scrollable
- **Type:** `boolean`
- **Attribute:** `scrollable`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Enable scrolling for card content

### padding
- **Type:** `Padding | string | undefined`
- **Attribute:** `padding`
- **Reflects:** `true`
- **Default:** `'0'`
- **Description:** The padding will apply to all parts of the card. For individual paddings use stack elements inside the parts

## Slots

### (default)
Card content area

### header
Card header content

### footer
Card footer content

## Events

### elvt-request-close
- **Type:** `Event`
- **Description:** Emitted when the close button is clicked

## Internationalization

Supports `CardIntl` interface for localizing:
- `closeLabel` - Button label for close action (visually hidden, default: "Close")

## CSS Parts

- `ground` - The card's ground container
- `header` - The header section
- `content` - The content section
- `footer` - The footer section

## Usage Notes
- Padding applies uniformly to all card parts
- When `closeable` is true, close button appears in the header if present, otherwise in the content area
- Layer property controls visual elevation and shadow
- Border styles affect corner rounding and borders
- Header and footer slots are only rendered if they have content
