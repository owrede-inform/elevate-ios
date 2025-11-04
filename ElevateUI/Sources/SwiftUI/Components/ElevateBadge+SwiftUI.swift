#if os(iOS)
import SwiftUI

/// ELEVATE Badge Component
///
/// Badges are used for status indicators, counts, and labels.
/// They come in two ranks: major (prominent) and minor (subtle).
///
/// **Web Component:** `<elvt-badge>`
/// **API Reference:** `.claude/components/Display/badge.md`
@available(iOS 15, *)
public struct ElevateBadge<Prefix: View, Suffix: View>: View {

    // MARK: - Properties

    /// The visual style of the badge
    public var tone: BadgeTokens.Tone

    /// The prominence level (major or minor)
    public var rank: BadgeTokens.Rank

    /// The shape of the badge
    public var shape: BadgeTokens.Shape

    /// Whether the badge should pulse to draw attention
    public var isPulsing: Bool

    // MARK: - Content

    private let label: String
    private let prefix: () -> Prefix
    private let suffix: () -> Suffix

    // MARK: - Environment

    @Environment(\.colorScheme) var colorScheme

    // MARK: - Initializers

    /// Create badge with all options
    public init(
        label: String,
        tone: BadgeTokens.Tone = .neutral,
        rank: BadgeTokens.Rank = .major,
        shape: BadgeTokens.Shape = .box,
        isPulsing: Bool = false,
        @ViewBuilder prefix: @escaping () -> Prefix = { EmptyView() },
        @ViewBuilder suffix: @escaping () -> Suffix = { EmptyView() }
    ) {
        self.label = label
        self.tone = tone
        self.rank = rank
        self.shape = shape
        self.isPulsing = isPulsing
        self.prefix = prefix
        self.suffix = suffix
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: tokenGap) {
            prefix()

            Text(label)
                .font(tokenFont)
                .lineLimit(1)

            suffix()
        }
        .foregroundColor(tokenTextColor)
        .padding(.horizontal, tokenHorizontalPadding)
        .padding(.vertical, tokenVerticalPadding)
        .frame(height: tokenHeight)
        .background(tokenFillColor)
        .overlay(
            RoundedRectangle(cornerRadius: tokenCornerRadius)
                .stroke(tokenBorderColor, lineWidth: tokenBorderWidth)
        )
        .cornerRadius(tokenCornerRadius)
        .modifier(PulseAnimation(isEnabled: isPulsing))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
    }

    // MARK: - Token Accessors

    private var tokenFillColor: Color {
        BadgeTokens.fillColor(for: tone, rank: rank).color(for: colorScheme)
    }

    private var tokenTextColor: Color {
        BadgeTokens.textColor(for: tone, rank: rank).color(for: colorScheme)
    }

    private var tokenBorderColor: Color {
        BadgeTokens.borderColor(for: tone, rank: rank).color(for: colorScheme)
    }

    private var tokenBorderWidth: CGFloat {
        rank == .minor ? 1.0 : 0.0
    }

    private var tokenHeight: CGFloat {
        rank.config.height
    }

    private var tokenHorizontalPadding: CGFloat {
        rank.config.horizontalPadding
    }

    private var tokenVerticalPadding: CGFloat {
        rank.config.verticalPadding
    }

    private var tokenFont: Font {
        .system(size: rank.config.fontSize, weight: rank.config.fontWeight)
    }

    private var tokenGap: CGFloat {
        rank.config.gap
    }

    private var tokenCornerRadius: CGFloat {
        shape.cornerRadius(for: rank)
    }
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension ElevateBadge where Prefix == EmptyView, Suffix == EmptyView {
    /// Create badge with label only
    public init(
        _ label: String,
        tone: BadgeTokens.Tone = .neutral,
        rank: BadgeTokens.Rank = .major,
        shape: BadgeTokens.Shape = .box,
        isPulsing: Bool = false
    ) {
        self.init(
            label: label,
            tone: tone,
            rank: rank,
            shape: shape,
            isPulsing: isPulsing
        )
    }
}

@available(iOS 15, *)
extension ElevateBadge where Suffix == EmptyView {
    /// Create badge with prefix icon
    public init(
        _ label: String,
        tone: BadgeTokens.Tone = .neutral,
        rank: BadgeTokens.Rank = .major,
        shape: BadgeTokens.Shape = .box,
        isPulsing: Bool = false,
        @ViewBuilder prefix: @escaping () -> Prefix
    ) {
        self.init(
            label: label,
            tone: tone,
            rank: rank,
            shape: shape,
            isPulsing: isPulsing,
            prefix: prefix
        )
    }
}

@available(iOS 15, *)
extension ElevateBadge where Prefix == EmptyView {
    /// Create badge with suffix icon
    public init(
        _ label: String,
        tone: BadgeTokens.Tone = .neutral,
        rank: BadgeTokens.Rank = .major,
        shape: BadgeTokens.Shape = .box,
        isPulsing: Bool = false,
        @ViewBuilder suffix: @escaping () -> Suffix
    ) {
        self.init(
            label: label,
            tone: tone,
            rank: rank,
            shape: shape,
            isPulsing: isPulsing,
            suffix: suffix
        )
    }
}

// MARK: - Pulse Animation

@available(iOS 15, *)
private struct PulseAnimation: ViewModifier {
    let isEnabled: Bool
    @State private var isAnimating = false

    func body(content: Content) -> some View {
        content
            .scaleEffect(isEnabled && isAnimating ? 1.05 : 1.0)
            .opacity(isEnabled && isAnimating ? 0.85 : 1.0)
            .animation(
                isEnabled ? .easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default,
                value: isAnimating
            )
            .onAppear {
                if isEnabled {
                    isAnimating = true
                }
            }
            .onChange(of: isEnabled) { newValue in
                isAnimating = newValue
            }
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateBadge_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Major badges
            HStack(spacing: 12) {
                ElevateBadge("Primary", tone: .primary, rank: .major)
                ElevateBadge("Success", tone: .success, rank: .major)
                ElevateBadge("Warning", tone: .warning, rank: .major)
                ElevateBadge("Danger", tone: .danger, rank: .major)
            }

            // Minor badges
            HStack(spacing: 12) {
                ElevateBadge("Primary", tone: .primary, rank: .minor)
                ElevateBadge("Success", tone: .success, rank: .minor)
                ElevateBadge("Warning", tone: .warning, rank: .minor)
                ElevateBadge("Danger", tone: .danger, rank: .minor)
            }

            // Pill shape
            HStack(spacing: 12) {
                ElevateBadge("Pill Major", tone: .primary, rank: .major, shape: .pill)
                ElevateBadge("Pill Minor", tone: .primary, rank: .minor, shape: .pill)
            }

            // With icon
            ElevateBadge("With Icon", tone: .success, rank: .major, prefix: {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 16, height: 16)
            })

            // Pulsing
            ElevateBadge("Pulsing", tone: .danger, rank: .major, isPulsing: true)
        }
        .padding()
    }
}
#endif

#endif
