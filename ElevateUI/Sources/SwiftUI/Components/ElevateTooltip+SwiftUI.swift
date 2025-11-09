#if os(iOS)
import SwiftUI

/// ELEVATE Tooltip Component
///
/// Display a tooltip next to the wrapped anchor element.
/// Shows on long press with optional arrow and customizable placement.
///
/// **Web Component:** `<elvt-tooltip>`
/// **API Reference:** `.claude/components/Overlays/tooltip.md`
@available(iOS 15, *)
public struct ElevateTooltip<Content: View>: View {

    // MARK: - Properties

    /// The content that triggers the tooltip
    private let content: () -> Content

    /// The tooltip text
    private let tooltip: String

    /// Whether to show an arrow
    private let arrow: Bool

    /// The preferred placement of the tooltip
    private let placement: TooltipPlacement

    /// Whether the tooltip is disabled
    private let isDisabled: Bool

    // MARK: - State

    @State private var isShowing = false
    @State private var showTimer: Timer?
    @State private var hideTimer: Timer?

    // MARK: - Initializer

    /// Creates a tooltip
    ///
    /// - Parameters:
    ///   - tooltip: The tooltip text to display
    ///   - arrow: Whether to show an arrow (default: false)
    ///   - placement: The preferred placement (default: .top)
    ///   - isDisabled: Whether the tooltip is disabled (default: false)
    ///   - content: The anchor element that triggers the tooltip
    public init(
        _ tooltip: String,
        arrow: Bool = false,
        placement: TooltipPlacement = .top,
        isDisabled: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.tooltip = tooltip
        self.arrow = arrow
        self.placement = placement
        self.isDisabled = isDisabled
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        content()
            .overlay(
                GeometryReader { geometry in
                    if isShowing && !isDisabled {
                        tooltipOverlay(anchorFrame: geometry.frame(in: .global))
                    }
                }
            )
            .onLongPressGesture(minimumDuration: 0.5, pressing: { pressing in
                if !isDisabled {
                    if pressing {
                        scheduleShow()
                    } else {
                        scheduleHide()
                    }
                }
            }, perform: {})
    }

    // MARK: - Tooltip Overlay

    @ViewBuilder
    private func tooltipOverlay(anchorFrame: CGRect) -> some View {
        VStack(spacing: 0) {
            if placement == .bottom && arrow {
                arrowView
                    .rotationEffect(.degrees(180))
            }

            Text(tooltip)
                .font(ElevateTypographyiOS.bodySmall) // 14pt (web: 12pt)
                .foregroundColor(TooltipComponentTokens.label_color)
                .padding(.horizontal, TooltipComponentTokens.padding_inline)
                .padding(.vertical, TooltipComponentTokens.padding_block)
                .background(TooltipComponentTokens.fill_color)
                .clipShape(RoundedRectangle(cornerRadius: TooltipComponentTokens.border_radius))
                .overlay(
                    RoundedRectangle(cornerRadius: TooltipComponentTokens.border_radius)
                        .strokeBorder(TooltipComponentTokens.border_color, lineWidth: TooltipComponentTokens.border_width)
                )
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)

            if placement == .top && arrow {
                arrowView
            }
        }
        .position(tooltipPosition(anchorFrame: anchorFrame))
        .transition(.opacity.combined(with: .scale(scale: 0.95)))
        .animation(.easeInOut(duration: 0.2), value: isShowing)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(tooltip)
    }

    private var arrowView: some View {
        Triangle()
            .fill(TooltipComponentTokens.fill_color)
            .frame(width: 12, height: 6)
            .overlay(
                Triangle()
                    .stroke(TooltipComponentTokens.border_color, lineWidth: TooltipComponentTokens.border_width)
            )
    }

    // MARK: - Positioning

    private func tooltipPosition(anchorFrame: CGRect) -> CGPoint {
        let distance = arrow ? TooltipComponentTokens.distance_withArrow : TooltipComponentTokens.distance_withoutArrow
        let arrowHeight: CGFloat = arrow ? 6 : 0

        switch placement {
        case .top:
            return CGPoint(
                x: anchorFrame.midX,
                y: anchorFrame.minY - distance - arrowHeight
            )
        case .bottom:
            return CGPoint(
                x: anchorFrame.midX,
                y: anchorFrame.maxY + distance + arrowHeight
            )
        case .leading:
            return CGPoint(
                x: anchorFrame.minX - distance,
                y: anchorFrame.midY
            )
        case .trailing:
            return CGPoint(
                x: anchorFrame.maxX + distance,
                y: anchorFrame.midY
            )
        }
    }

    // MARK: - Helpers

    private func scheduleShow() {
        cancelTimers()
        showTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            withAnimation {
                isShowing = true
            }
        }
    }

    private func scheduleHide() {
        cancelTimers()
        hideTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
            withAnimation {
                isShowing = false
            }
        }
    }

    private func cancelTimers() {
        showTimer?.invalidate()
        hideTimer?.invalidate()
        showTimer = nil
        hideTimer = nil
    }
}

