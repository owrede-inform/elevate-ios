#if os(iOS)
import SwiftUI

/// Icon component with SF Symbols integration
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's icon fonts, this uses:
/// - **SF Symbols**: Apple's native icon system (30,000+ icons)
/// - **System Image API**: SwiftUI's native `Image(systemName:)` for best performance
/// - **Custom images**: Support for custom assets when needed
/// - **Size variants**: Small, medium, large matching iOS conventions
/// - **Color variants**: Semantic colors (primary, danger, success, warning, neutral)
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// // SF Symbol
/// ElevateIcon("heart.fill", color: .danger, size: .medium)
///
/// // Custom image
/// ElevateIcon(image: "custom-logo", size: .large)
///
/// // Avatar icon
/// ElevateIcon.avatar("JD", size: .medium)
/// ```
@available(iOS 15, *)
public struct ElevateIcon: View {

    private let systemName: String?
    private let imageName: String?
    private let color: IconColor
    private let size: IconSize

    @Environment(\.isEnabled) private var isEnabled

    // MARK: - Initialization

    /// Create an icon with SF Symbol
    public init(
        _ systemName: String,
        color: IconColor = .neutral,
        size: IconSize = .medium
    ) {
        self.systemName = systemName
        self.imageName = nil
        self.color = color
        self.size = size
    }

    /// Create an icon with custom image asset
    public init(
        image imageName: String,
        color: IconColor = .neutral,
        size: IconSize = .medium
    ) {
        self.systemName = nil
        self.imageName = imageName
        self.color = color
        self.size = size
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if let systemName = systemName {
                Image(systemName: systemName)
                    .font(.system(size: iconSize))
                    .symbolRenderingMode(.hierarchical)
            } else if let imageName = imageName {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: iconSize, height: iconSize)
            }
        }
        .foregroundColor(iconColor)
        .opacity(isEnabled ? 1.0 : 0.5)
    }

    // MARK: - Computed Properties

    private var iconSize: CGFloat {
        switch size {
        case .small: return 16
        case .medium: return 20
        case .large: return 24
        }
    }

    private var iconColor: Color {
        if !isEnabled {
            return Color.secondary
        }

        switch color {
        case .primary: return IconComponentTokens.color_primary
        case .danger: return IconComponentTokens.color_danger
        case .success: return IconComponentTokens.color_success
        case .warning: return IconComponentTokens.color_warning
        case .neutral: return IconComponentTokens.color_neutral
        case .emphasized: return IconComponentTokens.color_emphasized
        }
    }
}

// MARK: - Icon Size

public enum IconSize {
    case small
    case medium
    case large
}

// MARK: - Icon Color

public enum IconColor {
    case primary
    case danger
    case success
    case warning
    case neutral
    case emphasized
}

// MARK: - Avatar Icon

@available(iOS 15, *)
extension ElevateIcon {
    /// Create an avatar icon with initials
    ///
    /// **iOS Adaptation**: Uses native iOS avatar pattern with circular background.
    ///
    /// Example:
    /// ```swift
    /// ElevateIcon.avatar("JD", size: .medium)
    /// ElevateIcon.avatar("AB", size: .large, isSelected: true)
    /// ```
    public static func avatar(
        _ initials: String,
        size: IconSize = .medium,
        isSelected: Bool = false
    ) -> some View {
        AvatarIcon(initials: initials, size: size, isSelected: isSelected)
    }
}

// MARK: - Avatar Icon View

@available(iOS 15, *)
private struct AvatarIcon: View {
    let initials: String
    let size: IconSize
    let isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .fill(backgroundColor)
                .overlay(
                    Circle()
                        .stroke(borderColor, lineWidth: IconComponentTokens.avatar_border_width_default)
                )

            Text(initials.prefix(2).uppercased())
                .font(.system(size: fontSize, weight: .medium))
                .foregroundColor(textColor)
        }
        .frame(width: avatarSize, height: avatarSize)
    }

    private var avatarSize: CGFloat {
        switch size {
        case .small: return IconComponentTokens.avatar_sizeNotPublished_circle_diameter_s
        case .medium: return IconComponentTokens.avatar_sizeNotPublished_circle_diameter_m
        case .large: return IconComponentTokens.avatar_sizeNotPublished_circle_diameter_l
        }
    }

    private var fontSize: CGFloat {
        switch size {
        case .small: return 12
        case .medium: return 14
        case .large: return 18
        }
    }

    private var backgroundColor: Color {
        // NOTE: Removed hover state - no hover on iOS per DIVERSIONS.md
        if isSelected {
            return IconComponentTokens.avatar_fill_selected_default
        }
        return IconComponentTokens.avatar_fill_default
    }

    private var borderColor: Color {
        // NOTE: Removed hover state - no hover on iOS per DIVERSIONS.md
        if isSelected {
            return IconComponentTokens.avatar_border_color_selected_default
        }
        return IconComponentTokens.avatar_border_color_default
    }

    private var textColor: Color {
        IconComponentTokens.avatar_text_color_onDark
    }
}

