#if os(iOS)
import SwiftUI

/// Tree component for hierarchical data
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's DOM tree, this uses:
/// - Native SwiftUI `DisclosureGroup` for expand/collapse
/// - Tap to expand/collapse (no hover or click)
/// - Haptic feedback on interactions
/// - Swipe actions for contextual menus
/// - Proper indentation for hierarchy levels
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// struct FileNode: TreeNode {
///     let id: UUID
///     let name: String
///     let icon: String?
///     var children: [FileNode]?
/// }
///
/// @State private var fileTree: [FileNode] = [...]
///
/// ElevateTree(data: fileTree) { node in
///     Label(node.name, systemImage: node.icon ?? "doc")
/// }
/// ```
@available(iOS 15, *)
public struct ElevateTree<Node: TreeNode, Content: View>: View {

    private let data: [Node]
    private let content: (Node) -> Content
    private let onSelect: ((Node) -> Void)?
    private let onDelete: ((Node) -> Void)?

    @State private var expandedNodes: Set<Node.ID> = []

    // MARK: - Initialization

    public init(
        data: [Node],
        @ViewBuilder content: @escaping (Node) -> Content,
        onSelect: ((Node) -> Void)? = nil,
        onDelete: ((Node) -> Void)? = nil
    ) {
        self.data = data
        self.content = content
        self.onSelect = onSelect
        self.onDelete = onDelete
    }

    // MARK: - Body

    public var body: some View {
        List {
            ForEach(data) { node in
                treeNodeView(node: node, level: 0)
            }
        }
        .listStyle(.insetGrouped)
    }

    // MARK: - Tree Node View

