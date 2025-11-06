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

## 📋 Component-by-Component Diversions

### 1. Dialog Component
**ELEVATE Web Pattern**:
- Fixed modal with backdrop
- Close via X button or ESC key
- Animated fade-in

**iOS Adaptation**:
- ✅ Use native `.sheet()` or `.fullScreenCover()` modifiers
- ✅ Support drag-to-dismiss gesture (sheet only)
- ✅ Haptic feedback on present/dismiss
- ✅ Adapt to safe areas automatically
- ✅ Support keyboard avoidance
- ✅ Use `.presentationDetents()` for partial sheets

**Reason**: iOS users expect native sheet behavior with drag gestures. Web-style fixed modals feel foreign on iOS.

**Implementation Notes**:
```swift
// NOT web-style fixed overlay
// YES: Native sheet presentation
.sheet(isPresented: $showDialog) {
    DialogContent()
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
}
```

---

### 2. Drawer Component
**ELEVATE Web Pattern**:
- Slide from left/right
- Fixed width overlay
- Click outside to close

**iOS Adaptation**:
- ✅ Use `.sheet()` with edge attachment on iPad
- ✅ Use `.fullScreenCover()` with custom slide on iPhone
- ✅ Support swipe-back gesture
- ✅ Adapt width for size classes (compact/regular)
- ✅ On iPhone: Full-screen or large sheet
- ✅ On iPad: Sidebar or popover style

**Reason**: iOS has distinct UI patterns for iPhone (sheets) vs iPad (popovers/split views). Web-style drawers don't adapt well.

**Size Class Adaptations**:
- Compact width (iPhone): Full-screen sheet or large detent
- Regular width (iPad): Sidebar (300pt width) or popover

---

### 3. Input Component
**ELEVATE Web Pattern**:
- Standard input with border
- Hover states
- Focus ring

**iOS Adaptation**:
- ✅ Use native `TextField` with iOS styling
- ✅ **Remove hover states** (no mouse on iOS)
- ✅ Use `.focused()` instead of hover
- ✅ Support iOS keyboard types (`.emailAddress`, `.numberPad`)
- ✅ Add `.textContentType()` for AutoFill support
- ✅ Support `.submitLabel()` for keyboard return key
- ✅ Use `.toolbar()` with keyboard accessory view for done/next

**Reason**: iOS has no hover. Native keyboard integration is essential.

**Critical Differences**:
```swift
// NO: Hover states from web
// YES: Focused states only
TextField("Placeholder", text: $value)
    .focused($isFocused)
    .textContentType(.emailAddress)  // iOS AutoFill
    .keyboardType(.emailAddress)     // iOS keyboard
    .submitLabel(.done)              // iOS return key
```

---

### 4. Select Component
**ELEVATE Web Pattern**:
- Dropdown list with options
- Click to open, click to select
- Scroll within dropdown

**iOS Adaptation**:
- ✅ Use **Picker** with `.wheel` style (default iOS pattern)
- ✅ Alternative: `.menu` style for compact lists
- ✅ Present in sheet for long lists
- ✅ Support search when >20 items
- ✅ Use `List` with checkmarks for multi-select
- ✅ **Never** use web-style hover dropdown on touch

**Reason**: iOS users expect picker wheels or action sheets, not hover dropdowns.

**Pattern Decision Tree**:
```
Select Component Needed?
├─ Single selection?
│  ├─ <10 items? → Picker(.menu)
│  └─ ≥10 items? → Sheet with searchable List
└─ Multiple selection? → Sheet with List + checkmarks
```

---

### 5. Dropdown Component
**ELEVATE Web Pattern**:
- Hover to reveal options
- Click to select
- Nested menus

**iOS Adaptation**:
- ✅ Use `.contextMenu()` for long-press menus
- ✅ Use `.menu()` button for tap menus
- ✅ Use `ActionSheet` for destructive actions
- ✅ **No hover triggers** - use tap or long-press
- ✅ Support haptic feedback on open

**Reason**: Touch has no hover. iOS patterns use tap or long-press.

