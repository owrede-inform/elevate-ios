#if os(iOS)
import SwiftUI

/// ELEVATE Link Component
///
/// A link that redirects to a URL when clicked.
/// Supports internal app navigation and external web links with visual indicators.
///
/// **Web Component:** `<elvt-link>`
/// **API Reference:** `.claude/components/Navigation/link.md`
@available(iOS 15, *)
public struct ElevateLink: View {

    // MARK: - Properties

    /// The URL to navigate to
    private let url: URL

    /// The link label text
    private let label: String

    /// The usage type (internal or external)
    private let usage: LinkUsage

    /// Whether the link is disabled
    private let isDisabled: Bool

    /// Optional custom action (for internal navigation)
    private let action: (() -> Void)?

    // MARK: - State

    @State private var isHovered = false
    @State private var isPressed = false
    @State private var hasBeenVisited = false

    // MARK: - Environment

    @Environment(\.openURL) private var openURL

    // MARK: - Initializer

    /// Creates a link
    ///
    /// - Parameters:
    ///   - url: The URL to navigate to
    ///   - label: The link label text
    ///   - usage: Whether internal app link or external web link (default: .internal)
    ///   - isDisabled: Whether the link is disabled (default: false)
    ///   - action: Optional custom action for internal navigation (default: nil)
    public init(
        url: URL,
        label: String,
        usage: LinkUsage = .internal,
        isDisabled: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.url = url
        self.label = label
        self.usage = usage
        self.isDisabled = isDisabled
        self.action = action
    }

    /// Creates a link with a string URL
    ///
    /// - Parameters:
    ///   - urlString: The URL string to navigate to
    ///   - label: The link label text
    ///   - usage: Whether internal app link or external web link (default: .internal)
    ///   - isDisabled: Whether the link is disabled (default: false)
    ///   - action: Optional custom action for internal navigation (default: nil)
    public init(
        _ urlString: String,
        label: String,
        usage: LinkUsage = .internal,
        isDisabled: Bool = false,
        action: (() -> Void)? = nil
    ) {
        self.url = URL(string: urlString) ?? URL(string: "about:blank")!
        self.label = label
        self.usage = usage
        self.isDisabled = isDisabled
        self.action = action
    }

    // MARK: - Body

    public var body: some View {
        Button(action: {
            if !isDisabled {
                hasBeenVisited = true
                if let action = action {
                    action()
                } else {
                    openURL(url)
                }
            }
        }) {
            HStack(spacing: 4) {
                // Link text
                Text(label)
                    .font(ElevateTypography.bodyMedium)
                    .foregroundColor(tokenLinkColor)
                    .underline(true, color: tokenLinkColor)

                // External link icon
                if usage == .external {
                    Image(systemName: "arrow.up.forward.square")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(tokenLinkColor)
                }
            }
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .background(
                RoundedRectangle(cornerRadius: LinkComponentTokens.radius)
                    .fill(isPressed ? ElevateAliases.Layout.General.backdrop.opacity(0.1) : Color.clear)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
        .opacity(isDisabled ? 0.6 : 1.0)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(label)
        .accessibilityHint(usage == .external ? "Opens in browser" : "Navigate")
        .accessibilityAddTraits(.isLink)
    }

    // MARK: - Token Accessors

    private var tokenLinkColor: Color {
        if isDisabled {
            return LinkComponentTokens.color_disabled
        }
        if hasBeenVisited {
            return LinkComponentTokens.color_visited
        }
        if isPressed {
            return LinkComponentTokens.color_active
        }
        if isHovered {
            return LinkComponentTokens.color_hover
        }
        return LinkComponentTokens.color_default
    }
}

// MARK: - Link Usage

@available(iOS 15, *)
public enum LinkUsage {
    case `internal`  // In-app navigation
    case external    // External web link
}

// MARK: - Preview Support

#if DEBUG
@available(iOS 15, *)
struct ElevateLink_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                // Basic Links
                VStack(alignment: .leading, spacing: 16) {
                    Text("Basic Links").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateLink(
                            url: URL(string: "https://example.com")!,
                            label: "Internal Link",
                            usage: .internal
                        )

                        ElevateLink(
                            url: URL(string: "https://example.com")!,
                            label: "External Link",
                            usage: .external
                        )
                    }
                }

                Divider()

                // Link Usage Types
                VStack(alignment: .leading, spacing: 16) {
                    Text("Link Types").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Internal (app navigation)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateLink(
                            "https://app.example.com/profile",
                            label: "View Profile",
                            usage: .internal
                        )

                        Text("External (opens in browser)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        ElevateLink(
                            "https://docs.example.com",
                            label: "View Documentation",
                            usage: .external
                        )
                    }
                }

                Divider()

                // Disabled State
                VStack(alignment: .leading, spacing: 16) {
                    Text("Disabled State").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        ElevateLink(
                            "https://example.com",
                            label: "Disabled Internal Link",
                            usage: .internal,
                            isDisabled: true
                        )

                        ElevateLink(
                            "https://example.com",
                            label: "Disabled External Link",
                            usage: .external,
                            isDisabled: true
                        )
                    }
                }

                Divider()

                // Inline with Text
                VStack(alignment: .leading, spacing: 16) {
                    Text("Links in Context").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("Visit our")
                            ElevateLink(
                                "https://docs.example.com",
                                label: "documentation",
                                usage: .external
                            )
                            Text("to learn more.")
                        }

                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("Go to your")
                            ElevateLink(
                                "https://app.example.com/settings",
                                label: "settings",
                                usage: .internal
                            )
                            Text("to update preferences.")
                        }
                    }
                }

                Divider()

                // Custom Actions
                VStack(alignment: .leading, spacing: 16) {
                    Text("Custom Actions").font(.headline)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Link with custom action handler")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        ElevateLink(
                            "https://app.example.com/action",
                            label: "Trigger Custom Action",
                            usage: .internal
                        ) {
                            print("Custom action triggered!")
                        }
                    }
                }

                Divider()

                // Common Patterns
                VStack(alignment: .leading, spacing: 16) {
                    Text("Common Link Patterns").font(.headline)

                    VStack(alignment: .leading, spacing: 16) {
                        // Footer links
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Footer Links").font(.caption).foregroundColor(.secondary)
                            HStack(spacing: 16) {
                                ElevateLink("https://example.com/about", label: "About", usage: .internal)
                                ElevateLink("https://example.com/privacy", label: "Privacy", usage: .internal)
                                ElevateLink("https://example.com/terms", label: "Terms", usage: .internal)
                                ElevateLink("https://help.example.com", label: "Help", usage: .external)
                            }
                        }

                        // Help text with link
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Help Text Pattern").font(.caption).foregroundColor(.secondary)
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("Need help?")
                                ElevateLink(
                                    "https://support.example.com",
                                    label: "Contact support",
                                    usage: .external
                                )
                                Text("for assistance.")
                            }
                        }

                        // Call to action
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Call to Action").font(.caption).foregroundColor(.secondary)
                            HStack(alignment: .firstTextBaseline, spacing: 4) {
                                Text("Don't have an account?")
                                ElevateLink(
                                    "https://app.example.com/signup",
                                    label: "Sign up now",
                                    usage: .internal
                                )
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}
#endif

#endif
