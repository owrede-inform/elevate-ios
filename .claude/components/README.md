# ELEVATE Core UI Component API Reference

This directory contains comprehensive API documentation extracted from the [ELEVATE Core UI](https://github.com/inform-elevate/elevate-core-ui) Web Components library (v0.0.41-alpha).

## Purpose

These markdown files serve as reference documentation for implementing ELEVATE components in iOS using SwiftUI and UIKit. Each file documents the web component's API, behavior, design tokens, and provides guidance for iOS implementation.

## Documentation Structure

Each component documentation file includes:

- **Metadata**: Web component name, category, status, and version
- **Properties**: All configurable attributes with types, defaults, and descriptions
- **Slots**: Content injection points
- **Events**: User interactions and state changes
- **CSS Parts/Properties**: Styling customization points
- **Methods**: Public API methods
- **Behavior Notes**: Implementation details and special behaviors
- **Design Token Mapping**: Color, spacing, and typography specifications
- **iOS Implementation Notes**: SwiftUI and UIKit adaptation guidance
- **Related Components**: Cross-references to related components

## Component Categories

### 🔵 Navigation (19 components)

| Component | Status | File |
|-----------|--------|------|
| Button | Complete ✅ | [button.md](Navigation/button.md) |
| Button Group | Complete ✅ | [button-group.md](Navigation/button-group.md) |
| Breadcrumb | Complete ✅ | [breadcrumb.md](Navigation/breadcrumb.md) |
| Breadcrumb Item | Complete ✅ | [breadcrumb-item.md](Navigation/breadcrumb-item.md) |
| Icon Button | Unstable 🟡 | [icon-button.md](Navigation/icon-button.md) |
| Link | Complete ✅ | [link.md](Navigation/link.md) |
| Menu | Preliminary 🟠 | [menu.md](Navigation/menu.md) |
| Menu Item | Unstable 🟡 | [menu-item.md](Navigation/menu-item.md) |
| Menu Label | Unstable 🟡 | [menu-label.md](Navigation/menu-label.md) |
| Navigation | Unstable 🟡 | [navigation.md](Navigation/navigation.md) |
| Navigation Item | Unstable 🟡 | [navigation-item.md](Navigation/navigation-item.md) |
| Navigation Label | Unstable 🟡 | [navigation-label.md](Navigation/navigation-label.md) |
| Paginator | Unstable 🟡 | [paginator.md](Navigation/paginator.md) |
| Stepper | Complete ✅ | [stepper.md](Navigation/stepper.md) |
| Stepper Item | Complete ✅ | [stepper-item.md](Navigation/stepper-item.md) |
| Tab | Complete ✅ | [tab.md](Navigation/tab.md) |
| Tab Group | Complete ✅ | [tab-group.md](Navigation/tab-group.md) |
| Tab Panel | Complete ✅ | [tab-panel.md](Navigation/tab-panel.md) |

**iOS Implementation Status:**
- ✅ Implemented: Button (SwiftUI + UIKit)
- ⏳ Pending: 18 components

### 🟢 Display (10 components)

| Component | Status | File |
|-----------|--------|------|
| Badge | Complete ✅ | [badge.md](Display/badge.md) |
| Chip | Unstable 🟡 | [chip.md](Display/chip.md) |
| Icon | Complete ✅ | [icon.md](Display/icon.md) |
| Indicator | Complete ✅ | [indicator.md](Display/indicator.md) |
| Skeleton | Complete ✅ | [skeleton.md](Display/skeleton.md) |
| Table | Experimental 🔬 | [table.md](Display/table.md) |
| Table Cell | Experimental 🔬 | [table-cell.md](Display/table-cell.md) |
| Table Column | Experimental 🔬 | [table-column.md](Display/table-column.md) |
| Table Row | Experimental 🔬 | [table-row.md](Display/table-row.md) |
| Visually Hidden | Stable 🟢 | [visually-hidden.md](Display/visually-hidden.md) |

**iOS Implementation Status:**
- ⏳ Pending: All 10 components

### 🟡 Forms (13 components)

| Component | Status | File |
|-----------|--------|------|
| Checkbox | Unstable 🟡 | [checkbox.md](Forms/checkbox.md) |
| Dropzone | Complete ✅ | [dropzone.md](Forms/dropzone.md) |
| Field | Unstable 🟡 | [field.md](Forms/field.md) |
| Input | Preliminary 🟠 | [input.md](Forms/input.md) |
| Radio | Complete ✅ | [radio.md](Forms/radio.md) |
| Radio Button | Unstable 🟡 | [radio-button.md](Forms/radio-button.md) |
| Radio Group | Complete ✅ | [radio-group.md](Forms/radio-group.md) |
| Select | Unstable 🟡 | [select.md](Forms/select.md) |
| Select Option | Unstable 🟡 | [select-option.md](Forms/select-option.md) |
| Select Option Group | Unstable 🟡 | [select-option-group.md](Forms/select-option-group.md) |
| Slider | Unstable 🟡 | [slider.md](Forms/slider.md) |
| Switch | Stable 🟢 | [switch.md](Forms/switch.md) |
| Textarea | Preliminary 🟠 | [textarea.md](Forms/textarea.md) |

**iOS Implementation Status:**
- ⏳ Pending: All 13 components

### 🔴 Structure (9 components)

| Component | Status | File |
|-----------|--------|------|
| Application | Unstable 🟡 | [application.md](Structure/application.md) |
| Card | Unstable 🟡 | [card.md](Structure/card.md) |
| Divider | Stable 🟢 | [divider.md](Structure/divider.md) |
| Expansion Panel | Complete ✅ | [expansion-panel.md](Structure/expansion-panel.md) |
| Expansion Panel Group | Complete ✅ | [expansion-panel-group.md](Structure/expansion-panel-group.md) |
| Headline | Unstable 🟡 | [headline.md](Structure/headline.md) |
| Split View | Unstable 🟡 | [split-view.md](Structure/split-view.md) |
| Stack | Unstable 🟡 | [stack.md](Structure/stack.md) |
| Toolbar | Complete ✅ | [toolbar.md](Structure/toolbar.md) |

**iOS Implementation Status:**
- ⏳ Pending: All 9 components

### 🟣 Overlays (4 components)

| Component | Status | File |
|-----------|--------|------|
| Dropdown | Preliminary 🟠 | [dropdown.md](Overlays/dropdown.md) |
| Lightbox | Unstable 🟡 | [lightbox.md](Overlays/lightbox.md) |
| Popup | Unstable 🟡 | [popup.md](Overlays/popup.md) |
| Tooltip | Preliminary 🟠 | [tooltip.md](Overlays/tooltip.md) |

**iOS Implementation Status:**
- ⏳ Pending: All 4 components

### 🟤 Feedback (2 components)

| Component | Status | File |
|-----------|--------|------|
| Notification | Unstable 🟡 | [notification.md](Feedback/notification.md) |
| Progress | Preliminary 🟠 | [progress.md](Feedback/progress.md) |

**iOS Implementation Status:**
- ⏳ Pending: Both components

## Status Legend

- ✅ **Complete**: Fully implemented and tested, API stable
- 🟢 **Stable**: API frozen, ready for production use
- 🟡 **Unstable**: Functional but API may change
- 🟠 **Preliminary**: Early stage, significant changes expected
- 🔬 **Experimental**: Proof of concept, major changes likely
- ⚠️ **Deprecated**: Avoid use, will be removed

## Statistics

- **Total Components Documented**: 57
- **Complete**: 18 components (32%)
- **Stable**: 4 components (7%)
- **Unstable**: 21 components (37%)
- **Preliminary**: 5 components (9%)
- **Experimental**: 4 components (7%)
- **Deprecated**: 1 component (2%) - Avatar (not documented)

### iOS Implementation Progress

- ✅ **Implemented**: 1 component (Button)
- ⏳ **Pending**: 56 components (98%)

## Implementation Priority

Based on component maturity and common use cases:

### Phase 1: Foundation (Priority: Critical)
- [x] Button
- [ ] Badge
- [ ] Icon
- [ ] Link

### Phase 2: Core UI (Priority: High)
**Forms:**
- [ ] Switch
- [ ] Radio + Radio Group
- [ ] Input
- [ ] Checkbox

**Structure:**
- [ ] Divider
- [ ] Card
- [ ] Toolbar

**Feedback:**
- [ ] Progress
- [ ] Skeleton

### Phase 3: Navigation (Priority: Medium)
- [ ] Tab Group + Tab + Tab Panel
- [ ] Breadcrumb + Breadcrumb Item
- [ ] Button Group
- [ ] Stepper + Stepper Item

### Phase 4: Advanced Forms (Priority: Medium)
- [ ] Select + Select Option
- [ ] Textarea
- [ ] Field
- [ ] Dropzone
- [ ] Slider

### Phase 5: Advanced UI (Priority: Low)
- [ ] Menu system
- [ ] Navigation system
- [ ] Expansion Panels
- [ ] Table system
- [ ] Overlays (Tooltip, Dropdown, Popup, Lightbox)

## Usage

When implementing a component in iOS:

1. **Read the component documentation** for API and behavior understanding
2. **Review Design Token Mapping** for exact colors, spacing, and typography
3. **Check iOS Implementation Notes** for platform-specific guidance
4. **Reference Related Components** for consistent patterns
5. **Follow the established patterns** from the Button implementation

## Source

Documentation extracted from:
- **Repository**: [inform-elevate/elevate-core-ui](https://github.com/inform-elevate/elevate-core-ui)
- **Version**: v0.0.41-alpha
- **Design Tokens**: @inform-elevate/elevate-design-tokens v0.37.0
- **Source Location**: `/Users/wrede/Documents/Elevate-2025-11-04/elevate-core-ui-main`

## Updates

Last updated: 2025-11-04

To update documentation:
1. Pull latest changes from elevate-core-ui repository
2. Re-run component extraction scripts
3. Verify changes against existing iOS implementations
4. Update version numbers and change notes
