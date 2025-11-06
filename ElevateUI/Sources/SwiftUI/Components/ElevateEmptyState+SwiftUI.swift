#if os(iOS)
import SwiftUI

/// ELEVATE Empty State Component
///
/// Displays a message when content is empty or unavailable.
/// Typically used in lists, tables, or search results with no data.
///
/// **Design Reference:** Empty state pattern from ELEVATE design system
@available(iOS 15, *)
public struct ElevateEmptyState<Action: View>: View {

    // MARK: - Properties

    /// The icon to display (SF Symbol name)
    private let icon: String

    /// The main title/message
    private let title: String

    /// Optional description text
    private let description: String?

    /// Optional action button or view
    private let action: (() -> Action)?

    // MARK: - Initializer

    /// Creates an empty state view
    ///
    /// - Parameters:
    ///   - icon: SF Symbol name for the icon
    ///   - title: The main message text
    ///   - description: Optional description (default: nil)
    ///   - action: Optional action view (default: nil)
    public init(
        icon: String,
        title: String,
        description: String? = nil,
        action: (() -> Action)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: EmptyStateComponentTokens.gap) {
            // Icon
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: EmptyStateComponentTokens.icon_size, height: EmptyStateComponentTokens.icon_size)
                .foregroundColor(EmptyStateComponentTokens.icon_color)

            // Title
            Text(title)
                .font(ElevateTypography.titleMedium)
                .foregroundColor(EmptyStateComponentTokens.text_color)
                .multilineTextAlignment(.center)

            // Description
            if let description = description {
                Text(description)
                    .font(ElevateTypography.bodyMedium)
                    .foregroundColor(EmptyStateComponentTokens.text_color.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            // Action
            if let action = action {
                action()
                    .padding(.top, EmptyStateComponentTokens.gap)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityText)
    }

    // MARK: - Helpers

    private var accessibilityText: String {
        var text = title
        if let description = description {
            text += ". " + description
        }
        return text
    }
}

// MARK: - Convenience Initializer (No Action)

@available(iOS 15, *)
extension ElevateEmptyState where Action == EmptyView {
    /// Creates an empty state without action
    ///
    /// - Parameters:
    ///   - icon: SF Symbol name for the icon
    ///   - title: The main message text
    ///   - description: Optional description (default: nil)
    public init(
        icon: String,
        title: String,
        description: String? = nil
    ) {
        self.icon = icon
        self.title = title
        self.description = description
        self.action = nil
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateEmptyState_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 48) {
                // Basic Empty State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Empty State").font(.headline)

                    ElevateEmptyState(
                        icon: "tray",
                        title: "No Items",
                        description: "There are no items to display"
                    )
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.1))
                }

                Divider()

                // With Action Button
                VStack(alignment: .leading, spacing: 16) {
                    Text("With Action").font(.headline)

                    ElevateEmptyState(
                        icon: "doc.text",
                        title: "No Documents",
                        description: "Get started by creating your first document"
                    ) {
                        Button("Create Document") {
                            print("Create tapped")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(height: 250)
                    .background(Color.gray.opacity(0.1))
                }

                Divider()

                // Common Use Cases
                VStack(alignment: .leading, spacing: 24) {
                    Text("Common Use Cases").font(.headline)

                    // Empty inbox
                    ElevateEmptyState(
                        icon: "envelope.open",
                        title: "Inbox Zero!",
                        description: "You're all caught up"
                    )
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.1))

                    // No search results
                    ElevateEmptyState(
                        icon: "magnifyingglass",
                        title: "No Results Found",
                        description: "Try adjusting your search criteria"
                    ) {
                        Button("Clear Filters") {
                            print("Clear filters")
                        }
                    }
                    .frame(height: 220)
                    .background(Color.gray.opacity(0.1))

                    // Empty favorites
                    ElevateEmptyState(
                        icon: "star",
                        title: "No Favorites Yet",
                        description: "Tap the star icon to add favorites"
                    )
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.1))

                    // No notifications
                    ElevateEmptyState(
                        icon: "bell.slash",
                        title: "No Notifications",
                        description: "You're all up to date"
                    )
                    .frame(height: 200)
                    .background(Color.gray.opacity(0.1))

                    // Empty cart
                    ElevateEmptyState(
                        icon: "cart",
                        title: "Your Cart is Empty",
                        description: "Add items to get started"
                    ) {
                        Button("Start Shopping") {
                            print("Start shopping")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(height: 220)
                    .background(Color.gray.opacity(0.1))

                    // No messages
                    ElevateEmptyState(
                        icon: "message",
                        title: "No Messages",
                        description: "Start a conversation"
                    ) {
                        Button("New Message") {
                            print("New message")
                        }
                        .buttonStyle(.bordered)
                    }
                    .frame(height: 220)
                    .background(Color.gray.opacity(0.1))

                    // Connection error
                    ElevateEmptyState(
                        icon: "wifi.slash",
                        title: "No Connection",
                        description: "Please check your internet connection"
                    ) {
                        Button("Try Again") {
                            print("Retry")
                        }
                    }
                    .frame(height: 220)
                    .background(Color.gray.opacity(0.1))

                    // Error state
                    ElevateEmptyState(
                        icon: "exclamationmark.triangle",
                        title: "Something Went Wrong",
                        description: "We couldn't load your data. Please try again."
                    ) {
                        Button("Reload") {
                            print("Reload")
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(height: 220)
                    .background(Color.gray.opacity(0.1))
                }
            }
            .padding()
        }
    }
}
#endif

#endif
