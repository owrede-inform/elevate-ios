#if os(iOS)
import SwiftUI

/// ELEVATE Breadcrumb Item Component for SwiftUI
///
/// A single breadcrumb item that can be clickable (link) or non-clickable (current page).
/// Used within ElevateBreadcrumb to show navigation hierarchy.
///
/// # Usage
/// ```swift
/// // Clickable item
/// ElevateBreadcrumbItem("Home") {
///     // Navigate to home
/// }
///
/// // Current page (non-clickable)
/// ElevateBreadcrumbItem("Settings", isCurrentPage: true)
/// ```
///
/// # iOS Adaptations
/// - Scroll-friendly tap gestures
/// - Minimum 44pt touch target for clickable items
/// - Dynamic text support
/// - VoiceOver support with "Current page" trait
///
/// # Design Tokens
/// Uses manually defined breadcrumb tokens from ELEVATE design system.
@available(iOS 15, *)
public struct ElevateBreadcrumbItem: View {

    // MARK: - Properties

    private let label: String
    private let isCurrentPage: Bool
    private let isSelected: Bool
    private let size: BreadcrumbTokens.Size
    private let action: (() -> Void)?

    @State private var isPressed = false

    // MARK: - Computed Properties

    private var sizeConfig: BreadcrumbTokens.SizeConfig {
        size.config
    }

    private var textColor: Color {
        if isCurrentPage {
            return BreadcrumbTokens.textDefault
        } else {
            return BreadcrumbTokens.linkTextColor(
                isSelected: isSelected,
                isPressed: isPressed
            )
        }
    }

    // MARK: - Initializer

    /// Creates a breadcrumb item
    /// - Parameters:
    ///   - label: The text label
    ///   - isCurrentPage: Whether this is the current page (non-clickable)
    ///   - isSelected: Whether this item is selected
    ///   - size: The size variant
    ///   - action: Optional closure called when item is tapped (nil for current page)
    public init(
        _ label: String,
        isCurrentPage: Bool = false,
        isSelected: Bool = false,
        size: BreadcrumbTokens.Size = .medium,
        action: (() -> Void)? = nil
    ) {
        self.label = label
        self.isCurrentPage = isCurrentPage
        self.isSelected = isSelected
        self.size = size
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        if isCurrentPage || action == nil {
            // Non-clickable current page
            Text(label)
                .font(.system(size: sizeConfig.fontSize, weight: .medium))
                .foregroundColor(textColor)
                .lineLimit(1)
                .accessibilityAddTraits([.isStaticText, .isHeader])
                .accessibilityLabel("\(label), current page")
        } else {
            // Clickable link
            Text(label)
                .font(.system(size: sizeConfig.fontSize))
                .foregroundColor(textColor)
                .lineLimit(1)
                .padding(.horizontal, sizeConfig.horizontalPadding)
                .frame(height: sizeConfig.height)
                .frame(minWidth: sizeConfig.minTouchTarget, minHeight: sizeConfig.minTouchTarget)
                .contentShape(Rectangle())
                .scrollFriendlyTap(
                    onPressedChanged: { pressed in
                        // Force immediate update with no animation delay
                        var transaction = Transaction()
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            isPressed = pressed
                        }
                    },
                    action: {
                        action?()
                    }
                )
                .accessibilityElement()
                .accessibilityLabel(label)
                .accessibilityAddTraits([.isLink])
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateBreadcrumbItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            // Basic Items
            VStack(alignment: .leading, spacing: 20) {
                Text("Breadcrumb Items").font(.headline)

                HStack(spacing: 8) {
                    ElevateBreadcrumbItem("Home") {}
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(BreadcrumbTokens.separatorColor)
                    ElevateBreadcrumbItem("Products") {}
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(BreadcrumbTokens.separatorColor)
                    ElevateBreadcrumbItem("Electronics", isCurrentPage: true)
                }

                HStack(spacing: 8) {
                    ElevateBreadcrumbItem("Home", isSelected: true) {}
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(BreadcrumbTokens.separatorColor)
                    ElevateBreadcrumbItem("Settings") {}
                }
            }
            .padding()
            .previewDisplayName("Basic Items")

            // Sizes
            VStack(alignment: .leading, spacing: 20) {
                Text("Sizes").font(.headline)

                HStack(spacing: 6) {
                    ElevateBreadcrumbItem("Home", size: .small) {}
                    Image(systemName: "chevron.right").font(.system(size: 10))
                    ElevateBreadcrumbItem("Page", isCurrentPage: true, size: .small)
                }

                HStack(spacing: 8) {
                    ElevateBreadcrumbItem("Home", size: .medium) {}
                    Image(systemName: "chevron.right").font(.system(size: 12))
                    ElevateBreadcrumbItem("Page", isCurrentPage: true, size: .medium)
                }

                HStack(spacing: 10) {
                    ElevateBreadcrumbItem("Home", size: .large) {}
                    Image(systemName: "chevron.right").font(.system(size: 14))
                    ElevateBreadcrumbItem("Page", isCurrentPage: true, size: .large)
                }
            }
            .padding()
            .previewDisplayName("Sizes")

            // Dark Mode
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 8) {
                    ElevateBreadcrumbItem("Home") {}
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(BreadcrumbTokens.separatorColor)
                    ElevateBreadcrumbItem("Products") {}
                    Image(systemName: "chevron.right")
                        .font(.system(size: 12))
                        .foregroundColor(BreadcrumbTokens.separatorColor)
                    ElevateBreadcrumbItem("Current", isCurrentPage: true)
                }
            }
            .padding()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
        }
    }
}
#endif

#endif
