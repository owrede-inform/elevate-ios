#if os(iOS)
import SwiftUI

/// ELEVATE Progress Component
///
/// Shows the progress of an ongoing operation with bar or circular styles.
/// Supports both determinate (with value) and indeterminate (loading) states.
///
/// **Web Component:** `<elvt-progress>`
/// **API Reference:** `.claude/components/Feedback/progress.md`
@available(iOS 15, *)
public struct ElevateProgress: View {

    // MARK: - Properties

    /// The progress value (0.0 to 1.0)
    private let value: Double

    /// Whether to show indeterminate loading state
    private let isIndeterminate: Bool

    /// The style of progress indicator
    private let style: ProgressStyle

    /// The size of the progress indicator
    private let size: ProgressSize

    /// Optional label for the progress
    private let label: String?

    // MARK: - State

    @State private var indeterminateRotation: Double = 0

    // MARK: - Initializer

    /// Creates a progress indicator
    ///
    /// - Parameters:
    ///   - value: Progress value from 0.0 to 1.0 (default: 0.0)
    ///   - isIndeterminate: Show loading animation instead of value (default: false)
    ///   - style: Bar or circular style (default: .linear)
    ///   - size: Small, medium, or large (default: .medium)
    ///   - label: Optional label text
    public init(
        value: Double = 0.0,
        isIndeterminate: Bool = false,
        style: ProgressStyle = .linear,
        size: ProgressSize = .medium,
        label: String? = nil
    ) {
        self.value = min(max(value, 0.0), 1.0) // Clamp between 0 and 1
        self.isIndeterminate = isIndeterminate
        self.style = style
        self.size = size
        self.label = label
    }

    // MARK: - Body

    public var body: some View {
        Group {
            switch style {
            case .linear:
                linearProgress
            case .circular:
                circularProgress
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label ?? "Progress")
        .accessibilityValue("\(Int(value * 100)) percent")
        .onAppear {
            if isIndeterminate {
                withAnimation(.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                    indeterminateRotation = 360
                }
            }
        }
    }

    // MARK: - Linear Progress

    private var linearProgress: some View {
        VStack(alignment: .leading, spacing: 4) {
            // Label (optional)
            if let label = label {
                Text(label)
                    .font(ElevateTypography.bodySmall)
                    .foregroundColor(ProgressComponentTokens.bar_text_on_track)
            }

            // Progress bar
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Track (background)
                    RoundedRectangle(cornerRadius: tokenBarHeight / 2)
                        .fill(ProgressComponentTokens.fill_empty)
                        .frame(height: tokenBarHeight)

                    // Progress fill
                    RoundedRectangle(cornerRadius: tokenBarHeight / 2)
                        .fill(ProgressComponentTokens.fill_filled)
                        .frame(
                            width: isIndeterminate ? geometry.size.width * 0.3 : geometry.size.width * value,
                            height: tokenBarHeight
                        )
                        .offset(x: isIndeterminate ? indeterminateOffset(width: geometry.size.width) : 0)
                }
            }
            .frame(height: tokenBarHeight)
            .frame(minWidth: tokenBarMinWidth)
        }
    }

    private func indeterminateOffset(width: CGFloat) -> CGFloat {
        let maxOffset = width * 0.7
        let normalizedRotation = (indeterminateRotation.truncatingRemainder(dividingBy: 360)) / 360
        return sin(normalizedRotation * 2 * .pi) * maxOffset
    }

    // MARK: - Circular Progress

    private var circularProgress: some View {
        ZStack {
            // Track circle
            Circle()
                .stroke(ProgressComponentTokens.fill_empty, lineWidth: tokenRingWidth)
                .frame(width: tokenRingDiameter, height: tokenRingDiameter)

            // Progress arc
            if isIndeterminate {
                Circle()
                    .trim(from: 0, to: 0.7)
                    .stroke(
                        ProgressComponentTokens.fill_filled,
                        style: StrokeStyle(lineWidth: tokenRingWidth, lineCap: .round)
                    )
                    .frame(width: tokenRingDiameter, height: tokenRingDiameter)
                    .rotationEffect(.degrees(indeterminateRotation))
            } else {
                Circle()
                    .trim(from: 0, to: value)
                    .stroke(
                        ProgressComponentTokens.fill_filled,
                        style: StrokeStyle(lineWidth: tokenRingWidth, lineCap: .round)
                    )
                    .frame(width: tokenRingDiameter, height: tokenRingDiameter)
                    .rotationEffect(.degrees(-90)) // Start from top
            }

            // Label in center (if not indeterminate)
            if !isIndeterminate, let label = label {
                Text(label)
                    .font(tokenLabelFont)
                    .foregroundColor(ProgressComponentTokens.icon_color)
            } else if !isIndeterminate {
                Text("\(Int(value * 100))%")
                    .font(tokenLabelFont)
                    .foregroundColor(ProgressComponentTokens.icon_color)
            }
        }
    }

    // MARK: - Token Accessors

    private var tokenBarHeight: CGFloat {
        switch size {
        case .small: return ProgressComponentTokens.bar_height_s
        case .medium: return ProgressComponentTokens.bar_height_m
        case .large: return ProgressComponentTokens.bar_height_l
        }
    }

    private var tokenBarMinWidth: CGFloat {
        switch size {
        case .small: return ProgressComponentTokens.bar_minWidth_s
        case .medium: return ProgressComponentTokens.bar_minWidth_m
        case .large: return ProgressComponentTokens.bar_minWidth_l
        }
    }

    private var tokenRingDiameter: CGFloat {
        switch size {
        case .small: return ProgressComponentTokens.ring_diameter_s
        case .medium: return ProgressComponentTokens.ring_diameter_m
        case .large: return ProgressComponentTokens.ring_diameter_l
        }
    }

    private var tokenRingWidth: CGFloat {
        switch size {
        case .small: return ProgressComponentTokens.ring_width_s
        case .medium: return ProgressComponentTokens.ring_width_m
        case .large: return ProgressComponentTokens.ring_width_l
        }
    }

    private var tokenLabelFont: Font {
        switch size {
        case .small: return ElevateTypography.bodySmall
        case .medium: return ElevateTypography.bodyMedium
        case .large: return ElevateTypography.bodyLarge
        }
    }
}