// MARK: - Triangle Shape

@available(iOS 15, *)
private struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Tooltip Placement

@available(iOS 15, *)
public enum TooltipPlacement {
    case top
    case bottom
    case leading
    case trailing
}

// MARK: - View Extension

@available(iOS 15, *)
extension View {
    /// Adds a tooltip to this view
    ///
    /// - Parameters:
    ///   - text: The tooltip text
    ///   - arrow: Whether to show an arrow (default: false)
    ///   - placement: The preferred placement (default: .top)
    ///   - isDisabled: Whether the tooltip is disabled (default: false)
    /// - Returns: A view with a tooltip attached
    public func elevateTooltip(
        _ text: String,
        arrow: Bool = false,
        placement: TooltipPlacement = .top,
        isDisabled: Bool = false
    ) -> some View {
        ElevateTooltip(text, arrow: arrow, placement: placement, isDisabled: isDisabled) {
            self
        }
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateTooltip_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 48) {
                // Basic Tooltips
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Tooltips").font(.headline)

                    HStack(spacing: 32) {
                        Button("Hover Me") {}
                            .elevateTooltip("This is a basic tooltip")

                        Button("With Arrow") {}
                            .elevateTooltip("Tooltip with arrow", arrow: true)
                    }
                }

                Divider()

                // Placement Options
                VStack(alignment: .leading, spacing: 16) {
                    Text("Placement Options").font(.headline)

                    VStack(spacing: 24) {
                        HStack(spacing: 16) {
                            Spacer()

                            Button("Top") {}
                                .elevateTooltip("Top placement", arrow: true, placement: .top)

                            Spacer()
                        }

                        HStack(spacing: 32) {
                            Button("Leading") {}
                                .elevateTooltip("Leading placement", arrow: false, placement: .leading)

                            Spacer()

                            Button("Trailing") {}
                                .elevateTooltip("Trailing placement", arrow: false, placement: .trailing)
                        }

                        HStack(spacing: 16) {
                            Spacer()

                            Button("Bottom") {}
                                .elevateTooltip("Bottom placement", arrow: true, placement: .bottom)

                            Spacer()
                        }
                    }
                }

                Divider()

                // Icon Buttons with Tooltips
                VStack(alignment: .leading, spacing: 16) {
                    Text("Icon Buttons").font(.headline)

                    HStack(spacing: 16) {
                        Image(systemName: "gear")
                            .font(.title2)
                            .elevateTooltip("Settings", placement: .top)

                        Image(systemName: "bell")
                            .font(.title2)
                            .elevateTooltip("Notifications", arrow: true, placement: .top)

                        Image(systemName: "person.circle")
                            .font(.title2)
                            .elevateTooltip("Profile", arrow: true, placement: .bottom)

                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .elevateTooltip("Search", placement: .bottom)
                    }
                }

                Divider()

                // Disabled State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disabled State").font(.headline)

                    Button("Disabled Tooltip") {}
                        .elevateTooltip("You won't see this", isDisabled: true)
                }

                Divider()

                // Longer Tooltip Text
                VStack(alignment: .leading, spacing: 16) {
                    Text("Long Tooltip Text").font(.headline)

                    Button("Information") {}
                        .elevateTooltip(
                            "This is a longer tooltip with more detailed information about the feature",
                            arrow: true,
                            placement: .top
                        )
                }

                Divider()

                // Common UI Patterns
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Patterns").font(.headline)

                    // Toolbar with tooltips
                    HStack(spacing: 20) {
                        Image(systemName: "doc.text")
                            .elevateTooltip("New Document", arrow: true, placement: .top)

                        Image(systemName: "folder")
                            .elevateTooltip("Open File", arrow: true, placement: .top)

                        Image(systemName: "square.and.arrow.down")
                            .elevateTooltip("Save", arrow: true, placement: .top)

                        Image(systemName: "printer")
                            .elevateTooltip("Print", arrow: true, placement: .top)

                        Image(systemName: "trash")
                            .elevateTooltip("Delete", arrow: true, placement: .top)
                    }
                    .font(.title3)

                    // Help icons
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("Username")

                        Image(systemName: "questionmark.circle")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .elevateTooltip(
                                "Your username must be 3-20 characters and can only contain letters and numbers",
                                arrow: true,
                                placement: .top
                            )
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
