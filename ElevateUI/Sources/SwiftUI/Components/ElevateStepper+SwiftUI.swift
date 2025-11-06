#if os(iOS)
import SwiftUI

/// ELEVATE Stepper Component
///
/// Container for stepper items that allows users to navigate through a sequence of steps.
/// Provides visual progress indication and manages the layout and connectors between stepper items.
///
/// **Web Component:** `<elvt-stepper>`
/// **API Reference:** `.claude/components/Navigation/stepper.md`
@available(iOS 15, *)
public struct ElevateStepper<Content: View>: View {

    // MARK: - Properties

    /// The direction of the stepper items
    private let direction: StepperDirection

    /// The size of the stepper items
    private let size: StepperSize

    /// The stepper content (StepperItem elements)
    private let content: () -> Content

    // MARK: - Initializer

    /// Creates a stepper
    ///
    /// - Parameters:
    ///   - direction: The direction of the stepper items (default: .row)
    ///   - size: The size of the stepper items (default: .medium)
    ///   - content: The stepper's steps (ElevateStepperItem elements)
    public init(
        direction: StepperDirection = .row,
        size: StepperSize = .medium,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.direction = direction
        self.size = size
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if direction == .row {
                HStack(alignment: .top, spacing: tokenGap) {
                    content()
                }
                .padding(.horizontal, tokenPaddingInline)
                .padding(.vertical, tokenPaddingBlock)
            } else {
                VStack(alignment: .leading, spacing: tokenGap) {
                    content()
                }
                .padding(.horizontal, tokenPaddingInline)
                .padding(.vertical, tokenPaddingBlock)
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Progress stepper")
    }

    // MARK: - Token Accessors

    private var tokenGap: CGFloat {
        switch size {
        case .small: return StepperComponentTokens.gap_s
        case .medium: return StepperComponentTokens.gap_m
        case .large: return StepperComponentTokens.gap_l
        }
    }

    private var tokenPaddingInline: CGFloat {
        switch size {
        case .small: return StepperComponentTokens.padding_inline_s
        case .medium: return StepperComponentTokens.padding_inline_m
        case .large: return StepperComponentTokens.padding_inline_l
        }
    }

    private var tokenPaddingBlock: CGFloat {
        switch size {
        case .small: return StepperComponentTokens.padding_block_s
        case .medium: return StepperComponentTokens.padding_block_m
        case .large: return StepperComponentTokens.padding_block_l
        }
    }
}

// MARK: - Stepper Direction

@available(iOS 15, *)
public enum StepperDirection {
    case row      // Horizontal layout
    case column   // Vertical layout
}

// MARK: - Stepper Size

@available(iOS 15, *)
public enum StepperSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateStepper_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 48) {
                // Horizontal Stepper
                VStack(alignment: .leading, spacing: 16) {
                    Text("Horizontal Stepper").font(.headline)

                    ElevateStepper(direction: .row, size: .medium) {
                        ElevateStepperItem(
                            label: "Step 1",
                            helpText: "Account setup",
                            marker: "1",
                            tone: .success,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Step 2",
                            helpText: "Shipping info",
                            marker: "2",
                            tone: .primary
                        )

                        ElevateStepperItem(
                            label: "Step 3",
                            helpText: "Payment",
                            marker: "3",
                            tone: .neutral
                        )

                        ElevateStepperItem(
                            label: "Step 4",
                            helpText: "Confirm",
                            marker: "4",
                            tone: .neutral
                        )
                    }
                }
                .background(Color.gray.opacity(0.1))

                Divider()

                // Vertical Stepper
                VStack(alignment: .leading, spacing: 16) {
                    Text("Vertical Stepper").font(.headline)

                    ElevateStepper(direction: .column, size: .medium) {
                        ElevateStepperItem(
                            label: "Account Created",
                            helpText: "Your account has been created successfully",
                            marker: "1",
                            tone: .success,
                            size: .medium,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Profile Information",
                            helpText: "Complete your profile details",
                            marker: "2",
                            tone: .primary,
                            size: .medium
                        )

                        ElevateStepperItem(
                            label: "Preferences",
                            helpText: "Set up your account preferences",
                            marker: "3",
                            tone: .neutral,
                            size: .medium
                        )

                        ElevateStepperItem(
                            label: "Email Verification",
                            helpText: "Verify your email address",
                            marker: "4",
                            tone: .neutral,
                            size: .medium
                        )
                    }
                }
                .background(Color.gray.opacity(0.1))

