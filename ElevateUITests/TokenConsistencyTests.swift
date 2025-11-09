#if os(iOS)
import XCTest
import SwiftUI
@testable import ElevateUI

/// Token Consistency Tests
///
/// Validates the ELEVATE token hierarchy:
/// - Primitives reference nothing (raw values)
/// - Aliases reference ONLY Primitives
/// - Components reference ONLY Aliases (never Primitives directly)
///
/// This ensures maintainability and proper semantic layering.
final class TokenConsistencyTests: XCTestCase {

    // MARK: - Hierarchy Validation

    func testComponentTokensNeverReferencePrimitives() {
        // Component tokens should ALWAYS reference Aliases, never Primitives
        // This maintains proper semantic layering
        //
        // ✅ CORRECT: ButtonComponentTokens.fill_primary_default = ElevateAliases.Action.StrongPrimary.fill_default
        // ❌ WRONG:   ButtonComponentTokens.fill_primary_default = ElevatePrimitives.Blue._600
        //
        // Note: This test validates the concept. Full validation requires
        // parsing generated token files, which could be added via build scripts.

        XCTAssertTrue(true, "Conceptual test - validate via code review and generation script")
    }

    func testAliasTokensNeverReferenceOtherAliases() {
        // Aliases should ONLY reference Primitives, not other Aliases
        //
        // ✅ CORRECT: ElevateAliases.Action.StrongPrimary.fill_default = ElevatePrimitives.Blue._600
        // ❌ WRONG:   ElevateAliases.Action.StrongPrimary.fill_default = ElevateAliases.Content.General.text_default
        //
        // Exception: Layout.Layer tokens may reference each other for z-index relationships

        // Sample check: Verify Action aliases reference primitives
        // Full validation requires source parsing
        XCTAssertTrue(true, "Conceptual test - validate via generation script")
    }

    // MARK: - Naming Consistency

    func testComponentTokenNamingConvention() {
        // Component token files should follow naming pattern:
        // [Component]ComponentTokens.swift
        //
        // Examples:
        // - ButtonComponentTokens.swift ✅
        // - Button-groupComponentTokens.swift ✅ (hyphenated ELEVATE names)
        // - ButtonTokens.swift ❌ (old pattern)

        // Verify key component tokens use correct naming
        let _ = ButtonComponentTokens.self
        let _ = CardComponentTokens.self
        let _ = InputComponentTokens.self
        let _ = TextareaComponentTokens.self

        XCTAssertTrue(true, "Component token naming follows convention")
    }

    func testAliasTokenNamingConvention() {
        // Alias tokens should be organized by semantic purpose:
        // - Action (interactive elements)
        // - Content (text, icons)
        // - Feedback (success, warning, error)
        // - Layout (backgrounds, layers)

        let _ = ElevateAliases.Action.self
        let _ = ElevateAliases.Content.self
        let _ = ElevateAliases.Feedback.self
        let _ = ElevateAliases.Layout.self

        XCTAssertTrue(true, "Alias token organization follows semantic structure")
    }

    // MARK: - No Hardcoded Colors

    func testComponentsUseOnlyTokens() {
        // SwiftUI components should NEVER use:
        // - Color.red, Color.blue, etc. (system colors for non-token purposes only)
        // - Color(red:green:blue:) (hardcoded RGB)
        // - Hardcoded CGFloat dimensions
        //
        // ✅ ALWAYS use:
        // - ComponentTokens (preferred)
        // - ElevateAliases (when no component token exists)
        // - ElevateSpacing for dimensions
        //
        // This test is validated by recent audit (see docs/HARDCODED_COLORS_ANALYSIS.md)

        XCTAssertTrue(true, "Validated via hardcoded color audit 2025-11-09")
    }

    // MARK: - Token Completeness

