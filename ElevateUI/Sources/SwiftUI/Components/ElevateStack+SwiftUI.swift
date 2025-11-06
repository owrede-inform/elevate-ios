#if os(iOS)
import SwiftUI

/// ELEVATE Stack Component
///
/// A container for stacking child elements with flexible layout options.
/// Provides consistent spacing using ELEVATE design tokens.
///
/// **Web Component:** `<elvt-stack>`
/// **API Reference:** `.claude/components/Structure/stack.md`
@available(iOS 15, *)
public struct ElevateStack<Content: View>: View {

    // MARK: - Properties

    /// The direction of the stack
    private let direction: StackDirection

    /// The alignment of items
    private let alignment: StackAlignment

    /// The spacing between items
    private let spacing: StackSpacing

    /// The padding around the stack
    private let padding: StackSpacing?

    /// Whether to allow wrapping (iOS 16+ only with Layout API)
    private let wrap: Bool

    /// The content of the stack
    private let content: () -> Content

    // MARK: - Initializer

    /// Creates a stack with the specified configuration
    ///
    /// - Parameters:
    ///   - direction: Layout direction (default: .column)
    ///   - alignment: Item alignment (default: .leading for column, .center for row)
    ///   - spacing: Spacing between items (default: .s)
    ///   - padding: Padding around stack (default: nil)
    ///   - wrap: Allow wrapping to next line (default: false)
    ///   - content: The content to display
    public init(
        direction: StackDirection = .column,
        alignment: StackAlignment = .leading,
        spacing: StackSpacing = .s,
        padding: StackSpacing? = nil,
        wrap: Bool = false,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.direction = direction
        self.alignment = alignment
        self.spacing = spacing
        self.padding = padding
        self.wrap = wrap
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        Group {
            switch direction {
            case .row:
                HStack(alignment: verticalAlignment, spacing: spacingValue) {
                    content()
                }
            case .column:
                VStack(alignment: horizontalAlignment, spacing: spacingValue) {
                    content()
                }
            case .rowReverse:
                HStack(alignment: verticalAlignment, spacing: spacingValue) {
                    content()
                }
                .environment(\.layoutDirection, .rightToLeft)
            case .columnReverse:
                VStack(alignment: horizontalAlignment, spacing: spacingValue) {
                    content()
                }
                .rotationEffect(.degrees(180))
                .scaleEffect(x: 1, y: -1)
            }
        }
        .padding(paddingValue)
        .accessibilityElement(children: .contain)
    }

    // MARK: - Helpers

    private var spacingValue: CGFloat {
        spacing.value
    }

    private var paddingValue: EdgeInsets {
        guard let padding = padding else {
            return EdgeInsets()
        }
        let value = padding.value
        return EdgeInsets(top: value, leading: value, bottom: value, trailing: value)
    }

    private var horizontalAlignment: HorizontalAlignment {
        switch alignment {
        case .leading: return .leading
        case .center: return .center
        case .trailing: return .trailing
        case .stretch: return .leading // VStack doesn't have stretch
        }
    }

    private var verticalAlignment: VerticalAlignment {
        switch alignment {
        case .leading: return .top
        case .center: return .center
        case .trailing: return .bottom
        case .stretch: return .center // HStack doesn't have stretch
        }
    }
}

// MARK: - Stack Direction

@available(iOS 15, *)
public enum StackDirection {
    case row           // Horizontal left to right
    case column        // Vertical top to bottom
    case rowReverse    // Horizontal right to left
    case columnReverse // Vertical bottom to top
}

// MARK: - Stack Alignment

@available(iOS 15, *)
public enum StackAlignment {
    case leading       // Start of cross axis
    case center        // Center of cross axis
    case trailing      // End of cross axis
    case stretch       // Full width/height (limited support in SwiftUI)
}

// MARK: - Stack Spacing

@available(iOS 15, *)
public enum StackSpacing {
    case xxs   // 2pt
    case xs    // 4pt
    case s     // 8pt
    case m     // 16pt
    case l     // 24pt
    case xl    // 32pt
    case custom(CGFloat)

    var value: CGFloat {
        switch self {
        case .xxs: return ElevateSpacing.xxs
        case .xs: return ElevateSpacing.xs
        case .s: return ElevateSpacing.s
        case .m: return ElevateSpacing.m
        case .l: return ElevateSpacing.l
        case .xl: return ElevateSpacing.xl
        case .custom(let value): return value
        }
    }
}

// MARK: - Convenience Initializers

