import Foundation
#if os(iOS)
import SwiftUI
import UIKit

/// iOS-Specific Typography Overrides for ELEVATE
///
/// Provides +15% larger text sizes for iOS to match proportional touch target increases.
///
/// **Reasoning**: iOS touch targets increased by ~25% on average (32→44pt, 40→48pt, 48→56pt).
/// Text sizes increased by +15% to maintain visual balance while staying readable on smaller screens.
///
/// **Web ELEVATE** → **iOS Adaptation**
/// - Display sizes optimized for Retina displays
/// - Body text meets Apple's minimum recommended sizes
/// - Maintains ELEVATE's typography scale relationships
/// - All sizes support Dynamic Type via SwiftUI
///
/// Usage: Import this instead of ElevateTypography for iOS-optimized sizes:
/// ```swift
/// import ElevateUI
///
/// Text("Heading")
///     .font(ElevateTypographyiOS.headingLarge)
/// ```
@available(iOS 15, *)
public struct ElevateTypographyiOS {

    // MARK: - Font Families

    /// Primary font family (Inter)
    public static let fontFamilyPrimary = "Inter"

    /// Monospace font family (Roboto Mono)
    public static let fontFamilyMono = "Roboto Mono"

    // MARK: - Font Weights

    public typealias FontWeight = ElevateTypography.FontWeight

    // MARK: - Heading Styles (+15% from web)

    /// Display heading (largest)
    /// Web: 57pt → iOS: 66pt (+15.8%)
    public static let displayLarge = Font.custom(fontFamilyPrimary, size: 66)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Display medium
    /// Web: 45pt → iOS: 52pt (+15.6%)
    public static let displayMedium = Font.custom(fontFamilyPrimary, size: 52)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Display small
    /// Web: 36pt → iOS: 41pt (+13.9%)
    public static let displaySmall = Font.custom(fontFamilyPrimary, size: 41)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Large heading
    /// Web: 32pt → iOS: 37pt (+15.6%)
    public static let headingLarge = Font.custom(fontFamilyPrimary, size: 37)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Medium heading
    /// Web: 28pt → iOS: 32pt (+14.3%)
    public static let headingMedium = Font.custom(fontFamilyPrimary, size: 32)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Small heading
    /// Web: 24pt → iOS: 28pt (+16.7%)
    public static let headingSmall = Font.custom(fontFamilyPrimary, size: 28)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Extra small heading
    /// Web: 20pt → iOS: 23pt (+15%)
    public static let headingXSmall = Font.custom(fontFamilyPrimary, size: 23)
        .weight(FontWeight.semibold.swiftUIWeight)

    // MARK: - Title Styles (+15% from web)

    /// Large title
    /// Web: 22pt → iOS: 25pt (+13.6%)
    public static let titleLarge = Font.custom(fontFamilyPrimary, size: 25)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Medium title
    /// Web: 16pt → iOS: 18pt (+12.5%)
    public static let titleMedium = Font.custom(fontFamilyPrimary, size: 18)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Small title
    /// Web: 14pt → iOS: 16pt (+14.3%)
    public static let titleSmall = Font.custom(fontFamilyPrimary, size: 16)
        .weight(FontWeight.semibold.swiftUIWeight)

    // MARK: - Body Text Styles (+15% from web)

    /// Large body text
    /// Web: 16pt → iOS: 18pt (+12.5%)
    public static let bodyLarge = Font.custom(fontFamilyPrimary, size: 18)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Medium body text (default)
    /// Web: 14pt → iOS: 16pt (+14.3%) - Meets Apple's 16pt minimum recommendation
    public static let bodyMedium = Font.custom(fontFamilyPrimary, size: 16)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Small body text
    /// Web: 12pt → iOS: 14pt (+16.7%)
    public static let bodySmall = Font.custom(fontFamilyPrimary, size: 14)
        .weight(FontWeight.regular.swiftUIWeight)

    // MARK: - Label Styles (+15% from web)

