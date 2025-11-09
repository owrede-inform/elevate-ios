#if os(iOS)
import SwiftUI

/// ELEVATE Slider Component
///
/// A slider allows users to select a value from a range of values.
/// Currently supports single value mode.
///
/// **Web Component:** `<elvt-slider>`
/// **API Reference:** `.claude/components/Forms/slider.md`
@available(iOS 15, *)
public struct ElevateSlider: View {

    // MARK: - Properties

    /// The current slider value
    @Binding private var value: Double

    /// Minimum value
    private let min: Double

    /// Maximum value
    private let max: Double

    /// Step increment
    private let step: Double

    /// Whether the slider is disabled
    private let isDisabled: Bool

    /// The tone (color scheme) of the slider
    private let tone: SliderTone

    /// The size of the slider
    private let size: SliderSize

    /// Optional label for accessibility
    private let label: String?

    /// Action called when value changes
    private let onChange: ((Double) -> Void)?

    // MARK: - Initializer

    /// Creates a slider with value binding
    ///
    /// - Parameters:
    ///   - value: Binding to the current value
    ///   - min: Minimum value (default: 0.0)
    ///   - max: Maximum value (default: 100.0)
    ///   - step: Step increment (default: 1.0)
    ///   - isDisabled: Whether disabled (default: false)
    ///   - tone: Color scheme (default: .primary)
    ///   - size: Slider size (default: .medium)
    ///   - label: Accessibility label (default: nil)
    ///   - onChange: Called when value changes (default: nil)
    public init(
        value: Binding<Double>,
        min: Double = 0.0,
        max: Double = 100.0,
        step: Double = 1.0,
        isDisabled: Bool = false,
        tone: SliderTone = .primary,
        size: SliderSize = .medium,
        label: String? = nil,
        onChange: ((Double) -> Void)? = nil
    ) {
        self._value = value
        self.min = min
        self.max = max
        self.step = step
        self.isDisabled = isDisabled
        self.tone = tone
        self.size = size
        self.label = label
        self.onChange = onChange
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Label (optional)
            if let label = label {
                Text(label)
                    .font(tokenLabelFont)
                    .foregroundColor(isDisabled ? ElevateAliases.Content.General.text_muted : ElevateAliases.Content.General.text_default)
            }

            // Custom styled slider
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // Track (background)
                    RoundedRectangle(cornerRadius: tokenTrackHeight / 2)
                        .fill(tokenTrackColor)
                        .frame(height: tokenTrackHeight)

                    // Progress (filled portion)
                    RoundedRectangle(cornerRadius: tokenTrackHeight / 2)
                        .fill(tokenProgressColor)
                        .frame(
                            width: geometry.size.width * normalizedValue,
                            height: tokenTrackHeight
                        )

                    // Thumb
                    Circle()
                        .fill(tokenThumbFillColor)
                        .overlay(
                            Circle()
                                .strokeBorder(tokenThumbBorderColor, lineWidth: tokenThumbBorderWidth)
                        )
                        .frame(width: tokenThumbSize, height: tokenThumbSize)
                        .offset(x: (geometry.size.width - tokenThumbSize) * normalizedValue)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { gesture in
                                    if !isDisabled {
                                        updateValue(for: gesture.location.x, in: geometry.size.width)
                                    }
                                }
                        )
                }
            }
            .frame(height: tokenThumbSize)
            .opacity(isDisabled ? 0.6 : 1.0)

            // Value display (optional)
            if label != nil {
                Text(formatValue(value))
                    .font(ElevateTypographyiOS.bodySmall) // 14pt (web: 12pt)
                    .foregroundColor(ElevateAliases.Content.General.text_understated)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(label ?? "Slider")
        .accessibilityValue("\(Int(value))")
        .accessibilityAdjustableAction { direction in
            if !isDisabled {
                switch direction {
                case .increment:
                    value = Swift.min(value + step, max)
                    onChange?(value)
                case .decrement:
                    value = Swift.max(value - step, min)
                    onChange?(value)
                @unknown default:
                    break
                }
            }
        }
    }

    // MARK: - Helpers

    private var normalizedValue: CGFloat {
        CGFloat((value - min) / (max - min))
    }

    private func updateValue(for locationX: CGFloat, in width: CGFloat) {
        let percentage = Swift.max(0, Swift.min(1, locationX / width))
        let rawValue = min + (max - min) * Double(percentage)

        // Snap to step
        let steppedValue = round(rawValue / step) * step
        let clampedValue = Swift.max(min, Swift.min(max, steppedValue))

        if clampedValue != value {
            value = clampedValue
            onChange?(value)
        }
    }

    private func formatValue(_ val: Double) -> String {
        if step >= 1.0 {
            return String(format: "%.0f", val)
        } else if step >= 0.1 {
            return String(format: "%.1f", val)
        } else {
            return String(format: "%.2f", val)
        }
    }

    // MARK: - Token Accessors

    private var tokenTrackHeight: CGFloat {
        switch size {
        case .small: return SliderComponentTokens.progress_size_row_s
        case .medium: return SliderComponentTokens.progress_size_row_m
        case .large: return SliderComponentTokens.progress_size_row_l
        }
    }

    private var tokenThumbSize: CGFloat {
        switch size {
        case .small: return SliderComponentTokens.size_row_s
        case .medium: return SliderComponentTokens.size_row_m
        case .large: return SliderComponentTokens.size_row_l
        }
    }

    private var tokenThumbBorderWidth: CGFloat {
        SliderComponentTokens.thumb_border_width_default
    }

    private var tokenLabelFont: Font {
        switch size {
        case .small: return ElevateTypographyiOS.labelSmall // 14pt (web: 12pt)
        case .medium: return ElevateTypographyiOS.labelMedium // 16pt (web: 14pt)
        case .large: return ElevateTypographyiOS.labelLarge // 18pt (web: 16pt)
        }
    }

    private var tokenTrackColor: Color {
        isDisabled
            ? SliderComponentTokens.track_fill_disabled
            : SliderComponentTokens.track_fill_default
    }

    private var tokenProgressColor: Color {
        if isDisabled {
            return SliderComponentTokens.progress_fill_disabled
        }

        switch tone {
        case .primary: return SliderComponentTokens.progress_fill_default
        case .success: return SliderComponentTokens.progress_fill_success
        case .danger: return SliderComponentTokens.progress_fill_danger
        }
    }

    private var tokenThumbFillColor: Color {
        isDisabled
            ? SliderComponentTokens.thumb_fill_disabled
            : SliderComponentTokens.thumb_fill_default
    }

    private var tokenThumbBorderColor: Color {
        if isDisabled {
            return SliderComponentTokens.thumb_border_color_disabled
        }

        switch tone {
        case .primary: return SliderComponentTokens.thumb_border_color_selected_default
        case .success: return SliderComponentTokens.thumb_border_color_success_default
        case .danger: return SliderComponentTokens.thumb_border_color_danger_default
        }
    }
}

