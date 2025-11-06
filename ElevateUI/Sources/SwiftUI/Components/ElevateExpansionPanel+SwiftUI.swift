#if os(iOS)
import SwiftUI

/// ELEVATE Expansion Panel Component
///
/// Provides an expandable details view with collapsible content.
/// Displays a header with chevron icon that expands to show content when tapped.
///
/// **Web Component:** `<elvt-expansion-panel>`
/// **API Reference:** `.claude/components/Structure/expansion-panel.md`
@available(iOS 15, *)
public struct ElevateExpansionPanel<Content: View>: View {

    // MARK: - Properties

    /// Binding to control whether the panel is expanded
    @Binding private var isOpen: Bool

    /// Summary text to show in the header
    private let summary: String

    /// Whether the panel is disabled
    private let isDisabled: Bool

    /// The layer (background style) of the panel
    private let layer: ExpansionPanelLayer

    /// The size of the panel
    private let size: ExpansionPanelSize

    /// Custom expand icon (SF Symbol name)
    private let expandIcon: String?

    /// Custom collapse icon (SF Symbol name)
    private let collapseIcon: String?

    /// The content to display when expanded
    private let content: () -> Content

    /// Action called when panel opens or closes
    private let onChange: ((Bool) -> Void)?

    // MARK: - State

    @State private var isHovered = false
    @State private var isPressed = false

    // MARK: - Initializer

    /// Creates an expansion panel
    ///
    /// - Parameters:
    ///   - isOpen: Binding to control whether the panel is expanded
    ///   - summary: Summary text to show in the header
    ///   - isDisabled: Whether the panel is disabled (default: false)
    ///   - layer: Background style (default: .default)
    ///   - size: Panel size (default: .medium)
    ///   - expandIcon: Custom expand icon SF Symbol name (default: nil uses chevron)
    ///   - collapseIcon: Custom collapse icon SF Symbol name (default: nil uses chevron)
    ///   - onChange: Called when panel opens or closes (default: nil)
    ///   - content: The content to display when expanded
    public init(
        isOpen: Binding<Bool>,
        summary: String,
        isDisabled: Bool = false,
        layer: ExpansionPanelLayer = .default,
        size: ExpansionPanelSize = .medium,
        expandIcon: String? = nil,
        collapseIcon: String? = nil,
        onChange: ((Bool) -> Void)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isOpen = isOpen
        self.summary = summary
        self.isDisabled = isDisabled
        self.layer = layer
        self.size = size
        self.expandIcon = expandIcon
        self.collapseIcon = collapseIcon
        self.onChange = onChange
        self.content = content
    }

    // MARK: - Body

