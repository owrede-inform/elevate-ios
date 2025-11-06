#if os(iOS)
import SwiftUI

/// Navigation item component with iOS-native navigation integration
///
/// **iOS Adaptation Note**: Unlike ELEVATE web's router links, this uses:
/// - **NavigationLink**: Native SwiftUI navigation (push to stack)
/// - **TabBar items**: For bottom navigation (iOS standard)
/// - **Swipe-back gesture**: Automatic navigation history
/// - **No hover states**: Selection and tap only
/// See docs/DIVERSIONS.md for full adaptation details.
///
/// Example:
/// ```swift
/// ElevateNavigationItem(
///     destination: DetailView(),
///     label: "Profile",
///     icon: "person.fill",
///     isSelected: false
/// )
/// ```
@available(iOS 15, *)
public struct ElevateNavigationItem<Destination: View>: View {

    private let destination: Destination
    private let label: String
    private let icon: String?
    private let badge: String?
    private let isSelected: Bool
    private let size: NavigationItemSize

    @Environment(\.isEnabled) private var isEnabled

    // MARK: - Initialization

    public init(
        destination: Destination,
        label: String,
        icon: String? = nil,
        badge: String? = nil,
        isSelected: Bool = false,
        size: NavigationItemSize = .medium
    ) {
        self.destination = destination
        self.label = label
        self.icon = icon
        self.badge = badge
        self.isSelected = isSelected
        self.size = size
    }

    // MARK: - Body

    public var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: gap) {
                // Leading icon
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: iconSize))
                        .foregroundColor(textColor)
                }

                // Label
                Text(label)
                    .font(labelFont)
                    .foregroundColor(textColor)

                Spacer()

                // Badge
                if let badge = badge {
                    Text(badge)
                        .font(.caption2)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .cornerRadius(12)
                }

                // Trailing chevron
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, paddingInline)
            .padding(.vertical, paddingBlock)
            .background(backgroundColor)
            .cornerRadius(NavigationItemComponentTokens.borderRadius_default)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }

    // MARK: - Computed Properties

    private var gap: CGFloat {
        switch size {
        case .small: return NavigationItemComponentTokens.gap_s
        case .medium: return NavigationItemComponentTokens.gap_m
        case .large: return NavigationItemComponentTokens.gap_l
        }
    }

    private var iconSize: CGFloat {
        switch size {
        case .small: return NavigationItemComponentTokens.icon_size_s
        case .medium: return NavigationItemComponentTokens.icon_size_m
        case .large: return NavigationItemComponentTokens.icon_size_l
        }
    }

    private var paddingInline: CGFloat {
        switch size {
        case .small: return NavigationItemComponentTokens.padding_inline_s
        case .medium: return NavigationItemComponentTokens.padding_inline_m
        case .large: return NavigationItemComponentTokens.padding_inline_l
        }
    }

    private var paddingBlock: CGFloat {
        switch size {
        case .small: return NavigationItemComponentTokens.padding_block_s
        case .medium: return NavigationItemComponentTokens.padding_block_m
        case .large: return NavigationItemComponentTokens.padding_block_l
        }
    }

    private var labelFont: Font {
        switch size {
        case .small: return .caption
        case .medium: return .body
        case .large: return .headline
        }
    }

    /// NOTE: Removed hover state - use selected state only per DIVERSIONS.md
    private var backgroundColor: Color {
        if !isEnabled {
            return NavigationItemComponentTokens.fill_disabled_default
        }
        if isSelected {
            return NavigationItemComponentTokens.fill_selected_default
        }
        return NavigationItemComponentTokens.fill_default
    }

    /// NOTE: Removed hover state - use selected state only per DIVERSIONS.md
    private var textColor: Color {
        if !isEnabled {
            return NavigationItemComponentTokens.text_disabled_default
        }
        if isSelected {
            return NavigationItemComponentTokens.text_selected_default
        }
        return NavigationItemComponentTokens.text_default
    }
}

// MARK: - Navigation Item Size

public enum NavigationItemSize {
    case small
    case medium
    case large
}

// MARK: - Simple Navigation Item (No Destination)

/// Navigation item that executes an action instead of navigating
///
/// **iOS Adaptation**: For actions like logout, settings that open sheets
/// instead of pushing to navigation stack.
@available(iOS 15, *)
public struct ElevateNavigationAction: View {
    private let label: String
    private let icon: String?
    private let isDestructive: Bool
    private let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    public init(
        label: String,
        icon: String? = nil,
        isDestructive: Bool = false,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.icon = icon
        self.isDestructive = isDestructive
        self.action = action
    }

