# iOS Adaptations from ELEVATE Web Patterns

**Purpose**: This document tracks every deviation from ELEVATE web UI patterns to iOS-native best practices. When updating from new ELEVATE versions, recreate these exact adaptations to maintain iOS-native feel.

**Last Updated**: 2025-11-06

---

## 🎯 Adaptation Philosophy

### Core Principles
1. **Touch-First**: All interactions optimized for fingers, not mouse pointers
2. **Native Patterns**: Use iOS-standard UI patterns even if web differs
3. **Accessibility**: Follow iOS accessibility guidelines, not web ARIA
4. **Gestures**: Leverage iOS gestures (swipe, long-press, pinch)
5. **Platform Integration**: Integrate with iOS system features (haptics, notifications)

### Minimum Touch Targets
- **Web ELEVATE**: 32px × 32px
- **iOS Adaptation**: 44pt × 44pt (55pt × 55pt recommended)

---

## 📋 Component-Specific Documentation

**All 52 components have individual iOS adaptation documentation** in [`.claude/components/`](../.claude/components/).

Each component file documents:
- ELEVATE web pattern (original behavior)
- iOS adaptations made (with ✅ checkmarks)
- Reasoning for changes
- Implementation notes and code examples
- Related components

### Navigation & Links (9 components)
- [Breadcrumb](../.claude/components/Breadcrumb.md) - iOS breadcrumb navigation
- [BreadcrumbItem](../.claude/components/BreadcrumbItem.md) - Individual breadcrumb items
- [Button](../.claude/components/Button.md) - Touch-optimized buttons
- [ButtonGroup](../.claude/components/ButtonGroup.md) - Button grouping patterns
- [IconButton](../.claude/components/IconButton.md) - Icon-only buttons
- [Link](../.claude/components/Link.md) - Navigation links
- [Menu](../.claude/components/Menu.md) - Context menus
- [MenuItem](../.claude/components/MenuItem.md) - Menu items
- [NavigationItem](../.claude/components/NavigationItem.md) - NavigationLink integration

### Form Components (14 components)
- [Checkbox](../.claude/components/Checkbox.md) - Boolean input (prefer Toggle on iOS)
- [Chip](../.claude/components/Chip.md) - Selectable chips
- [Dropdown](../.claude/components/Dropdown.md) - Context menus and action sheets
- [Dropzone](../.claude/components/Dropzone.md) - File selection with native pickers
- [Field](../.claude/components/Field.md) - Form field wrapper
- [Input](../.claude/components/Input.md) - Text input with keyboard types
- [Radio](../.claude/components/Radio.md) - Radio button selection
- [RadioGroup](../.claude/components/RadioGroup.md) - Radio button groups
- [RequiredIndicator](../.claude/components/RequiredIndicator.md) - Required field marker
- [Select](../.claude/components/Select.md) - Picker and searchable lists
- [Slider](../.claude/components/Slider.md) - Value slider
- [Switch](../.claude/components/Switch.md) - Toggle switch (iOS native)
- [TextArea](../.claude/components/TextArea.md) - Multi-line text input
- [TextField](../.claude/components/TextField.md) - Single-line text input

### Display Components (9 components)
- [Avatar](../.claude/components/Avatar.md) - User avatar with initials
- [Badge](../.claude/components/Badge.md) - Notification badges
- [Card](../.claude/components/Card.md) - Content cards
- [Divider](../.claude/components/Divider.md) - Visual separators
- [EmptyState](../.claude/components/EmptyState.md) - Empty content states
- [Headline](../.claude/components/Headline.md) - Section headings
- [Icon](../.claude/components/Icon.md) - SF Symbols integration
- [Progress](../.claude/components/Progress.md) - Progress indicators
- [Skeleton](../.claude/components/Skeleton.md) - Loading placeholders

### Layout Components (5 components)
- [Application](../.claude/components/Application.md) - Root app container
- [SplitPanel](../.claude/components/SplitPanel.md) - Resizable split views
- [Stack](../.claude/components/Stack.md) - Layout stacking
- [Table](../.claude/components/Table.md) - Data tables with List
- [Toolbar](../.claude/components/Toolbar.md) - Navigation toolbars

### Overlay Components (5 components)
- [Dialog](../.claude/components/Dialog.md) - Modal sheets
- [Drawer](../.claude/components/Drawer.md) - Side panels
- [Lightbox](../.claude/components/Lightbox.md) - Image viewer with gestures
- [Notification](../.claude/components/Notification.md) - Toast notifications
- [Tooltip](../.claude/components/Tooltip.md) - Long-press tooltips

### Interactive Components (9 components)
- [ExpansionPanel](../.claude/components/ExpansionPanel.md) - Expandable sections
- [Indicator](../.claude/components/Indicator.md) - Status indicators
- [Paginator](../.claude/components/Paginator.md) - Page navigation
- [Stepper](../.claude/components/Stepper.md) - Step-by-step UI
- [StepperItem](../.claude/components/StepperItem.md) - Individual steps
- [Tab](../.claude/components/Tab.md) - Tab items
- [TabBar](../.claude/components/TabBar.md) - Top tab bar (web pattern)
- [TabGroup](../.claude/components/TabGroup.md) - Tab navigation (iOS patterns)
- [Tree](../.claude/components/Tree.md) - Hierarchical trees with DisclosureGroup

### Utility Components (2 components)
- [Scrollbar](../.claude/components/Scrollbar.md) - System scroll indicators
- [VisuallyHidden](../.claude/components/VisuallyHidden.md) - Accessibility helpers

---

## 🎨 Universal iOS Adaptations

These adaptations apply to **ALL components**:

### ❌ Removed from Web
- **No hover states** - Touch devices have no hover hardware
- **No mouse cursors** - Use press states and haptic feedback instead
- **No keyboard shortcuts** - iOS uses gestures and screen navigation
- **No scroll-jacking** - Respect native iOS scroll behavior

### ✅ Added for iOS
- **Haptic feedback** - UIImpactFeedbackGenerator on interactions
- **44pt minimum touch targets** - All tappable elements meet iOS standards
- **SF Symbols** - 30,000+ native icons via `Image(systemName:)`
- **Native gestures** - Swipe, long-press, pinch-to-zoom, double-tap
- **Size class adaptation** - Different layouts for iPhone vs iPad
- **Safe area respect** - Automatic safe area insets
- **Dynamic Type** - Text scales with accessibility settings
- **VoiceOver support** - Screen reader accessibility
- **Dark mode** - Color.adaptive() for all colors

### 🔄 State Mappings
```
Web Hover    → iOS Press (via @GestureState)
Web Focus    → iOS Focused (@FocusState)
Web Active   → iOS Press (tap down)
Web Disabled → iOS Disabled (.disabled)
```

### 📏 Spacing Conversions
```
Web (px) → iOS (pt)
8px  → 8pt
16px → 16pt
24px → 24pt
32px → 44pt (touch target minimum)
```

---

## 🔄 Update Procedure

When updating from new ELEVATE version:

### 1. Regenerate Tokens
```bash
rm ElevateUI/Sources/DesignTokens/.token_cache.json
python3 scripts/update-design-tokens-v4.py
```

### 2. Review Each Component
For each changed component:
- [ ] Open its documentation in `.claude/components/[ComponentName].md`
- [ ] Review documented iOS adaptations
- [ ] Check if new ELEVATE patterns conflict with iOS adaptations
- [ ] Update component implementation to match documented patterns

### 3. Reapply Adaptations
For each component update:
- Recreate each iOS adaptation exactly as documented
- Remove any hover states introduced by web updates
- Add haptic feedback if missing
- Verify 44pt minimum touch targets
- Test on both iPhone and iPad
- Verify gestures work correctly
- Test with VoiceOver

### 4. Document New Diversions
If new ELEVATE patterns require iOS adaptation:
- Update the component's `.claude/components/[ComponentName].md` file
- Add the new adaptation with ✅ checkbox
- Explain the reasoning
- Provide code examples
- Update the diversion log below

### 5. Test Matrix
After any component update:
- [ ] iPhone (compact width)
- [ ] iPad (regular width)
- [ ] Light mode
- [ ] Dark mode
- [ ] Largest accessibility text size (Accessibility Inspector)
- [ ] VoiceOver enabled
- [ ] All gestures work (swipe, long-press, pinch, etc.)
- [ ] Haptic feedback present
- [ ] No hover states remain

---

## 📝 Diversion Log

### 2025-11-06: Comprehensive Documentation
- Split DIVERSIONS.md into 52 component-specific files
- Each component now has individual iOS adaptation documentation
- Documented ALL components (not just initial 12)
- Created `.claude/components/` directory for component docs
- Updated update procedure to reference component files

### 2025-11-06: Phase 3 - Utility Components
- Implemented Icon with SF Symbols (30,000+ native icons)
- Implemented NavigationItem with NavigationLink patterns
- Implemented RequiredIndicator for form fields
- Implemented Dropzone with native file pickers
- Implemented Application root container
- Implemented Scrollbar utilities (system indicators)

### 2025-11-06: Phase 2 - Layout Components
- Implemented Table with iOS List patterns and swipe actions
- Implemented TabGroup with segmented control and TabView
- Implemented SplitPanel with touch-optimized 44pt drag targets
- Implemented Tree with DisclosureGroup

### 2025-11-06: Phase 1 - Core Interactive Components
- Implemented Dialog with native sheet presentation
- Implemented Drawer with size class adaptation
- Implemented Input with keyboard types and AutoFill
- Implemented Select with Menu picker and searchable sheets
- Implemented Dropdown with context menus and action sheets
- Implemented Lightbox with iOS Photos gestures

### 2025-11-06: Initial iOS Port
- Created foundation with iOS-native patterns
- Documented initial major diversions
- Established adaptation philosophy
- Implemented 39 initial components from web ELEVATE

### [Future updates will be logged here]

---

## 🎓 iOS Design Resources

**Apple Human Interface Guidelines**:
- https://developer.apple.com/design/human-interface-guidelines/
- Modality: https://developer.apple.com/design/human-interface-guidelines/modality
- Navigation: https://developer.apple.com/design/human-interface-guidelines/navigation
- Gestures: https://developer.apple.com/design/human-interface-guidelines/touchscreen-gestures
- Typography: https://developer.apple.com/design/human-interface-guidelines/typography
- SF Symbols: https://developer.apple.com/design/human-interface-guidelines/sf-symbols

**SwiftUI Documentation**:
- Sheets: https://developer.apple.com/documentation/swiftui/view/sheet
- Popovers: https://developer.apple.com/documentation/swiftui/view/popover
- Pickers: https://developer.apple.com/documentation/swiftui/picker
- NavigationStack: https://developer.apple.com/documentation/swiftui/navigationstack
- TabView: https://developer.apple.com/documentation/swiftui/tabview

**Accessibility**:
- VoiceOver Testing: https://developer.apple.com/documentation/accessibility/voiceover
- Dynamic Type: https://developer.apple.com/documentation/uikit/uifont/scaling_fonts_automatically
- Accessibility Inspector: Use Xcode's Accessibility Inspector tool

---

**Remember**: These diversions make ELEVATE feel native on iOS. Don't blindly copy web patterns to touch devices. Always consult the component-specific documentation in `.claude/components/` when updating components.
