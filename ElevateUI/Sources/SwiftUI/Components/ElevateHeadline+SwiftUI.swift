#if os(iOS)
import SwiftUI

/// ELEVATE Headline Component
///
/// Headline component with optional overline and subtitle.
/// Different font styles are available based on size.
///
/// **Web Component:** `<elvt-headline>`
/// **API Reference:** `.claude/components/Structure/headline.md`
@available(iOS 15, *)
public struct ElevateHeadline<EndContent: View>: View {

    // MARK: - Properties

    /// The main title text
    private let title: String

    /// Optional overline text shown above the title
    private let overline: String?

    /// Optional subtitle text shown below the title
    private let subtitle: String?

    /// The size of the headline
    private let size: HeadlineSize

    /// The semantic heading level (1-6)
    private let level: Int

    /// Optional end content (actions, icons, etc.)
    private let endContent: (() -> EndContent)?

    // MARK: - Initializer

    /// Creates a headline
    ///
    /// - Parameters:
    ///   - title: The main title text
    ///   - overline: Optional overline text (default: nil)
    ///   - subtitle: Optional subtitle text (default: nil)
    ///   - size: The size/style of the headline (default: .medium)
    ///   - level: The semantic heading level 1-6 (default: 2)
    ///   - endContent: Optional content at the end of the headline (default: nil)
    public init(
        _ title: String,
        overline: String? = nil,
        subtitle: String? = nil,
        size: HeadlineSize = .medium,
        level: Int = 2,
        endContent: (() -> EndContent)? = nil
    ) {
        self.title = title
        self.overline = overline
        self.subtitle = subtitle
        self.size = size
        self.level = min(6, max(1, level)) // Clamp between 1 and 6
        self.endContent = endContent
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: tokenPadding / 2) {
            // Overline
            if let overline = overline {
                Text(overline)
                    .font(overlineFont)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
            }

            // Title row with optional end content
            HStack(alignment: .center) {
                Text(title)
                    .font(titleFont)
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isHeader)

                if let endContent = endContent {
                    Spacer()
                    endContent()
                }
            }

            // Subtitle
            if let subtitle = subtitle {
                Text(subtitle)
                    .font(subtitleFont)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, tokenPadding)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityText)
        .accessibilityAddTraits(.isHeader)
    }

    // MARK: - Token Accessors

    private var tokenPadding: CGFloat {
        switch size {
        case .extraExtraSmall: return HeadingComponentTokens.padding_2xs
        case .extraSmall: return HeadingComponentTokens.padding_xs
        case .small: return HeadingComponentTokens.padding_s
        case .medium: return HeadingComponentTokens.padding_m
        case .large: return HeadingComponentTokens.padding_l
        case .extraLarge: return HeadingComponentTokens.padding_xl
        }
    }

    private var titleFont: Font {
        switch size {
        case .extraExtraSmall: return ElevateTypography.labelLarge
        case .extraSmall: return ElevateTypography.headingXSmall
        case .small: return ElevateTypography.headingSmall
        case .medium: return ElevateTypography.headingMedium
        case .large: return ElevateTypography.headingLarge
        case .extraLarge: return ElevateTypography.displaySmall
        }
    }

    private var overlineFont: Font {
        switch size {
        case .extraExtraSmall, .extraSmall: return ElevateTypography.labelSmall
        case .small, .medium: return ElevateTypography.labelMedium
        case .large, .extraLarge: return ElevateTypography.labelLarge
        }
    }

    private var subtitleFont: Font {
        switch size {
        case .extraExtraSmall: return ElevateTypography.bodySmall
        case .extraSmall: return ElevateTypography.bodySmall
        case .small: return ElevateTypography.bodyMedium
        case .medium: return ElevateTypography.bodyMedium
        case .large: return ElevateTypography.bodyLarge
        case .extraLarge: return ElevateTypography.bodyLarge
        }
    }

    private var accessibilityText: String {
        var text = ""
        if let overline = overline {
            text += overline + ". "
        }
        text += title
        if let subtitle = subtitle {
            text += ". " + subtitle
        }
        return text
    }
}

// MARK: - Convenience Initializer (No End Content)