    public var body: some View {
        Button {
            performHaptic()
            action()
        } label: {
            HStack(spacing: NavigationItemComponentTokens.gap_m) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: NavigationItemComponentTokens.icon_size_m))
                }

                Text(label)
                    .font(.body)

                Spacer()
            }
            .foregroundColor(isDestructive ? .red : .primary)
            .padding(.horizontal, NavigationItemComponentTokens.padding_inline_m)
            .padding(.vertical, NavigationItemComponentTokens.padding_block_m)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Expandable Navigation Item

/// Navigation item with expandable children (accordion pattern)
///
/// **iOS Adaptation**: Uses DisclosureGroup for native iOS expand/collapse.
@available(iOS 15, *)
public struct ElevateExpandableNavigationItem<Content: View>: View {
    @State private var isExpanded = false

    private let label: String
    private let icon: String?
    private let content: () -> Content

    public init(
        label: String,
        icon: String? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.label = label
        self.icon = icon
        self.content = content
    }

    public var body: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: {
                VStack(alignment: .leading, spacing: 0) {
                    content()
                }
                .padding(.leading, NavigationItemComponentTokens.indent_size_m)
            },
            label: {
                HStack(spacing: NavigationItemComponentTokens.gap_m) {
                    if let icon = icon {
                        Image(systemName: icon)
                            .font(.system(size: NavigationItemComponentTokens.icon_size_m))
                    }

                    Text(label)
                        .font(.body)
                }
            }
        )
        .padding(.horizontal, NavigationItemComponentTokens.padding_inline_m)
        .padding(.vertical, NavigationItemComponentTokens.padding_block_m)
        .onChange(of: isExpanded) { _ in
            performHaptic()
        }
    }

    private func performHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateNavigationItem_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            List {
                Section("Navigation Items") {
                    ElevateNavigationItem(
                        destination: Text("Profile View"),
                        label: "Profile",
                        icon: "person.fill"
                    )

                    ElevateNavigationItem(
                        destination: Text("Settings View"),
                        label: "Settings",
                        icon: "gearshape.fill"
                    )

                    ElevateNavigationItem(
                        destination: Text("Notifications View"),
                        label: "Notifications",
                        icon: "bell.fill",
                        badge: "3"
                    )
                }

                Section("Sizes") {
                    ElevateNavigationItem(
                        destination: Text("Small"),
                        label: "Small Item",
                        icon: "star.fill",
                        size: .small
                    )

                    ElevateNavigationItem(
                        destination: Text("Medium"),
                        label: "Medium Item",
                        icon: "star.fill",
                        size: .medium
                    )

                    ElevateNavigationItem(
                        destination: Text("Large"),
                        label: "Large Item",
                        icon: "star.fill",
                        size: .large
                    )
                }

                Section("States") {
                    ElevateNavigationItem(
                        destination: Text("Selected"),
                        label: "Selected Item",
                        icon: "checkmark.circle.fill",
                        isSelected: true
                    )

                    ElevateNavigationItem(
                        destination: Text("Disabled"),
                        label: "Disabled Item",
                        icon: "xmark.circle"
                    )
                    .disabled(true)
                }

                Section("Actions") {
                    ElevateNavigationAction(
                        label: "Share",
                        icon: "square.and.arrow.up"
                    ) {
                        print("Share tapped")
                    }

                    ElevateNavigationAction(
                        label: "Logout",
                        icon: "arrow.right.square",
                        isDestructive: true
                    ) {
                        print("Logout tapped")
                    }
                }

                Section("Expandable") {
                    ElevateExpandableNavigationItem(
                        label: "More Options",
                        icon: "ellipsis.circle"
                    ) {
                        ElevateNavigationAction(label: "Option 1") {
                            print("Option 1")
                        }

                        ElevateNavigationAction(label: "Option 2") {
                            print("Option 2")
                        }

                        ElevateNavigationAction(label: "Option 3") {
                            print("Option 3")
                        }
                    }
                }

                Section("iOS Adaptations") {
                    Text("✓ NavigationLink for push navigation")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Swipe-back gesture automatic")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ No hover states (touch device)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("✓ Haptic feedback on expand/collapse")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Navigation Items")
        }
    }
}
#endif

#endif
