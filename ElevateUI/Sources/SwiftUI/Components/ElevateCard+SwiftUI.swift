#if os(iOS)
import SwiftUI

/// ELEVATE Card Component
///
/// A container component for grouping related content with optional header and footer.
/// Supports different elevations, tones, and border styles.
///
/// **Web Component:** `<elvt-card>`
/// **API Reference:** `.claude/components/Structure/card.md`
@available(iOS 15, *)
public struct ElevateCard<Content: View, Header: View, Footer: View>: View {

    // MARK: - Properties

    /// The main content of the card
    private let content: () -> Content

    /// Optional header content
    private let header: () -> Header

    /// Optional footer content
    private let footer: () -> Footer

    /// The visual elevation of the card
    private let elevation: CardElevation

    /// The tone/color of the card border
    private let tone: CardTone

    // MARK: - Initializer

    /// Creates a card with content, optional header and footer
    public init(
        elevation: CardElevation = .raised,
        tone: CardTone = .neutral,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> Header = { EmptyView() },
        @ViewBuilder footer: @escaping () -> Footer = { EmptyView() }
    ) {
        self.elevation = elevation
        self.tone = tone
        self.content = content
        self.header = header
        self.footer = footer
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            // Header
            if !(header() is EmptyView) {
                header()
                    .padding(.horizontal, tokenPaddingInline)
                    .padding(.vertical, tokenPaddingBlock)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.clear)
                    .overlay(
                        Rectangle()
                            .fill(tokenHeadingBorderColor)
                            .frame(height: tokenHeadingBorderWidth),
                        alignment: .bottom
                    )
            }

            // Content
            content()
                .padding(.horizontal, tokenPaddingInline)
                .padding(.vertical, tokenPaddingBlock)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Footer
            if !(footer() is EmptyView) {
                footer()
                    .padding(.horizontal, tokenPaddingInline)
                    .padding(.vertical, tokenPaddingBlock)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(tokenFooterFill)
                    .overlay(
                        Rectangle()
                            .fill(tokenFooterBorderColor)
                            .frame(height: tokenFooterBorderWidth),
                        alignment: .top
                    )
            }
        }
        .background(tokenBackgroundColor)
        .cornerRadius(tokenBorderRadius)
        .overlay(
            RoundedRectangle(cornerRadius: tokenBorderRadius)
                .stroke(tokenBorderColor, lineWidth: tokenBorderWidth)
        )
        .modifier(CardShadowModifier(elevation: elevation))
    }

    // MARK: - Token Accessors

    private var tokenBackgroundColor: Color {
        switch elevation {
        case .ground:
            return CardComponentTokens.fill_ground
        case .raised:
            return CardComponentTokens.fill_raised
        case .elevated:
            return CardComponentTokens.fill_elevated
        case .sunken:
            return CardComponentTokens.fill_sunken
        case .overlay:
            return CardComponentTokens.fill_overlay
        case .popover:
            return CardComponentTokens.fill_popover
        }
    }

    private var tokenBorderColor: Color {
        switch tone {
        case .neutral:
            switch elevation {
            case .sunken:
                return CardComponentTokens.border_color_neutral_sunken
            case .elevated:
                return CardComponentTokens.border_color_neutral_elevated
            case .overlay:
                return CardComponentTokens.border_color_neutral_overlay
            default:
                return CardComponentTokens.border_color_neutral_default
            }
        case .primary:
            return CardComponentTokens.border_color_primary
        case .success:
            return CardComponentTokens.border_color_success
        case .warning:
            return CardComponentTokens.border_color_warning
        case .danger:
            return CardComponentTokens.border_color_danger
        case .emphasized:
            return CardComponentTokens.border_color_emphasized
        }
    }

    private var tokenBorderWidth: CGFloat {
        CardComponentTokens.border_width
    }

    private var tokenBorderRadius: CGFloat {
        CardComponentTokens.border_radius
    }

    private var tokenPaddingInline: CGFloat {
        CardComponentTokens.padding_inline
    }

    private var tokenPaddingBlock: CGFloat {
        CardComponentTokens.padding_block
    }

    private var tokenHeadingBorderColor: Color {
        CardComponentTokens.heading_border_color
    }

    private var tokenHeadingBorderWidth: CGFloat {
        CardComponentTokens.heading_border_width
    }

    private var tokenFooterFill: Color {
        switch tone {
        case .neutral:
            return CardComponentTokens.footer_fill_neutral
        case .primary:
            return CardComponentTokens.footer_fill_primary
        case .success:
            return CardComponentTokens.footer_fill_success
        case .warning:
            return CardComponentTokens.footer_fill_warning
        case .danger:
            return CardComponentTokens.footer_fill_danger
        case .emphasized:
            return CardComponentTokens.footer_fill_emphasized
        }
    }

    private var tokenFooterBorderColor: Color {
        CardComponentTokens.footer_border_color
    }

    private var tokenFooterBorderWidth: CGFloat {
        CardComponentTokens.footer_border_width
    }
}

