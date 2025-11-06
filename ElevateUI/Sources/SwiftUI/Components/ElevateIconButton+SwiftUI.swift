#if os(iOS)
import SwiftUI

/// ELEVATE Icon Button Component
///
/// A clickable icon button that can be selected or unselected.
/// Optimized for single-icon actions in toolbars, navigation, and action bars.
///
/// **Web Component:** `<elvt-icon-button>`
/// **API Reference:** `.claude/components/Navigation/icon-button.md`
@available(iOS 15, *)
public struct ElevateIconButton: View {

    // MARK: - Properties

    /// The SF Symbol name or icon identifier
    private let icon: String

    /// Accessibility label describing what the button does
    private let label: String

    /// Whether the button is in selected state
    private let isSelected: Bool

    /// Whether the button is disabled
    private let isDisabled: Bool

    /// The shape of the button
    private let shape: IconButtonShape

    /// The size of the button
    private let size: IconButtonSize

    /// Action to perform when tapped
    private let action: () -> Void

    // MARK: - State

    @State private var isPressed = false

    // MARK: - Initializer

    /// Creates an icon button
    ///
    /// - Parameters:
    ///   - icon: SF Symbol name (e.g., "heart.fill", "star", "gear")
    ///   - label: Accessibility label describing the button's purpose
    ///   - isSelected: Whether the button is in selected state (default: false)
    ///   - isDisabled: Whether the button is disabled (default: false)
    ///   - shape: Circle or box shape (default: .box)
    ///   - size: Small, medium, or large (default: .medium)
    ///   - action: Closure to execute when tapped
    public init(
        icon: String,
        label: String,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        shape: IconButtonShape = .box,
        size: IconButtonSize = .medium,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.label = label
        self.isSelected = isSelected
        self.isDisabled = isDisabled
        self.shape = shape
        self.size = size
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: {
            if !isDisabled {
                action()
            }
        }) {
            ZStack {
                // Background (shown when selected)
                if isSelected {
                    backgroundShape
                        .fill(tokenBackgroundColor)
                }

                // Icon
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: tokenIconSize, height: tokenIconSize)
                    .foregroundColor(tokenIconColor)
            }
            .frame(width: tokenButtonSize, height: tokenButtonSize)
        }
        .buttonStyle(IconButtonPressableStyle(
            isPressed: $isPressed,
            isDisabled: isDisabled
        ))
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityLabel(label)
        .accessibilityAddTraits(isSelected ? [.isButton, .isSelected] : .isButton)
    }

    // MARK: - Components

    @ViewBuilder
    private var backgroundShape: some View {
        switch shape {
        case .circle:
            Circle()
        case .box:
            RoundedRectangle(cornerRadius: IconButtonComponentTokens.border_radius_default)
        }
    }

    // MARK: - Token Accessors

    private var tokenButtonSize: CGFloat {
        switch (shape, size) {
        case (.circle, .small): return IconButtonComponentTokens.size_circle_diameter_s
        case (.circle, .medium): return IconButtonComponentTokens.size_circle_diameter_m
        case (.circle, .large): return IconButtonComponentTokens.size_circle_diameter_l
        case (.box, .small): return IconButtonComponentTokens.size_box_width_s
        case (.box, .medium): return IconButtonComponentTokens.size_box_width_m
        case (.box, .large): return IconButtonComponentTokens.size_box_width_l
        }
    }

    private var tokenIconSize: CGFloat {
        switch size {
        case .small: return 16.0
        case .medium: return 20.0
        case .large: return 24.0
        }
    }

    private var tokenIconColor: Color {
        if isDisabled {
            return IconButtonComponentTokens.icon_color_disabled_default
        }

        if isSelected {
            return isPressed
                ? IconButtonComponentTokens.icon_color_selected_active
                : IconButtonComponentTokens.icon_color_selected_default
        }

        return isPressed
            ? IconButtonComponentTokens.icon_color_active
            : IconButtonComponentTokens.icon_color_default
    }

    private var tokenBackgroundColor: Color {
        isPressed
            ? IconButtonComponentTokens.fill_selected_active
            : IconButtonComponentTokens.fill_selected_default
    }
}

