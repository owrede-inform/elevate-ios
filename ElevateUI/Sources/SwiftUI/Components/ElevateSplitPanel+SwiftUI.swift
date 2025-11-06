#if os(iOS)
import SwiftUI

/// Split panel component with resizable divider
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's mouse-driven resize, this uses:
/// - Touch-optimized drag gesture for resizing
/// - Larger touch target for divider handle (44pt minimum)
/// - Haptic feedback on drag start/end
/// - Support for both horizontal and vertical splits
/// - Collapsible panels with animation
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// ElevateSplitPanel(orientation: .horizontal) {
///     // Leading/top panel
///     Text("Panel 1")
/// } secondary: {
///     // Trailing/bottom panel
///     Text("Panel 2")
/// }
/// ```
@available(iOS 15, *)
public struct ElevateSplitPanel<Primary: View, Secondary: View>: View {

    @State private var splitRatio: CGFloat
    @State private var isDragging = false

    private let orientation: SplitOrientation
    private let minRatio: CGFloat
    private let maxRatio: CGFloat
    private let primary: () -> Primary
    private let secondary: () -> Secondary

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    // MARK: - Initialization

    public init(
        orientation: SplitOrientation = .horizontal,
        initialRatio: CGFloat = 0.5,
        minRatio: CGFloat = 0.2,
        maxRatio: CGFloat = 0.8,
        @ViewBuilder primary: @escaping () -> Primary,
        @ViewBuilder secondary: @escaping () -> Secondary
    ) {
        self.orientation = orientation
        self._splitRatio = State(initialValue: initialRatio)
        self.minRatio = minRatio
        self.maxRatio = maxRatio
        self.primary = primary
        self.secondary = secondary
    }

    // MARK: - Body

    public var body: some View {
        GeometryReader { geometry in
            if orientation == .horizontal {
                horizontalLayout(size: geometry.size)
            } else {
                verticalLayout(size: geometry.size)
            }
        }
    }

    // MARK: - Horizontal Layout

    private func horizontalLayout(size: CGSize) -> some View {
        HStack(spacing: 0) {
            // Leading panel
            primary()
                .frame(width: size.width * splitRatio)

            // Divider with handle
            divider(size: size)

            // Trailing panel
            secondary()
                .frame(width: size.width * (1 - splitRatio) - dividerWidth)
        }
    }

    // MARK: - Vertical Layout

    private func verticalLayout(size: CGSize) -> some View {
        VStack(spacing: 0) {
            // Top panel
            primary()
                .frame(height: size.height * splitRatio)

            // Divider with handle
            divider(size: size)

            // Bottom panel
            secondary()
                .frame(height: size.height * (1 - splitRatio) - dividerWidth)
        }
    }

    // MARK: - Divider

    private func divider(size: CGSize) -> some View {
        ZStack {
            // Divider line
            Rectangle()
                .fill(dividerColor)
                .frame(
                    width: orientation == .horizontal ? dividerWidth : nil,
                    height: orientation == .vertical ? dividerWidth : nil
                )

            // Touch target (larger for easy dragging)
            Rectangle()
                .fill(Color.clear)
                .frame(
                    width: orientation == .horizontal ? 44 : nil,
                    height: orientation == .vertical ? 44 : nil
                )
                .contentShape(Rectangle())

            // Handle dots (visual indicator)
            handle
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if !isDragging {
                        isDragging = true
                        performHaptic(.light)
                    }

                    let delta: CGFloat
                    if orientation == .horizontal {
                        delta = value.translation.width / size.width
                    } else {
                        delta = value.translation.height / size.height
                    }

                    let newRatio = splitRatio + delta
                    splitRatio = min(max(newRatio, minRatio), maxRatio)
                }
                .onEnded { _ in
                    isDragging = false
                    performHaptic(.light)
                }
        )
    }

    // MARK: - Handle

    private var handle: some View {
        HStack(spacing: SplitPanelComponentTokens.handle_dot_gap_m) {
            ForEach(0..<3) { _ in
                Circle()
                    .fill(handleDotColor)
                    .frame(
                        width: SplitPanelComponentTokens.handle_dot_size_m,
                        height: SplitPanelComponentTokens.handle_dot_size_m
                    )
            }
        }
        .padding(SplitPanelComponentTokens.handle_padding_block_m)
        .background(handleFillColor)
        .cornerRadius(SplitPanelComponentTokens.handle_border_radius_m)
        .overlay(
            RoundedRectangle(cornerRadius: SplitPanelComponentTokens.handle_border_radius_m)
                .stroke(handleBorderColor, lineWidth: SplitPanelComponentTokens.handle_border_weight_m)
        )
    }

    // MARK: - Computed Properties

    private var dividerWidth: CGFloat {
        // iOS Adaptation: Larger touch target (44pt) for touch devices
        return 44
    }

    /// NOTE: Removed hover state - use dragging state only per DIVERSIONS.md
    private var dividerColor: Color {
        if isDragging {
            return SplitPanelComponentTokens.divider_color_active
        }
        return SplitPanelComponentTokens.divider_color_default
    }

    /// NOTE: Removed hover state - use dragging state only per DIVERSIONS.md
    private var handleFillColor: Color {
        if isDragging {
            return SplitPanelComponentTokens.handle_fill_active
        }
        return SplitPanelComponentTokens.handle_fill_default
    }

    /// NOTE: Removed hover state - use dragging state only per DIVERSIONS.md
    private var handleBorderColor: Color {
        if isDragging {
            return SplitPanelComponentTokens.handle_border_color_active
        }
        return SplitPanelComponentTokens.handle_border_color_default
    }

    /// NOTE: Removed hover state - use dragging state only per DIVERSIONS.md
    private var handleDotColor: Color {
        if isDragging {
            return SplitPanelComponentTokens.handle_dot_color_active
        }
        return SplitPanelComponentTokens.handle_dot_color_default
    }

    // MARK: - Haptics

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Split Orientation

