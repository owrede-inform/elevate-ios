#if os(iOS)
import SwiftUI

/// ELEVATE Breadcrumb Component for SwiftUI
///
/// A navigation breadcrumb trail showing the current page's location within a hierarchy.
/// Automatically adds separators between items.
///
/// # Usage
/// ```swift
/// ElevateBreadcrumb {
///     ElevateBreadcrumbItem("Home") {
///         // Navigate to home
///     }
///     ElevateBreadcrumbItem("Products") {
///         // Navigate to products
///     }
///     ElevateBreadcrumbItem("Electronics", isCurrentPage: true)
/// }
///
/// // With array of items
/// let items = ["Home", "Catalog", "Electronics", "Laptops"]
/// ElevateBreadcrumb(items: items, currentIndex: 3) { index in
///     // Navigate to item at index
/// }
/// ```
///
/// # iOS Adaptations
/// - Horizontal scrolling for long breadcrumb trails
/// - Scroll-friendly item interactions
/// - Automatic separator insertion
/// - Dynamic text support
/// - VoiceOver navigation support
///
/// # Design Tokens
/// Uses manually defined breadcrumb tokens from ELEVATE design system.
@available(iOS 15, *)
public struct ElevateBreadcrumb<Content: View>: View {

    // MARK: - Properties

    private let size: BreadcrumbTokens.Size
    private let content: Content

    // MARK: - Computed Properties

    private var sizeConfig: BreadcrumbTokens.SizeConfig {
        size.config
    }

    // MARK: - Initializer

    /// Creates a breadcrumb with custom content
    /// - Parameters:
    ///   - size: The size variant
    ///   - content: The breadcrumb items
    public init(
        size: BreadcrumbTokens.Size = .medium,
        @ViewBuilder content: () -> Content
    ) {
        self.size = size
        self.content = content()
    }

    // MARK: - Body

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: sizeConfig.gap) {
                content
            }
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Breadcrumb navigation")
    }
}

// MARK: - Array-Based Initializer

@available(iOS 15, *)
extension ElevateBreadcrumb where Content == AnyView {

    /// Creates a breadcrumb from an array of item labels
    /// - Parameters:
    ///   - items: Array of breadcrumb labels
    ///   - currentIndex: Index of the current page (last item is current by default)
    ///   - size: The size variant
    ///   - onItemTap: Closure called when an item is tapped with its index
    public init(
        items: [String],
        currentIndex: Int? = nil,
        size: BreadcrumbTokens.Size = .medium,
        onItemTap: @escaping (Int) -> Void
    ) {
        self.size = size
        let currentIdx = currentIndex ?? items.count - 1

        self.content = AnyView(
            ForEach(Array(items.enumerated()), id: \.offset) { index, label in
                HStack(spacing: 0) {
                    ElevateBreadcrumbItem(
                        label,
                        isCurrentPage: index == currentIdx,
                        size: size
                    ) {
                        onItemTap(index)
                    }

                    // Add separator if not last item
                    if index < items.count - 1 {
                        Image(systemName: "chevron.right")
                            .font(.system(size: Self.separatorSize(for: size)))
                            .foregroundColor(BreadcrumbTokens.separatorColor)
                            .padding(.horizontal, size.config.gap / 2)
                    }
                }
            }
        )
    }

    private static func separatorSize(for size: BreadcrumbTokens.Size) -> CGFloat {
        switch size {
        case .small: return 10.0
        case .medium: return 12.0
        case .large: return 14.0
        }
    }
}

// MARK: - Helper for Manual Separator Insertion

/// A breadcrumb separator view
@available(iOS 15, *)
public struct ElevateBreadcrumbSeparator: View {
    private let size: BreadcrumbTokens.Size

    public init(size: BreadcrumbTokens.Size = .medium) {
        self.size = size
    }

