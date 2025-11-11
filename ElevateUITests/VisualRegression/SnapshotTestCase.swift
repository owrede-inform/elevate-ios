#if os(iOS)
import XCTest
import SwiftUI
import SnapshotTesting
@testable import ElevateUI

/// Base class for visual regression snapshot tests
///
/// Provides utilities for capturing and comparing UI snapshots across light and dark modes.
/// Uses swift-snapshot-testing for snapshot comparison and diff generation.
///
/// ## Usage
///
/// ```swift
/// class ButtonVisualTests: SnapshotTestCase {
///     func testButtonPrimary() {
///         let button = ElevateButton(title: "Primary", tone: .primary)
///         assertSnapshot(button, named: "Button_primary_default")
///     }
/// }
/// ```
///
/// ## Recording Baselines
///
/// To record new baselines or update existing ones:
/// 1. Set `record = true` when calling `assertSnapshot()`
/// 2. Run tests - baselines will be saved to `__Snapshots__/`
/// 3. Review snapshots visually
/// 4. Set `record = false` for comparison mode
///
/// ## Snapshot Organization
///
/// Snapshots are stored in:
/// - `ElevateUITests/__Snapshots__/{TestClassName}/{testName}_light.png`
/// - `ElevateUITests/__Snapshots__/{TestClassName}/{testName}_dark.png`
@available(iOS 15, *)
class SnapshotTestCase: XCTestCase {

    // MARK: - Configuration

    /// Precision for image comparison (0.0 = exact match, 1.0 = any difference allowed)
    /// Default 0.99 allows ~1% pixel difference to account for font rendering variations
    var snapshotPrecision: Float = 0.99

    /// Perceptual precision for more human-like comparison
    /// Accounts for anti-aliasing, font hinting, and sub-pixel rendering
    var perceptualPrecision: Float = 0.98

    /// Enable recording mode to update baselines
    /// WARNING: Only enable when intentionally updating snapshots
    var recordMode: Bool = false

    // MARK: - Device Configuration

    /// Standard iPhone device for snapshot testing
    static let iPhoneConfig = ViewImageConfig.iPhone13

    /// Standard iPad device for snapshot testing
    static let iPadConfig = ViewImageConfig.iPad12_9

    // MARK: - Snapshot Assertion Helpers

    /// Assert snapshot in both light and dark modes
    ///
    /// Captures snapshots in both appearance modes and compares against baselines.
    /// If differences are detected, generates diff images for review.
    ///
    /// - Parameters:
    ///   - view: The SwiftUI view to snapshot
    ///   - named: Base name for the snapshot (will append _light/_dark)
    ///   - record: Whether to record new baselines (default: false)
    ///   - precision: Image comparison precision (default: uses instance precision)
    ///   - device: Device configuration (default: iPhone 13)
    func assertSnapshot<V: View>(
        _ view: V,
        named name: String,
        record: Bool? = nil,
        precision: Float? = nil,
        device: ViewImageConfig = iPhoneConfig,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        let shouldRecord = record ?? recordMode
        let comparisonPrecision = precision ?? snapshotPrecision

        // Light mode snapshot
        assertSnapshot(
            matching: view
                .environment(\.colorScheme, .light)
                .background(Color.white),
            as: .image(
                precision: comparisonPrecision,
                layout: .device(config: device)
            ),
            named: "\(name)_light",
            record: shouldRecord,
            file: file,
            testName: testName,
            line: line
        )

        // Dark mode snapshot
        assertSnapshot(
            matching: view
                .environment(\.colorScheme, .dark)
                .background(Color.black),
            as: .image(
                precision: comparisonPrecision,
                layout: .device(config: device)
            ),
            named: "\(name)_dark",
            record: shouldRecord,
            file: file,
            testName: testName,
            line: line
        )
    }

    /// Assert snapshot in single appearance mode
    ///
    /// Use this for testing specific light or dark mode behavior in isolation.
    ///
    /// - Parameters:
    ///   - view: The SwiftUI view to snapshot
    ///   - colorScheme: Light or dark mode
    ///   - named: Name for the snapshot
    ///   - record: Whether to record new baselines
    ///   - precision: Image comparison precision
    ///   - device: Device configuration
    func assertSnapshot<V: View>(
        _ view: V,
        colorScheme: ColorScheme,
        named name: String,
        record: Bool? = nil,
        precision: Float? = nil,
        device: ViewImageConfig = iPhoneConfig,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        let shouldRecord = record ?? recordMode
        let comparisonPrecision = precision ?? snapshotPrecision
        let background = colorScheme == .light ? Color.white : Color.black

        assertSnapshot(
            matching: view
                .environment(\.colorScheme, colorScheme)
                .background(background),
            as: .image(
                precision: comparisonPrecision,
                layout: .device(config: device)
            ),
            named: name,
            record: shouldRecord,
            file: file,
            testName: testName,
            line: line
        )
    }

