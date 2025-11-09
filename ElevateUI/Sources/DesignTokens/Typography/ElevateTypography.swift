import Foundation
#if os(iOS)
import SwiftUI
import UIKit

/// ELEVATE Design System Typography Tokens
///
/// This file defines the typography system for the ELEVATE design system,
/// including font families, sizes, weights, and text styles.
///
/// Based on ELEVATE Core UI design tokens from:
/// @inform-elevate/elevate-design-tokens
///
/// ## Font Registration
///
/// Before using custom fonts, you must register them in your app:
///
/// ```swift
/// import ElevateUI
///
/// @main
/// struct MyApp: App {
///     init() {
///         ElevateFontRegistration.registerFonts()
///     }
///
///     var body: some Scene {
///         WindowGroup {
///             ContentView()
///         }
///     }
/// }
/// ```
///
/// ## Using Inter Font
///
/// This package includes Inter font (SIL Open Font License) in multiple weights:
/// - Variable fonts: InterVariable.ttf (recommended for iOS 13+)
/// - Static fonts: Regular, Medium, SemiBold, Bold
///
/// All typography styles use Inter by default. If Inter fails to load,
/// the system falls back to San Francisco (iOS system font).
@available(iOS 15, *)
public struct ElevateTypography {

    // MARK: - Font Families

    /// Primary font family (Inter)
    public static let fontFamilyPrimary = "Inter"

    /// Monospace font family (Roboto Mono)
    public static let fontFamilyMono = "Roboto Mono"

    // MARK: - Font Weights

    public enum FontWeight {
        case regular    // 400
        case medium     // 500
        case semibold   // 600
        case bold       // 700

        var swiftUIWeight: Font.Weight {
            switch self {
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            }
        }

        var uiKitWeight: UIFont.Weight {
            switch self {
            case .regular: return .regular
            case .medium: return .medium
            case .semibold: return .semibold
            case .bold: return .bold
            }
        }
    }

    // MARK: - Base Sizes (ELEVATE Web Defaults)

    /// Typography base sizes from ELEVATE design tokens
    /// These can be themed/overridden, and iOS applies iosScaleFactor on top
    public enum Sizes {
        // Display
        public static let displayLarge: CGFloat = 57
        public static let displayMedium: CGFloat = 45
        public static let displaySmall: CGFloat = 36

        // Headings
        public static let headingLarge: CGFloat = 32
        public static let headingMedium: CGFloat = 28
        public static let headingSmall: CGFloat = 24
        public static let headingXSmall: CGFloat = 20

        // Titles
        public static let titleLarge: CGFloat = 22
        public static let titleMedium: CGFloat = 16
        public static let titleSmall: CGFloat = 14

        // Body
        public static let bodyLarge: CGFloat = 16
        public static let bodyMedium: CGFloat = 14
        public static let bodySmall: CGFloat = 12

        // Labels
        public static let labelLarge: CGFloat = 16
        public static let labelMedium: CGFloat = 14
        public static let labelSmall: CGFloat = 12
        public static let labelXSmall: CGFloat = 11

        // Monospace
        public static let code: CGFloat = 14
        public static let codeSmall: CGFloat = 12
    }

    // MARK: - Heading Styles

    /// Display heading (largest)
    public static let displayLarge = Font.custom(fontFamilyPrimary, size: Sizes.displayLarge)
        .weight(FontWeight.bold.swiftUIWeight)

    public static let displayMedium = Font.custom(fontFamilyPrimary, size: Sizes.displayMedium)
        .weight(FontWeight.bold.swiftUIWeight)

    public static let displaySmall = Font.custom(fontFamilyPrimary, size: Sizes.displaySmall)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Large heading
    public static let headingLarge = Font.custom(fontFamilyPrimary, size: Sizes.headingLarge)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Medium heading
    public static let headingMedium = Font.custom(fontFamilyPrimary, size: Sizes.headingMedium)
        .weight(FontWeight.bold.swiftUIWeight)

    /// Small heading
    public static let headingSmall = Font.custom(fontFamilyPrimary, size: Sizes.headingSmall)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Extra small heading
    public static let headingXSmall = Font.custom(fontFamilyPrimary, size: Sizes.headingXSmall)
        .weight(FontWeight.semibold.swiftUIWeight)

    // MARK: - Title Styles

    /// Large title
    public static let titleLarge = Font.custom(fontFamilyPrimary, size: Sizes.titleLarge)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Medium title
    public static let titleMedium = Font.custom(fontFamilyPrimary, size: Sizes.titleMedium)
        .weight(FontWeight.semibold.swiftUIWeight)

    /// Small title
    public static let titleSmall = Font.custom(fontFamilyPrimary, size: Sizes.titleSmall)
        .weight(FontWeight.semibold.swiftUIWeight)

    // MARK: - Body Text Styles

