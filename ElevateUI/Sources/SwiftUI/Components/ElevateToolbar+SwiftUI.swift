#if os(iOS)
import SwiftUI

/// ELEVATE Toolbar Component
///
/// A toolbar defines a row of actions and context information with flexible slot-based layout.
/// Supports start, center, and end content slots with customizable borders, direction, and elevation.
///
/// **Web Component:** `<elvt-toolbar>`
/// **API Reference:** `.claude/components/Structure/toolbar.md`
@available(iOS 15, *)
public struct ElevateToolbar<Start: View, Center: View, End: View, Content: View>: View {

    // MARK: - Properties

    /// The layer/elevation level
    private let layer: ToolbarLayer

    /// Border configuration
    private let border: ToolbarBorder

    /// Layout direction
    private let direction: ToolbarDirection

    /// Custom gap between items
    private let gap: CGFloat?

    /// Custom padding
    private let padding: CGFloat?

    /// Start slot content
    private let start: (() -> Start)?

    /// Center slot content
    private let center: (() -> Center)?

    /// End slot content
    private let end: (() -> End)?

    /// Default slot content (appears after start)
    private let content: (() -> Content)?

    // MARK: - Initializer

    /// Creates a toolbar with all slots
    ///
    /// - Parameters:
    ///   - layer: Elevation level (default: .ground)
    ///   - border: Border configuration (default: .start)
    ///   - direction: Layout direction (default: .row)
    ///   - gap: Custom gap between items (default: nil, uses token value)
    ///   - padding: Custom padding (default: nil, uses token value)
    ///   - start: Start slot content
    ///   - center: Center slot content
    ///   - end: End slot content
    ///   - content: Default slot content
    public init(
        layer: ToolbarLayer = .ground,
        border: ToolbarBorder = .start,
        direction: ToolbarDirection = .row,
        gap: CGFloat? = nil,
        padding: CGFloat? = nil,
        @ViewBuilder start: @escaping () -> Start,
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder end: @escaping () -> End,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.layer = layer
        self.border = border
        self.direction = direction
        self.gap = gap
        self.padding = padding
        self.start = start
        self.center = center
        self.end = end
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        Group {
            if direction == .row {
                HStack(spacing: effectiveGap) {
                    layoutContent()
                }
                .padding(effectivePadding)
            } else {
                VStack(spacing: effectiveGap) {
                    layoutContent()
                }
                .padding(effectivePadding)
            }
        }
        .background(tokenFillColor)
        .overlay(borderOverlay)
        .accessibilityElement(children: .contain)
    }

    // MARK: - Layout

    @ViewBuilder
    private func layoutContent() -> some View {
        // Start slot
        if let start = start {
            start()
        }

        // Default slot (after start)
        if let content = content {
            content()
        }

        // Center slot
        if let center = center {
            Spacer()
            center()
            Spacer()
        } else if end != nil {
            // Push end content to the end if no center
            Spacer()
        }

        // End slot
        if let end = end {
            end()
        }
    }

    @ViewBuilder
    private var borderOverlay: some View {
        GeometryReader { geometry in
            ZStack {
                // Top border
                if border == .start || border == .both || border == .all {
                    Rectangle()
                        .fill(tokenBorderColor)
                        .frame(height: ToolbarComponentTokens.border_width)
                        .frame(maxWidth: .infinity)
                        .position(x: geometry.size.width / 2, y: 0)
                }

                // Bottom border
                if border == .end || border == .both || border == .all {
                    Rectangle()
                        .fill(tokenBorderColor)
                        .frame(height: ToolbarComponentTokens.border_width)
                        .frame(maxWidth: .infinity)
                        .position(x: geometry.size.width / 2, y: geometry.size.height)
                }

                // Leading border (for column direction or all)
                if border == .all && direction == .column {
                    Rectangle()
                        .fill(tokenBorderColor)
                        .frame(width: ToolbarComponentTokens.border_width)
                        .frame(maxHeight: .infinity)
                        .position(x: 0, y: geometry.size.height / 2)
                }

                // Trailing border (for column direction or all)
                if border == .all && direction == .column {
                    Rectangle()
                        .fill(tokenBorderColor)
                        .frame(width: ToolbarComponentTokens.border_width)
                        .frame(maxHeight: .infinity)
                        .position(x: geometry.size.width, y: geometry.size.height / 2)
                }
            }
        }
    }

