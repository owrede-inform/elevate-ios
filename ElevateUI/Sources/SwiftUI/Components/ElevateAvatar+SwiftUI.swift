#if os(iOS)
import SwiftUI

/// ELEVATE Avatar Component
///
/// Displays a user avatar with support for images, initials, icons, and selection states.
/// Can be circular or box-shaped with customizable sizes and tones.
///
/// **Based on:** Icon component avatar tokens
/// **API Reference:** `.claude/components/Display/icon.md`
@available(iOS 15, *)
public struct ElevateAvatar: View {

    // MARK: - Properties

    /// The image to display (optional)
    private let image: Image?

    /// The text to derive initials from (optional)
    private let label: String?

    /// The SF Symbol icon name (optional)
    private let icon: String?

    /// The shape of the avatar
    private let shape: AvatarShape

    /// The size of the avatar
    private let size: AvatarSize

    /// The color tone
    private let tone: AvatarTone

    /// Whether the avatar is selected
    private let isSelected: Bool

    /// Custom fill color (overrides tone)
    private let fillColor: Color?

    // MARK: - State

    @State private var isPressed = false
    @State private var isHovered = false

    // MARK: - Initializer

    /// Creates an avatar
    ///
    /// - Parameters:
    ///   - image: Optional image to display
    ///   - label: Text to derive initials from (default: nil)
    ///   - icon: SF Symbol name (default: nil)
    ///   - shape: Shape of avatar (default: .circle)
    ///   - size: Size of avatar (default: .medium)
    ///   - tone: Color tone (default: .neutral)
    ///   - isSelected: Whether selected (default: false)
    ///   - fillColor: Custom fill color (default: nil)
    public init(
        image: Image? = nil,
        label: String? = nil,
        icon: String? = nil,
        shape: AvatarShape = .circle,
        size: AvatarSize = .medium,
        tone: AvatarTone = .neutral,
        isSelected: Bool = false,
        fillColor: Color? = nil
    ) {
        self.image = image
        self.label = label
        self.icon = icon
        self.shape = shape
        self.size = size
        self.tone = tone
        self.isSelected = isSelected
        self.fillColor = fillColor
    }

    // MARK: - Body

    public var body: some View {
        ZStack {
            // Background
            Group {
                if shape == .circle {
                    Circle()
                        .fill(tokenFillColor)
                } else {
                    RoundedRectangle(cornerRadius: tokenBorderRadius)
                        .fill(tokenFillColor)
                }
            }

            // Content
            contentView
                .foregroundColor(tokenTextColor)
        }
        .frame(width: tokenSize, height: tokenSize)
        .overlay(
            Group {
                if shape == .circle {
                    Circle()
                        .strokeBorder(tokenBorderColor, lineWidth: tokenBorderWidth)
                } else {
                    RoundedRectangle(cornerRadius: tokenBorderRadius)
                        .strokeBorder(tokenBorderColor, lineWidth: tokenBorderWidth)
                }
            }
        )
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    // MARK: - Content View

    @ViewBuilder
    private var contentView: some View {
        if let image = image {
            Group {
                if shape == .circle {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: tokenSize - tokenBorderWidth * 2, height: tokenSize - tokenBorderWidth * 2)
                        .clipShape(Circle())
                } else {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: tokenSize - tokenBorderWidth * 2, height: tokenSize - tokenBorderWidth * 2)
                        .clipShape(RoundedRectangle(cornerRadius: tokenBorderRadius))
                }
            }
        } else if let icon = icon {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: tokenIconSize, height: tokenIconSize)
        } else if let initials = computedInitials {
            Text(initials)
                .font(initialsFont)
                .fontWeight(.medium)
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: tokenIconSize, height: tokenIconSize)
        }
    }

    // MARK: - Helpers

    private var computedInitials: String? {
        guard let label = label, !label.isEmpty else { return nil }

        let words = label.split(separator: " ")
        if words.count >= 2 {
            // Take first letter of first two words
            let first = words[0].prefix(1).uppercased()
            let second = words[1].prefix(1).uppercased()
            return first + second
        } else if let word = words.first {
            // Take first two letters of single word
            return String(word.prefix(2).uppercased())
        }
        return nil
    }

    private var accessibilityLabel: String {
        label ?? "Avatar"
    }

    // MARK: - Token Accessors

    private var tokenSize: CGFloat {
        switch (shape, size) {
        case (.circle, .small): return IconComponentTokens.avatar_sizeNotPublished_circle_diameter_s
        case (.circle, .medium): return IconComponentTokens.avatar_sizeNotPublished_circle_diameter_m
        case (.circle, .large): return IconComponentTokens.avatar_sizeNotPublished_circle_diameter_l
        case (.box, .small): return IconComponentTokens.avatar_sizeNotPublished_box_width_s
        case (.box, .medium): return IconComponentTokens.avatar_sizeNotPublished_box_width_m
        case (.box, .large): return IconComponentTokens.avatar_sizeNotPublished_box_width_l
        }
    }

    private var tokenIconSize: CGFloat {
        tokenSize * 0.5
    }

    private var tokenBorderRadius: CGFloat {
        IconComponentTokens.avatar_border_radius_default
    }

    private var tokenBorderWidth: CGFloat {
        IconComponentTokens.avatar_border_width_default
    }

    private var tokenFillColor: Color {
        if let fillColor = fillColor {
            return fillColor
        }

        if isSelected {
            if isPressed {
                return IconComponentTokens.avatar_fill_selected_active
            }
            if isHovered {
                return IconComponentTokens.avatar_fill_selected_hover
            }
            return IconComponentTokens.avatar_fill_selected_default
        }

        if isPressed {
            return IconComponentTokens.avatar_fill_active
        }
        if isHovered {
            return IconComponentTokens.avatar_fill_hover
        }
        return IconComponentTokens.avatar_fill_default
    }

    private var tokenBorderColor: Color {
        if isSelected {
            if isPressed {
                return IconComponentTokens.avatar_border_color_selected_active
            }
            if isHovered {
                return IconComponentTokens.avatar_border_color_selected_hover
            }
            return IconComponentTokens.avatar_border_color_selected_default
        }

        if isPressed {
            return IconComponentTokens.avatar_border_color_active
        }
        if isHovered {
            return IconComponentTokens.avatar_border_color_hover
        }
        return IconComponentTokens.avatar_border_color_default
    }

    private var tokenTextColor: Color {
        // Determine if fill is light or dark
        let isDarkFill = fillColor != nil
        return isDarkFill ? IconComponentTokens.avatar_text_color_onDark : IconComponentTokens.avatar_text_color_onLight
    }

    private var initialsFont: Font {
        switch size {
        case .small: return ElevateTypographyiOS.labelSmall // 14pt (web: 12pt)
        case .medium: return ElevateTypographyiOS.labelMedium // 16pt (web: 14pt)
        case .large: return ElevateTypographyiOS.labelLarge // 18pt (web: 16pt)
        }
    }
}

