#if os(iOS)
import SwiftUI

/// ELEVATE iOS-Optimized Corner Radius
///
/// Corner radius values scaled for iOS using dynamic scaling factor.
/// References ElevateSpacing.BorderRadius base values and applies iOS scaling.
///
/// Architecture:
/// - ElevateSpacing.BorderRadius.* = ELEVATE web defaults (can be themed)
/// - iosScaleFactor = iOS platform multiplier (1.25x = +25%)
/// - Final radius = ElevateSpacing.BorderRadius.* × iosScaleFactor
///
/// Example: medium = ElevateSpacing.BorderRadius.medium (8pt) × 1.25 = 10pt
///
/// iOS Design Guidelines:
/// - Corner radii should be proportional to component size
/// - Continuous corner radius (.continuous) preferred for iOS-native feel
/// - Consistent scaling maintains visual hierarchy
@available(iOS 15, *)
public struct ElevateCornerRadius {

    // MARK: - iOS Scaling Factor

    /// iOS corner radius scaling factor applied to all ELEVATE web radii
    /// Single point of control for iOS corner radius adaptation
    /// Change this value to adjust ALL corner radii proportionally
    ///
    /// **Note**: Uses same iosScaleFactor as typography for consistency
    public static let iosScaleFactor: CGFloat = 1.25  // +25% larger than web

    // MARK: - Corner Radius Scale

    /// Extra small corner radius
    /// Web: 4pt (ElevateSpacing.BorderRadius.small) → iOS: 5pt (×iosScaleFactor)
    public static let xs: CGFloat = ElevateSpacing.BorderRadius.small * iosScaleFactor

    /// Small corner radius
    /// Web: 8pt (ElevateSpacing.BorderRadius.medium) → iOS: 10pt (×iosScaleFactor)
    public static let s: CGFloat = ElevateSpacing.BorderRadius.medium * iosScaleFactor

    /// Medium corner radius (default)
    /// Web: 12pt (ElevateSpacing.BorderRadius.large) → iOS: 15pt (×iosScaleFactor)
    public static let m: CGFloat = ElevateSpacing.BorderRadius.large * iosScaleFactor

    /// Large corner radius
    /// Web: 16pt (ElevateSpacing.BorderRadius.xlarge) → iOS: 20pt (×iosScaleFactor)
    public static let l: CGFloat = ElevateSpacing.BorderRadius.xlarge * iosScaleFactor

    /// Extra large corner radius (for cards, modals)
    /// Web: 24pt → iOS: 30pt (×iosScaleFactor)
    public static let xl: CGFloat = 24 * iosScaleFactor

    // MARK: - Convenience Accessors

    /// Small corner radius (alias for xs)
    public static let small: CGFloat = xs

    /// Medium corner radius (alias for s)
    public static let medium: CGFloat = s

    /// Large corner radius (alias for m)
    public static let large: CGFloat = m

    /// Extra large corner radius (alias for l)
    public static let xlarge: CGFloat = l

    // MARK: - iOS-Specific Radii

    /// iOS standard button corner radius
    /// Optimized for 44pt minimum touch target height
    public static let button: CGFloat = 10  // iOS standard for buttons

    /// iOS standard input/field corner radius
    /// Matches iOS system text fields
    public static let input: CGFloat = 10  // iOS standard for inputs

    /// iOS standard card corner radius
    /// iOS-native feel for card-style containers
    public static let card: CGFloat = 13  // iOS standard for cards

    /// iOS standard modal/sheet corner radius
    /// Matches system sheet presentation
    public static let modal: CGFloat = 13  // iOS standard for modals

    // MARK: - Helper Methods

    /// Get scaled corner radius from web value
    /// - Parameter webRadius: Web corner radius value
    /// - Returns: iOS-scaled corner radius
    public static func scaled(_ webRadius: CGFloat) -> CGFloat {
        return webRadius * iosScaleFactor
    }

    /// Get continuous corner radius for iOS-native feel
    /// - Parameter radius: Corner radius value
    /// - Returns: RoundedCornerStyle.continuous
    public static func continuous(_ radius: CGFloat) -> RoundedRectangle {
        return RoundedRectangle(cornerRadius: radius, style: .continuous)
    }
}

#endif
