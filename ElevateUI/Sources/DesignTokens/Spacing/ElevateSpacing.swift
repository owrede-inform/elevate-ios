#if os(iOS)
import SwiftUI
import CoreGraphics

/// ELEVATE Design System Spacing Tokens
///
/// This file defines the spacing and sizing system for the ELEVATE design system,
/// including padding, margins, gaps, and component sizes.
///
/// Based on ELEVATE Core UI design tokens from:
/// @inform-elevate/elevate-design-tokens
@available(iOS 15, *)
public struct ElevateSpacing {

    // MARK: - Base Spacing Scale

    /// Extra extra small spacing (2pt)
    public static let xxs: CGFloat = 2

    /// Extra small spacing (4pt)
    public static let xs: CGFloat = 4

    /// Small spacing (8pt)
    public static let s: CGFloat = 8

    /// Medium spacing (12pt)
    public static let m: CGFloat = 12

    /// Large spacing (16pt)
    public static let l: CGFloat = 16

    /// Extra large spacing (24pt)
    public static let xl: CGFloat = 24

    /// Extra extra large spacing (32pt)
    public static let xxl: CGFloat = 32

    /// Extra extra extra large spacing (48pt)
    public static let xxxl: CGFloat = 48

    // MARK: - Semantic Spacing

    /// Spacing between related elements within a component
    public static let componentGap = s

    /// Spacing between different components
    public static let sectionGap = l

    /// Page margins
    public static let pageMargin = l

    /// Container padding
    public static let containerPadding = m

    // MARK: - Border Radius

    public enum BorderRadius {
        /// No border radius
        public static let none: CGFloat = 0

        /// Small border radius (4pt)
        public static let small: CGFloat = 4

        /// Medium border radius (8pt)
        public static let medium: CGFloat = 8

        /// Large border radius (12pt)
        public static let large: CGFloat = 12

        /// Extra large border radius (16pt)
        public static let extraLarge: CGFloat = 16

        /// Fully rounded (pill shape)
        public static let full: CGFloat = 9999
    }

    // MARK: - Border Width

    public enum BorderWidth {
        /// Thin border (1pt)
        public static let thin: CGFloat = 1

        /// Medium border (2pt)
        public static let medium: CGFloat = 2

        /// Thick border (4pt)
        public static let thick: CGFloat = 4
    }

    // MARK: - Component Sizes

    public enum ComponentSize {
        case small
        case medium
        case large

        /// Height for the component size
        public var height: CGFloat {
            switch self {
            case .small: return 32
            case .medium: return 40
            case .large: return 48
            }
        }

        /// Padding inline (horizontal) for the component size
        public var paddingInline: CGFloat {
            switch self {
            case .small: return ElevateSpacing.m
            case .medium: return ElevateSpacing.l
            case .large: return ElevateSpacing.xl
            }
        }

        /// Gap (spacing between elements) for the component size
        public var gap: CGFloat {
            switch self {
            case .small: return ElevateSpacing.s
            case .medium: return ElevateSpacing.m
            case .large: return ElevateSpacing.l
            }
        }

        /// Border radius for the component size
        public var borderRadius: CGFloat {
            switch self {
            case .small: return BorderRadius.small
            case .medium: return BorderRadius.medium
            case .large: return BorderRadius.large
            }
        }
    }

    // MARK: - Icon Sizes

    public enum IconSize {
        /// Small icon (16pt)
        public static let small: CGFloat = 16

        /// Medium icon (20pt)
        public static let medium: CGFloat = 20

        /// Large icon (24pt)
        public static let large: CGFloat = 24

        /// Extra large icon (32pt)
        public static let extraLarge: CGFloat = 32
    }

    // MARK: - Elevation (Shadow)

    public enum Elevation {
        case none
        case low
        case medium
        case high

        public var shadowRadius: CGFloat {
            switch self {
            case .none: return 0
            case .low: return 2
            case .medium: return 4
            case .high: return 8
            }
        }

        public var shadowOffset: CGSize {
            switch self {
            case .none: return .zero
            case .low: return CGSize(width: 0, height: 1)
            case .medium: return CGSize(width: 0, height: 2)
            case .high: return CGSize(width: 0, height: 4)
            }
        }

        public var shadowOpacity: Float {
            switch self {
            case .none: return 0
            case .low: return 0.1
            case .medium: return 0.15
            case .high: return 0.2
            }
        }
    }
}

// MARK: - SwiftUI Extensions

@available(iOS 15, *)
extension View {
    /// Apply ELEVATE padding with the specified spacing value
    public func elevatePadding(_ spacing: CGFloat) -> some View {
        self.padding(spacing)
    }

    /// Apply ELEVATE padding with different values for edges
    public func elevatePadding(
        top: CGFloat = 0,
        leading: CGFloat = 0,
        bottom: CGFloat = 0,
        trailing: CGFloat = 0
    ) -> some View {
        self.padding(.top, top)
            .padding(.leading, leading)
            .padding(.bottom, bottom)
            .padding(.trailing, trailing)
    }

    /// Apply ELEVATE elevation (shadow)
    public func elevateElevation(_ elevation: ElevateSpacing.Elevation) -> some View {
        self.shadow(
            color: Color.black.opacity(Double(elevation.shadowOpacity)),
            radius: elevation.shadowRadius,
            x: elevation.shadowOffset.width,
            y: elevation.shadowOffset.height
        )
    }

    /// Apply ELEVATE border radius
    public func elevateBorderRadius(_ radius: CGFloat) -> some View {
        self.cornerRadius(radius)
    }
}
#endif