    /// Assert snapshot with custom size
    ///
    /// Useful for testing components in isolation without full device chrome.
    ///
    /// - Parameters:
    ///   - view: The SwiftUI view to snapshot
    ///   - size: Custom size for the snapshot
    ///   - named: Name for the snapshot
    ///   - record: Whether to record new baselines
    func assertSnapshotWithSize<V: View>(
        _ view: V,
        size: CGSize,
        named name: String,
        record: Bool? = nil,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        let shouldRecord = record ?? recordMode

        // Light mode
        assertSnapshot(
            matching: view
                .environment(\.colorScheme, .light)
                .frame(width: size.width, height: size.height),
            as: .image(precision: snapshotPrecision),
            named: "\(name)_light",
            record: shouldRecord,
            file: file,
            testName: testName,
            line: line
        )

        // Dark mode
        assertSnapshot(
            matching: view
                .environment(\.colorScheme, .dark)
                .frame(width: size.width, height: size.height),
            as: .image(precision: snapshotPrecision),
            named: "\(name)_dark",
            record: shouldRecord,
            file: file,
            testName: testName,
            line: line
        )
    }

    // MARK: - Multi-State Snapshot Helpers

    /// Assert snapshots for all standard button states
    ///
    /// Captures snapshots for default, hover (pressed on iOS), active, and disabled states.
    /// Useful for comprehensive component validation.
    ///
    /// - Parameters:
    ///   - componentName: Name of the component (e.g., "Button_primary")
    ///   - states: Dictionary mapping state names to view builders
    ///   - record: Whether to record new baselines
    func assertAllStates<V: View>(
        componentName: String,
        states: [String: () -> V],
        record: Bool? = nil,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        for (stateName, viewBuilder) in states {
            let view = viewBuilder()
            assertSnapshot(
                view,
                named: "\(componentName)_\(stateName)",
                record: record,
                file: file,
                testName: testName,
                line: line
            )
        }
    }

    // MARK: - Test Lifecycle

    override func setUp() {
        super.setUp()

        // Ensure consistent snapshot rendering
        // Disable animations for deterministic snapshots
        UIView.setAnimationsEnabled(false)
    }

    override func tearDown() {
        // Re-enable animations
        UIView.setAnimationsEnabled(true)

        super.tearDown()
    }
}

// MARK: - Snapshot Naming Conventions

/*
 Snapshot Naming Convention:

 {ComponentName}_{Variant}_{State}_{mode}.png

 Examples:
 - Button_primary_default_light.png
 - Button_primary_default_dark.png
 - Button_danger_disabled_light.png
 - Card_elevated_default_light.png
 - Input_small_focused_dark.png

 Components:
 - ComponentName: Button, Card, Input, Badge, etc.
 - Variant: primary, secondary, danger, small, large, etc.
 - State: default, hover, active, disabled, focused, invalid
 - Mode: light, dark (automatically appended)

 This naming ensures:
 1. Easy organization in __Snapshots__ directory
 2. Clear identification of what's being tested
 3. Automatic grouping by component in file browsers
 4. Consistent naming across the test suite
 */

// MARK: - Usage Examples

/*
 Example 1: Basic Component Snapshot

 ```swift
 func testButtonPrimary() {
     let button = ElevateButton(title: "Click Me", tone: .primary)
     assertSnapshot(button, named: "Button_primary_default")
 }
 ```

 Example 2: Multiple States

 ```swift
 func testButtonAllStates() {
     assertAllStates(
         componentName: "Button_primary",
         states: [
             "default": { ElevateButton(title: "Default", tone: .primary) },
             "disabled": { ElevateButton(title: "Disabled", tone: .primary).disabled(true) }
         ]
     )
 }
 ```

 Example 3: Recording Baselines

 ```swift
 func testNewComponent() {
     let component = NewComponent()
     assertSnapshot(component, named: "NewComponent_default", record: true)
     // First run: records baseline
     // Second run: compares against baseline
 }
 ```

 Example 4: Custom Size

 ```swift
 func testBadge() {
     let badge = ElevateBadge(text: "New", tone: .primary)
     assertSnapshotWithSize(badge, size: CGSize(width: 100, height: 40), named: "Badge_primary")
 }
 ```
 */
#endif
