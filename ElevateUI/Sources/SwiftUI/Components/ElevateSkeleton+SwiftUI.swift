#if os(iOS)
import SwiftUI

/// ELEVATE Skeleton Component
///
/// Visual placeholder for content that is loading.
/// Provides animated placeholders to indicate loading state.
///
/// **Web Component:** `<elvt-skeleton>`
/// **API Reference:** `.claude/components/Display/skeleton.md`
@available(iOS 15, *)
public struct ElevateSkeleton: View {

    // MARK: - Properties

    /// The shape of the skeleton
    private let shape: SkeletonShape

    /// Animation effect
    private let effect: SkeletonEffect

    /// Number of lines (for lines shape) or height multiplier (for block)
    private let lineCount: Int

    /// Width of the last line as percentage (0-100)
    private let lineWidth: CGFloat

    /// Typography scale for sizing
    private let font: SkeletonFont

    // MARK: - State

    @State private var isAnimating = false

    // MARK: - Initializer

    /// Creates a skeleton placeholder
    ///
    /// - Parameters:
    ///   - shape: Shape of the skeleton (default: .lines)
    ///   - effect: Animation effect (default: .pulse)
    ///   - lineCount: Number of lines or height multiplier (default: 1)
    ///   - lineWidth: Width of last line as percentage 0-100 (default: 100)
    ///   - font: Typography scale for sizing (default: .content)
    public init(
        shape: SkeletonShape = .lines,
        effect: SkeletonEffect = .pulse,
        lineCount: Int = 1,
        lineWidth: CGFloat = 100,
        font: SkeletonFont = .content
    ) {
        self.shape = shape
        self.effect = effect
        self.lineCount = max(1, lineCount)
        self.lineWidth = max(0, min(100, lineWidth))
        self.font = font
    }

    // MARK: - Body

    public var body: some View {
        Group {
            switch shape {
            case .lines:
                linesShape
            case .block:
                blockShape
            case .circle:
                circleShape
            case .square:
                squareShape
            }
        }
        .onAppear {
            startAnimation()
        }
    }

    // MARK: - Shapes

    private var linesShape: some View {
        VStack(alignment: .leading, spacing: tokenLineGap) {
            ForEach(0..<lineCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: SkeletonComponentTokens.radius)
                    .fill(SkeletonComponentTokens.fill)
                    .frame(height: tokenLineHeight)
                    .frame(maxWidth: index == lineCount - 1 ? .infinity : nil)
                    .frame(width: index == lineCount - 1 ? nil : .infinity)
                    .modifier(widthModifier(for: index))
                    .modifier(effectModifier)
            }
        }
    }

    private var blockShape: some View {
        RoundedRectangle(cornerRadius: SkeletonComponentTokens.radius)
            .fill(SkeletonComponentTokens.fill)
            .frame(height: tokenBlockHeight)
            .modifier(effectModifier)
    }

    private var circleShape: some View {
        Circle()
            .fill(SkeletonComponentTokens.fill)
            .frame(width: tokenCircleSize, height: tokenCircleSize)
            .modifier(effectModifier)
    }

    private var squareShape: some View {
        RoundedRectangle(cornerRadius: SkeletonComponentTokens.radius)
            .fill(SkeletonComponentTokens.fill)
            .frame(width: tokenSquareSize, height: tokenSquareSize)
            .modifier(effectModifier)
    }

    // MARK: - Modifiers

    private func widthModifier(for index: Int) -> some View {
        GeometryReader { geometry in
            Color.clear.preference(
                key: WidthPreferenceKey.self,
                value: index == lineCount - 1 ? geometry.size.width * (lineWidth / 100) : geometry.size.width
            )
        }
    }

    private var effectModifier: some View {
        Group {
            switch effect {
            case .none:
                EmptyView()
            case .pulse:
                Color.clear
                    .opacity(isAnimating ? 0.3 : 1.0)
            case .sheen:
                Color.clear
                    .overlay(
                        LinearGradient(
                            colors: [
                                Color.white.opacity(0),
                                Color.white.opacity(0.3),
                                Color.white.opacity(0)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .offset(x: isAnimating ? 200 : -200)
                        .mask(
                            Rectangle()
                                .fill(Color.white)
                        )
                    )
            }
        }
    }

    // MARK: - Helpers

    private func startAnimation() {
        switch effect {
        case .pulse:
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        case .sheen:
            withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                isAnimating = true
            }
        case .none:
            break
        }
    }

    // MARK: - Token Accessors

    private var tokenLineHeight: CGFloat {
        switch font {
        case .annotation: return 12.0
        case .label: return 16.0
        case .content: return 20.0
        case .headline: return 24.0
        }
    }

    private var tokenLineGap: CGFloat {
        switch font {
        case .annotation: return 4.0
        case .label: return 6.0
        case .content: return 8.0
        case .headline: return 10.0
        }
    }

    private var tokenBlockHeight: CGFloat {
        (tokenLineHeight + tokenLineGap) * CGFloat(lineCount) - tokenLineGap
    }

    private var tokenCircleSize: CGFloat {
        (tokenLineHeight + tokenLineGap) * CGFloat(lineCount) - tokenLineGap
    }

    private var tokenSquareSize: CGFloat {
        (tokenLineHeight + tokenLineGap) * CGFloat(lineCount) - tokenLineGap
    }
}