    public var body: some View {
        VStack(spacing: 0) {
            // Header
            Button(action: {
                if !isDisabled {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isOpen.toggle()
                    }
                    onChange?(isOpen)
                }
            }) {
                HStack(spacing: tokenPaddingInline) {
                    // Summary text
                    Text(summary)
                        .font(tokenHeaderFont)
                        .foregroundColor(tokenHeaderTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    // Chevron icon
                    Image(systemName: chevronIconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: tokenChevronSize, height: tokenChevronSize)
                        .foregroundColor(tokenHeaderTextColor)
                        .rotationEffect(.degrees(isOpen ? 180 : 0))
                }
                .padding(.horizontal, tokenPaddingInline)
                .frame(height: tokenHeaderHeight)
                .contentShape(Rectangle())
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(isDisabled)

            // Content (expanded)
            if isOpen {
                VStack(alignment: .leading, spacing: 0) {
                    content()
                        .font(tokenBodyFont)
                        .foregroundColor(tokenBodyTextColor)
                        .padding(.horizontal, tokenPaddingInline)
                        .padding(.top, tokenBodyPaddingTop)
                        .padding(.bottom, tokenBodyPaddingBottom)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(tokenBackgroundColor)
        .overlay(
            RoundedRectangle(cornerRadius: tokenBorderRadius)
                .strokeBorder(tokenBorderColor, lineWidth: tokenBorderWidth)
        )
        .clipShape(RoundedRectangle(cornerRadius: tokenBorderRadius))
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(summary)
        .accessibilityAddTraits(.isButton)
        .accessibilityHint(isOpen ? "Double tap to collapse" : "Double tap to expand")
    }

    // MARK: - Helpers

    private var chevronIconName: String {
        if let customIcon = isOpen ? collapseIcon : expandIcon {
            return customIcon
        }
        return "chevron.down"
    }

    // MARK: - Token Accessors

    private var tokenHeaderHeight: CGFloat {
        switch size {
        case .small: return ExpansionPanelComponentTokens.height_s
        case .medium: return ExpansionPanelComponentTokens.height_m
        case .large: return ExpansionPanelComponentTokens.height_l
        }
    }

    private var tokenChevronSize: CGFloat {
        switch size {
        case .small: return ExpansionPanelComponentTokens.chevron_width_s
        case .medium: return ExpansionPanelComponentTokens.chevron_width_m
        case .large: return ExpansionPanelComponentTokens.chevron_width_l
        }
    }

    private var tokenPaddingInline: CGFloat {
        switch size {
        case .small: return ExpansionPanelComponentTokens.padding_inline_s
        case .medium: return ExpansionPanelComponentTokens.padding_inline_m
        case .large: return ExpansionPanelComponentTokens.padding_inline_l
        }
    }

    private var tokenBodyPaddingTop: CGFloat {
        switch size {
        case .small: return ExpansionPanelComponentTokens.body_padding_block_start_s
        case .medium: return ExpansionPanelComponentTokens.body_padding_block_start_m
        case .large: return ExpansionPanelComponentTokens.body_padding_block_start_l
        }
    }

    private var tokenBodyPaddingBottom: CGFloat {
        switch size {
        case .small: return ExpansionPanelComponentTokens.body_padding_block_end_s
        case .medium: return ExpansionPanelComponentTokens.body_padding_block_end_m
        case .large: return ExpansionPanelComponentTokens.body_padding_block_end_l
        }
    }

    private var tokenBorderRadius: CGFloat {
        switch size {
        case .small: return ExpansionPanelComponentTokens.border_radius_s
        case .medium: return ExpansionPanelComponentTokens.border_radius_m
        case .large: return ExpansionPanelComponentTokens.border_radius_l
        }
    }

    private var tokenBorderWidth: CGFloat {
        switch size {
        case .small: return ExpansionPanelComponentTokens.border_width_s
        case .medium: return ExpansionPanelComponentTokens.border_width_m
        case .large: return ExpansionPanelComponentTokens.border_width_l
        }
    }

    private var tokenBorderColor: Color {
        if isDisabled {
            return ExpansionPanelComponentTokens.border_color_disabled
        }
        if isPressed {
            return ExpansionPanelComponentTokens.border_color_active
        }
        if isHovered {
            return ExpansionPanelComponentTokens.border_color_hover
        }
        return ExpansionPanelComponentTokens.border_color_default
    }

    private var tokenBackgroundColor: Color {
        if isDisabled {
            switch layer {
            case .default: return ExpansionPanelComponentTokens.fill_default_disabled_default
            case .elevated: return ExpansionPanelComponentTokens.fill_elevated_disabled_default
            }
        }
        if isPressed {
            switch layer {
            case .default: return ExpansionPanelComponentTokens.fill_default_active
            case .elevated: return ExpansionPanelComponentTokens.fill_elevated_active
            }
        }
        if isHovered {
            switch layer {
            case .default: return ExpansionPanelComponentTokens.fill_default_hover
            case .elevated: return ExpansionPanelComponentTokens.fill_elevated_hover
            }
        }
        switch layer {
        case .default: return ExpansionPanelComponentTokens.fill_default_default
        case .elevated: return ExpansionPanelComponentTokens.fill_elevated_default
        }
    }

    private var tokenHeaderTextColor: Color {
        if isDisabled {
            return ExpansionPanelComponentTokens.text_header_color_disabled
        }
        if isPressed {
            return ExpansionPanelComponentTokens.text_header_color_active
        }
        if isHovered {
            return ExpansionPanelComponentTokens.text_header_color_hover
        }
        return ExpansionPanelComponentTokens.text_header_color_default
    }

    private var tokenBodyTextColor: Color {
        if isDisabled {
            return ExpansionPanelComponentTokens.text_body_color_disabled
        }
        if isPressed {
            return ExpansionPanelComponentTokens.text_body_color_active
        }
        if isHovered {
            return ExpansionPanelComponentTokens.text_body_color_hover
        }
        return ExpansionPanelComponentTokens.text_body_color_default
    }

    private var tokenHeaderFont: Font {
        switch size {
        case .small: return ElevateTypography.labelSmall
        case .medium: return ElevateTypography.labelMedium
        case .large: return ElevateTypography.labelLarge
        }
    }

    private var tokenBodyFont: Font {
        switch size {
        case .small: return ElevateTypography.bodySmall
        case .medium: return ElevateTypography.bodyMedium
        case .large: return ElevateTypography.bodyLarge
        }
    }
}

// MARK: - Expansion Panel Layer

@available(iOS 15, *)
public enum ExpansionPanelLayer {
    case `default`
    case elevated
}

// MARK: - Expansion Panel Size

@available(iOS 15, *)
public enum ExpansionPanelSize {
    case small
    case medium
    case large
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateExpansionPanel_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Expansion Panels
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Expansion Panels").font(.headline)

                    VStack(spacing: 12) {
                        PreviewPanel(summary: "What is ELEVATE?") {
                            Text("ELEVATE is a modern design system for building consistent user interfaces across web and mobile platforms.")
                        }

                        PreviewPanel(summary: "How do I get started?") {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("1. Install the ELEVATE package")
                                Text("2. Import the components you need")
                                Text("3. Start building your UI")
                            }
                        }

                        PreviewPanel(summary: "Where can I find documentation?") {
                            Text("Visit our documentation site at docs.elevate.com for comprehensive guides, API references, and examples.")
                        }
                    }
                }

                Divider()

                // Sizes
                VStack(alignment: .leading, spacing: 16) {
                    Text("Panel Sizes").font(.headline)

                    VStack(spacing: 12) {
                        PreviewPanel(summary: "Small Panel", size: .small) {
                            Text("This is a small expansion panel with compact spacing.")
                        }

                        PreviewPanel(summary: "Medium Panel", size: .medium) {
                            Text("This is a medium expansion panel with standard spacing.")
                        }

                        PreviewPanel(summary: "Large Panel", size: .large) {
                            Text("This is a large expansion panel with generous spacing.")
                        }
                    }
                }

                Divider()

                // Layers
                VStack(alignment: .leading, spacing: 16) {
                    Text("Panel Layers").font(.headline)

                    VStack(spacing: 12) {
                        PreviewPanel(summary: "Default Layer", layer: .default) {
                            Text("This panel has the default background layer.")
                        }

                        PreviewPanel(summary: "Elevated Layer", layer: .elevated) {
                            Text("This panel has the elevated background layer with a subtle tint.")
                        }
                    }
                }

                Divider()

                // Disabled State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disabled State").font(.headline)

                    PreviewPanel(summary: "Disabled Panel", isDisabled: true) {
                        Text("This panel is disabled and cannot be interacted with.")
                    }
                }

                Divider()

                // Custom Icons
                VStack(alignment: .leading, spacing: 16) {
                    Text("Custom Icons").font(.headline)

                    PreviewPanel(
                        summary: "Custom Chevron Icons",
                        expandIcon: "plus.circle",
                        collapseIcon: "minus.circle"
                    ) {
                        Text("This panel uses custom expand and collapse icons instead of the default chevron.")
                    }
                }

                Divider()

                // Rich Content
                VStack(alignment: .leading, spacing: 16) {
                    Text("Rich Content Example").font(.headline)

                    PreviewPanel(summary: "Features & Benefits") {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Responsive Design").bold()
                                    Text("Works seamlessly across all device sizes")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }

                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Accessible").bold()
                                    Text("Built with WCAG 2.1 AA compliance")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }

                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Customizable").bold()
                                    Text("Extensive theming and customization options")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }

    struct PreviewPanel<Content: View>: View {
        @State var isOpen: Bool = false
        let summary: String
        var isDisabled: Bool = false
        var layer: ExpansionPanelLayer = .default
        var size: ExpansionPanelSize = .medium
        var expandIcon: String? = nil
        var collapseIcon: String? = nil
        let content: () -> Content

        init(
            summary: String,
            isDisabled: Bool = false,
            layer: ExpansionPanelLayer = .default,
            size: ExpansionPanelSize = .medium,
            expandIcon: String? = nil,
            collapseIcon: String? = nil,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.summary = summary
            self.isDisabled = isDisabled
            self.layer = layer
            self.size = size
            self.expandIcon = expandIcon
            self.collapseIcon = collapseIcon
            self.content = content
        }

        var body: some View {
            ElevateExpansionPanel(
                isOpen: $isOpen,
                summary: summary,
                isDisabled: isDisabled,
                layer: layer,
                size: size,
                expandIcon: expandIcon,
                collapseIcon: collapseIcon
            ) { newValue in
                print("\(summary): \(newValue ? "opened" : "closed")")
            } content: {
                content()
            }
        }
    }
}
#endif

#endif
