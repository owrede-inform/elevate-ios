#if os(iOS)
import SwiftUI

/// ELEVATE Stepper Item Component
///
/// Single step within a stepper. Displays a marker, label, optional help text, and nested content.
/// Can be interactive (button or link) or non-interactive.
///
/// **Web Component:** `<elvt-stepper-item>`
/// **API Reference:** `.claude/components/Navigation/stepper-item.md`
@available(iOS 15, *)
public struct ElevateStepperItem<Content: View>: View {

    // MARK: - Properties

    /// The label for the stepper item
    private let label: String

    /// Optional help text
    private let helpText: String?

    /// Optional custom marker text (defaults to position number)
    private let marker: String?

    /// The tone/status of the stepper item
    private let tone: StepperItemTone

    /// Whether the item is disabled
    private let isDisabled: Bool

    /// The size of the stepper item
    private let size: StepperItemSize

    /// Whether this is the first item (no connector)
    private let isFirst: Bool

    /// Optional action when tapped
    private let action: (() -> Void)?

    /// Optional nested content
    private let content: (() -> Content)?

    // MARK: - State

    @State private var isPressed = false
    @State private var isHovered = false

    // MARK: - Initializer

    /// Creates a stepper item
    ///
    /// - Parameters:
    ///   - label: The label text for the stepper item
    ///   - helpText: Optional help text (default: nil)
    ///   - marker: Optional custom marker text (default: nil uses position)
    ///   - tone: The status/tone (default: .neutral)
    ///   - isDisabled: Whether the item is disabled (default: false)
    ///   - size: The size (default: .medium)
    ///   - isFirst: Whether this is the first item (default: false)
    ///   - action: Optional action when tapped (default: nil)
    ///   - content: Optional nested content (default: nil)
    public init(
        label: String,
        helpText: String? = nil,
        marker: String? = nil,
        tone: StepperItemTone = .neutral,
        isDisabled: Bool = false,
        size: StepperItemSize = .medium,
        isFirst: Bool = false,
        action: (() -> Void)? = nil,
        @ViewBuilder content: (() -> Content)? = nil
    ) {
        self.label = label
        self.helpText = helpText
        self.marker = marker
        self.tone = tone
        self.isDisabled = isDisabled
        self.size = size
        self.isFirst = isFirst
        self.action = action
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: tokenGap) {
            // Marker and connector
            HStack(alignment: .center, spacing: 0) {
                // Connector line (if not first)
                if !isFirst {
                    Rectangle()
                        .fill(tokenConnectorColor)
                        .frame(width: tokenConnectorContainer, height: tokenConnectorStrokeWidth)
                }

                // Marker
                markerView
            }

            // Label and help text
            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(ElevateTypography.labelMedium)
                    .foregroundColor(tokenLabelColor)

                if let helpText = helpText {
                    Text(helpText)
                        .font(ElevateTypography.bodySmall)
                        .foregroundColor(tokenHelpTextColor)
                }
            }