// MARK: - Avatar Shape

@available(iOS 15, *)
public enum AvatarShape {
    case circle
    case box
}

// MARK: - Avatar Size

@available(iOS 15, *)
public enum AvatarSize {
    case small
    case medium
    case large
}

// MARK: - Avatar Tone

@available(iOS 15, *)
public enum AvatarTone {
    case neutral
    case primary
    case success
    case warning
    case danger
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateAvatar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Avatars with Initials
                VStack(alignment: .leading, spacing: 16) {
                    Text("Avatars with Initials").font(.headline)

                    HStack(spacing: 16) {
                        ElevateAvatar(label: "John Doe")
                        ElevateAvatar(label: "Jane Smith")
                        ElevateAvatar(label: "Bob Johnson")
                        ElevateAvatar(label: "Alice")
                    }
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Avatar Sizes").font(.headline)

                    HStack(spacing: 16) {
                        ElevateAvatar(label: "JD", size: .small)
                        ElevateAvatar(label: "JD", size: .medium)
                        ElevateAvatar(label: "JD", size: .large)
                    }
                }

                Divider()

                // Shapes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Avatar Shapes").font(.headline)

                    HStack(spacing: 16) {
                        ElevateAvatar(label: "JS", shape: .circle)
                        ElevateAvatar(label: "JS", shape: .box)
                    }
                }

                Divider()

                // With Icons
                VStack(alignment: .leading, spacing: 16) {
                    Text("Avatars with Icons").font(.headline)

                    HStack(spacing: 16) {
                        ElevateAvatar(icon: "person.fill")
                        ElevateAvatar(icon: "star.fill")
                        ElevateAvatar(icon: "heart.fill")
                        ElevateAvatar(icon: "bell.fill")
                    }
                }

                Divider()

                // With Images
                VStack(alignment: .leading, spacing: 16) {
                    Text("Avatars with Images").font(.headline)

                    HStack(spacing: 16) {
                        ElevateAvatar(
                            image: Image(systemName: "person.crop.circle.fill"),
                            label: "User 1"
                        )
                        ElevateAvatar(
                            image: Image(systemName: "person.crop.circle.fill"),
                            label: "User 2",
                            shape: .box
                        )
                    }
                }

                Divider()

                // Selected State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Selected State").font(.headline)

                    HStack(spacing: 16) {
                        ElevateAvatar(label: "JD", isSelected: false)
                        ElevateAvatar(label: "JD", isSelected: true)
                    }
                }

                Divider()

                // Custom Colors
                VStack(alignment: .leading, spacing: 16) {
                    Text("Custom Fill Colors").font(.headline)

                    HStack(spacing: 16) {
                        ElevateAvatar(label: "A", fillColor: .blue)
                        ElevateAvatar(label: "B", fillColor: .green)
                        ElevateAvatar(label: "C", fillColor: .orange)
                        ElevateAvatar(label: "D", fillColor: .purple)
                        ElevateAvatar(label: "E", fillColor: .red)
                    }
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Use Cases").font(.headline)

                    VStack(alignment: .leading, spacing: 16) {
                        // User list
                        HStack {
                            ElevateAvatar(label: "John Doe", size: .small)
                            VStack(alignment: .leading) {
                                Text("John Doe")
                                    .font(.body)
                                Text("Software Engineer")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }

                        // Navigation bar avatar
                        HStack {
                            Text("Profile")
                                .font(.title2)
                            Spacer()
                            ElevateAvatar(
                                label: "Jane Smith",
                                size: .medium,
                                isSelected: true
                            )
                        }

                        // Comment thread
                        HStack(alignment: .top, spacing: 12) {
                            ElevateAvatar(label: "Bob", size: .small)
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text("Bob Johnson")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                    Text("2h ago")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Text("This looks great! Thanks for sharing.")
                                    .font(.body)
                            }
                        }

                        // Team members
                        HStack {
                            Text("Team")
                                .font(.headline)
                            Spacer()
                            HStack(spacing: -8) {
                                ElevateAvatar(label: "Alice Brown", size: .small)
                                ElevateAvatar(label: "Charlie Davis", size: .small)
                                ElevateAvatar(label: "Diana Evans", size: .small)
                                ZStack {
                                    Circle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(width: 36, height: 36)
                                    Text("+5")
                                        .font(.caption2)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