    private func treeNodeView(node: Node, level: Int) -> AnyView {
        if let children = node.children, !children.isEmpty {
            // Node with children - use DisclosureGroup
            return AnyView(
                DisclosureGroup(
                    isExpanded: Binding(
                        get: { expandedNodes.contains(node.id) },
                        set: { isExpanded in
                            if isExpanded {
                                expandedNodes.insert(node.id)
                                performHaptic(.light)
                            } else {
                                expandedNodes.remove(node.id)
                                performHaptic(.light)
                            }
                        }
                    )
                ) {
                    ForEach(children) { child in
                        treeNodeView(node: child, level: level + 1)
                    }
                } label: {
                    treeNodeLabel(node: node, level: level)
                }
            )
        } else {
            // Leaf node - simple button
            return AnyView(
                Button {
                    performHaptic(.light)
                    onSelect?(node)
                } label: {
                    treeNodeLabel(node: node, level: level)
                }
                .buttonStyle(.plain)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    if let onDelete = onDelete {
                        Button(role: .destructive) {
                            performHaptic(.medium)
                            onDelete(node)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            )
        }
    }

    // MARK: - Tree Node Label

    private func treeNodeLabel(node: Node, level: Int) -> some View {
        HStack(spacing: TreeItemComponentTokens.gap_m) {
            // Indentation spacer
            if level > 0 {
                Spacer()
                    .frame(width: CGFloat(level) * TreeItemComponentTokens.indent_size_m)
            }

            // Content
            content(node)
                .foregroundColor(TreeItemComponentTokens.text_color_default)
        }
        .padding(.vertical, TreeItemComponentTokens.padding_block_m)
        .padding(.horizontal, TreeItemComponentTokens.padding_inline_m)
        .background(Color.clear)
        .cornerRadius(TreeItemComponentTokens.border_radius_m)
    }

    // MARK: - Haptics

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Tree Node Protocol

/// Protocol for tree nodes with hierarchical structure
public protocol TreeNode: Identifiable {
    var id: ID { get }
    var children: [Self]? { get }
}

// MARK: - Outline Group Alternative (iOS 17+)

/// Tree using native OutlineGroup (iOS 17+)
///
/// **iOS Adaptation**: Uses iOS 17's OutlineGroup for better performance
/// with very large trees.
@available(iOS 17, *)
public struct ElevateOutlineTree<Node: TreeNode, Content: View>: View {

    private let data: [Node]
    private let children: KeyPath<Node, [Node]?>
    private let content: (Node) -> Content
    private let onSelect: ((Node) -> Void)?

    public init(
        data: [Node],
        children: KeyPath<Node, [Node]?>,
        @ViewBuilder content: @escaping (Node) -> Content,
        onSelect: ((Node) -> Void)? = nil
    ) {
        self.data = data
        self.children = children
        self.content = content
        self.onSelect = onSelect
    }

    public var body: some View {
        List(data, children: children) { node in
            Button {
                performHaptic(.light)
                onSelect?(node)
            } label: {
                content(node)
            }
            .buttonStyle(.plain)
        }
        .listStyle(.insetGrouped)
    }

    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

// MARK: - Simple Tree Builder

@available(iOS 15, *)
extension ElevateTree {
    /// Simple tree with text labels
    ///
    /// Example:
    /// ```swift
    /// ElevateTree.simple(
    ///     data: folders,
    ///     label: \.name,
    ///     children: \.subfolders
    /// )
    /// ```
    public static func simple<T: TreeNode>(
        data: [T],
        label: KeyPath<T, String>,
        icon: KeyPath<T, String>? = nil,
        onSelect: ((T) -> Void)? = nil,
        onDelete: ((T) -> Void)? = nil
    ) -> ElevateTree<T, Label<Text, Image>> where Node == T, Content == Label<Text, Image> {
        ElevateTree(
            data: data,
            content: { node in
                let iconName = icon.map { node[keyPath: $0] } ?? "doc"
                return Label(node[keyPath: label], systemImage: iconName)
            },
            onSelect: onSelect,
            onDelete: onDelete
        )
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateTree_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            SimpleTreePreview()
                .tabItem {
                    Label("Simple", systemImage: "folder")
                }

            CustomTreePreview()
                .tabItem {
                    Label("Custom", systemImage: "doc.text")
                }
        }
    }

    // Simple file tree example
    struct SimpleTreePreview: View {
        @State private var files: [FileNode] = [
            FileNode(
                name: "Documents",
                icon: "folder.fill",
                children: [
                    FileNode(name: "Resume.pdf", icon: "doc.fill", children: nil),
                    FileNode(name: "Cover Letter.docx", icon: "doc.text.fill", children: nil),
                    FileNode(
                        name: "Projects",
                        icon: "folder.fill",
                        children: [
                            FileNode(name: "App.swift", icon: "doc.fill", children: nil),
                            FileNode(name: "README.md", icon: "doc.fill", children: nil)
                        ]
                    )
                ]
            ),
            FileNode(
                name: "Photos",
                icon: "folder.fill",
                children: [
                    FileNode(name: "IMG_001.jpg", icon: "photo.fill", children: nil),
                    FileNode(name: "IMG_002.jpg", icon: "photo.fill", children: nil)
                ]
            ),
            FileNode(name: "Notes.txt", icon: "doc.text.fill", children: nil)
        ]

        var body: some View {
            NavigationView {
                ElevateTree(
                    data: files,
                    content: { node in
                        Label(node.name, systemImage: node.icon ?? "doc")
                    },
                    onSelect: { node in
                        print("Selected: \(node.name)")
                    },
                    onDelete: { node in
                        deleteNode(node)
                    }
                )
                .navigationTitle("File Browser")
            }
        }

        func deleteNode(_ node: FileNode) {
            // Recursive deletion logic would go here
            print("Delete: \(node.name)")
        }
    }

    // Custom tree with badges
    struct CustomTreePreview: View {
        @State private var items: [TreeItem] = [
            TreeItem(
                title: "Inbox",
                badge: "12",
                children: [
                    TreeItem(title: "Work", badge: "5", children: nil),
                    TreeItem(title: "Personal", badge: "7", children: nil)
                ]
            ),
            TreeItem(title: "Drafts", badge: "3", children: nil),
            TreeItem(
                title: "Archive",
                badge: nil,
                children: [
                    TreeItem(title: "2024", badge: nil, children: nil),
                    TreeItem(title: "2023", badge: nil, children: nil)
                ]
            )
        ]

        var body: some View {
            NavigationView {
                ElevateTree(
                    data: items,
                    content: { item in
                        HStack {
                            Text(item.title)
                            Spacer()
                            if let badge = item.badge {
                                Text(badge)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                            }
                        }
                    },
                    onSelect: { item in
                        print("Selected: \(item.title)")
                    }
                )
                .navigationTitle("Mail")
            }
        }
    }

    // Sample data models
    struct FileNode: TreeNode {
        let id = UUID()
        var name: String
        var icon: String?
        var children: [FileNode]?
    }

    struct TreeItem: TreeNode {
        let id = UUID()
        var title: String
        var badge: String?
        var children: [TreeItem]?
    }
}
#endif

#endif