            // Nested content
            if let content = content {
                content()
                    .padding(.leading, tokenMarkerSize + tokenGap)
            }
        }
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityHint(helpText ?? "")
        .accessibilityAddTraits(isDisabled ? .isButton : [])
    }

    // MARK: - Marker View

    private var markerView: some View {
        Group {
            if let action = action, !isDisabled {
                Button(action: action) {
                    markerContent
                }
                .buttonStyle(PlainButtonStyle())
            } else {
                markerContent
            }
        }
    }

    private var markerContent: some View {
        ZStack {
            Circle()
                .fill(tokenMarkerFillColor)
                .frame(width: tokenMarkerSize, height: tokenMarkerSize)

            if tone == .success {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: tokenMarkerIconSize, height: tokenMarkerIconSize)
                    .foregroundColor(tokenMarkerIconColor)
            } else if tone == .danger {
                Image(systemName: "exclamationmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: tokenMarkerIconSize, height: tokenMarkerIconSize)
                    .foregroundColor(tokenMarkerIconColor)
            } else if let marker = marker {
                Text(marker)
                    .font(markerFont)
                    .foregroundColor(tokenMarkerIconColor)
            } else {
                Text("1")
                    .font(markerFont)
                    .foregroundColor(tokenMarkerIconColor)
            }
        }
    }

    // MARK: - Token Accessors

    private var tokenMarkerSize: CGFloat {
        switch size {
        case .small: return StepperItemComponentTokens.marker_size_s
        case .medium: return StepperItemComponentTokens.marker_size_m
        case .large: return StepperItemComponentTokens.marker_size_l
        }
    }

    private var tokenMarkerIconSize: CGFloat {
        switch size {
        case .small: return StepperItemComponentTokens.marker_icon_size_s
        case .medium: return StepperItemComponentTokens.marker_icon_size_m
        case .large: return StepperItemComponentTokens.marker_icon_size_l
        }
    }

    private var tokenGap: CGFloat {
        switch size {
        case .small: return StepperItemComponentTokens.gap_s
        case .medium: return StepperItemComponentTokens.gap_m
        case .large: return StepperItemComponentTokens.gap_l
        }
    }

    private var tokenConnectorContainer: CGFloat {
        switch size {
        case .small: return StepperItemComponentTokens.connector_container_s
        case .medium: return StepperItemComponentTokens.connector_container_m
        case .large: return StepperItemComponentTokens.connector_container_l
        }
    }

    private var tokenConnectorStrokeWidth: CGFloat {
        switch size {
        case .small: return StepperItemComponentTokens.connector_stroke_width_s
        case .medium: return StepperItemComponentTokens.connector_stroke_width_m
        case .large: return StepperItemComponentTokens.connector_stroke_width_l
        }
    }

    private var tokenMarkerFillColor: Color {
        if isDisabled {
            return StepperItemComponentTokens.marker_fill_disabled_default
        }

        if isPressed {
            switch tone {
            case .neutral: return StepperItemComponentTokens.marker_fill_default_active
            case .primary: return StepperItemComponentTokens.marker_fill_selected_active
            case .success: return StepperItemComponentTokens.marker_fill_completed_active
            case .danger: return StepperItemComponentTokens.marker_fill_invalid_active
            }
        }

        if isHovered {
            switch tone {
            case .neutral: return StepperItemComponentTokens.marker_fill_default_hover
            case .primary: return StepperItemComponentTokens.marker_fill_selected_hover
            case .success: return StepperItemComponentTokens.marker_fill_completed_hover
            case .danger: return StepperItemComponentTokens.marker_fill_invalid_hover
            }
        }

        switch tone {
        case .neutral: return StepperItemComponentTokens.marker_fill_default_default
        case .primary: return StepperItemComponentTokens.marker_fill_selected_default
        case .success: return StepperItemComponentTokens.marker_fill_completed_default
        case .danger: return StepperItemComponentTokens.marker_fill_invalid_default
        }
    }

    private var tokenMarkerIconColor: Color {
        StepperItemComponentTokens.marker_icon_color
    }

    private var tokenLabelColor: Color {
        if isDisabled {
            return StepperItemComponentTokens.label_color_disabled
        }
        if tone == .danger {
            return StepperItemComponentTokens.label_color_invalid
        }
        return StepperItemComponentTokens.label_color_default
    }

    private var tokenHelpTextColor: Color {
        if isDisabled {
            return StepperItemComponentTokens.helpText_color_disabled
        }
        if tone == .danger {
            return StepperItemComponentTokens.helpText_color_invalid
        }
        return StepperItemComponentTokens.helpText_color_default
    }

    private var tokenConnectorColor: Color {
        if isDisabled {
            return StepperItemComponentTokens.connector_stroke_color_disabled
        }
        if tone == .success {
            return StepperItemComponentTokens.connector_stroke_color_completed
        }
        return StepperItemComponentTokens.connector_stroke_color_default
    }

    private var markerFont: Font {
        switch size {
        case .small: return ElevateTypography.labelSmall
        case .medium: return ElevateTypography.labelMedium
        case .large: return ElevateTypography.labelLarge
        }
    }
}

// MARK: - Convenience Initializer (No Content)