**Gesture Mapping**:
- Web hover → iOS long-press (`.contextMenu()`)
- Web click → iOS tap (`.menu()`)
- Web nested → iOS hierarchical menu

---

### 6. Lightbox Component
**ELEVATE Web Pattern**:
- Full-screen image overlay
- Previous/next buttons
- Close button

**iOS Adaptation**:
- ✅ Use **pinch-to-zoom** gesture
- ✅ Use **double-tap to zoom** (iOS Photos pattern)
- ✅ Use **swipe down to dismiss** (sheet)
- ✅ Show share button (iOS share sheet)
- ✅ Support **image saving** to Photos
- ✅ Full-screen with status bar hidden
- ✅ Paging for multiple images (horizontal scroll)

**Reason**: iOS users expect Photos app behavior. Web lightboxes miss native gestures.

**Critical iOS Gestures**:
```swift
.simultaneousGesture(MagnificationGesture())  // Pinch zoom
.simultaneousGesture(TapGesture(count: 2))    // Double-tap zoom
.gesture(DragGesture())                       // Swipe dismiss
```

---

### 7. Table Component
**ELEVATE Web Pattern**:
- Grid layout with headers
- Horizontal scroll
- Row hover states

**iOS Adaptation**:
- ✅ Use `List` for most cases (native iOS pattern)
- ✅ Use `Table` (iOS 16+) for true tabular data
- ✅ **No hover states**
- ✅ Support swipe actions (delete, edit)
- ✅ Support reordering with drag handle
- ✅ Use `.listRowInsets()` for proper spacing
- ✅ Support pull-to-refresh

**Reason**: iOS Lists feel native and support gestures. Web tables don't translate well.

---

### 8. Tab Component
**ELEVATE Web Pattern**:
- Horizontal tab bar
- Click to switch
- Underline indicator

**iOS Adaptation**:
- ✅ Use **native TabView** for bottom tabs (iOS standard)
- ✅ Use **Picker(.segmented)** for top segment control
- ✅ Place navigation tabs at **bottom** (iOS convention)
- ✅ Place segmented controls at **top** (iOS convention)
- ✅ Use SF Symbols for tab icons
- ✅ Support badge indicators (native `.badge()`)

**Reason**: iOS tabs go at bottom, segments at top. This is platform convention.

**Position Guidelines**:
```
Tab Placement:
├─ Bottom Navigation → TabView (main app navigation)
└─ Top Segments → Picker(.segmented) (view filtering)
```

**Note**: We implemented `ElevateTabBar` for top tabs (web pattern) but recommend native TabView for bottom navigation.

---

### 9. Checkbox & Switch
**ELEVATE Web Pattern**:
- Checkbox for boolean
- Custom styled

**iOS Adaptation**:
- ✅ Use native **Toggle** (not Checkbox) for iOS
- ✅ Checkbox appearance is Android pattern
- ✅ iOS users expect Toggle switches
- ✅ Use List with Toggle for settings screens

**Reason**: iOS uses Toggle switches. Checkboxes appear in web/Android but not iOS.

**Platform Differences**:
- Web/Android: Checkbox ☑️
- iOS: Toggle switch (slide control)

**Note**: We implemented `ElevateCheckbox` for web compatibility, but recommend `Toggle` in iOS-native contexts.

---

### 10. Button Hover States
**ELEVATE Web Pattern**:
- Hover changes color
- Cursor changes to pointer

**iOS Adaptation**:
- ✅ **Remove all hover states** (no mouse)
- ✅ Use **pressed state only** (via `@GestureState`)
- ✅ Add **haptic feedback** on tap
- ✅ Increase touch target to 44pt minimum
- ✅ Use `buttonStyle` for consistent press behavior

**Reason**: Touch devices have no hover. Haptics replace visual feedback.

**Hover → iOS State Mapping**:
```
Web Hover → iOS Pressed (not implemented, no hover hardware)
Web Active → iOS Pressed (tap down)
Web Focus → iOS Focused (keyboard/VoiceOver)
```

