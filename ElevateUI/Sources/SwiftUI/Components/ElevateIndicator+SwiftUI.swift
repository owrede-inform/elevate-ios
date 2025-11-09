#if os(iOS)
import SwiftUI

/// ELEVATE Indicator Component
///
/// Attach an indicator badge to any component, typically for notification counts or status.
/// Supports multiple placement positions and customizable indicator content.
///
/// **Web Component:** `<elvt-indicator>`
/// **API Reference:** `.claude/components/Display/indicator.md`
@available(iOS 15, *)
public struct ElevateIndicator<Content: View, Indicator: View>: View {

    // MARK: - Properties

    /// The placement of the indicator relative to the content
    private let placement: IndicatorPlacement

    /// The content to attach the indicator to
    private let content: () -> Content

    /// The indicator badge content
    private let indicator: () -> Indicator

    // MARK: - Initializer

    /// Creates an indicator overlay
    ///
    /// - Parameters:
    ///   - placement: Position of the indicator (default: .topTrailing)
    ///   - content: The component to attach the indicator to
    ///   - indicator: The indicator badge content
    public init(
        placement: IndicatorPlacement = .topTrailing,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder indicator: @escaping () -> Indicator
    ) {
        self.placement = placement
        self.content = content
        self.indicator = indicator
    }

    // MARK: - Body

    public var body: some View {
        ZStack(alignment: placementAlignment) {
            content()

            indicator()
                .offset(x: placementOffsetX, y: placementOffsetY)
        }
    }

    // MARK: - Helpers

    private var placementAlignment: Alignment {
        switch placement {
        case .topLeading: return .topLeading
        case .topTrailing: return .topTrailing
        case .bottomLeading: return .bottomLeading
        case .bottomTrailing: return .bottomTrailing
        }
    }

    private var placementOffsetX: CGFloat {
        switch placement {
        case .topLeading, .bottomLeading: return 4
        case .topTrailing, .bottomTrailing: return -4
        }
    }

    private var placementOffsetY: CGFloat {
        switch placement {
        case .topLeading, .topTrailing: return 4
        case .bottomLeading, .bottomTrailing: return -4
        }
    }
}

// MARK: - Convenience Initializer with Badge

@available(iOS 15, *)
extension ElevateIndicator where Indicator == ElevateBadge<EmptyView, EmptyView> {
    /// Creates an indicator with a default badge
    ///
    /// - Parameters:
    ///   - count: The number to display in the badge
    ///   - tone: Color scheme of the indicator (default: .primary)
    ///   - placement: Position of the indicator (default: .topTrailing)
    ///   - content: The component to attach the indicator to
    public init(
        count: Int,
        tone: IndicatorTone = .primary,
        placement: IndicatorPlacement = .topTrailing,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            placement: placement,
            content: content,
            indicator: {
                ElevateBadge(
                    "\(count)",
                    tone: Self.mapToBadgeTone(tone),
                    rank: .minor,
                    shape: .pill
                )
            }
        )
    }

    private static func mapToBadgeTone(_ tone: IndicatorTone) -> BadgeTokens.Tone {
        switch tone {
        case .primary: return .primary
        case .success: return .success
        case .warning: return .warning
        case .danger: return .danger
        case .neutral: return .neutral
        case .emphasized: return .primary
        }
    }
}

// MARK: - Convenience Initializer with Dot

@available(iOS 15, *)
extension ElevateIndicator {
    /// Creates an indicator with a dot (no text)
    ///
    /// - Parameters:
    ///   - tone: Color scheme of the indicator (default: .danger)
    ///   - placement: Position of the indicator (default: .topTrailing)
    ///   - content: The component to attach the indicator to
    public init(
        tone: IndicatorTone = .danger,
        placement: IndicatorPlacement = .topTrailing,
        @ViewBuilder content: @escaping () -> Content
    ) where Indicator == AnyView {
        self.init(
            placement: placement,
            content: content,
            indicator: {
                AnyView(
                    Circle()
                        .fill(Self.tokenFillColor(for: tone))
                        .frame(width: 12, height: 12)
                        .overlay(
                            Circle()
                                .strokeBorder(ElevateAliases.Feedback.Strong.text_inverted, lineWidth: 2)
                        )
                )
            }
        )
    }

    private static func tokenFillColor(for tone: IndicatorTone) -> Color {
        switch tone {
        case .primary: return IndicatorComponentTokens.fill_primary
        case .success: return IndicatorComponentTokens.fill_success
        case .warning: return IndicatorComponentTokens.fill_warning
        case .danger: return IndicatorComponentTokens.fill_danger
        case .neutral: return IndicatorComponentTokens.fill_neutral
        case .emphasized: return IndicatorComponentTokens.fill_emphasized
        }
    }
}

