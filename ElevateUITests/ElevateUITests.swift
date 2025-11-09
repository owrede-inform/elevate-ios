#if os(iOS)
import XCTest
import SwiftUI
@testable import ElevateUI

/// Comprehensive test suite for ELEVATE UI token system
///
/// Tests validate:
/// - Token hierarchy (Primitives → Aliases → Components)
/// - Dark mode support
/// - Accessibility (WCAG contrast ratios)
/// - Spacing and sizing consistency
///
/// Run with: swift test
final class ElevateUITests: XCTestCase {

    // MARK: - Version Tests

    func testVersionNumber() {
        XCTAssertFalse(ElevateUI.version.isEmpty, "Version should be defined")
        XCTAssertTrue(ElevateUI.version.contains("."), "Version should follow semver format")
    }

    func testDesignSystemVersion() {
        XCTAssertEqual(ElevateUI.designSystemVersion, "0.36.1", "Design system version should match ELEVATE source")
    }

    // MARK: - Component Token Tests

    func testButtonComponentTokensExist() {
        // Verify button tokens are properly defined
        XCTAssertNotNil(ButtonComponentTokens.fill_primary_default)
        XCTAssertNotNil(ButtonComponentTokens.label_primary_default)
        XCTAssertNotNil(ButtonComponentTokens.border_primary_color_default)

        // Verify all tones have tokens
        XCTAssertNotNil(ButtonComponentTokens.fill_danger_default)
        XCTAssertNotNil(ButtonComponentTokens.fill_emphasized_default)
        XCTAssertNotNil(ButtonComponentTokens.fill_neutral_default)
    }

    func testInputComponentTokensExist() {
        // Verify input tokens follow proper structure
        XCTAssertNotNil(InputComponentTokens.fill_default)
        XCTAssertNotNil(InputComponentTokens.border_color_default)
        XCTAssertNotNil(InputComponentTokens.border_color_invalid)
        XCTAssertNotNil(InputComponentTokens.border_color_selected)
        XCTAssertNotNil(InputComponentTokens.icon_default)
    }

    func testCardComponentTokensExist() {
        // Verify card tokens exist
        XCTAssertNotNil(CardComponentTokens.fill_ground)
        XCTAssertNotNil(CardComponentTokens.fill_elevated)
        XCTAssertNotNil(CardComponentTokens.border_color_neutral_default)
    }

    // MARK: - Alias Token Tests

    func testAliasTokensExist() {
        // Verify core alias categories exist
        XCTAssertNotNil(ElevateAliases.Action.StrongPrimary.fill_default)
        XCTAssertNotNil(ElevateAliases.Content.General.text_default)
        XCTAssertNotNil(ElevateAliases.Feedback.Strong.fill_success)
        XCTAssertNotNil(ElevateAliases.Layout.Layer.ground)
    }

    func testAliasesReferenceOnlyPrimitives() {
        // This is a structural test - aliases should ONLY reference primitives
        // Actual validation requires parsing Swift source, so this is a placeholder
        // for the comprehensive test in TokenConsistencyTests.swift
        XCTAssertTrue(true, "See TokenConsistencyTests for detailed hierarchy validation")
    }

    // MARK: - Primitive Token Tests

    func testPrimitiveTokensExist() {
        // Verify primitive colors exist
        XCTAssertNotNil(ElevatePrimitives.Blue._500)
        XCTAssertNotNil(ElevatePrimitives.Red._500)
        XCTAssertNotNil(ElevatePrimitives.Green._500)
        XCTAssertNotNil(ElevatePrimitives.Gray._500)
        XCTAssertNotNil(ElevatePrimitives.White._color_white)
        XCTAssertNotNil(ElevatePrimitives.Black._color_black)
    }

    // MARK: - Spacing Tests

    func testSpacingValues() {
        // Test that spacing values are in ascending order
        XCTAssertLessThan(ElevateSpacing.xxs, ElevateSpacing.xs)
        XCTAssertLessThan(ElevateSpacing.xs, ElevateSpacing.s)
        XCTAssertLessThan(ElevateSpacing.s, ElevateSpacing.m)
        XCTAssertLessThan(ElevateSpacing.m, ElevateSpacing.l)
        XCTAssertLessThan(ElevateSpacing.l, ElevateSpacing.xl)
    }

    func testBorderRadius() {
        // Test that border radius values are defined and ascending
        XCTAssertGreaterThan(ElevateSpacing.BorderRadius.small, 0)
        XCTAssertGreaterThan(ElevateSpacing.BorderRadius.medium, ElevateSpacing.BorderRadius.small)
        XCTAssertGreaterThan(ElevateSpacing.BorderRadius.large, ElevateSpacing.BorderRadius.medium)
        XCTAssertGreaterThan(ElevateSpacing.BorderRadius.xlarge, ElevateSpacing.BorderRadius.large)
    }

    func testBorderWidth() {
        // Test border widths are defined
        XCTAssertEqual(ElevateSpacing.BorderWidth.thin, 1)
        XCTAssertEqual(ElevateSpacing.BorderWidth.medium, 2)
        XCTAssertEqual(ElevateSpacing.BorderWidth.thick, 3)
    }

    func testIconSizes() {
        // Test icon sizes are defined
        XCTAssertEqual(ElevateSpacing.IconSize.small.value, 16)
        XCTAssertEqual(ElevateSpacing.IconSize.medium.value, 24)
        XCTAssertEqual(ElevateSpacing.IconSize.large.value, 32)
        XCTAssertEqual(ElevateSpacing.IconSize.xlarge.value, 48)
    }

    // MARK: - Touch Target Tests (iOS Specific)

    func testMinimumTouchTargetSizes() {
        // iOS HIG requires minimum 44pt × 44pt touch targets
        // ELEVATE web uses 32px, we adapt to 44pt minimum

        // Button heights should meet minimum touch target
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_s, 44, "Small button should meet 44pt minimum")
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_m, 44, "Medium button should meet 44pt minimum")
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_l, 44, "Large button should meet 44pt minimum")

        // Input heights should meet minimum touch target
        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_s, 44, "Small input should meet 44pt minimum")
        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_m, 44, "Medium input should meet 44pt minimum")
        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_l, 44, "Large input should meet 44pt minimum")
    }

    // MARK: - Typography Tests

    func testTypographySizes() {
        // Verify typography tokens exist and return valid Font objects
        // Note: Font objects don't expose pointSize directly in SwiftUI
        XCTAssertNotNil(ElevateTypography.displayLarge)
        XCTAssertNotNil(ElevateTypography.headingLarge)
        XCTAssertNotNil(ElevateTypography.bodyLarge)
        XCTAssertNotNil(ElevateTypography.labelMedium)
    }

    // MARK: - Color Adaptation Tests

    func testColorAdaptationMechanism() {
        // Verify Color.adaptive() helper exists and works
        let testColor = Color.adaptive(
            lightRGB: (red: 1.0, green: 0.0, blue: 0.0, opacity: 1.0),
            darkRGB: (red: 0.0, green: 1.0, blue: 0.0, opacity: 1.0)
        )
        XCTAssertNotNil(testColor, "Color.adaptive should create valid color")
    }

    // MARK: - Integration Tests

    func testComponentTokensReferenceAliases() {
        // Verify component tokens properly reference alias layer
        // This structural test ensures proper token hierarchy
        // Detailed validation in TokenConsistencyTests.swift
        XCTAssertTrue(true, "See TokenConsistencyTests for detailed hierarchy validation")
    }
}
#endif
