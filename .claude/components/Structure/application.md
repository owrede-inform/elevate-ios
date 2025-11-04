# Application Component

## Overview
Application acts as a main container providing services to its children and maintaining state. It provides dependency injection, theme management, and layout structure for the application.

**Category:** Structure
**Tag Name:** `elvt-application`
**Since:** 0.0.7
**Status:** Unstable

## Properties

### root
- **Type:** `boolean`
- **Attribute:** `root`
- **Reflects:** `true`
- **Default:** `false`
- **Description:** Setting `root` will disable inheritance and set the theme only for this container

### theme
- **Type:** `string | undefined`
- **Attribute:** `theme`
- **Reflects:** `true`
- **Description:** The identifier/name of the theme. It needs to start with an ASCII letter and consists of only ASCII letters and digits. Setting this value will apply CSS classes to the body element to activate the theme

### providers
- **Type:** `DependencyProvider[]`
- **Attribute:** `false`
- **Description:** Array of dependency providers for the application container. Supports dependency injection for child components

## Dependency Container

The component provides a `DependencyContainer` that offers:
- `ELVT_DIALOG` - DialogManager for managing dialogs
- `ELVT_ICONS` - Icon registry for icon management

## Slots

### (default)
Content area

### header
At the top of the component. Children are aligned horizontally

### footer
At the bottom of the component. Children are aligned horizontally

### side-start
At the start side of the component (in reading direction). Children are aligned vertically

### side-end
At the end side of the component (in reading direction). Children are aligned vertically

## Static Methods

### getAsAncestor(descendant: Element)
Fetches the nearest ApplicationComponent instance on the ancestor axis of its descendant

## Usage Notes
- The `header` and `footer` slots align their children horizontally, all others vertically
- The `side-start` and `side-end` are positioned depending on the reading direction
- Padding and gap have to be defined inside the slots
- Nested `elvt-application` instances will inherit theme and services from their ancestor unless `root` is set to `true`
- Theme identifier must match pattern: `[a-z][a-z0-9]*`
- Provides dependency injection infrastructure for child components
