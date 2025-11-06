#if os(iOS)
import SwiftUI

/// ELEVATE Spacing Tokens
///
/// Provides consistent spacing values across the design system.
/// These values ensure visual rhythm and proper component spacing.
@available(iOS 15, *)
public struct ElevateSpacing {

    // MARK: - Spacing Scale

    /// Extra extra small spacing (2pt)
    public static let xxs: CGFloat = 2

    /// Extra small spacing (4pt)
    public static let xs: CGFloat = 4

    /// Small spacing (8pt)
    public static let s: CGFloat = 8

    /// Medium spacing (16pt) - Default spacing
    public static let m: CGFloat = 16

    /// Large spacing (24pt)
    public static let l: CGFloat = 24

    /// Extra large spacing (32pt)
    public static let xl: CGFloat = 32

    // MARK: - Border Radius

    public struct BorderRadius {
        /// Small border radius (4pt)
        public static let small: CGFloat = 4

        /// Medium border radius (8pt)
        public static let medium: CGFloat = 8

        /// Large border radius (12pt)
        public static let large: CGFloat = 12

        /// Extra large border radius (16pt)
        public static let xlarge: CGFloat = 16
    }

    // MARK: - Border Width

    public struct BorderWidth {
        /// Thin border (1pt)
        public static let thin: CGFloat = 1

        /// Medium border (2pt)
        public static let medium: CGFloat = 2

        /// Thick border (3pt)
        public static let thick: CGFloat = 3
    }

    // MARK: - Icon Sizes

    public enum IconSize: CGFloat {
        case small = 16
        case medium = 24
        case large = 32
        case xlarge = 48

        public var value: CGFloat {
            self.rawValue
        }
    }
}

#endif