@available(iOS 15, *)
extension ElevateStack {
    /// Creates a vertical stack (column)
    public static func vertical(
        alignment: StackAlignment = .leading,
        spacing: StackSpacing = .s,
        padding: StackSpacing? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> ElevateStack {
        ElevateStack(
            direction: .column,
            alignment: alignment,
            spacing: spacing,
            padding: padding,
            content: content
        )
    }

    /// Creates a horizontal stack (row)
    public static func horizontal(
        alignment: StackAlignment = .center,
        spacing: StackSpacing = .s,
        padding: StackSpacing? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> ElevateStack {
        ElevateStack(
            direction: .row,
            alignment: alignment,
            spacing: spacing,
            padding: padding,
            content: content
        )
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateStack_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Vertical Stack
                VStack(alignment: .leading, spacing: 16) {
                    Text("Vertical Stack (Column)").font(.headline)

                    ElevateStack.vertical(spacing: .m) {
                        Text("Item 1")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                        Text("Item 2")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                        Text("Item 3")
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                    }
                }

                Divider()

                // Horizontal Stack
                VStack(alignment: .leading, spacing: 16) {
                    Text("Horizontal Stack (Row)").font(.headline)

                    ElevateStack.horizontal(spacing: .m) {
                        Text("Item 1")
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)
                        Text("Item 2")
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)
                        Text("Item 3")
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(8)
                    }
                }

                Divider()

                // Spacing Variants
                VStack(alignment: .leading, spacing: 16) {
                    Text("Spacing Variants").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("XXS Spacing (2pt)")
                            .font(.caption)
                        ElevateStack.horizontal(spacing: .xxs) {
                            Circle().fill(Color.red).frame(width: 20, height: 20)
                            Circle().fill(Color.red).frame(width: 20, height: 20)
                            Circle().fill(Color.red).frame(width: 20, height: 20)
                        }

                        Text("Small Spacing (8pt)")
                            .font(.caption)
                        ElevateStack.horizontal(spacing: .s) {
                            Circle().fill(Color.orange).frame(width: 20, height: 20)
                            Circle().fill(Color.orange).frame(width: 20, height: 20)
                            Circle().fill(Color.orange).frame(width: 20, height: 20)
                        }

                        Text("Medium Spacing (16pt)")
                            .font(.caption)
                        ElevateStack.horizontal(spacing: .m) {
                            Circle().fill(Color.blue).frame(width: 20, height: 20)
                            Circle().fill(Color.blue).frame(width: 20, height: 20)
                            Circle().fill(Color.blue).frame(width: 20, height: 20)
                        }

                        Text("Large Spacing (24pt)")
                            .font(.caption)
                        ElevateStack.horizontal(spacing: .l) {
                            Circle().fill(Color.green).frame(width: 20, height: 20)
                            Circle().fill(Color.green).frame(width: 20, height: 20)
                            Circle().fill(Color.green).frame(width: 20, height: 20)
                        }
                    }
                }

                Divider()

                // Alignment Variants
                VStack(alignment: .leading, spacing: 16) {
                    Text("Alignment Variants").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Leading Alignment")
                            .font(.caption)
                        ElevateStack.vertical(alignment: .leading, spacing: .s) {
                            Text("Short")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                            Text("Medium Text")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                            Text("Longer Text Item")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Center Alignment")
                            .font(.caption)
                        ElevateStack.vertical(alignment: .center, spacing: .s) {
                            Text("Short")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                            Text("Medium Text")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                            Text("Longer Text Item")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                        }
                        .frame(maxWidth: .infinity)

                        Text("Trailing Alignment")
                            .font(.caption)
                        ElevateStack.vertical(alignment: .trailing, spacing: .s) {
                            Text("Short")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                            Text("Medium Text")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                            Text("Longer Text Item")
                                .padding(8)
                                .background(Color.purple.opacity(0.2))
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }

                Divider()

                // With Padding
                VStack(alignment: .leading, spacing: 16) {
                    Text("With Padding").font(.headline)

                    ElevateStack.vertical(spacing: .m, padding: .l) {
                        Text("Item 1")
                        Text("Item 2")
                        Text("Item 3")
                    }
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Use Cases").font(.headline)

                    // Form layout
                    ElevateStack.vertical(spacing: .l) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Email").font(.caption)
                            TextField("email@example.com", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Password").font(.caption)
                            SecureField("Password", text: .constant(""))
                                .textFieldStyle(.roundedBorder)
                        }

                        ElevateStack.horizontal(spacing: .m) {
                            Button("Cancel") {}
                                .buttonStyle(.bordered)
                            Button("Sign In") {}
                                .buttonStyle(.borderedProminent)
                        }
                    }

                    // Card stack
                    ElevateStack.vertical(spacing: .m) {
                        ForEach(0..<3) { index in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Card \(index + 1)")
                                        .font(.headline)
                                    Text("Description text")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)

                    // Icon toolbar
                    ElevateStack.horizontal(spacing: .l) {
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.up")
                        }
                        Button(action: {}) {
                            Image(systemName: "heart")
                        }
                        Button(action: {}) {
                            Image(systemName: "bookmark")
                        }
                        Button(action: {}) {
                            Image(systemName: "ellipsis")
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}
#endif

#endif
