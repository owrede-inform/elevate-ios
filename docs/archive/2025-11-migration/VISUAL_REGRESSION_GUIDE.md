# Visual Regression Testing Guide

**Version**: 1.0
**Last Updated**: 2025-11-11
**Status**: Active

---

## Table of Contents

- [Overview](#overview)
- [Quick Start](#quick-start)
- [Writing Visual Tests](#writing-visual-tests)
- [Running Tests](#running-tests)
- [Reviewing Failures](#reviewing-failures)
- [Updating Baselines](#updating-baselines)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)

---

## Overview

Visual regression testing captures screenshots of UI components and compares them against baseline images. This ensures that token updates and code changes don't introduce unintended visual breaks.

### What It Does

- **Captures**: Screenshots of components in light & dark modes
- **Compares**: New screenshots against baseline images
- **Detects**: Pixel-level visual differences
- **Reports**: Side-by-side comparisons with diff visualization

### When to Use

✅ **Use visual regression testing for**:
- Token system updates
- Component styling changes
- Cross-platform rendering validation
- Dark mode compatibility
- Typography changes

❌ **Don't use for**:
- Logic/behavior testing (use unit tests)
- Dynamic content (timestamps, random data)
- Network-dependent UIs

---

## Quick Start

### 1. Run Existing Tests

```bash
# Run all visual tests
xcodebuild test \
  -scheme ElevateUI \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:ElevateUITests/ButtonVisualTests
```

### 2. Check for Failures

```bash
# Check status
./scripts/update-visual-baselines.sh --status

# Generate HTML report
python3 scripts/visual-diff-report.py

# Open report in browser
open visual-regression-report.html
```

### 3. Approve Changes (if expected)

```bash
# Approve all changes
./scripts/update-visual-baselines.sh --all

# Or approve specific test
./scripts/update-visual-baselines.sh --test ButtonVisualTests

# Or approve specific snapshot
./scripts/update-visual-baselines.sh --snapshot Button_primary_default
```

### 4. Commit Baselines

```bash
git add ElevateUITests/__Snapshots__
git commit -m "Update visual baselines for Button component"
```

---

## Writing Visual Tests

### Basic Test Structure

```swift
import XCTest
import SwiftUI
@testable import ElevateUI

final class MyComponentVisualTests: SnapshotTestCase {

    override func setUp() {
        super.setUp()
        recordMode = false  // Set to true to record new baselines
    }

    func testComponentDefault() {
        let component = MyComponent()
        assertSnapshot(component, named: "MyComponent_default")
    }
}
```

### Test Naming Convention

Follow this pattern for snapshot names:

```
{ComponentName}_{Variant}_{State}_{mode}.png
```

Examples:
- `Button_primary_default_light.png`
- `Button_primary_default_dark.png`
- `Card_elevated_hover_light.png`
- `Input_small_focused_dark.png`

### Testing Multiple States

```swift
func testButtonAllTones() {
    assertAllStates(
        componentName: "Button",
        states: [
            "primary": {
                ElevateButton(title: "Primary", tone: .primary)
            },
            "danger": {
                ElevateButton(title: "Danger", tone: .danger)
            },
            "disabled": {
                ElevateButton(title: "Disabled", tone: .primary)
                    .disabled(true)
            }
        ]
    )
}
```

### Testing Custom Sizes

```swift
func testBadgeSmall() {
    let badge = ElevateBadge(text: "New", tone: .primary)
    assertSnapshotWithSize(
        badge,
        size: CGSize(width: 100, height: 40),
        named: "Badge_primary_small"
    )
}
```

### Testing Dark Mode Only

```swift
func testDarkModeContrast() {
    let button = ElevateButton(title: "Button", tone: .primary)
    assertSnapshot(
        button,
        colorScheme: .dark,
        named: "Button_primary_dark_contrast"
    )
}
```

### Testing Component Groups

```swift
func testButtonGroup() {
    let group = VStack(spacing: 12) {
        ElevateButton(title: "Save", tone: .primary)
        ElevateButton(title: "Cancel", tone: .secondary)
        ElevateButton(title: "Delete", tone: .danger)
    }
    .padding()
    .background(Color.white)
    .frame(width: 300, height: 250)

    assertSnapshotWithSize(
        group,
        size: CGSize(width: 300, height: 250),
        named: "Button_group_vertical"
    )
}
```

---

## Running Tests

### Run All Visual Tests

```bash
xcodebuild test \
  -scheme ElevateUI \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  | grep -A 5 "VisualTests"
```

### Run Specific Test Class

```bash
xcodebuild test \
  -scheme ElevateUI \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:ElevateUITests/ButtonVisualTests
```

### Run Specific Test Method

```bash
xcodebuild test \
  -scheme ElevateUI \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -only-testing:ElevateUITests/ButtonVisualTests/testButtonPrimaryDefault
```

### Recording New Baselines

To create initial baselines or update existing ones:

1. **Set record mode in test**:
```swift
override func setUp() {
    super.setUp()
    recordMode = true  // ⚠️ Enable recording
}
```

2. **Run tests** - baselines will be saved to `__Snapshots__/`

3. **Review snapshots** visually

4. **Disable record mode**:
```swift
recordMode = false  // ✅ Back to comparison mode
```

---

## Reviewing Failures

### Automatic HTML Report

After tests with failures:

```bash
# Generate report
python3 scripts/visual-diff-report.py

# Open in browser
open visual-regression-report.html
```

The report shows:
- ✅ **Baseline** (expected)
- ❌ **Current** (actual)
- 🔍 **Diff** (pixel differences highlighted)

### Manual Review

Snapshots are stored in:

```
ElevateUITests/__Snapshots__/
├── ButtonVisualTests/
│   ├── Button_primary_default_light.png        # Baseline
│   ├── Button_primary_default_light.1.png      # Failed snapshot
│   ├── Button_primary_default_light.diff.png   # Visual diff
│   └── ...
```

**File Meanings**:
- `.png` - Baseline (expected)
- `.1.png` - Current test result (failed)
- `.diff.png` - Visual diff (differences highlighted in red)

### Check Status

```bash
./scripts/update-visual-baselines.sh --status
```

Output:
```
⚠️  12 pending baseline update(s)

Failed snapshots by test:
   • ButtonVisualTests: 8 failure(s)
   • CardVisualTests: 4 failure(s)
```

---

## Updating Baselines

### When to Update

✅ **Update baselines when**:
- Token changes are intentional
- Component design has been updated
- Dark mode colors have been refined
- Typography has been adjusted

❌ **Don't update baselines for**:
- Unexpected visual breaks
- Unreviewed changes
- Random rendering differences

### Update All Baselines

```bash
./scripts/update-visual-baselines.sh --all
```

This will:
1. Show all pending updates
2. Ask for confirmation
3. Replace all baselines with new snapshots
4. Clean up diff files

### Update Specific Test

```bash
./scripts/update-visual-baselines.sh --test ButtonVisualTests
```

Updates only baselines for `ButtonVisualTests` class.

### Update Specific Snapshot

```bash
./scripts/update-visual-baselines.sh --snapshot Button_primary_default
```

Updates only snapshots matching the pattern.

### Commit Updated Baselines

```bash
# Review changes
git diff ElevateUITests/__Snapshots__

# Stage changes
git add ElevateUITests/__Snapshots__

# Commit with descriptive message
git commit -m "Update visual baselines: Button primary tone color shift

Token update changed primary button fill from Blue._600 to Blue._700.
Updated 8 snapshots across ButtonVisualTests.

Risk: LOW - Intentional design improvement
Reviewed: visual-regression-report.html"
```

---

## Best Practices

### 1. Keep Tests Deterministic

❌ **Avoid**:
```swift
// Don't use random values
let button = ElevateButton(title: String(arc4random()))

// Don't use current time
let timestamp = Text(Date().description)
```

✅ **Do**:
```swift
// Use fixed values
let button = ElevateButton(title: "Test Button")

// Use mock dates
let timestamp = Text("2025-11-11 12:00:00")
```

### 2. Test Realistic Sizes

```swift
// ✅ Good - realistic width
.frame(width: 300, height: 100)

// ❌ Bad - arbitrary tiny size
.frame(width: 50, height: 20)
```

### 3. Test Both Light and Dark Modes

```swift
// ✅ Automatic with assertSnapshot()
assertSnapshot(button, named: "Button_primary_default")
// Captures both light and dark

// ⚠️ Only when specifically testing one mode
assertSnapshot(button, colorScheme: .dark, named: "Button_dark_only")
```

### 4. Name Snapshots Consistently

```swift
// ✅ Good names
"Button_primary_default"
"Card_elevated_hover"
"Input_small_focused"

// ❌ Bad names
"test1"
"myButton"
"snapshot_20251111"
```

### 5. Group Related Tests

```swift
// ✅ Good - organized by feature
func testButtonTones() { ... }
func testButtonSizes() { ... }
func testButtonStates() { ... }

// ❌ Bad - one giant test
func testEverything() { ... }
```

### 6. Review Baselines Before Committing

```bash
# Always review visual changes
git diff ElevateUITests/__Snapshots__

# Check file sizes (large increases = potential issue)
du -sh ElevateUITests/__Snapshots__
```

### 7. Use Precision Wisely

```swift
// Default precision (0.99) allows ~1% diff
assertSnapshot(button, named: "Button_default")

// Stricter precision for critical components
assertSnapshot(button, named: "Button_critical", precision: 0.995)

// More lenient for complex gradients/shadows
assertSnapshot(card, named: "Card_shadow", precision: 0.98)
```

---

## Troubleshooting

### Tests Pass Locally but Fail in CI

**Cause**: Different rendering environments (macOS version, Xcode version, simulator)

**Solution**:
```yaml
# In .github/workflows/token-tests.yml
- name: Set Consistent Environment
  run: |
    sudo xcode-select -s /Applications/Xcode_15.app
    defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES
```

### Flaky Tests (Random Failures)

**Causes**:
- Animations not disabled
- Async content loading
- Font rendering variations
- System appearance changes

**Solutions**:
```swift
override func setUp() {
    super.setUp()

    // Disable animations
    UIView.setAnimationsEnabled(false)

    // Wait for fonts to load (if using custom fonts)
    let _ = ElevateTypography.bodyMedium
}
```

### Large Baseline File Sizes

**Causes**:
- Testing full-screen layouts
- Complex gradients/shadows
- High-resolution devices

**Solutions**:
```swift
// Test components in isolation
assertSnapshotWithSize(button, size: CGSize(width: 200, height: 60), ...)

// Use iPhone config (not iPad)
assertSnapshot(button, ..., device: .iPhone13)
```

### Diff Highlights Entire Image

**Cause**: Baseline and current snapshot have completely different dimensions

**Solution**:
```swift
// Ensure consistent sizing
.frame(width: 300) // Fixed width
.fixedSize() // Or use fixed size modifier
```

### Can't Find Snapshots Directory

**Cause**: Tests haven't been run yet or directory was deleted

**Solution**:
```bash
# Run tests to create initial baselines
xcodebuild test -scheme ElevateUI -only-testing:ElevateUITests/ButtonVisualTests

# Check directory exists
ls -la ElevateUITests/__Snapshots__
```

### "No space left on device"

**Cause**: Too many snapshots accumulating

**Solution**:
```bash
# Clean up old diff files
find ElevateUITests/__Snapshots__ -name "*.diff.png" -delete
find ElevateUITests/__Snapshots__ -name "*.1.png" -delete

# Or clean entire snapshot directory (⚠️ will require re-recording)
rm -rf ElevateUITests/__Snapshots__
```

---

## CI Integration

### GitHub Actions Workflow

```yaml
name: Visual Regression Tests

on:
  pull_request:
    paths:
      - 'ElevateUI/Sources/DesignTokens/**'

jobs:
  visual-tests:
    runs-on: macos-15
    steps:
      - uses: actions/checkout@v4

      - name: Run Visual Tests
        run: |
          xcodebuild test \
            -scheme ElevateUI \
            -destination 'platform=iOS Simulator,name=iPhone 17' \
            -only-testing:ElevateUITests/ButtonVisualTests

      - name: Generate Diff Report
        if: failure()
        run: python3 scripts/visual-diff-report.py

      - name: Upload Report
        if: failure()
        uses: actions/upload-artifact@v4
        with:
          name: visual-regression-report
          path: visual-regression-report.html
```

---

## File Organization

```
elevate-ios/
├── ElevateUITests/
│   ├── VisualRegression/
│   │   ├── SnapshotTestCase.swift          # Base class
│   │   ├── ButtonVisualTests.swift         # Button snapshots
│   │   ├── CardVisualTests.swift           # Card snapshots
│   │   └── ... (one file per component)
│   │
│   └── __Snapshots__/                      # Generated by tests
│       ├── ButtonVisualTests/
│       │   ├── Button_primary_default_light.png
│       │   ├── Button_primary_default_dark.png
│       │   └── ...
│       └── CardVisualTests/
│           └── ...
│
├── scripts/
│   ├── visual-diff-report.py               # Generate HTML report
│   └── update-visual-baselines.sh          # Approve baselines
│
└── docs/
    └── VISUAL_REGRESSION_GUIDE.md          # This guide
```

---

## Additional Resources

- [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing) - Library documentation
- [TOKEN_AUTOMATION_MIGRATION_PLAN.md](TOKEN_AUTOMATION_MIGRATION_PLAN.md) - Phase 2 implementation details
- [MIGRATION_PROGRESS.md](MIGRATION_PROGRESS.md) - Overall migration status

---

## Quick Reference

```bash
# Run visual tests
xcodebuild test -scheme ElevateUI -only-testing:ElevateUITests/ButtonVisualTests

# Check status
./scripts/update-visual-baselines.sh --status

# Generate report
python3 scripts/visual-diff-report.py && open visual-regression-report.html

# Approve all changes
./scripts/update-visual-baselines.sh --all

# Commit baselines
git add ElevateUITests/__Snapshots__ && git commit -m "Update visual baselines"
```

---

**Last Updated**: 2025-11-11
**Maintainer**: ElevateUI Team
**Questions**: See troubleshooting section or create an issue