// MARK: - Skeleton Shape

@available(iOS 15, *)
public enum SkeletonShape {
    case lines    // Multiple text lines
    case block    // Solid rectangular block
    case circle   // Circular shape
    case square   // Square shape
}

// MARK: - Skeleton Effect

@available(iOS 15, *)
public enum SkeletonEffect {
    case none     // No animation
    case pulse    // Pulsing opacity
    case sheen    // Shimmer effect
}

// MARK: - Skeleton Font

@available(iOS 15, *)
public enum SkeletonFont {
    case annotation  // Smallest
    case label       // Label size
    case content     // Body/content size
    case headline    // Headline size
}

// MARK: - Width Preference Key

private struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateSkeleton_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Lines
                VStack(alignment: .leading, spacing: 16) {
                    Text("Lines (Text Placeholder)").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateSkeleton(shape: .lines, lineCount: 1)
                        ElevateSkeleton(shape: .lines, lineCount: 3)
                        ElevateSkeleton(shape: .lines, lineCount: 3, lineWidth: 60)
                    }
                }

                Divider()

                // Shapes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Shapes").font(.headline)

                    HStack(spacing: 16) {
                        ElevateSkeleton(shape: .block, lineCount: 3)
                            .frame(width: 150)
                        ElevateSkeleton(shape: .circle, lineCount: 3)
                        ElevateSkeleton(shape: .square, lineCount: 3)
                    }
                }

                Divider()

                // Effects
                VStack(alignment: .leading, spacing: 16) {
                    Text("Animation Effects").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("None").font(.caption).foregroundColor(.secondary)
                        ElevateSkeleton(effect: .none, lineCount: 2)

                        Text("Pulse").font(.caption).foregroundColor(.secondary)
                        ElevateSkeleton(effect: .pulse, lineCount: 2)

                        Text("Sheen").font(.caption).foregroundColor(.secondary)
                        ElevateSkeleton(effect: .sheen, lineCount: 2)
                    }
                }

                Divider()

                // Font Scales
                VStack(alignment: .leading, spacing: 16) {
                    Text("Font Scales").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Annotation").font(.caption).foregroundColor(.secondary)
                        ElevateSkeleton(lineCount: 2, font: .annotation)

                        Text("Label").font(.caption).foregroundColor(.secondary)
                        ElevateSkeleton(lineCount: 2, font: .label)

                        Text("Content").font(.caption).foregroundColor(.secondary)
                        ElevateSkeleton(lineCount: 2, font: .content)

                        Text("Headline").font(.caption).foregroundColor(.secondary)
                        ElevateSkeleton(lineCount: 2, font: .headline)
                    }
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Patterns").font(.headline)

                    // Article card skeleton
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Article Card").font(.caption).foregroundColor(.secondary)
                        HStack(alignment: .top, spacing: 12) {
                            ElevateSkeleton(shape: .square, lineCount: 4)
                            VStack(alignment: .leading, spacing: 8) {
                                ElevateSkeleton(shape: .lines, lineCount: 1, font: .headline)
                                ElevateSkeleton(shape: .lines, lineCount: 2, lineWidth: 80, font: .content)
                            }
                        }
                    }

                    // User profile skeleton
                    VStack(alignment: .leading, spacing: 12) {
                        Text("User Profile").font(.caption).foregroundColor(.secondary)
                        HStack(spacing: 12) {
                            ElevateSkeleton(shape: .circle, lineCount: 2)
                            VStack(alignment: .leading, spacing: 4) {
                                ElevateSkeleton(shape: .lines, lineCount: 1, font: .label)
                                    .frame(width: 120)
                                ElevateSkeleton(shape: .lines, lineCount: 1, font: .annotation)
                                    .frame(width: 80)
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
