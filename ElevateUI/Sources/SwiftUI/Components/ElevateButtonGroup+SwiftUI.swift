#if os(iOS)
import SwiftUI

/// ELEVATE Button Group Component
///
/// Groups related buttons together with connected styling.
/// Automatically handles corner radius masking for first, middle, and last buttons.
///
/// **Web Component:** `<elvt-button-group>`
/// **API Reference:** `.claude/components/Navigation/button-group.md`
@available(iOS 15, *)
public struct ElevateButtonGroup<Content: View>: View {

    // MARK: - Properties

    /// Accessibility label for the group
    private let label: String

    /// The buttons to display
    private let content: () -> Content

    // MARK: - Initializer

    /// Creates a button group
    ///
    /// - Parameters:
    ///   - label: Accessibility label for the group
    ///   - content: The buttons to display
    public init(
        label: String = "Button group",
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.label = label
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        HStack(spacing: 0) {
            content()
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(label)
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateButtonGroup_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Button Group
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Button Group").font(.headline)

                    ElevateButtonGroup(label: "Text alignment") {
                        Button("Left") {}
                            .buttonStyle(.bordered)
                        Button("Center") {}
                            .buttonStyle(.bordered)
                        Button("Right") {}
                            .buttonStyle(.bordered)
                    }
                }

                Divider()

                // With Icons
                VStack(alignment: .leading, spacing: 16) {
                    Text("Icon Buttons").font(.headline)

                    ElevateButtonGroup(label: "Text formatting") {
                        Button(action: {}) {
                            Image(systemName: "bold")
                        }
                        .buttonStyle(.bordered)

                        Button(action: {}) {
                            Image(systemName: "italic")
                        }
                        .buttonStyle(.bordered)

                        Button(action: {}) {
                            Image(systemName: "underline")
                        }
                        .buttonStyle(.bordered)
                    }
                }

                Divider()

                // Different Styles
                VStack(alignment: .leading, spacing: 16) {
                    Text("Button Styles").font(.headline)

                    VStack(spacing: 12) {
                        ElevateButtonGroup(label: "Bordered buttons") {
                            Button("Option 1") {}
                                .buttonStyle(.bordered)
                            Button("Option 2") {}
                                .buttonStyle(.bordered)
                            Button("Option 3") {}
                                .buttonStyle(.bordered)
                        }

                        ElevateButtonGroup(label: "Filled buttons") {
                            Button("Save") {}
                                .buttonStyle(.borderedProminent)
                            Button("Cancel") {}
                                .buttonStyle(.bordered)
                        }
                    }
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Use Cases").font(.headline)

                    VStack(alignment: .leading, spacing: 16) {
                        // Segmented control style
                        VStack(alignment: .leading, spacing: 8) {
                            Text("View Mode").font(.caption).foregroundColor(.secondary)
                            ElevateButtonGroup(label: "View mode selector") {
                                Button(action: {}) {
                                    Image(systemName: "square.grid.2x2")
                                }
                                .buttonStyle(.bordered)

                                Button(action: {}) {
                                    Image(systemName: "list.bullet")
                                }
                                .buttonStyle(.borderedProminent)

                                Button(action: {}) {
                                    Image(systemName: "rectangle.grid.1x2")
                                }
                                .buttonStyle(.bordered)
                            }
                        }

                        // Zoom controls
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Zoom Controls").font(.caption).foregroundColor(.secondary)
                            ElevateButtonGroup(label: "Zoom controls") {
                                Button(action: {}) {
                                    Image(systemName: "minus")
                                }
                                .buttonStyle(.bordered)

                                Button("100%") {}
                                    .buttonStyle(.bordered)

                                Button(action: {}) {
                                    Image(systemName: "plus")
                                }
                                .buttonStyle(.bordered)
                            }
                        }

                        // Pagination
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Pagination").font(.caption).foregroundColor(.secondary)
                            ElevateButtonGroup(label: "Page navigation") {
                                Button(action: {}) {
                                    Image(systemName: "chevron.left")
                                }
                                .buttonStyle(.bordered)

                                Button("1") {}
                                    .buttonStyle(.borderedProminent)

                                Button("2") {}
                                    .buttonStyle(.bordered)

                                Button("3") {}
                                    .buttonStyle(.bordered)

                                Button(action: {}) {
                                    Image(systemName: "chevron.right")
                                }
                                .buttonStyle(.bordered)
                            }
                        }

                        // Text alignment
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Text Alignment").font(.caption).foregroundColor(.secondary)
                            ElevateButtonGroup(label: "Text alignment") {
                                Button(action: {}) {
                                    Image(systemName: "text.alignleft")
                                }
                                .buttonStyle(.borderedProminent)

                                Button(action: {}) {
                                    Image(systemName: "text.aligncenter")
                                }
                                .buttonStyle(.bordered)

                                Button(action: {}) {
                                    Image(systemName: "text.alignright")
                                }
                                .buttonStyle(.bordered)

                                Button(action: {}) {
                                    Image(systemName: "text.justify")
                                }
                                .buttonStyle(.bordered)
                            }
                        }

                        // Media controls
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Media Controls").font(.caption).foregroundColor(.secondary)
                            ElevateButtonGroup(label: "Media controls") {
                                Button(action: {}) {
                                    Image(systemName: "backward.fill")
                                }
                                .buttonStyle(.bordered)

                                Button(action: {}) {
                                    Image(systemName: "play.fill")
                                }
                                .buttonStyle(.borderedProminent)

                                Button(action: {}) {
                                    Image(systemName: "forward.fill")
                                }
                                .buttonStyle(.bordered)
                            }
                        }

                        // Filter options
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Filter Options").font(.caption).foregroundColor(.secondary)
                            ElevateButtonGroup(label: "Filter by category") {
                                Button("All") {}
                                    .buttonStyle(.borderedProminent)
                                Button("Active") {}
                                    .buttonStyle(.bordered)
                                Button("Completed") {}
                                    .buttonStyle(.bordered)
                                Button("Archived") {}
                                    .buttonStyle(.bordered)
                            }
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
