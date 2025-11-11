#if os(iOS)
import XCTest
import SwiftUI
@testable import ElevateUI

/// Visual regression tests for ElevateButton component
///
/// Tests all button tones, sizes, and states to ensure visual consistency
/// across token updates and code changes.
///
/// ## Baseline Management
///
/// To record new baselines:
/// 1. Set `recordMode = true` in setUp()
/// 2. Run tests
/// 3. Review generated snapshots in `__Snapshots__/ButtonVisualTests/`
/// 4. Set `recordMode = false` for future comparison runs
@available(iOS 15, *)
final class ButtonVisualTests: SnapshotTestCase {

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        // Set to true ONLY when recording new baselines
        recordMode = false
    }

    // MARK: - All Tones (Default State)

    func testButtonPrimaryDefault() {
        let button = createTestButton(tone: .primary, title: "Primary")
        assertSnapshot(button, named: "Button_primary_default")
    }

    func testButtonSecondaryDefault() {
        let button = createTestButton(tone: .secondary, title: "Secondary")
        assertSnapshot(button, named: "Button_secondary_default")
    }

    func testButtonSuccessDefault() {
        let button = createTestButton(tone: .success, title: "Success")
        assertSnapshot(button, named: "Button_success_default")
    }

    func testButtonWarningDefault() {
        let button = createTestButton(tone: .warning, title: "Warning")
        assertSnapshot(button, named: "Button_warning_default")
    }

    func testButtonDangerDefault() {
        let button = createTestButton(tone: .danger, title: "Danger")
        assertSnapshot(button, named: "Button_danger_default")
    }

    func testButtonEmphasizedDefault() {
        let button = createTestButton(tone: .emphasized, title: "Emphasized")
        assertSnapshot(button, named: "Button_emphasized_default")
    }

    func testButtonSubtleDefault() {
        let button = createTestButton(tone: .subtle, title: "Subtle")
        assertSnapshot(button, named: "Button_subtle_default")
    }

    func testButtonNeutralDefault() {
        let button = createTestButton(tone: .neutral, title: "Neutral")
        assertSnapshot(button, named: "Button_neutral_default")
    }

    // MARK: - Button Sizes

    func testButtonSizes() {
        assertAllStates(
            componentName: "Button_primary",
            states: [
                "small": {
                    createTestButton(tone: .primary, title: "Small", size: .small)
                },
                "medium": {
                    createTestButton(tone: .primary, title: "Medium", size: .medium)
                },
                "large": {
                    createTestButton(tone: .primary, title: "Large", size: .large)
                }
            ]
        )
    }

    // MARK: - Button Shapes

    func testButtonShapes() {
        VStack(spacing: 16) {
            createTestButton(tone: .primary, title: "Default Shape", shape: .default)
            createTestButton(tone: .primary, title: "Pill Shape", shape: .pill)
        }
        .padding()
        .background(Color.white)
        .frame(width: 300, height: 200)
        .then { view in
            assertSnapshotWithSize(view, size: CGSize(width: 300, height: 200), named: "Button_shapes")
        }
    }

    // MARK: - Button with Icons

    func testButtonWithLeadingIcon() {
        let button = createTestButton(
            tone: .primary,
            title: "With Icon",
            systemImage: "star.fill"
        )
        assertSnapshot(button, named: "Button_primary_with_icon")
    }

    func testButtonIconOnly() {
        // Icon-only button (minimal text)
        let button = createTestButton(
            tone: .primary,
            title: "",
            systemImage: "plus"
        )
        assertSnapshotWithSize(button, size: CGSize(width: 60, height: 60), named: "Button_icon_only")
    }

    // MARK: - Disabled State

    func testButtonDisabled() {
        assertAllStates(
            componentName: "Button",
            states: [
                "primary_disabled": {
                    createTestButton(tone: .primary, title: "Disabled")
                        .disabled(true)
                },
                "danger_disabled": {
                    createTestButton(tone: .danger, title: "Disabled")
                        .disabled(true)
                },
                "subtle_disabled": {
                    createTestButton(tone: .subtle, title: "Disabled")
                        .disabled(true)
                }
            ]
        )
    }

    // MARK: - Button Groups

    func testButtonGroup() {
        let group = VStack(spacing: 12) {
            createTestButton(tone: .primary, title: "Save")
            createTestButton(tone: .secondary, title: "Cancel")
            createTestButton(tone: .danger, title: "Delete")
        }
        .padding()
        .background(Color.white)
        .frame(width: 300, height: 250)

        assertSnapshotWithSize(group, size: CGSize(width: 300, height: 250), named: "Button_group_vertical")
    }

    func testButtonGroupHorizontal() {
        let group = HStack(spacing: 12) {
            createTestButton(tone: .secondary, title: "Cancel")
            createTestButton(tone: .primary, title: "Confirm")
        }
        .padding()
        .background(Color.white)
        .frame(width: 400, height: 100)

        assertSnapshotWithSize(group, size: CGSize(width: 400, height: 100), named: "Button_group_horizontal")
    }

    // MARK: - Long Text

    func testButtonLongText() {
        let button = createTestButton(
            tone: .primary,
            title: "This is a very long button label that should wrap or truncate"
        )
        assertSnapshotWithSize(button, size: CGSize(width: 300, height: 100), named: "Button_long_text")
    }

    // MARK: - Touch Target Validation

    func testButtonTouchTargets() {
        // Verify minimum touch target sizes visually
        VStack(spacing: 20) {
            createTestButton(tone: .primary, title: "44pt Min", size: .small)
                .overlay(
                    Rectangle()
                        .stroke(Color.red, lineWidth: 1)
                        .frame(height: 44)
                )

            createTestButton(tone: .primary, title: "Standard", size: .medium)

            createTestButton(tone: .primary, title: "Large", size: .large)
        }
        .padding()
        .background(Color.white)
        .frame(width: 300, height: 300)
        .then { view in
            assertSnapshotWithSize(view, size: CGSize(width: 300, height: 300), named: "Button_touch_targets")
        }
    }

    // MARK: - Dark Mode Specific

    func testButtonDarkModeContrast() {
        // Test that buttons have sufficient contrast in dark mode
        VStack(spacing: 16) {
            createTestButton(tone: .primary, title: "Primary")
            createTestButton(tone: .subtle, title: "Subtle")
            createTestButton(tone: .emphasized, title: "Emphasized")
        }
        .padding()
        .background(Color.black)
        .frame(width: 300, height: 250)
        .then { view in
            assertSnapshot(view, colorScheme: .dark, named: "Button_dark_mode_contrast")
        }
    }

    // MARK: - All Tones Together

    func testAllTonesComparison() {
        let allTones = VStack(spacing: 12) {
            createTestButton(tone: .primary, title: "Primary")
            createTestButton(tone: .secondary, title: "Secondary")
            createTestButton(tone: .success, title: "Success")
            createTestButton(tone: .warning, title: "Warning")
            createTestButton(tone: .danger, title: "Danger")
            createTestButton(tone: .emphasized, title: "Emphasized")
            createTestButton(tone: .subtle, title: "Subtle")
            createTestButton(tone: .neutral, title: "Neutral")
        }
        .padding()
        .background(Color.white)
        .frame(width: 300, height: 550)

        assertSnapshotWithSize(allTones, size: CGSize(width: 300, height: 550), named: "Button_all_tones")
    }

    // MARK: - Helper Methods

    private func createTestButton(
        tone: ButtonTokens.Tone,
        title: String,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default,
        systemImage: String? = nil
    ) -> some View {
        VStack {
            if let systemImage = systemImage {
                ElevateButton(
                    title: title,
                    systemImage: systemImage,
                    tone: tone,
                    size: size,
                    action: {}
                )
            } else {
                ElevateButton(
                    title: title,
                    tone: tone,
                    size: size,
                    action: {}
                )
            }
        }
        .frame(width: 250)
        .padding()
    }
}

// MARK: - View Extension Helper

extension View {
    /// Helper to apply transformations in a chain
    func then<Content: View>(_ transform: (Self) -> Content) -> Content {
        transform(self)
    }
}
#endif