---

### 11. Tooltip Component
**ELEVATE Web Pattern**:
- Show on hover
- Fixed positioning

**iOS Adaptation**:
- ✅ Use **long-press** instead of hover
- ✅ Use **action sheet** for extensive help
- ✅ Consider **Popover** (iPad) instead of tooltip
- ✅ Auto-dismiss after 3-5 seconds
- ✅ Support VoiceOver hints (not visual tooltips)

**Reason**: No hover on touch. Long-press or help buttons replace tooltips.

**Note**: We implemented `ElevateTooltip` with long-press trigger. Web's hover-based tooltips adapted to tap-and-hold.

---

### 12. Form Layout & Validation
**ELEVATE Web Pattern**:
- Inline validation messages
- Submit button at bottom
- Tab navigation

**iOS Adaptation**:
- ✅ Use `Form` and `Section` for native iOS layout
- ✅ Validation errors in **sheet** or **inline below field**
- ✅ "Done" in **navigation bar** (not bottom submit button)
- ✅ Use `.toolbar()` with keyboard to add done/next
- ✅ Support keyboard navigation automatically

**Reason**: iOS forms use Settings-style layout with sections.

---

### 13. Spacing & Sizing
**ELEVATE Web Pattern**:
- Pixel-based spacing (8px, 16px, 24px)
- Fixed widths

**iOS Adaptation**:
- ✅ Use **Dynamic Type** (scalable text)
- ✅ Convert px to pt (1pt ≈ 1px on 1x displays)
- ✅ Support accessibility text sizes
- ✅ Use `.dynamicTypeSize()` modifiers
- ✅ Respect user's text size preferences

**Conversion Table**:
```
ELEVATE (px) → iOS (pt)
8px  → 8pt
12px → 12pt
16px → 16pt
24px → 24pt
32px → 32pt (min touch target)
44px → 44pt (recommended touch target)
```

---

### 14. Typography
**ELEVATE Web Pattern**:
- Web fonts (Inter, system fonts)
- Fixed font sizes

**iOS Adaptation**:
- ✅ Use **SF Pro** (system font) as primary
- ✅ Support **Dynamic Type** scaling
- ✅ Use `.font(.title)`, `.font(.body)` etc.
- ✅ Custom fonts (Inter) as fallback/brand option
- ✅ Test all UI with largest accessibility text size

**Font Hierarchy**:
```
Primary: SF Pro (system)
Brand: Inter (from ELEVATE, optional)
```

---

### 15. Colors & Dark Mode
**ELEVATE Web Pattern**:
- Fixed light/dark color values
- CSS media query for dark mode

**iOS Adaptation**:
- ✅ Use `Color.adaptive(light:dark:)` helper
- ✅ Respect iOS system appearance
- ✅ Support auto-switching with system
- ✅ Test in both modes always
- ✅ Use semantic colors when possible

**Implementation**: Already implemented via `ColorAdaptive.swift` - no diversion needed.

---

### 16. Navigation Patterns
**ELEVATE Web Pattern**:
- Top navigation bar
- Breadcrumbs
- URL routing

**iOS Adaptation**:
- ✅ Use `NavigationStack` for hierarchical navigation
- ✅ Use `TabView` for bottom tabs
- ✅ Use `.navigationTitle()` for page titles
- ✅ Use `.toolbar()` for actions
- ✅ Support swipe-back gesture automatically
- ✅ Breadcrumbs → Navigation bar title (iOS uses back button)

**Reason**: iOS uses drill-down navigation, not breadcrumbs.

---

### 17. Gestures Summary
**Added iOS Gestures Not in Web ELEVATE**:

| Gesture | Component | Purpose |
|---------|-----------|---------|
| Swipe down | Dialog, Drawer, Lightbox | Dismiss |
| Long-press | Tooltip, Dropdown | Show options |
| Pinch | Lightbox | Zoom image |
| Double-tap | Lightbox | Toggle zoom |
| Swipe left/right | Table rows | Actions (delete, edit) |
| Pull down | List | Refresh |
| Drag | Dialog sheet | Resize/dismiss |