    // MARK: - Token Accessors

    private var effectiveGap: CGFloat {
        gap ?? ToolbarComponentTokens.gap
    }

    private var effectivePadding: CGFloat {
        padding ?? ToolbarComponentTokens.padding
    }

    private var tokenFillColor: Color {
        switch layer {
        case .ground: return ToolbarComponentTokens.fill_default
        case .elevated: return ToolbarComponentTokens.fill_elevated
        case .overlay: return ToolbarComponentTokens.fill_overlay
        case .sunken: return ToolbarComponentTokens.fill_sunken
        }
    }

    private var tokenBorderColor: Color {
        switch layer {
        case .ground: return ToolbarComponentTokens.border_color_default
        case .elevated: return ToolbarComponentTokens.border_color_elevated
        case .overlay: return ToolbarComponentTokens.border_color_overlay
        case .sunken: return ToolbarComponentTokens.border_color_sunken
        }
    }
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension ElevateToolbar where Content == EmptyView {
    /// Creates a toolbar without default slot content
    public init(
        layer: ToolbarLayer = .ground,
        border: ToolbarBorder = .start,
        direction: ToolbarDirection = .row,
        gap: CGFloat? = nil,
        padding: CGFloat? = nil,
        @ViewBuilder start: @escaping () -> Start,
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder end: @escaping () -> End
    ) {
        self.layer = layer
        self.border = border
        self.direction = direction
        self.gap = gap
        self.padding = padding
        self.start = start
        self.center = center
        self.end = end
        self.content = nil
    }
}

@available(iOS 15, *)
extension ElevateToolbar where Center == EmptyView, Content == EmptyView {
    /// Creates a toolbar with only start and end slots
    public init(
        layer: ToolbarLayer = .ground,
        border: ToolbarBorder = .start,
        direction: ToolbarDirection = .row,
        gap: CGFloat? = nil,
        padding: CGFloat? = nil,
        @ViewBuilder start: @escaping () -> Start,
        @ViewBuilder end: @escaping () -> End
    ) {
        self.layer = layer
        self.border = border
        self.direction = direction
        self.gap = gap
        self.padding = padding
        self.start = start
        self.center = nil
        self.end = end
        self.content = nil
    }
}

@available(iOS 15, *)
extension ElevateToolbar where Start == EmptyView, Center == EmptyView, End == EmptyView {
    /// Creates a simple toolbar with only default content
    public init(
        layer: ToolbarLayer = .ground,
        border: ToolbarBorder = .start,
        direction: ToolbarDirection = .row,
        gap: CGFloat? = nil,
        padding: CGFloat? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.layer = layer
        self.border = border
        self.direction = direction
        self.gap = gap
        self.padding = padding
        self.start = nil
        self.center = nil
        self.end = nil
        self.content = content
    }
}

@available(iOS 15, *)
extension ElevateToolbar where Start == EmptyView, Content == EmptyView {
    /// Creates a toolbar with only center and end slots
    public init(
        layer: ToolbarLayer = .ground,
        border: ToolbarBorder = .start,
        direction: ToolbarDirection = .row,
        gap: CGFloat? = nil,
        padding: CGFloat? = nil,
        @ViewBuilder center: @escaping () -> Center,
        @ViewBuilder end: @escaping () -> End
    ) {
        self.layer = layer
        self.border = border
        self.direction = direction
        self.gap = gap
        self.padding = padding
        self.start = nil
        self.center = center
        self.end = end
        self.content = nil
    }
}

// MARK: - Toolbar Layer

@available(iOS 15, *)
public enum ToolbarLayer {
    case ground      // Default background
    case elevated    // Slightly raised
    case overlay     // Above content
    case sunken      // Recessed appearance
}

// MARK: - Toolbar Border

@available(iOS 15, *)
public enum ToolbarBorder {
    case none        // No border
    case start       // Top border (default)
    case end         // Bottom border
    case both        // Top and bottom borders
    case all         // All borders
}

// MARK: - Toolbar Direction

@available(iOS 15, *)
public enum ToolbarDirection {
    case row         // Horizontal layout (default)
    case column      // Vertical layout
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateToolbar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Toolbar
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Toolbar").font(.headline)

