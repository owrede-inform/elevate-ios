# Headline Component

## Overview
Headline component with optional overline and subtitle. Different font styles are available based on size.

**Category:** Structure
**Tag Name:** `elvt-headline`
**Since:** 0.0.38
**Status:** Unstable

## Properties

### size
- **Type:** `HeadlineSize`
- **Attribute:** `size`
- **Reflects:** `true`
- **Default:** `'m'`
- **Description:** The headline's size defines the used font styles
- **Valid Values:** `'2xs' | 'xs' | 's' | 'm' | 'l' | 'xl'`

### level
- **Type:** `1 | 2 | 3 | 4 | 5 | 6`
- **Attribute:** `level`
- **Reflects:** `true`
- **Default:** `2`
- **Description:** The title and subtitle are wrapped into an `h{level}` element to provide a hierarchical structure

### overline
- **Type:** `string | undefined`
- **Attribute:** `overline`
- **Reflects:** `true`
- **Description:** The overline is shown above the title

### subtitle
- **Type:** `string | undefined`
- **Attribute:** `subtitle`
- **Reflects:** `true`
- **Description:** The subtitle is shown below the title

## Slots

### (default)
The title text

### overline
A presentational overline displayed above the title

### subtitle
A subtitle displayed below the title

### end
Additional slot for elements at the end of the headline row

## Usage Notes
- The `level` property controls semantic heading level (h1-h6) for accessibility
- The `size` property controls visual styling independently from semantic level
- This allows you to maintain proper document outline while having flexible visual design
- Overline and subtitle can be provided via attribute or slot
- The `end` slot is useful for actions or icons aligned to the end of the headline
- Size options range from `2xs` (smallest) to `xl` (largest)
- Level is automatically clamped between 1 and 6