// MARK: - Slider Tone

@available(iOS 15, *)
public enum SliderTone {
    case primary
    case success
    case danger
}

// MARK: - Slider Size

@available(iOS 15, *)
public enum SliderSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateSlider_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Slider
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Slider").font(.headline)
                    PreviewSlider(label: "Volume", initialValue: 50)
                }

                Divider()

                // Tones
                VStack(alignment: .leading, spacing: 16) {
                    Text("Slider Tones").font(.headline)
                    PreviewSlider(label: "Primary", initialValue: 60, tone: .primary)
                    PreviewSlider(label: "Success", initialValue: 75, tone: .success)
                    PreviewSlider(label: "Danger", initialValue: 90, tone: .danger)
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Slider Sizes").font(.headline)
                    PreviewSlider(label: "Small", initialValue: 30, size: .small)
                    PreviewSlider(label: "Medium", initialValue: 50, size: .medium)
                    PreviewSlider(label: "Large", initialValue: 70, size: .large)
                }

                Divider()

                // Disabled
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disabled State").font(.headline)
                    PreviewSlider(label: "Disabled", initialValue: 50, isDisabled: true)
                }

                Divider()

                // Different Ranges
                VStack(alignment: .leading, spacing: 16) {
                    Text("Different Ranges").font(.headline)
                    PreviewSlider(label: "0-10", initialValue: 5, min: 0, max: 10)
                    PreviewSlider(label: "0-1 (step 0.1)", initialValue: 0.5, min: 0, max: 1, step: 0.1)
                    PreviewSlider(label: "-100 to 100", initialValue: 0, min: -100, max: 100, step: 10)
                }
            }
            .padding()
        }
    }

    struct PreviewSlider: View {
        let label: String
        @State var value: Double
        var min: Double = 0
        var max: Double = 100
        var step: Double = 1
        var isDisabled: Bool = false
        var tone: SliderTone = .primary
        var size: SliderSize = .medium

        init(
            label: String,
            initialValue: Double,
            min: Double = 0,
            max: Double = 100,
            step: Double = 1,
            isDisabled: Bool = false,
            tone: SliderTone = .primary,
            size: SliderSize = .medium
        ) {
            self.label = label
            self._value = State(initialValue: initialValue)
            self.min = min
            self.max = max
            self.step = step
            self.isDisabled = isDisabled
            self.tone = tone
            self.size = size
        }

        var body: some View {
            ElevateSlider(
                value: $value,
                min: min,
                max: max,
                step: step,
                isDisabled: isDisabled,
                tone: tone,
                size: size,
                label: label
            ) { newValue in
                print("\(label): \(newValue)")
            }
        }
    }
}
#endif

#endif