    public var body: some View {
        Image(systemName: "chevron.right")
            .font(.system(size: separatorSize))
            .foregroundColor(BreadcrumbTokens.separatorColor)
    }

    private var separatorSize: CGFloat {
        switch size {
        case .small: return 10.0
        case .medium: return 12.0
        case .large: return 14.0
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateBreadcrumb_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Manual Content
            VStack(spacing: 24) {
                Text("Manual Content").font(.headline)

                ElevateBreadcrumb {
                    ElevateBreadcrumbItem("Home") {
                        print("Navigate to Home")
                    }
                    ElevateBreadcrumbSeparator()
                    ElevateBreadcrumbItem("Products") {
                        print("Navigate to Products")
                    }
                    ElevateBreadcrumbSeparator()
                    ElevateBreadcrumbItem("Electronics", isCurrentPage: true)
                }

                ElevateBreadcrumb(size: .small) {
                    ElevateBreadcrumbItem("Home", size: .small) {}
                    ElevateBreadcrumbSeparator(size: .small)
                    ElevateBreadcrumbItem("Search", size: .small) {}
                    ElevateBreadcrumbSeparator(size: .small)
                    ElevateBreadcrumbItem("Results", isCurrentPage: true, size: .small)
                }
            }
            .padding()
            .previewDisplayName("Manual Content")

            // Array-Based
            VStack(spacing: 24) {
                Text("Array-Based").font(.headline)

                ElevateBreadcrumb(
                    items: ["Home", "Products", "Electronics", "Laptops"],
                    onItemTap: { index in
                        print("Navigate to item \(index)")
                    }
                )

                ElevateBreadcrumb(
                    items: ["Dashboard", "Settings", "Profile"],
                    currentIndex: 2,
                    size: .small,
                    onItemTap: { _ in }
                )

                ElevateBreadcrumb(
                    items: ["Level 1", "Level 2"],
                    size: .large,
                    onItemTap: { _ in }
                )
            }
            .padding()
            .previewDisplayName("Array-Based")

            // Long Breadcrumb (Scrollable)
            VStack(spacing: 24) {
                Text("Long Breadcrumb (Scrollable)").font(.headline)

                ElevateBreadcrumb(
                    items: [
                        "Home",
                        "Category",
                        "Subcategory",
                        "Products",
                        "Item Type",
                        "Specific Item",
                        "Details"
                    ],
                    onItemTap: { _ in }
                )
            }
            .padding()
            .previewDisplayName("Scrollable")

            // Interactive Example
            BreadcrumbNavigationExample()
                .previewDisplayName("Interactive")

            // Dark Mode
            VStack(spacing: 24) {
                ElevateBreadcrumb(
                    items: ["Home", "Products", "Current Page"],
                    onItemTap: { _ in }
                )

                ElevateBreadcrumb {
                    ElevateBreadcrumbItem("Home") {}
                    ElevateBreadcrumbSeparator()
                    ElevateBreadcrumbItem("Settings") {}
                    ElevateBreadcrumbSeparator()
                    ElevateBreadcrumbItem("Profile", isCurrentPage: true)
                }
            }
            .padding()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
    }

    struct BreadcrumbNavigationExample: View {
        @State private var path: [String] = ["Home", "Products", "Electronics"]
        @State private var message = "Tap any breadcrumb item"

        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text("Interactive Navigation").font(.headline)

                ElevateBreadcrumb(
                    items: path,
                    onItemTap: { index in
                        // Navigate by removing items after the tapped index
                        path = Array(path.prefix(index + 1))
                        message = "Navigated to: \(path.last ?? "")"
                    }
                )

                Text(message)
                    .font(.caption)
                    .foregroundColor(ElevateAliases.Content.General.text_muted)

                // Add navigation button
                Button("Go Deeper → Laptops") {
                    path.append("Laptops")
                    message = "Navigated to: Laptops"
                }
                .font(.caption)
            }
            .padding()
        }
    }
}
#endif

#endif