// MARK: - Progress Style

@available(iOS 15, *)
public enum ProgressStyle {
    case linear  // Horizontal bar
    case circular  // Ring/circle
}

// MARK: - Progress Size

@available(iOS 15, *)
public enum ProgressSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateProgress_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Linear Progress
                VStack(alignment: .leading, spacing: 16) {
                    Text("Linear Progress").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateProgress(value: 0.0, label: "0%")
                        ElevateProgress(value: 0.25, label: "25%")
                        ElevateProgress(value: 0.5, label: "50%")
                        ElevateProgress(value: 0.75, label: "75%")
                        ElevateProgress(value: 1.0, label: "100%")
                    }
                }

                Divider()

                // Indeterminate Progress
                VStack(alignment: .leading, spacing: 16) {
                    Text("Indeterminate (Loading)").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateProgress(isIndeterminate: true, label: "Loading...")
                        ElevateProgress(isIndeterminate: true, style: .circular)
                    }
                }

                Divider()

                // Circular Progress
                VStack(alignment: .leading, spacing: 16) {
                    Text("Circular Progress").font(.headline)

                    HStack(spacing: 24) {
                        ElevateProgress(value: 0.25, style: .circular, label: "25%")
                        ElevateProgress(value: 0.5, style: .circular)
                        ElevateProgress(value: 0.75, style: .circular, label: "75%")
                        ElevateProgress(value: 1.0, style: .circular)
                    }
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Progress Sizes").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateProgress(value: 0.6, size: .small, label: "Small")
                        ElevateProgress(value: 0.6, size: .medium, label: "Medium")
                        ElevateProgress(value: 0.6, size: .large, label: "Large")
                    }

                    HStack(spacing: 24) {
                        ElevateProgress(value: 0.6, style: .circular, size: .small)
                        ElevateProgress(value: 0.6, style: .circular, size: .medium)
                        ElevateProgress(value: 0.6, style: .circular, size: .large)
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
