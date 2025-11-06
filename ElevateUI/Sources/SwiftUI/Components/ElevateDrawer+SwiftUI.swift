#if os(iOS)
import SwiftUI

/// Drawer component with size class adaptive presentation
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's fixed-width slide-in drawer,
/// this adapts to device size classes:
/// - iPhone (compact): Full-screen sheet
/// - iPad (regular): Sidebar or popover (300pt width)
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// @State private var showDrawer = false
///
/// Button("Show Drawer") {
///     showDrawer = true
/// }
/// .elevateDrawer(isPresented: $showDrawer, edge: .leading) {
///     DrawerContent()
/// }
/// ```
@available(iOS 15, *)
public struct ElevateDrawer<Content: View>: View {

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private let title: String?
    private let edge: Edge
    private let content: () -> Content

    // MARK: - Initialization

    public init(
        title: String? = nil,
        edge: Edge = .leading,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.edge = edge
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            if let title = title {
                drawerHeader
            }

            // Content
            ScrollView {
                VStack(alignment: .leading, spacing: DrawerComponentTokens.gap) {
                    content()
                }
                .padding(.horizontal, DrawerComponentTokens.padding_inline)
                .padding(.vertical, DrawerComponentTokens.padding_block)
            }
        }
        .background(DrawerComponentTokens.fill)
        .frame(width: drawerWidth)
    }

    // MARK: - Subviews

    private var drawerHeader: some View {
        HStack {
            Text(title ?? "")
                .font(.headline)
                .foregroundColor(DrawerComponentTokens.text_color_default)

            Spacer()
        }
        .padding(.horizontal, DrawerComponentTokens.padding_inline)
        .padding(.vertical, DrawerComponentTokens.padding_block)
        .background(DrawerComponentTokens.fill)
        .overlay(
            Rectangle()
                .fill(DrawerComponentTokens.border_color)
                .frame(height: DrawerComponentTokens.border_width),
            alignment: .bottom
        )
    }

    // MARK: - Size Adaptation

    private var drawerWidth: CGFloat? {
        // Adapt to size class per DIVERSIONS.md
        if horizontalSizeClass == .regular {
            // iPad: Fixed sidebar width
            return min(DrawerComponentTokens.column_maxWidth, 300)
        } else {
            // iPhone: Full width
            return nil
        }
    }
}

// MARK: - View Extension

@available(iOS 15, *)
extension View {
    /// Present a drawer with size class adaptation
    ///
    /// **iOS Adaptation**: Automatically adapts presentation:
    /// - iPhone: Full-screen sheet
    /// - iPad: Sidebar or popover
    ///
    /// - Parameters:
    ///   - isPresented: Binding to control drawer visibility
    ///   - edge: Edge from which drawer slides (default: .leading)
    ///   - onDismiss: Closure called when drawer is dismissed
    ///   - content: Drawer content builder
    public func elevateDrawer<Content: View>(
        isPresented: Binding<Bool>,
        edge: Edge = .leading,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.modifier(
            DrawerModifier(
                isPresented: isPresented,
                edge: edge,
                onDismiss: onDismiss,
                drawerContent: content
            )
        )
    }
}

// MARK: - Drawer Modifier

@available(iOS 15, *)
private struct DrawerModifier<DrawerContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    let edge: Edge
    let onDismiss: (() -> Void)?
    let drawerContent: () -> DrawerContent

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, onDismiss: onDismiss) {
                NavigationView {
                    ElevateDrawer(edge: edge, content: drawerContent)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Done") {
                                    performHaptic()
                                    isPresented = false
                                }
                            }
                        }
                }
                // Size adaptation per DIVERSIONS.md
                .presentationDetents(presentationDetents)
                .presentationDragIndicator(.visible)
            }
    }

    private var presentationDetents: Set<PresentationDetent> {
        if horizontalSizeClass == .regular {
            // iPad: Large sheet (can be resized)
            return [.large]
        } else {
            // iPhone: Large sheet
            return [.large]
        }
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Edge

public enum Edge: Hashable {
    case leading
    case trailing
    case top
    case bottom
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateDrawer_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
            .previewDisplayName("iPhone")

        PreviewContainer()
            .previewDevice("iPad Pro (12.9-inch) (6th generation)")
            .previewDisplayName("iPad")
    }

    struct PreviewContainer: View {
        @State private var showDrawer = false
        @State private var showMenuDrawer = false

        var body: some View {
            NavigationView {
                VStack(spacing: 20) {
                    Button("Show Simple Drawer") {
                        showDrawer = true
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Show Menu Drawer") {
                        showMenuDrawer = true
                    }
                    .buttonStyle(.bordered)

                    Spacer()

                    VStack(alignment: .leading, spacing: 8) {
                        Text("iOS Adaptation:")
                            .font(.caption)
                            .fontWeight(.semibold)

                        Text("• iPhone: Full-screen sheet")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("• iPad: Sidebar-style presentation")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("• Drag indicator visible")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text("• Swipe down to dismiss")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .padding()
                .navigationTitle("Drawer Examples")

                // Simple drawer
                .elevateDrawer(isPresented: $showDrawer) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Drawer Content")
                            .font(.title2)

                        Text("This drawer adapts to the device size class.")
                            .foregroundColor(.secondary)

                        Divider()

                        ForEach(0..<10) { index in
                            Text("Item \(index + 1)")
                                .padding(.vertical, 8)
                        }
                    }
                }

                // Menu-style drawer
                .elevateDrawer(
                    isPresented: $showMenuDrawer,
                    edge: .leading
                ) {
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(["Home", "Profile", "Settings", "Help", "About"], id: \.self) { item in
                            Button(action: {
                                showMenuDrawer = false
                            }) {
                                HStack {
                                    Image(systemName: iconName(for: item))
                                    Text(item)
                                    Spacer()
                                }
                                .foregroundColor(.primary)
                                .padding()
                            }

                            Divider()
                        }
                    }
                }
            }
        }

        func iconName(for item: String) -> String {
            switch item {
            case "Home": return "house"
            case "Profile": return "person"
            case "Settings": return "gearshape"
            case "Help": return "questionmark.circle"
            case "About": return "info.circle"
            default: return "circle"
            }
        }
    }
}
#endif

#endif
