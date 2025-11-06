#if os(iOS)
import SwiftUI

/// ELEVATE Icon Size
///
/// Standard icon sizes for the ELEVATE design system.
@available(iOS 15, *)
public enum ElevateIconSize {
    case small
    case medium
    case large
    case custom(CGFloat)

    /// The CGFloat value for the icon size
    public var value: CGFloat {
        switch self {
        case .small: return 16.0
        case .medium: return 20.0
        case .large: return 24.0
        case .custom(let size): return size
        }
    }
}

/// ELEVATE Icon System
///
/// Provides semantic icon names mapped to SF Symbols with automatic sizing.
/// This ensures consistent icon usage across the design system while leveraging
/// iOS native SF Symbols.
///
/// Usage:
/// ```swift
/// ElevateButton("Delete", prefix: {
///     ElevateIcon.close.image(size: .small)
/// })
/// ```
@available(iOS 15, *)
public enum ElevateIcon: String, CaseIterable {

    // MARK: - Actions
    case close = "xmark"
    case closeCircle = "xmark.circle.fill"
    case add = "plus"
    case addCircle = "plus.circle.fill"
    case remove = "minus"
    case removeCircle = "minus.circle.fill"
    case edit = "pencil"
    case delete = "trash"
    case save = "checkmark"
    case cancel = "xmark.circle"

    // MARK: - Navigation
    case chevronUp = "chevron.up"
    case chevronDown = "chevron.down"
    case chevronLeft = "chevron.left"
    case chevronRight = "chevron.right"
    case arrowUp = "arrow.up"
    case arrowDown = "arrow.down"
    case arrowLeft = "arrow.left"
    case arrowRight = "arrow.right"
    case menu = "line.3.horizontal"
    case more = "ellipsis"

    // MARK: - Status & Feedback
    case checkCircle = "checkmark.circle.fill"
    case infoCircle = "info.circle.fill"
    case warningTriangle = "exclamationmark.triangle.fill"
    case errorCircle = "exclamationmark.circle.fill"
    case helpCircle = "questionmark.circle.fill"

    // MARK: - Content
    case search = "magnifyingglass"
    case filter = "line.3.horizontal.decrease.circle"
    case sort = "arrow.up.arrow.down"
    case calendar = "calendar"
    case clock = "clock"
    case location = "location.fill"
    case attach = "paperclip"
    case camera = "camera.fill"
    case photo = "photo.fill"

    // MARK: - Communication
    case mail = "envelope.fill"
    case notification = "bell.fill"
    case share = "square.and.arrow.up"
    case link = "link"

    // MARK: - User
    case person = "person.fill"
    case personCircle = "person.crop.circle.fill"
    case people = "person.2.fill"

    // MARK: - Settings
    case settings = "gearshape.fill"
    case visibility = "eye.fill"
    case visibilityOff = "eye.slash.fill"
    case lock = "lock.fill"
    case unlock = "lock.open.fill"

    // MARK: - Media
    case play = "play.fill"
    case pause = "pause.fill"
    case stop = "stop.fill"
    case volume = "speaker.wave.2.fill"
    case volumeOff = "speaker.slash.fill"

    // MARK: - Files
    case folder = "folder.fill"
    case document = "doc.fill"
    case download = "arrow.down.circle.fill"
    case upload = "arrow.up.circle.fill"

    // MARK: - Star/Favorite
    case star = "star"
    case starFilled = "star.fill"
    case heart = "heart"
    case heartFilled = "heart.fill"

    // MARK: - Image Generation

    /// Create an Image view with automatic sizing
    ///
    /// - Parameters:
    ///   - size: The icon size to use (defaults to .medium)
    ///   - renderingMode: The rendering mode (defaults to .template for tinting)
    /// - Returns: A sized Image view ready to use in SwiftUI
    public func image(
        size: ElevateIconSize = .medium,
        renderingMode: Image.TemplateRenderingMode = .template
    ) -> some View {
        Image(systemName: rawValue)
            .resizable()
            .renderingMode(renderingMode)
            .aspectRatio(contentMode: .fit)
            .frame(width: size.value, height: size.value)
    }

    /// Create a basic SwiftUI Image (no automatic sizing)
    ///
    /// Use this when you need manual control over sizing.
    ///
    /// - Returns: SwiftUI Image of the SF Symbol
    public func makeImage() -> Image {
        Image(systemName: rawValue)
    }

    // MARK: - Semantic Helpers

    /// Success icons (typically green/positive)
    public static let successIcons: [ElevateIcon] = [.checkCircle, .checkCircle]

    /// Warning icons (typically yellow/caution)
    public static let warningIcons: [ElevateIcon] = [.warningTriangle]

    /// Error/Danger icons (typically red/negative)
    public static let errorIcons: [ElevateIcon] = [.errorCircle, .closeCircle]

    /// Info icons (typically blue/neutral)
    public static let infoIcons: [ElevateIcon] = [.infoCircle, .helpCircle]
}

// MARK: - Icon Size Extension

@available(iOS 15, *)
extension ElevateIconSize {
    /// Convenience for creating sized icon views
    public func frame(for image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: value, height: value)
    }
}

// MARK: - View Extension

@available(iOS 15, *)
extension View {
    /// Apply icon sizing from ELEVATE design tokens
    ///
    /// Usage:
    /// ```swift
    /// Image(systemName: "star.fill")
    ///     .iconSize(.medium)
    /// ```
    public func iconSize(_ size: ElevateIconSize) -> some View {
        self
            .frame(width: size.value, height: size.value)
    }
}

#endif