// MARK: - Icon Button

/// Icon button with tap gesture and haptic feedback
///
/// **iOS Adaptation**: Combines icon with button behavior and haptic feedback.
@available(iOS 15, *)
public struct ElevateIconButton: View {
    private let systemName: String
    private let color: IconColor
    private let size: IconSize
    private let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    public init(
        _ systemName: String,
        color: IconColor = .neutral,
        size: IconSize = .medium,
        action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.color = color
        self.size = size
        self.action = action
    }

    public var body: some View {
        Button {
            performHaptic()
            action()
        } label: {
            ElevateIcon(systemName, color: color, size: size)
                .frame(minWidth: 44, minHeight: 44) // iOS minimum touch target
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateIcon_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text("Icon Examples")
                    .font(.title)

                // SF Symbols with sizes
                VStack(alignment: .leading, spacing: 12) {
                    Text("SF Symbols - Sizes")
                        .font(.headline)

                    HStack(spacing: 20) {
                        VStack {
                            ElevateIcon("heart.fill", color: .danger, size: .small)
                            Text("Small")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon("heart.fill", color: .danger, size: .medium)
                            Text("Medium")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon("heart.fill", color: .danger, size: .large)
                            Text("Large")
                                .font(.caption)
                        }
                    }
                }

                Divider()

                // Color variants
                VStack(alignment: .leading, spacing: 12) {
                    Text("Color Variants")
                        .font(.headline)

                    HStack(spacing: 16) {
                        VStack {
                            ElevateIcon("circle.fill", color: .primary)
                            Text("Primary")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon("circle.fill", color: .danger)
                            Text("Danger")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon("circle.fill", color: .success)
                            Text("Success")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon("circle.fill", color: .warning)
                            Text("Warning")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon("circle.fill", color: .neutral)
                            Text("Neutral")
                                .font(.caption)
                        }
                    }
                }

                Divider()

                // Common SF Symbols
                VStack(alignment: .leading, spacing: 12) {
                    Text("Common SF Symbols")
                        .font(.headline)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 16) {
                        iconExample("house.fill", "Home")
                        iconExample("magnifyingglass", "Search")
                        iconExample("person.fill", "Profile")
                        iconExample("gear", "Settings")
                        iconExample("bell.fill", "Notification")
                        iconExample("heart.fill", "Favorite")
                        iconExample("star.fill", "Star")
                        iconExample("folder.fill", "Folder")
                        iconExample("doc.fill", "Document")
                        iconExample("photo.fill", "Photo")
                        iconExample("trash.fill", "Delete")
                        iconExample("plus.circle.fill", "Add")
                    }
                }

                Divider()

                // Avatar icons
                VStack(alignment: .leading, spacing: 12) {
                    Text("Avatar Icons")
                        .font(.headline)

                    HStack(spacing: 16) {
                        VStack {
                            ElevateIcon.avatar("JD", size: .small)
                            Text("Small")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon.avatar("AB", size: .medium)
                            Text("Medium")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon.avatar("XY", size: .large)
                            Text("Large")
                                .font(.caption)
                        }

                        VStack {
                            ElevateIcon.avatar("CD", size: .medium, isSelected: true)
                            Text("Selected")
                                .font(.caption)
                        }
                    }
                }

                Divider()

                // Icon buttons
                VStack(alignment: .leading, spacing: 12) {
                    Text("Icon Buttons")
                        .font(.headline)

                    HStack(spacing: 16) {
                        ElevateIconButton("heart.fill", color: .danger) {
                            print("Favorite tapped")
                        }

                        ElevateIconButton("star.fill", color: .warning) {
                            print("Star tapped")
                        }

                        ElevateIconButton("trash.fill", color: .danger) {
                            print("Delete tapped")
                        }

                        ElevateIconButton("gear", color: .neutral) {
                            print("Settings tapped")
                        }
                    }
                }

                Divider()

                // Disabled state
                VStack(alignment: .leading, spacing: 12) {
                    Text("Disabled State")
                        .font(.headline)

                    HStack(spacing: 16) {
                        ElevateIcon("heart.fill", color: .danger)
                            .disabled(true)

                        ElevateIconButton("star.fill", color: .warning) {
                            print("Won't fire")
                        }
                        .disabled(true)
                    }
                }

                // iOS Adaptation notes
                VStack(alignment: .leading, spacing: 8) {
                    Text("iOS Adaptations:")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Text("✓ SF Symbols (30,000+ native iOS icons)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ System Image API for best performance")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Hierarchical rendering mode")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ 44pt minimum touch targets for buttons")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Haptic feedback on icon button tap")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }
            .padding()
        }
    }

    static func iconExample(_ systemName: String, _ label: String) -> some View {
        VStack {
            ElevateIcon(systemName, color: .primary)
            Text(label)
                .font(.caption2)
                .multilineTextAlignment(.center)
        }
    }
}
#endif

#endif