                    ElevateToolbar(
                        start: {
                            Text("Title").font(.headline)
                        },
                        end: {
                            HStack {
                                Button(action: {}) {
                                    Image(systemName: "square.and.arrow.up")
                                }
                                Button(action: {}) {
                                    Image(systemName: "ellipsis")
                                }
                            }
                        }
                    )
                }

                Divider()

                // With Center Content
                VStack(alignment: .leading, spacing: 16) {
                    Text("With Center Content").font(.headline)

                    ElevateToolbar(
                        start: {
                            Button(action: {}) {
                                Image(systemName: "chevron.left")
                            }
                        },
                        center: {
                            Text("Page Title").font(.headline)
                        },
                        end: {
                            Button(action: {}) {
                                Image(systemName: "gear")
                            }
                        }
                    )
                }

                Divider()

                // Different Layers
                VStack(alignment: .leading, spacing: 16) {
                    Text("Layer Variants").font(.headline)

                    VStack(spacing: 12) {
                        ElevateToolbar(layer: .ground) {
                            Text("Ground Layer")
                        }

                        ElevateToolbar(layer: .elevated) {
                            Text("Elevated Layer")
                        }

                        ElevateToolbar(layer: .overlay) {
                            Text("Overlay Layer")
                        }

                        ElevateToolbar(layer: .sunken) {
                            Text("Sunken Layer")
                        }
                    }
                }

                Divider()

                // Border Variants
                VStack(alignment: .leading, spacing: 16) {
                    Text("Border Variants").font(.headline)

                    VStack(spacing: 12) {
                        ElevateToolbar(border: .none) {
                            Text("No Border")
                        }

                        ElevateToolbar(border: .start) {
                            Text("Start Border (Top)")
                        }

                        ElevateToolbar(border: .end) {
                            Text("End Border (Bottom)")
                        }

                        ElevateToolbar(border: .both) {
                            Text("Both Borders")
                        }

                        ElevateToolbar(border: .all) {
                            Text("All Borders")
                        }
                    }
                }

                Divider()

                // Vertical Direction
                VStack(alignment: .leading, spacing: 16) {
                    Text("Vertical Toolbar").font(.headline)

                    ElevateToolbar(
                        direction: .column,
                        start: {
                            Button("Home") {}
                        },
                        center: {
                            Divider()
                        },
                        end: {
                            Button("Settings") {}
                        }
                    )
                    .frame(width: 200)
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Use Cases").font(.headline)

                    VStack(spacing: 12) {
                        // Navigation bar
                        ElevateToolbar(
                            layer: .elevated,
                            border: .end,
                            start: {
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "line.3.horizontal")
                                    }
                                    Text("App Title").font(.headline)
                                }
                            },
                            end: {
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "magnifyingglass")
                                    }
                                    Button(action: {}) {
                                        Image(systemName: "person.circle")
                                    }
                                }
                            }
                        )

                        // Editor toolbar
                        ElevateToolbar(
                            border: .both,
                            start: {
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "bold")
                                    }
                                    Button(action: {}) {
                                        Image(systemName: "italic")
                                    }
                                    Button(action: {}) {
                                        Image(systemName: "underline")
                                    }
                                }
                            },
                            end: {
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "link")
                                    }
                                    Button(action: {}) {
                                        Image(systemName: "photo")
                                    }
                                }
                            }
                        )

                        // Bottom action bar
                        ElevateToolbar(
                            layer: .sunken,
                            border: .start,
                            start: {
                                Text("3 items selected")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            },
                            end: {
                                HStack {
                                    Button("Delete") {}
                                        .foregroundColor(.red)
                                    Button("Share") {}
                                }
                            }
                        )

                        // Context actions
                        ElevateToolbar(
                            center: {
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "arrow.uturn.backward")
                                    }
                                    Button(action: {}) {
                                        Image(systemName: "arrow.uturn.forward")
                                    }
                                }
                            },
                            end: {
                                Button("Done") {}
                            }
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