@available(iOS 15, *)
extension ElevateHeadline where EndContent == EmptyView {
    /// Creates a headline without end content
    ///
    /// - Parameters:
    ///   - title: The main title text
    ///   - overline: Optional overline text (default: nil)
    ///   - subtitle: Optional subtitle text (default: nil)
    ///   - size: The size/style of the headline (default: .medium)
    ///   - level: The semantic heading level 1-6 (default: 2)
    public init(
        _ title: String,
        overline: String? = nil,
        subtitle: String? = nil,
        size: HeadlineSize = .medium,
        level: Int = 2
    ) {
        self.title = title
        self.overline = overline
        self.subtitle = subtitle
        self.size = size
        self.level = min(6, max(1, level))
        self.endContent = nil
    }
}

// MARK: - Headline Size

@available(iOS 15, *)
public enum HeadlineSize {
    case extraExtraSmall  // 2xs
    case extraSmall       // xs
    case small            // s
    case medium           // m
    case large            // l
    case extraLarge       // xl
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateHeadline_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Headlines
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Headlines").font(.headline)

                    ElevateHeadline("Page Title")

                    ElevateHeadline(
                        "Section Heading",
                        subtitle: "With a descriptive subtitle"
                    )

                    ElevateHeadline(
                        "Featured Article",
                        overline: "Blog Post",
                        subtitle: "Published on January 15, 2024"
                    )
                }

                Divider()

                // Size Variations
                VStack(alignment: .leading, spacing: 16) {
                    Text("Size Variations").font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        ElevateHeadline(
                            "Extra Extra Small",
                            size: .extraExtraSmall
                        )

                        ElevateHeadline(
                            "Extra Small",
                            size: .extraSmall
                        )

                        ElevateHeadline(
                            "Small",
                            size: .small
                        )

                        ElevateHeadline(
                            "Medium",
                            size: .medium
                        )

                        ElevateHeadline(
                            "Large",
                            size: .large
                        )

                        ElevateHeadline(
                            "Extra Large",
                            size: .extraLarge
                        )
                    }
                }

                Divider()

                // With Overline
                VStack(alignment: .leading, spacing: 16) {
                    Text("With Overline").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateHeadline(
                            "Getting Started",
                            overline: "Documentation",
                            size: .large
                        )

                        ElevateHeadline(
                            "Q4 Performance Review",
                            overline: "Financial Report",
                            size: .medium
                        )

                        ElevateHeadline(
                            "New Feature Launch",
                            overline: "Product Update",
                            subtitle: "Available starting next week",
                            size: .medium
                        )
                    }
                }

                Divider()

                // With End Content
                VStack(alignment: .leading, spacing: 16) {
                    Text("With End Content").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateHeadline(
                            "Settings",
                            size: .large
                        ) {
                            Button(action: {}) {
                                Image(systemName: "ellipsis.circle")
                            }
                        }

                        ElevateHeadline(
                            "Notifications",
                            subtitle: "3 new messages",
                            size: .medium
                        ) {
                            ElevateBadge("3", tone: .danger, rank: .minor, shape: .pill)
                        }

                        ElevateHeadline(
                            "Projects",
                            overline: "Dashboard",
                            subtitle: "12 active projects",
                            size: .medium
                        ) {
                            Button("View All") {}
                        }
                    }
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Use Cases").font(.headline)

                    VStack(alignment: .leading, spacing: 16) {
                        // Article header
                        ElevateHeadline(
                            "Understanding SwiftUI",
                            overline: "Tutorial",
                            subtitle: "A comprehensive guide to building modern iOS apps",
                            size: .large
                        )

                        // Card header
                        ElevateHeadline(
                            "Weekly Summary",
                            subtitle: "Your activity this week",
                            size: .medium
                        ) {
                            Button(action: {}) {
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }

                        // Section header
                        ElevateHeadline(
                            "Recent Activity",
                            size: .small
                        )

                        // Feature highlight
                        ElevateHeadline(
                            "Introducing Dark Mode",
                            overline: "New Feature",
                            subtitle: "Experience a whole new look with our latest update",
                            size: .extraLarge
                        )
                    }
                }

                Divider()

                // Semantic Levels
                VStack(alignment: .leading, spacing: 16) {
                    Text("Semantic Levels").font(.headline)

                    Text("Visual size is independent from semantic level (h1-h6)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    VStack(alignment: .leading, spacing: 8) {
                        ElevateHeadline("H1 - Main Page Title", size: .extraLarge, level: 1)
                        ElevateHeadline("H2 - Section Heading", size: .large, level: 2)
                        ElevateHeadline("H3 - Subsection", size: .medium, level: 3)
                        ElevateHeadline("H4 - Detail Header", size: .small, level: 4)
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