                Divider()

                // Size Variations
                VStack(alignment: .leading, spacing: 24) {
                    Text("Size Variations").font(.headline)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Small").font(.caption).foregroundColor(.secondary)
                        ElevateStepper(direction: .row, size: .small) {
                            ElevateStepperItem(
                                label: "Start",
                                marker: "1",
                                tone: .success,
                                size: .small,
                                isFirst: true
                            )

                            ElevateStepperItem(
                                label: "Current",
                                marker: "2",
                                tone: .primary,
                                size: .small
                            )

                            ElevateStepperItem(
                                label: "Next",
                                marker: "3",
                                tone: .neutral,
                                size: .small
                            )
                        }
                        .background(Color.gray.opacity(0.1))

                        Text("Medium").font(.caption).foregroundColor(.secondary)
                        ElevateStepper(direction: .row, size: .medium) {
                            ElevateStepperItem(
                                label: "Start",
                                marker: "1",
                                tone: .success,
                                size: .medium,
                                isFirst: true
                            )

                            ElevateStepperItem(
                                label: "Current",
                                marker: "2",
                                tone: .primary,
                                size: .medium
                            )

                            ElevateStepperItem(
                                label: "Next",
                                marker: "3",
                                tone: .neutral,
                                size: .medium
                            )
                        }
                        .background(Color.gray.opacity(0.1))

                        Text("Large").font(.caption).foregroundColor(.secondary)
                        ElevateStepper(direction: .row, size: .large) {
                            ElevateStepperItem(
                                label: "Start",
                                marker: "1",
                                tone: .success,
                                size: .large,
                                isFirst: true
                            )

                            ElevateStepperItem(
                                label: "Current",
                                marker: "2",
                                tone: .primary,
                                size: .large
                            )

                            ElevateStepperItem(
                                label: "Next",
                                marker: "3",
                                tone: .neutral,
                                size: .large
                            )
                        }
                        .background(Color.gray.opacity(0.1))
                    }
                }

                Divider()

                // E-commerce Checkout Flow
                VStack(alignment: .leading, spacing: 16) {
                    Text("E-commerce Checkout Flow").font(.headline)

                    ElevateStepper(direction: .column, size: .medium) {
                        ElevateStepperItem(
                            label: "Shopping Cart",
                            helpText: "Review your items",
                            marker: "1",
                            tone: .success,
                            size: .medium,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Shipping Information",
                            helpText: "Enter delivery address",
                            marker: "2",
                            tone: .success,
                            size: .medium
                        )

                        ElevateStepperItem(
                            label: "Payment Details",
                            helpText: "Enter payment method",
                            marker: "3",
                            tone: .primary,
                            size: .medium
                        )

                        ElevateStepperItem(
                            label: "Order Confirmation",
                            helpText: "Review and place order",
                            marker: "4",
                            tone: .neutral,
                            size: .medium
                        )
                    }
                }
                .background(Color.gray.opacity(0.1))

                Divider()

                // Form Wizard
                VStack(alignment: .leading, spacing: 16) {
                    Text("Form Wizard").font(.headline)

                    ElevateStepper(direction: .row, size: .medium) {
                        ElevateStepperItem(
                            label: "Personal",
                            marker: "1",
                            tone: .success,
                            size: .medium,
                            isFirst: true
                        )

                        ElevateStepperItem(
                            label: "Education",
                            marker: "2",
                            tone: .success,
                            size: .medium
                        )

                        ElevateStepperItem(
                            label: "Experience",
                            marker: "3",
                            tone: .danger,
                            size: .medium
                        ) {
                            Text("Please fix validation errors")
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        ElevateStepperItem(
                            label: "Review",
                            marker: "4",
                            tone: .neutral,
                            size: .medium
                        )
                    }
                }
                .background(Color.gray.opacity(0.1))
            }
            .padding()
        }
    }
}
#endif

#endif