@available(iOS 15, *)
extension ElevateStepperItem where Content == EmptyView {
    /// Creates a stepper item without nested content
    ///
    /// - Parameters:
    ///   - label: The label text for the stepper item
    ///   - helpText: Optional help text (default: nil)
    ///   - marker: Optional custom marker text (default: nil uses position)
    ///   - tone: The status/tone (default: .neutral)
    ///   - isDisabled: Whether the item is disabled (default: false)
    ///   - size: The size (default: .medium)
    ///   - isFirst: Whether this is the first item (default: false)
    ///   - action: Optional action when tapped (default: nil)
    public init(
        label: String,
        helpText: String? = nil,
        marker: String? = nil,
        tone: StepperItemTone = .neutral,
        isDisabled: Bool = false,
        size: StepperItemSize = .medium,
        isFirst: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.label = label
        self.helpText = helpText
        self.marker = marker
        self.tone = tone
        self.isDisabled = isDisabled
        self.size = size
        self.isFirst = isFirst
        self.action = action
        self.content = nil
    }
}

// MARK: - Stepper Item Tone

@available(iOS 15, *)
public enum StepperItemTone {
    case neutral   // Default, incomplete
    case primary   // Current/active step
    case success   // Completed successfully
    case danger    // Error or failed step
}

// MARK: - Stepper Item Size

@available(iOS 15, *)
public enum StepperItemSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateStepperItem_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Stepper Items
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Stepper Items").font(.headline)

                    VStack(spacing: 16) {
                        ElevateStepperItem(
                            label: "Account Details",
                            marker: "1",
                            tone: .success,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Shipping Address",
                            marker: "2",
                            tone: .primary
                        )

                        ElevateStepperItem(
                            label: "Payment Method",
                            marker: "3",
                            tone: .neutral
                        )

                        ElevateStepperItem(
                            label: "Confirm Order",
                            marker: "4",
                            tone: .neutral
                        )
                    }
                }

                Divider()

                // With Help Text
                VStack(alignment: .leading, spacing: 16) {
                    Text("With Help Text").font(.headline)

                    VStack(spacing: 16) {
                        ElevateStepperItem(
                            label: "Choose Plan",
                            helpText: "Select your subscription tier",
                            marker: "1",
                            tone: .success,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Create Account",
                            helpText: "Enter your email and password",
                            marker: "2",
                            tone: .primary
                        )

                        ElevateStepperItem(
                            label: "Verify Email",
                            helpText: "Check your inbox for verification",
                            marker: "3",
                            tone: .neutral
                        )
                    }
                }

                Divider()

                // Tone States
                VStack(alignment: .leading, spacing: 16) {
                    Text("Tone States").font(.headline)

                    VStack(spacing: 16) {
                        ElevateStepperItem(
                            label: "Neutral (Incomplete)",
                            marker: "1",
                            tone: .neutral,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Primary (Current)",
                            marker: "2",
                            tone: .primary
                        )

                        ElevateStepperItem(
                            label: "Success (Completed)",
                            marker: "3",
                            tone: .success
                        )

                        ElevateStepperItem(
                            label: "Danger (Error)",
                            helpText: "Please fix the errors and try again",
                            marker: "4",
                            tone: .danger
                        )
                    }
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sizes").font(.headline)

                    VStack(spacing: 16) {
                        ElevateStepperItem(
                            label: "Small Step",
                            marker: "1",
                            tone: .primary,
                            size: .small,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Medium Step",
                            marker: "2",
                            tone: .primary,
                            size: .medium
                        )

                        ElevateStepperItem(
                            label: "Large Step",
                            marker: "3",
                            tone: .primary,
                            size: .large
                        )
                    }
                }

                Divider()

                // Disabled State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disabled State").font(.headline)

                    ElevateStepperItem(
                        label: "Disabled Step",
                        helpText: "This step is not available",
                        marker: "1",
                        tone: .neutral,
                        isDisabled: true,
                        isFirst: true
                    )
                }

                Divider()

                // Interactive
                VStack(alignment: .leading, spacing: 16) {
                    Text("Interactive").font(.headline)

                    ElevateStepperItem(
                        label: "Tap to Navigate",
                        helpText: "This step is interactive",
                        marker: "1",
                        tone: .primary,
                        isFirst: true
                    ) {
                        print("Step tapped!")
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