public enum SplitOrientation {
    case horizontal
    case vertical
}

// MARK: - Collapsible Split Panel

/// Split panel with collapsible panels
///
/// **iOS Adaptation**: Adds ability to collapse panels with animation,
/// useful for navigation drawers or detail views on iOS.
@available(iOS 15, *)
public struct ElevateCollapsibleSplitPanel<Primary: View, Secondary: View>: View {

    @Binding var isPrimaryCollapsed: Bool
    @Binding var isSecondaryCollapsed: Bool

    private let orientation: SplitOrientation
    private let primary: () -> Primary
    private let secondary: () -> Secondary

    public init(
        orientation: SplitOrientation = .horizontal,
        isPrimaryCollapsed: Binding<Bool> = .constant(false),
        isSecondaryCollapsed: Binding<Bool> = .constant(false),
        @ViewBuilder primary: @escaping () -> Primary,
        @ViewBuilder secondary: @escaping () -> Secondary
    ) {
        self.orientation = orientation
        self._isPrimaryCollapsed = isPrimaryCollapsed
        self._isSecondaryCollapsed = isSecondaryCollapsed
        self.primary = primary
        self.secondary = secondary
    }

    public var body: some View {
        if orientation == .horizontal {
            HStack(spacing: 0) {
                if !isPrimaryCollapsed {
                    primary()
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .leading))
                }

                if !isSecondaryCollapsed {
                    secondary()
                        .frame(maxWidth: .infinity)
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.spring(response: 0.3), value: isPrimaryCollapsed)
            .animation(.spring(response: 0.3), value: isSecondaryCollapsed)
        } else {
            VStack(spacing: 0) {
                if !isPrimaryCollapsed {
                    primary()
                        .frame(maxHeight: .infinity)
                        .transition(.move(edge: .top))
                }

                if !isSecondaryCollapsed {
                    secondary()
                        .frame(maxHeight: .infinity)
                        .transition(.move(edge: .bottom))
                }
            }
            .animation(.spring(response: 0.3), value: isPrimaryCollapsed)
            .animation(.spring(response: 0.3), value: isSecondaryCollapsed)
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateSplitPanel_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            HorizontalPreview()
                .tabItem {
                    Label("Horizontal", systemImage: "rectangle.split.2x1")
                }

            VerticalPreview()
                .tabItem {
                    Label("Vertical", systemImage: "rectangle.split.1x2")
                }

            CollapsiblePreview()
                .tabItem {
                    Label("Collapsible", systemImage: "sidebar.left")
                }
        }
    }

    struct HorizontalPreview: View {
        var body: some View {
            NavigationView {
                ElevateSplitPanel(orientation: .horizontal) {
                    // Leading panel
                    VStack {
                        Text("Leading Panel")
                            .font(.title2)
                        Text("Drag the divider to resize")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue.opacity(0.1))
                } secondary: {
                    // Trailing panel
                    VStack {
                        Text("Trailing Panel")
                            .font(.title2)
                        Text("Touch-optimized 44pt drag target")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green.opacity(0.1))
                }
                .navigationTitle("Horizontal Split")
            }
        }
    }

    struct VerticalPreview: View {
        var body: some View {
            NavigationView {
                ElevateSplitPanel(orientation: .vertical, initialRatio: 0.3) {
                    // Top panel
                    VStack {
                        Text("Top Panel")
                            .font(.title2)
                        Text("Vertical split with 30% initial ratio")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.orange.opacity(0.1))
                } secondary: {
                    // Bottom panel
                    VStack {
                        Text("Bottom Panel")
                            .font(.title2)
                        Text("Haptic feedback on drag")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.purple.opacity(0.1))
                }
                .navigationTitle("Vertical Split")
            }
        }
    }

    struct CollapsiblePreview: View {
        @State private var isPrimaryCollapsed = false
        @State private var isSecondaryCollapsed = false

        var body: some View {
            NavigationView {
                VStack {
                    // Controls
                    HStack {
                        Button("Toggle Leading") {
                            withAnimation {
                                isPrimaryCollapsed.toggle()
                            }
                        }
                        .buttonStyle(.bordered)

                        Button("Toggle Trailing") {
                            withAnimation {
                                isSecondaryCollapsed.toggle()
                            }
                        }
                        .buttonStyle(.bordered)
                    }
                    .padding()

                    // Collapsible split panel
                    ElevateCollapsibleSplitPanel(
                        orientation: .horizontal,
                        isPrimaryCollapsed: $isPrimaryCollapsed,
                        isSecondaryCollapsed: $isSecondaryCollapsed
                    ) {
                        VStack {
                            Text("Collapsible Panel 1")
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.red.opacity(0.1))
                    } secondary: {
                        VStack {
                            Text("Collapsible Panel 2")
                                .font(.title2)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.teal.opacity(0.1))
                    }
                }
                .navigationTitle("Collapsible Split")
            }
        }
    }
}
#endif

#endif