    /// Large label (emphasized)
    /// Web: 16pt → iOS: 18pt (+12.5%)
    public static let labelLarge = Font.custom(fontFamilyPrimary, size: 18)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Medium label (emphasized)
    /// Web: 14pt → iOS: 16pt (+14.3%)
    public static let labelMedium = Font.custom(fontFamilyPrimary, size: 16)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Small label (emphasized)
    /// Web: 12pt → iOS: 14pt (+16.7%)
    public static let labelSmall = Font.custom(fontFamilyPrimary, size: 14)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Extra small label
    /// Web: 11pt → iOS: 13pt (+18.2%) - Above Apple's 11pt minimum
    public static let labelXSmall = Font.custom(fontFamilyPrimary, size: 13)
        .weight(FontWeight.medium.swiftUIWeight)

    // MARK: - Monospace Styles (+15% from web)

    /// Code/monospace text
    /// Web: 14pt → iOS: 16pt (+14.3%)
    public static let code = Font.custom(fontFamilyMono, size: 16)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Small code/monospace text
    /// Web: 12pt → iOS: 14pt (+16.7%)
    public static let codeSmall = Font.custom(fontFamilyMono, size: 14)
        .weight(FontWeight.regular.swiftUIWeight)

    // MARK: - UIKit Compatibility

    /// UIKit-compatible font accessors
    public enum UIKit {

        // MARK: - Headings

        public static var displayLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 66)?.withWeight(.bold) ?? .systemFont(ofSize: 66, weight: .bold)
        }

        public static var displayMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 52)?.withWeight(.bold) ?? .systemFont(ofSize: 52, weight: .bold)
        }

        public static var displaySmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 41)?.withWeight(.bold) ?? .systemFont(ofSize: 41, weight: .bold)
        }

        public static var headingLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 37)?.withWeight(.bold) ?? .systemFont(ofSize: 37, weight: .bold)
        }

        public static var headingMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 32)?.withWeight(.bold) ?? .systemFont(ofSize: 32, weight: .bold)
        }

        public static var headingSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 28)?.withWeight(.semibold) ?? .systemFont(ofSize: 28, weight: .semibold)
        }

        public static var headingXSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 23)?.withWeight(.semibold) ?? .systemFont(ofSize: 23, weight: .semibold)
        }

        // MARK: - Titles

        public static var titleLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 25)?.withWeight(.semibold) ?? .systemFont(ofSize: 25, weight: .semibold)
        }

        public static var titleMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 18)?.withWeight(.semibold) ?? .systemFont(ofSize: 18, weight: .semibold)
        }

        public static var titleSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 16)?.withWeight(.semibold) ?? .systemFont(ofSize: 16, weight: .semibold)
        }

        // MARK: - Body

        public static var bodyLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 18)?.withWeight(.regular) ?? .systemFont(ofSize: 18, weight: .regular)
        }

        public static var bodyMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 16)?.withWeight(.regular) ?? .systemFont(ofSize: 16, weight: .regular)
        }

        public static var bodySmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 14)?.withWeight(.regular) ?? .systemFont(ofSize: 14, weight: .regular)
        }

        // MARK: - Labels

        public static var labelLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 18)?.withWeight(.medium) ?? .systemFont(ofSize: 18, weight: .medium)
        }

        public static var labelMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 16)?.withWeight(.medium) ?? .systemFont(ofSize: 16, weight: .medium)
        }

        public static var labelSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 14)?.withWeight(.medium) ?? .systemFont(ofSize: 14, weight: .medium)
        }

        public static var labelXSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 13)?.withWeight(.medium) ?? .systemFont(ofSize: 13, weight: .medium)
        }

        // MARK: - Monospace

        public static var code: UIFont {
            UIFont(name: fontFamilyMono, size: 16)?.withWeight(.regular) ?? .monospacedSystemFont(ofSize: 16, weight: .regular)
        }

        public static var codeSmall: UIFont {
            UIFont(name: fontFamilyMono, size: 14)?.withWeight(.regular) ?? .monospacedSystemFont(ofSize: 14, weight: .regular)
        }
    }
}

// MARK: - UIFont Weight Extension
// Note: withWeight is now provided by iOS natively, so this extension has been removed

#endif
