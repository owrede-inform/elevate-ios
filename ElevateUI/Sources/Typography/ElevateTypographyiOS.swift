#if os(iOS)
import SwiftUI

/// ELEVATE iOS-Optimized Typography
///
/// Typography styles scaled for iOS readability using dynamic scaling factor.
/// References ElevateTypography base sizes and applies iOS scaling.
///
/// Architecture:
/// - ElevateTypography.Sizes.* = ELEVATE web defaults (can be themed)
/// - iosScaleFactor = iOS platform multiplier (1.25x = +25%)
/// - Final size = ElevateTypography.Sizes.* × iosScaleFactor
///
/// Example: bodyMedium = ElevateTypography.Sizes.bodyMedium (14pt) × 1.25 = 17.5pt
///
/// Apple HIG Compliance:
/// - Body text ≥ 17pt (we use 17.5pt)
/// - Minimum readable ≥ 11pt (we use 13.75pt for smallest)
///
/// Auto-generated from ELEVATE design tokens + iOS primitives.css overrides
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ElevateTypographyiOS {

    // MARK: - iOS Scaling Factor

    /// iOS typography scaling factor applied to all ELEVATE web sizes
    /// Single point of control for iOS text size adaptation
    /// Change this value to adjust ALL typography sizes proportionally
    public static let iosScaleFactor: CGFloat = 1.25  // +25% larger than web

    // MARK: - Font Families

    /// Primary font family (Inter) - delegates to ElevateTypography
    public static let fontFamilyPrimary = ElevateTypography.fontFamilyPrimary

    /// Monospace font family (Roboto Mono) - delegates to ElevateTypography
    public static let fontFamilyMono = ElevateTypography.fontFamilyMono

    // MARK: - Font Weights

    /// Font weights - delegates to ElevateTypography
    public typealias FontWeight = ElevateTypography.FontWeight

    // MARK: - Display Styles

    /// Display heading (largest)
    /// Web: 57pt (ElevateTypography.Sizes.displayLarge) → iOS: 71.25pt (×iosScaleFactor)
    public static let displayLarge = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.displayLarge * iosScaleFactor)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Medium display heading
    /// Web: 45pt (ElevateTypography.Sizes.displayMedium) → iOS: 56.25pt (×iosScaleFactor)
    public static let displayMedium = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.displayMedium * iosScaleFactor)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Small display heading
    /// Web: 36pt (ElevateTypography.Sizes.displaySmall) → iOS: 45.00pt (×iosScaleFactor)
    public static let displaySmall = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.displaySmall * iosScaleFactor)
        .weight(FontWeight.bold.swiftUIWeight)


    // MARK: - Heading Styles

    /// Large heading
    /// Web: 32pt (ElevateTypography.Sizes.headingLarge) → iOS: 40.00pt (×iosScaleFactor)
    public static let headingLarge = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.headingLarge * iosScaleFactor)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Medium heading
    /// Web: 28pt (ElevateTypography.Sizes.headingMedium) → iOS: 35.00pt (×iosScaleFactor)
    public static let headingMedium = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.headingMedium * iosScaleFactor)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Small heading
    /// Web: 24pt (ElevateTypography.Sizes.headingSmall) → iOS: 30.00pt (×iosScaleFactor)
    public static let headingSmall = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.headingSmall * iosScaleFactor)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Extra small heading
    /// Web: 20pt (ElevateTypography.Sizes.headingXSmall) → iOS: 25.00pt (×iosScaleFactor)
    public static let headingXSmall = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.headingXSmall * iosScaleFactor)
        .weight(FontWeight.semibold.swiftUIWeight)


    // MARK: - Title Styles

    /// Large title
    /// Web: 22pt (ElevateTypography.Sizes.titleLarge) → iOS: 27.50pt (×iosScaleFactor)
    public static let titleLarge = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.titleLarge * iosScaleFactor)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Medium title
    /// Web: 16pt (ElevateTypography.Sizes.titleMedium) → iOS: 20.00pt (×iosScaleFactor)
    public static let titleMedium = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.titleMedium * iosScaleFactor)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Small title
    /// Web: 14pt (ElevateTypography.Sizes.titleSmall) → iOS: 17.50pt (×iosScaleFactor)
    public static let titleSmall = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.titleSmall * iosScaleFactor)
        .weight(FontWeight.semibold.swiftUIWeight)


    // MARK: - Body Text Styles

    /// Large body text
    /// Web: 16pt (ElevateTypography.Sizes.bodyLarge) → iOS: 20.00pt (×iosScaleFactor)
    public static let bodyLarge = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.bodyLarge * iosScaleFactor)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Medium body text (default) - Apple HIG compliant
    /// Web: 14pt (ElevateTypography.Sizes.bodyMedium) → iOS: 17.50pt (×iosScaleFactor)
    public static let bodyMedium = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.bodyMedium * iosScaleFactor)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Small body text
    /// Web: 12pt (ElevateTypography.Sizes.bodySmall) → iOS: 15.00pt (×iosScaleFactor)
    public static let bodySmall = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.bodySmall * iosScaleFactor)
        .weight(FontWeight.regular.swiftUIWeight)


    // MARK: - Label Styles

    /// Large label (emphasized)
    /// Web: 16pt (ElevateTypography.Sizes.labelLarge) → iOS: 20.00pt (×iosScaleFactor)
    public static let labelLarge = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.labelLarge * iosScaleFactor)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Medium label (emphasized)
    /// Web: 14pt (ElevateTypography.Sizes.labelMedium) → iOS: 17.50pt (×iosScaleFactor)
    public static let labelMedium = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.labelMedium * iosScaleFactor)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Small label (emphasized)
    /// Web: 12pt (ElevateTypography.Sizes.labelSmall) → iOS: 15.00pt (×iosScaleFactor)
    public static let labelSmall = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.labelSmall * iosScaleFactor)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Extra small label - Exceeds Apple 11pt min
    /// Web: 11pt (ElevateTypography.Sizes.labelXSmall) → iOS: 13.75pt (×iosScaleFactor)
    public static let labelXSmall = Font.custom(fontFamilyPrimary, size: ElevateTypography.Sizes.labelXSmall * iosScaleFactor)
        .weight(FontWeight.medium.swiftUIWeight)


    // MARK: - Monospace Styles

    /// Code/monospace text
    /// Web: 14pt (ElevateTypography.Sizes.code) → iOS: 17.50pt (×iosScaleFactor)
    public static let code = Font.custom(fontFamilyMono, size: ElevateTypography.Sizes.code * iosScaleFactor)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Small code/monospace text
    /// Web: 12pt (ElevateTypography.Sizes.codeSmall) → iOS: 15.00pt (×iosScaleFactor)
    public static let codeSmall = Font.custom(fontFamilyMono, size: ElevateTypography.Sizes.codeSmall * iosScaleFactor)
        .weight(FontWeight.regular.swiftUIWeight)

}
#endif