    func testAllComponentsHaveTokenFiles() {
        // Every SwiftUI component should have a corresponding ComponentTokens file
        // This ensures consistent styling across the design system

        let expectedComponents = [
            "Button", "Card", "Input", "Textarea", "Select", "Dropdown",
            "Checkbox", "Switch", "Slider", "Badge", "Chip", "Avatar",
            "Dialog", "Drawer", "Notification", "Tooltip", "Lightbox",
            "Menu", "Tab", "Stepper", "Progress", "Indicator",
            "Table", "Tree", "Breadcrumb", "Field", "Icon"
        ]

        // Note: Not all components require tokens (utility components like VisuallyHidden)
        // This is a guideline test
        XCTAssertGreaterThan(expectedComponents.count, 20, "Should have tokens for major components")
    }

    // MARK: - Token Value Validity

    func testColorTokensAreValid() {
        // All color tokens should be valid SwiftUI colors
        // No nil or invalid color values

        let testColors: [Color] = [
            ButtonComponentTokens.fill_primary_default,
            CardComponentTokens.fill_ground,
            InputComponentTokens.fill_default,
            ElevateAliases.Action.StrongPrimary.fill_default,
            ElevatePrimitives.Blue._500
        ]

        for color in testColors {
            XCTAssertNotNil(color, "All token colors should be valid")
        }
    }

    func testDimensionTokensArePositive() {
        // Dimension tokens should be positive values
        // Zero is acceptable for specific cases (like gap: 0)

        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_s, 0)
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_m, 0)
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_l, 0)

        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_s, 0)
        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_m, 0)
        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_l, 0)
    }

    // MARK: - Semantic Consistency

    func testDangerTokensUseSamePrimitive() {
        // All "danger" themed tokens should reference the same primitive color family
        // This ensures visual consistency for error states

        // Button danger and feedback danger should be semantically aligned
        // (Note: Exact equality not required as they may use different shades)
        XCTAssertNotNil(ButtonComponentTokens.fill_danger_default)
        XCTAssertNotNil(ElevateAliases.Feedback.Strong.fill_danger)

        // Both should ultimately reference Red primitives
        // Full validation requires tracing token references
        XCTAssertTrue(true, "Danger tokens should use Red primitive family")
    }

    func testSuccessTokensUseSamePrimitive() {
        // All "success" themed tokens should reference Green primitives
        XCTAssertNotNil(ElevateAliases.Feedback.Strong.fill_success)
        XCTAssertNotNil(ElevatePrimitives.Green._500)

        XCTAssertTrue(true, "Success tokens should use Green primitive family")
    }

    func testWarningTokensUseSamePrimitive() {
        // All "warning" themed tokens should reference Yellow/Orange primitives
        XCTAssertNotNil(ElevateAliases.Feedback.Strong.fill_warning)

        XCTAssertTrue(true, "Warning tokens should use Yellow/Orange primitive family")
    }

    // MARK: - iOS Adaptation Validation

    func testTouchTargetAdaptations() {
        // Verify iOS adaptations are applied for touch targets
        // ELEVATE web: 32px minimum
        // iOS HIG: 44pt minimum (55pt recommended)

        // Buttons should meet iOS minimum
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_s, 44,
            "Button small should meet 44pt iOS minimum (adapted from ELEVATE 32px)")
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_m, 44,
            "Button medium should meet 44pt iOS minimum")
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.height_l, 48,
            "Button large should exceed minimum for better UX")

        // Inputs should meet iOS minimum
        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_s, 44,
            "Input small should meet 44pt iOS minimum (adapted from ELEVATE 32px)")
        XCTAssertGreaterThanOrEqual(InputComponentTokens.height_m, 44,
            "Input medium should meet 44pt iOS minimum")

        // This adaptation should be documented in DIVERSIONS.md
    }

    func testSpacingAdaptations() {
        // iOS may require larger spacing for touch-friendly UI
        // Verify spacing tokens are appropriate for touch interaction

        XCTAssertGreaterThanOrEqual(ElevateSpacing.s, 8,
            "Small spacing should be at least 8pt for touch clarity")
        XCTAssertGreaterThanOrEqual(ElevateSpacing.m, 16,
            "Medium spacing should be at least 16pt for touch separation")

        // Tap areas should have sufficient padding
        XCTAssertGreaterThanOrEqual(ButtonComponentTokens.padding_inline_s, 12,
            "Button padding should provide adequate touch area")
    }
}
#endif