    /// Large body text
    public static let bodyLarge = Font.custom(fontFamilyPrimary, size: Sizes.bodyLarge)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Medium body text (default)
    public static let bodyMedium = Font.custom(fontFamilyPrimary, size: Sizes.bodyMedium)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Small body text
    public static let bodySmall = Font.custom(fontFamilyPrimary, size: Sizes.bodySmall)
        .weight(FontWeight.regular.swiftUIWeight)

    // MARK: - Label Styles

    /// Large label (emphasized)
    public static let labelLarge = Font.custom(fontFamilyPrimary, size: Sizes.labelLarge)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Medium label (emphasized)
    public static let labelMedium = Font.custom(fontFamilyPrimary, size: Sizes.labelMedium)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Small label (emphasized)
    public static let labelSmall = Font.custom(fontFamilyPrimary, size: Sizes.labelSmall)
        .weight(FontWeight.medium.swiftUIWeight)

    /// Extra small label
    public static let labelXSmall = Font.custom(fontFamilyPrimary, size: Sizes.labelXSmall)
        .weight(FontWeight.medium.swiftUIWeight)

    // MARK: - Monospace Styles

    /// Code/monospace text
    public static let code = Font.custom(fontFamilyMono, size: Sizes.code)
        .weight(FontWeight.regular.swiftUIWeight)

    /// Small code/monospace text
    public static let codeSmall = Font.custom(fontFamilyMono, size: Sizes.codeSmall)
        .weight(FontWeight.regular.swiftUIWeight)

    // MARK: - UIKit Compatibility

    /// UIKit-compatible font accessors
    public enum UIKit {

        // MARK: - Headings

        public static var displayLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 57)?.withWeight(.bold) ?? .systemFont(ofSize: 57, weight: .bold)
        }

        public static var displayMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 45)?.withWeight(.bold) ?? .systemFont(ofSize: 45, weight: .bold)
        }

        public static var displaySmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 36)?.withWeight(.bold) ?? .systemFont(ofSize: 36, weight: .bold)
        }

        public static var headingLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 32)?.withWeight(.bold) ?? .systemFont(ofSize: 32, weight: .bold)
        }

        public static var headingMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 28)?.withWeight(.bold) ?? .systemFont(ofSize: 28, weight: .bold)
        }

        public static var headingSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 24)?.withWeight(.semibold) ?? .systemFont(ofSize: 24, weight: .semibold)
        }

        public static var headingXSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 20)?.withWeight(.semibold) ?? .systemFont(ofSize: 20, weight: .semibold)
        }

        // MARK: - Titles

        public static var titleLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 22)?.withWeight(.semibold) ?? .systemFont(ofSize: 22, weight: .semibold)
        }

        public static var titleMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 16)?.withWeight(.semibold) ?? .systemFont(ofSize: 16, weight: .semibold)
        }

        public static var titleSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 14)?.withWeight(.semibold) ?? .systemFont(ofSize: 14, weight: .semibold)
        }

        // MARK: - Body

        public static var bodyLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 16)?.withWeight(.regular) ?? .systemFont(ofSize: 16, weight: .regular)
        }

        public static var bodyMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 14)?.withWeight(.regular) ?? .systemFont(ofSize: 14, weight: .regular)
        }

        public static var bodySmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 12)?.withWeight(.regular) ?? .systemFont(ofSize: 12, weight: .regular)
        }

        // MARK: - Labels

        public static var labelLarge: UIFont {
            UIFont(name: fontFamilyPrimary, size: 16)?.withWeight(.medium) ?? .systemFont(ofSize: 16, weight: .medium)
        }

        public static var labelMedium: UIFont {
            UIFont(name: fontFamilyPrimary, size: 14)?.withWeight(.medium) ?? .systemFont(ofSize: 14, weight: .medium)
        }

        public static var labelSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 12)?.withWeight(.medium) ?? .systemFont(ofSize: 12, weight: .medium)
        }

        public static var labelXSmall: UIFont {
            UIFont(name: fontFamilyPrimary, size: 11)?.withWeight(.medium) ?? .systemFont(ofSize: 11, weight: .medium)
        }

        // MARK: - Monospace

        public static var code: UIFont {
            UIFont(name: fontFamilyMono, size: 14)?.withWeight(.regular) ?? .monospacedSystemFont(ofSize: 14, weight: .regular)
        }

        public static var codeSmall: UIFont {
            UIFont(name: fontFamilyMono, size: 12)?.withWeight(.regular) ?? .monospacedSystemFont(ofSize: 12, weight: .regular)
        }
    }
}

// MARK: - Helper Extensions

@available(iOS 15, *)
extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let descriptor = fontDescriptor.addingAttributes([
            .traits: [UIFontDescriptor.TraitKey.weight: weight]
        ])
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}
#endif