// MARK: - Card Elevation

@available(iOS 15, *)
public enum CardElevation {
    case ground      // Base level
    case raised      // Slightly elevated (default)
    case elevated    // More elevated
    case sunken      // Recessed
    case overlay     // On top of content
    case popover     // Floating above
}

// MARK: - Card Tone

@available(iOS 15, *)
public enum CardTone {
    case neutral
    case primary
    case success
    case warning
    case danger
    case emphasized
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension ElevateCard where Header == EmptyView, Footer == EmptyView {
    /// Creates a card with only content
    public init(
        elevation: CardElevation = .raised,
        tone: CardTone = .neutral,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            elevation: elevation,
            tone: tone,
            content: content,
            header: { EmptyView() },
            footer: { EmptyView() }
        )
    }
}

@available(iOS 15, *)
extension ElevateCard where Footer == EmptyView {
    /// Creates a card with header and content
    public init(
        elevation: CardElevation = .raised,
        tone: CardTone = .neutral,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder header: @escaping () -> Header
    ) {
        self.init(
            elevation: elevation,
            tone: tone,
            content: content,
            header: header,
            footer: { EmptyView() }
        )
    }
}

// MARK: - Card Shadow Modifier

@available(iOS 15, *)
private struct CardShadowModifier: ViewModifier {
    let elevation: CardElevation

    @Environment(\.colorScheme) var colorScheme

    func body(content: Content) -> some View {
        switch elevation {
        case .ground:
            // No shadow - flat on surface
            content

        case .raised:
            // Subtle elevation
            content.applyShadow(
                light: .raised,
                dark: .raisedDark
            )

        case .elevated:
            // Moderate depth
            content.applyShadow(
                light: .elevated,
                dark: .elevatedDark
            )

        case .sunken:
            // Inset appearance (approximation)
            content.applyShadow(
                light: .sunken,
                dark: .sunkenDark
            )

        case .overlay:
            // High elevation for modals
            content.applyShadow(
                light: .overlay,
                dark: .overlayDark
            )

        case .popover:
            // Floating menus/tooltips
            content.applyShadow(
                light: .popover,
                dark: .popoverDark
            )
        }
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateCard_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Basic Card
                ElevateCard {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Simple Card")
                            .font(ElevateTypographyiOS.titleMedium) // 18pt (web: 16pt)
                        Text("This is a basic card with just content.")
                            .font(ElevateTypographyiOS.bodySmall) // 14pt (web: 12pt)
                    }
                }

                // Card with Header
                ElevateCard(
                    content: {
                        Text("Card content goes here.")
                            .font(ElevateTypographyiOS.bodyMedium) // 16pt (web: 14pt)
                    },
                    header: {
                        Text("Card Header")
                            .font(ElevateTypographyiOS.titleMedium) // 18pt (web: 16pt)
                    }
                )

                // Card with Header and Footer
                ElevateCard(
                    tone: .primary,
                    content: {
                        Text("Main card content.")
                            .font(ElevateTypographyiOS.bodyMedium) // 16pt (web: 14pt)
                    },
                    header: {
                        Text("Header Section")
                            .font(ElevateTypographyiOS.titleMedium) // 18pt (web: 16pt)
                    },
                    footer: {
                        HStack {
                            Spacer()
                            Text("Footer Actions")
                                .font(ElevateTypographyiOS.labelSmall) // 14pt (web: 12pt)
                        }
                    }
                )

                // Different Elevations
                ForEach([CardElevation.ground, .raised, .elevated, .sunken], id: \.self) { elevation in
                    ElevateCard(elevation: elevation) {
                        Text("Elevation: \(String(describing: elevation))")
                            .font(ElevateTypographyiOS.bodyMedium) // 16pt (web: 14pt)
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