// MARK: - Icon Button Shape

@available(iOS 15, *)
public enum IconButtonShape {
    case circle
    case box
}

// MARK: - Icon Button Size

@available(iOS 15, *)
public enum IconButtonSize {
    case small
    case medium
    case large
}

// MARK: - Custom Button Style

@available(iOS 15, *)
private struct IconButtonPressableStyle: ButtonStyle {
    @Binding var isPressed: Bool
    let isDisabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .onChange(of: configuration.isPressed) { pressed in
                if !isDisabled {
                    isPressed = pressed
                }
            }
    }
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateIconButton_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Icon Buttons
                VStack(alignment: .leading, spacing: 16) {
                    Text("Icon Buttons").font(.headline)

                    HStack(spacing: 16) {
                        ElevateIconButton(icon: "heart", label: "Like") {
                            print("Heart tapped")
                        }
                        ElevateIconButton(icon: "star", label: "Favorite") {
                            print("Star tapped")
                        }
                        ElevateIconButton(icon: "gear", label: "Settings") {
                            print("Settings tapped")
                        }
                        ElevateIconButton(icon: "trash", label: "Delete") {
                            print("Delete tapped")
                        }
                    }
                }

                Divider()

                // Selected State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Selected State").font(.headline)

                    HStack(spacing: 16) {
                        ElevateIconButton(icon: "heart", label: "Like", isSelected: false) {}
                        ElevateIconButton(icon: "heart.fill", label: "Liked", isSelected: true) {}
                        ElevateIconButton(icon: "star", label: "Favorite", isSelected: false) {}
                        ElevateIconButton(icon: "star.fill", label: "Favorited", isSelected: true) {}
                    }
                }

                Divider()

                // Shapes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Shapes").font(.headline)

                    HStack(spacing: 16) {
                        ElevateIconButton(
                            icon: "heart.fill",
                            label: "Like",
                            isSelected: true,
                            shape: .box
                        ) {}

                        ElevateIconButton(
                            icon: "heart.fill",
                            label: "Like",
                            isSelected: true,
                            shape: .circle
                        ) {}
                    }
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Sizes").font(.headline)

                    HStack(alignment: .center, spacing: 16) {
                        VStack(spacing: 8) {
                            ElevateIconButton(
                                icon: "star.fill",
                                label: "Small",
                                isSelected: true,
                                size: .small
                            ) {}
                            Text("Small").font(.caption2)
                        }

                        VStack(spacing: 8) {
                            ElevateIconButton(
                                icon: "star.fill",
                                label: "Medium",
                                isSelected: true,
                                size: .medium
                            ) {}
                            Text("Medium").font(.caption2)
                        }

                        VStack(spacing: 8) {
                            ElevateIconButton(
                                icon: "star.fill",
                                label: "Large",
                                isSelected: true,
                                size: .large
                            ) {}
                            Text("Large").font(.caption2)
                        }
                    }
                }

                Divider()

                // Disabled State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disabled State").font(.headline)

                    HStack(spacing: 16) {
                        ElevateIconButton(icon: "heart", label: "Disabled") {}
                        ElevateIconButton(icon: "heart", label: "Disabled", isDisabled: true) {}
                        ElevateIconButton(icon: "heart.fill", label: "Disabled Selected", isSelected: true, isDisabled: true) {}
                    }
                }

                Divider()

                // Common Icon Patterns
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Icons").font(.headline)

                    HStack(spacing: 16) {
                        ElevateIconButton(icon: "ellipsis", label: "More") {}
                        ElevateIconButton(icon: "magnifyingglass", label: "Search") {}
                        ElevateIconButton(icon: "bell", label: "Notifications") {}
                        ElevateIconButton(icon: "person", label: "Profile") {}
                        ElevateIconButton(icon: "plus", label: "Add") {}
                        ElevateIconButton(icon: "xmark", label: "Close") {}
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
