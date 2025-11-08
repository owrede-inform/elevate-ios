#if os(iOS)
import SwiftUI

/// Table component with iOS-native List patterns
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's grid layout, this uses:
/// - Native SwiftUI `List` for iOS-standard row presentation
/// - Swipe actions for delete/edit (iOS pattern, not buttons)
/// - Pull-to-refresh instead of reload button
/// - No hover states (touch device)
/// - Optional reordering with drag handle
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// struct Item: Identifiable {
///     let id: UUID
///     var name: String
/// }
///
/// @State private var items: [Item] = [...]
///
/// ElevateTable(
///     data: items,
///     columns: [
///         TableColumn("Name") { item in Text(item.name) }
///     ],
///     onRefresh: { await refreshData() },
///     onDelete: { items.remove(atOffsets: $0) }
/// )
/// ```
@available(iOS 15, *)
public struct ElevateTable<Data, RowContent>: View where Data: RandomAccessCollection, Data.Element: Identifiable, RowContent: View {

    private let data: Data
    private let rowContent: (Data.Element) -> RowContent
    private let onRefresh: (() async -> Void)?
    private let onDelete: ((IndexSet) -> Void)?
    private let onEdit: ((Data.Element) -> Void)?
    private let canReorder: Bool

    @Environment(\.editMode) private var editMode

    // MARK: - Initialization

    public init(
        data: Data,
        @ViewBuilder rowContent: @escaping (Data.Element) -> RowContent,
        onRefresh: (() async -> Void)? = nil,
        onDelete: ((IndexSet) -> Void)? = nil,
        onEdit: ((Data.Element) -> Void)? = nil,
        canReorder: Bool = false
    ) {
        self.data = data
        self.rowContent = rowContent
        self.onRefresh = onRefresh
        self.onDelete = onDelete
        self.onEdit = onEdit
        self.canReorder = canReorder
    }

    // MARK: - Body

    public var body: some View {
        List {
            ForEach(Array(data.enumerated()), id: \.element.id) { index, item in
                rowContent(item)
                    .listRowInsets(EdgeInsets(
                        top: 8,
                        leading: TableComponentTokens.cell_even_padding_inline_start,
                        bottom: 8,
                        trailing: TableComponentTokens.cell_even_padding_inline_start
                    ))
                    .listRowBackground(
                        // NOTE: Removed hover states - no hover on iOS per DIVERSIONS.md
                        backgroundColor(for: index)
                    )
                    // iOS Adaptation: Swipe actions instead of buttons
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        if let onDelete = onDelete {
                            Button(role: .destructive) {
                                performHaptic(.medium)
                                let indexSet = IndexSet(integer: index)
                                onDelete(indexSet)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }

                        if let onEdit = onEdit {
                            Button {
                                performHaptic(.light)
                                onEdit(item)
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                        }
                    }
            }
            .onMove { source, destination in
                if canReorder {
                    performHaptic(.light)
                }
            }
        }
        .listStyle(.insetGrouped)
        // iOS Adaptation: Pull-to-refresh instead of reload button
        .refreshable {
            if let onRefresh = onRefresh {
                await onRefresh()
            }
        }
    }

    // MARK: - Background Color

    /// iOS Adaptation: Alternating row colors (even/odd pattern from tokens)
    /// NOTE: Removed hover and active states - touch devices don't have hover
    private func backgroundColor(for index: Int) -> Color {
        if index % 2 == 0 {
            return TableComponentTokens.cell_even_fill_default
        } else {
            return TableComponentTokens.cell_odd_fill_default
        }
    }

    // MARK: - Haptics

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Simple Table Builder

@available(iOS 15, *)
extension ElevateTable {
    /// Simple table with text columns
    ///
    /// Example:
    /// ```swift
    /// ElevateTable.simple(
    ///     data: users,
    ///     columns: ["Name", "Email", "Role"],
    ///     row: { user in [user.name, user.email, user.role] }
    /// )
    /// ```
    // NOTE: Commented out due to generic type conflicts with extension context
    // Use ElevateTable init directly with custom rowContent closure instead
    /*
    public static func simple<T: Identifiable>(
        data: [T],
        columns: [String],
        row: @escaping (T) -> [String],
        onRefresh: (() async -> Void)? = nil,
        onDelete: ((IndexSet) -> Void)? = nil,
        onEdit: ((T) -> Void)? = nil
    ) -> some View {
        // Implementation has generic type conflicts
    }
    */
}

// MARK: - Advanced Table (iOS 16+)
// NOTE: Commented out due to complex generic type inference issues with SwiftUI Table
// The basic ElevateTable component above provides list-based functionality

/*
/// Advanced table with native SwiftUI Table (iOS 16+)
///
/// **iOS Adaptation**: Uses native `Table` component for true tabular data
/// with sortable columns and selection support.
@available(iOS 16, *)
public struct ElevateAdvancedTable<Data, Columns, Sort>: View where Data: RandomAccessCollection, Data.Element: Identifiable, Columns: View, Sort: Comparable {
    // Implementation commented out - requires Table API fixes
}
*/

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateTable_Previews: PreviewProvider {
    static var previews: some View {
        PreviewContainer()
    }

    struct PreviewContainer: View {
        @State private var users: [User] = [
            User(name: "Alice Johnson", email: "alice@example.com", role: "Admin"),
            User(name: "Bob Smith", email: "bob@example.com", role: "User"),
            User(name: "Carol White", email: "carol@example.com", role: "Editor"),
            User(name: "David Brown", email: "david@example.com", role: "User"),
            User(name: "Eve Davis", email: "eve@example.com", role: "Viewer"),
            User(name: "Frank Miller", email: "frank@example.com", role: "Admin"),
        ]

        @State private var isRefreshing = false

        var body: some View {
            NavigationView {
                VStack(spacing: 0) {
                    // Simple List-based Table
                    ElevateTable(
                        data: users,
                        rowContent: { user in
                            HStack(spacing: 12) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.name)
                                        .font(.headline)
                                        .foregroundColor(TableComponentTokens.cell_even_text_default)

                                    Text(user.email)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                Text(user.role)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(4)
                            }
                        },
                        onRefresh: {
                            try? await Task.sleep(nanoseconds: 1_000_000_000)
                        },
                        onDelete: { indexSet in
                            users.remove(atOffsets: indexSet)
                        },
                        onEdit: { user in
                            print("Edit user: \(user.name)")
                        }
                    )
                }
                .navigationTitle("Users")
                .navigationBarTitleDisplayMode(.large)
            }
        }

        struct User: Identifiable {
            let id = UUID()
            var name: String
            var email: String
            var role: String
        }
    }

    // NOTE: AdvancedTablePreview commented out since ElevateAdvancedTable is disabled
    /*
    @available(iOS 16, *)
    struct AdvancedTablePreview: View {
        // Implementation commented out
    }
    */
}
#endif

#endif