---

### 18. Animation Timing
**ELEVATE Web Pattern**:
- CSS transitions (200-300ms)
- Cubic bezier easing

**iOS Adaptation**:
- ✅ Use `.animation(.spring())` for natural feel
- ✅ Shorter durations (150-250ms typical)
- ✅ Match iOS system animation curves
- ✅ Use `.transition()` for appear/disappear

**iOS Standard Timings**:
```swift
.animation(.spring(response: 0.3, dampingFraction: 0.8))  // Default
.animation(.easeInOut(duration: 0.2))                     // Quick
.animation(.spring(response: 0.4, dampingFraction: 0.7))  // Bouncy
```

---

### 19. Accessibility Differences
**ELEVATE Web Pattern**:
- ARIA labels
- Keyboard navigation
- Focus management

**iOS Adaptation**:
- ✅ Use `.accessibilityLabel()` (not ARIA)
- ✅ Support **VoiceOver** (screen reader)
- ✅ Support **Dynamic Type** (text scaling)
- ✅ Use `.accessibilityAction()` for custom actions
- ✅ Test with VoiceOver enabled
- ✅ Support **Voice Control** commands

**Accessibility Checklist**:
- [ ] All interactive elements have labels
- [ ] Minimum 44pt touch targets
- [ ] Supports Dynamic Type
- [ ] Works with VoiceOver
- [ ] Appropriate accessibility traits
- [ ] Custom actions where needed

---

### 20. Loading & Progress States
**ELEVATE Web Pattern**:
- Spinner overlays
- Progress bars

**iOS Adaptation**:
- ✅ Use `.progressViewStyle(.circular)` for spinners
- ✅ Use `.progressViewStyle(.linear)` for bars
- ✅ Consider **pull-to-refresh** instead of reload button
- ✅ Use `.refreshable()` modifier (iOS 15+)
- ✅ Show loading in **navigation bar** for page loads

---

## 🔄 Update Procedure

When updating from new ELEVATE version:

### 1. Regenerate Tokens
```bash
rm ElevateUI/Sources/DesignTokens/.token_cache.json
python3 scripts/update-design-tokens-v4.py
```

### 2. Review Each Component
For each component, check this document:
- [ ] Does it have iOS adaptations listed?
- [ ] Are the adaptations still valid?
- [ ] Do new ELEVATE patterns conflict?

### 3. Reapply Adaptations
- Recreate each diversion exactly as documented
- Test on both iPhone and iPad
- Verify gestures work correctly
- Test with VoiceOver

### 4. Document New Diversions
If new patterns require adaptation:
- Document the change in this file
- Explain the reasoning
- Provide code examples
- Update memory store

### 5. Test Matrix
- [ ] iPhone (compact width)
- [ ] iPad (regular width)
- [ ] Light mode
- [ ] Dark mode
- [ ] Largest accessibility text size
- [ ] VoiceOver enabled
- [ ] All gestures work

---

## 📝 Diversion Log

### 2025-11-06: Initial iOS Port
- Created foundation with iOS-native patterns
- Documented all major diversions
- Established adaptation philosophy

### [Future updates will be logged here]

---

## 🎓 iOS Design Resources

**Apple Human Interface Guidelines**:
- https://developer.apple.com/design/human-interface-guidelines/
- Modality: https://developer.apple.com/design/human-interface-guidelines/modality
- Navigation: https://developer.apple.com/design/human-interface-guidelines/navigation
- Gestures: https://developer.apple.com/design/human-interface-guidelines/touchscreen-gestures

**SwiftUI Documentation**:
- Sheets: https://developer.apple.com/documentation/swiftui/view/sheet
- Popovers: https://developer.apple.com/documentation/swiftui/view/popover
- Pickers: https://developer.apple.com/documentation/swiftui/picker

---

**Remember**: These diversions make ELEVATE feel native on iOS. Don't blindly copy web patterns to touch devices.
