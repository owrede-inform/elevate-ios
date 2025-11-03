import XCTest
@testable import ElevateUI

final class ElevateUITests: XCTestCase {

    func testVersionNumber() {
        XCTAssertEqual(ElevateUI.version, "0.1.0")
    }

    func testDesignSystemVersion() {
        XCTAssertEqual(ElevateUI.designSystemVersion, "0.36.1")
    }

    func testButtonTones() {
        // Test that all button tones are defined
        let tones: [ButtonTokens.Tone] = [
            .primary, .secondary, .success, .warning,
            .danger, .emphasized, .subtle, .neutral
        ]

        for tone in tones {
            XCTAssertNotNil(tone.colors)
        }
    }

    func testButtonSizes() {
        // Test that all button sizes have valid dimensions
        let sizes: [ButtonTokens.Size] = [.small, .medium, .large]

        for size in sizes {
            let componentSize = size.componentSize
            XCTAssertGreaterThan(componentSize.height, 0)
            XCTAssertGreaterThan(componentSize.paddingInline, 0)
            XCTAssertGreaterThan(componentSize.gap, 0)
        }
    }

    func testSpacingValues() {
        // Test that spacing values are in ascending order
        XCTAssertLessThan(ElevateSpacing.xxs, ElevateSpacing.xs)
        XCTAssertLessThan(ElevateSpacing.xs, ElevateSpacing.s)
        XCTAssertLessThan(ElevateSpacing.s, ElevateSpacing.m)
        XCTAssertLessThan(ElevateSpacing.m, ElevateSpacing.l)
        XCTAssertLessThan(ElevateSpacing.l, ElevateSpacing.xl)
        XCTAssertLessThan(ElevateSpacing.xl, ElevateSpacing.xxl)
        XCTAssertLessThan(ElevateSpacing.xxl, ElevateSpacing.xxxl)
    }

    func testBorderRadius() {
        // Test that border radius values are defined
        XCTAssertEqual(ElevateSpacing.BorderRadius.none, 0)
        XCTAssertGreaterThan(ElevateSpacing.BorderRadius.small, 0)
        XCTAssertGreaterThan(ElevateSpacing.BorderRadius.medium, ElevateSpacing.BorderRadius.small)
        XCTAssertGreaterThan(ElevateSpacing.BorderRadius.large, ElevateSpacing.BorderRadius.medium)
    }
}
