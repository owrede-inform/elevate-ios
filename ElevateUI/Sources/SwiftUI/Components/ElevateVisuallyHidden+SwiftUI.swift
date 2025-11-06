#if os(iOS)
import SwiftUI

/// ELEVATE Visually Hidden Component
///
/// Makes content accessible to assistive devices without displaying it on the screen.
/// If an element inside has the focus, the component will be visible.
///
/// **Web Component:** `<elvt-visually-hidden>`
/// **API Reference:** `.claude/components/Display/visually-hidden.md`
@available(iOS 15, *)
public struct ElevateVisuallyHidden<Content: View>: View {

    // MARK: - Properties

    /// The content that should be hidden visually but accessible
    private let content: () -> Content

    // MARK: - State

    @FocusState private var isFocused: Bool

    // MARK: - Initializer

    /// Creates a visually hidden component
    ///
    /// - Parameter content: Content that should be visually hidden but accessible to screen readers
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        if #available(iOS 17.0, *) {
            content()
                .opacity(isFocused ? 1.0 : 0.0)
                .frame(width: isFocused ? nil : 0.01, height: isFocused ? nil : 0.01)
                .clipped()
                .accessibilityHidden(false)
                .focusable()
                .focused($isFocused)
        } else {
            content()
                .opacity(isFocused ? 1.0 : 0.0)
                .frame(width: isFocused ? nil : 0.01, height: isFocused ? nil : 0.01)
                .clipped()
                .accessibilityHidden(false)
                .focused($isFocused)
        }
    }
}

// MARK: - View Extension

@available(iOS 15, *)
extension View {
    /// Makes this view visually hidden but accessible to screen readers
    ///
    /// - Returns: A visually hidden version of this view
    public func elevateVisuallyHidden() -> some View {
        ElevateVisuallyHidden {
            self
        }
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateVisuallyHidden_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Usage
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Usage").font(.headline)

                    Text("The text below is visually hidden but accessible to screen readers:")

                    ElevateVisuallyHidden {
                        Text("This text is hidden from sight but accessible to assistive technologies")
                    }

                    Text("(Hidden text is above this line)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Skip Navigation Link
                VStack(alignment: .leading, spacing: 16) {
                    Text("Skip Navigation Link").font(.headline)

                    ElevateVisuallyHidden {
                        Button("Skip to main content") {
                            print("Navigating to main content")
                        }
                    }

                    Text("Screen reader users can use the skip link above to bypass navigation")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Form Label
                VStack(alignment: .leading, spacing: 16) {
                    Text("Hidden Form Labels").font(.headline)

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)

                        TextField("", text: .constant(""))
                            .textFieldStyle(.roundedBorder)

                        ElevateVisuallyHidden {
                            Text("Search query")
                        }
                    }

                    Text("The 'Search query' label is hidden but accessible")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Icon Button Context
                VStack(alignment: .leading, spacing: 16) {
                    Text("Icon Button Context").font(.headline)

                    HStack(spacing: 16) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "gear")
                                ElevateVisuallyHidden {
                                    Text("Open settings")
                                }
                            }
                        }

                        Button(action: {}) {
                            HStack {
                                Image(systemName: "trash")
                                ElevateVisuallyHidden {
                                    Text("Delete item")
                                }
                            }
                        }

                        Button(action: {}) {
                            HStack {
                                Image(systemName: "square.and.arrow.up")
                                ElevateVisuallyHidden {
                                    Text("Share content")
                                }
                            }
                        }
                    }

                    Text("Icons have hidden labels for screen readers")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Additional Context
                VStack(alignment: .leading, spacing: 16) {
                    Text("Additional Context").font(.headline)

                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Items: 42")
                            ElevateVisuallyHidden {
                                Text("total items in the list")
                            }
                        }

                        HStack {
                            Text("Updated 2h ago")
                            ElevateVisuallyHidden {
                                Text("last update was 2 hours ago")
                            }
                        }

                        HStack {
                            Text("★★★★☆")
                            ElevateVisuallyHidden {
                                Text("4 out of 5 stars")
                            }
                        }
                    }

                    Text("Additional context is provided for screen readers")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Using View Extension
                VStack(alignment: .leading, spacing: 16) {
                    Text("Using View Extension").font(.headline)

                    Text("Hidden via extension modifier")
                        .elevateVisuallyHidden()

                    Text("(Hidden text is above using .elevateVisuallyHidden())")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Divider()

                // Focus Behavior
                VStack(alignment: .leading, spacing: 16) {
                    Text("Focus Behavior").font(.headline)

                    Text("When a hidden element receives focus, it becomes visible:")

                    ElevateVisuallyHidden {
                        Button("I become visible when focused") {
                            print("Button tapped")
                        }
                    }

                    Text("Try tabbing through the page to see the button appear")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}
#endif

#endif