// MARK: - Indicator Placement

@available(iOS 15, *)
public enum IndicatorPlacement {
    case topLeading      // Top-left
    case topTrailing     // Top-right (default)
    case bottomLeading   // Bottom-left
    case bottomTrailing  // Bottom-right
}

// MARK: - Indicator Tone

@available(iOS 15, *)
public enum IndicatorTone {
    case primary
    case success
    case warning
    case danger
    case neutral
    case emphasized
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Indicators with Count
                VStack(alignment: .leading, spacing: 16) {
                    Text("Indicators with Count").font(.headline)

                    HStack(spacing: 32) {
                        ElevateIndicator(count: 5) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
                        }

                        ElevateIndicator(count: 12, tone: .danger) {
                            Image(systemName: "envelope.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
                        }

                        ElevateIndicator(count: 99, tone: .success) {
                            Image(systemName: "tray.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.blue)
                        }
                    }
                }

                Divider()

                // Dot Indicators
                VStack(alignment: .leading, spacing: 16) {
                    Text("Dot Indicators").font(.headline)

                    HStack(spacing: 32) {
                        ElevateIndicator(tone: .danger) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        }

                        ElevateIndicator(tone: .success) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        }

                        ElevateIndicator(tone: .warning) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 32))
                                .foregroundColor(.gray)
                        }
                    }
                }

                Divider()

                // Placement Positions
                VStack(alignment: .leading, spacing: 16) {
                    Text("Indicator Placements").font(.headline)

                    HStack(spacing: 32) {
                        VStack(spacing: 8) {
                            ElevateIndicator(count: 1, placement: .topLeading) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 60, height: 60)
                            }
                            Text("Top Leading")
                                .font(.caption2)
                        }

                        VStack(spacing: 8) {
                            ElevateIndicator(count: 2, placement: .topTrailing) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 60, height: 60)
                            }
                            Text("Top Trailing")
                                .font(.caption2)
                        }

                        VStack(spacing: 8) {
                            ElevateIndicator(count: 3, placement: .bottomLeading) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 60, height: 60)
                            }
                            Text("Bottom Leading")
                                .font(.caption2)
                        }

                        VStack(spacing: 8) {
                            ElevateIndicator(count: 4, placement: .bottomTrailing) {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue.opacity(0.3))
                                    .frame(width: 60, height: 60)
                            }
                            Text("Bottom Trailing")
                                .font(.caption2)
                        }
                    }
                }

                Divider()

                // Custom Indicator Content
                VStack(alignment: .leading, spacing: 16) {
                    Text("Custom Indicator Content").font(.headline)

                    HStack(spacing: 32) {
                        // Custom icon indicator
                        ElevateIndicator(
                            placement: .topTrailing,
                            content: {
                                Circle()
                                    .fill(Color.purple)
                                    .frame(width: 50, height: 50)
                            },
                            indicator: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .padding(4)
                                    .background(Circle().fill(Color.green))
                            }
                        )

                        // Custom text indicator
                        ElevateIndicator(
                            placement: .topTrailing,
                            content: {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.orange.opacity(0.3))
                                    .frame(width: 50, height: 50)
                            },
                            indicator: {
                                Text("NEW")
                                    .font(.caption2)
                                    .bold()
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 2)
                                    .background(Capsule().fill(Color.red))
                            }
                        )
                    }
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Use Cases").font(.headline)

                    VStack(alignment: .leading, spacing: 16) {
                        // Notification bell
                        HStack(spacing: 12) {
                            ElevateIndicator(count: 3, tone: .danger) {
                                VStack {
                                    Image(systemName: "bell.fill")
                                        .font(.title)
                                    Text("Notifications")
                                        .font(.caption)
                                }
                            }
                        }

                        // Messages
                        HStack(spacing: 12) {
                            ElevateIndicator(count: 12, tone: .primary) {
                                VStack {
                                    Image(systemName: "message.fill")
                                        .font(.title)
                                    Text("Messages")
                                        .font(.caption)
                                }
                            }
                        }

                        // Cart items
                        HStack(spacing: 12) {
                            ElevateIndicator(count: 7, tone: .success) {
                                VStack {
                                    Image(systemName: "cart.fill")
                                        .font(.title)
                                    Text("Cart")
                                        .font(.caption)
                                }
                            }
                        }

                        // Online status dot
                        HStack(spacing: 12) {
                            ElevateIndicator(tone: .success, placement: .bottomTrailing) {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Image(systemName: "person.fill")
                                            .foregroundColor(.gray)
                                    )
                            }
                            Text("Online Status")
                                .font(.caption)
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
