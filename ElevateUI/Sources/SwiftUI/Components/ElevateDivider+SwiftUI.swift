#if os(iOS)
import SwiftUI

/// ELEVATE Divider Component
///
/// A visual separator that can be horizontal or vertical, with optional label.
/// Supports various tones and size-based spacing.
///
/// **Web Component:** `<elvt-divider>`
/// **API Reference:** `.claude/components/Structure/divider.md`
@available(iOS 15, *)
public struct ElevateDivider: View {

    // MARK: - Properties

    /// Optional label for the divider
    private let label: String?

    /// The axis of the divider (horizontal or vertical)
    private let axis: Axis

    /// The tone (color scheme) of the divider
    private let tone: DividerTone

    /// The size (affects spacing before/after)
    private let size: DividerSize?

    // MARK: - Initializer

    /// Creates a divider
    ///
    /// - Parameters:
    ///   - label: Optional text to display in the middle of the divider
    ///   - axis: Horizontal (default) or vertical orientation
    ///   - tone: Color scheme (default: neutral)
    ///   - size: Spacing size (default: nil for no extra spacing)
    public init(
        _ label: String? = nil,
        axis: Axis = .horizontal,
        tone: DividerTone = .neutral,
        size: DividerSize? = nil
    ) {
        self.label = label
        self.axis = axis
        self.tone = tone
        self.size = size
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if let label = label {
                // Labeled divider
                labeledDivider(label: label)
            } else {
                // Simple divider line
                simpleDivider
            }
        }
        .padding(axis == .horizontal ? .vertical : .horizontal, tokenSpacing)
    }

    // MARK: - Components

    private var simpleDivider: some View {
        Rectangle()
            .fill(tokenStrokeColor)
            .frame(
                width: axis == .horizontal ? nil : tokenStrokeWidth,
                height: axis == .horizontal ? tokenStrokeWidth : nil
            )
    }

    private func labeledDivider(label: String) -> some View {
        HStack(spacing: tokenGap) {
            if axis == .horizontal {
                // Horizontal divider with label
                line
                Text(label)
                    .font(ElevateTypographyiOS.bodySmall) // 14pt (web: 12pt)
                    .foregroundColor(tokenTextColor)
                    .lineLimit(1)
                line
            } else {
                // For vertical dividers, just show the line
                // (labels don't make sense in vertical orientation)
                simpleDivider
            }
        }
    }

    private var line: some View {
        Rectangle()
            .fill(tokenStrokeColor)
            .frame(height: tokenStrokeWidth)
    }

    // MARK: - Token Accessors

    private var tokenStrokeColor: Color {
        switch tone {
        case .neutral: return DividerComponentTokens.stroke_color_neutral
        case .primary: return DividerComponentTokens.stroke_color_primary
        case .danger: return DividerComponentTokens.stroke_color_danger
        case .emphasized: return DividerComponentTokens.stroke_color_emphasized
        case .subtle: return DividerComponentTokens.stroke_color_subtle
        }
    }

    private var tokenTextColor: Color {
        switch tone {
        case .neutral: return DividerComponentTokens.text_color_neutral
        case .primary: return DividerComponentTokens.text_color_primary
        case .danger: return DividerComponentTokens.text_color_danger
        case .emphasized: return DividerComponentTokens.text_color_emphasized
        case .subtle: return DividerComponentTokens.text_color_subtle
        }
    }

    private var tokenStrokeWidth: CGFloat {
        DividerComponentTokens.stroke_width
    }

    private var tokenGap: CGFloat {
        guard let size = size else { return DividerComponentTokens.gap_m }
        switch size {
        case .small: return DividerComponentTokens.gap_s
        case .medium: return DividerComponentTokens.gap_m
        case .large: return DividerComponentTokens.gap_l
        }
    }

    private var tokenSpacing: CGFloat {
        guard let size = size else { return 0 }
        switch size {
        case .small: return DividerComponentTokens.spacing_s
        case .medium: return DividerComponentTokens.spacing_m
        case .large: return DividerComponentTokens.spacing_l
        }
    }
}

// MARK: - Divider Tone

@available(iOS 15, *)
public enum DividerTone {
    case neutral
    case primary
    case danger
    case emphasized
    case subtle
}

// MARK: - Divider Size

@available(iOS 15, *)
public enum DividerSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateDivider_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 32) {
                // Basic Dividers
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Dividers").font(.headline)

                    VStack(spacing: 8) {
                        Text("Item 1")
                        ElevateDivider()
                        Text("Item 2")
                        ElevateDivider()
                        Text("Item 3")
                    }
                }

                Divider()

                // Labeled Dividers
                VStack(alignment: .leading, spacing: 16) {
                    Text("Labeled Dividers").font(.headline)

                    VStack(spacing: 8) {
                        Text("Section Above")
                        ElevateDivider("OR")
                        Text("Section Below")
                    }
                }

                Divider()

                // Tones
                VStack(alignment: .leading, spacing: 16) {
                    Text("Divider Tones").font(.headline)

                    VStack(spacing: 12) {
                        ElevateDivider("Neutral", tone: .neutral)
                        ElevateDivider("Primary", tone: .primary)
                        ElevateDivider("Danger", tone: .danger)
                        ElevateDivider("Emphasized", tone: .emphasized)
                        ElevateDivider("Subtle", tone: .subtle)
                    }
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Divider Sizes").font(.headline)

                    VStack(spacing: 0) {
                        Text("Small spacing")
                        ElevateDivider(size: .small)
                        Text("Medium spacing")
                        ElevateDivider(size: .medium)
                        Text("Large spacing")
                        ElevateDivider(size: .large)
                        Text("No spacing")
                    }
                }

                Divider()

                // Vertical Divider
                VStack(alignment: .leading, spacing: 16) {
                    Text("Vertical Divider").font(.headline)

                    HStack(spacing: 0) {
                        Text("Left")
                        ElevateDivider(axis: .vertical, size: .medium)
                        Text("Right")
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
