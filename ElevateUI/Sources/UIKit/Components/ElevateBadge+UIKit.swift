#if os(iOS)
import UIKit
import SwiftUI

/// ELEVATE Badge Component (UIKit)
///
/// UIKit wrapper around SwiftUI Badge implementation.
/// Provides Interface Builder support and UIKit-friendly API.
///
/// **Web Component:** `<elvt-badge>`
/// **API Reference:** `.claude/components/Display/badge.md`
@available(iOS 15, *)
@IBDesignable
public class ElevateUIKitBadge: UIView {

    // MARK: - Properties

    @IBInspectable
    public var label: String = "" {
        didSet { updateConfiguration() }
    }

    /// The visual style of the badge (not IBInspectable - use toneIndex)
    public var tone: BadgeTokens.Tone = .neutral {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public var toneIndex: Int {
        get {
            switch tone {
            case .primary: return 0
            case .secondary: return 1
            case .success: return 2
            case .warning: return 3
            case .danger: return 4
            case .neutral: return 5
            }
        }
        set {
            tone = [.primary, .secondary, .success, .warning, .danger, .neutral][
                max(0, min(newValue, 5))
            ]
        }
    }

    /// The prominence level (not IBInspectable - use isMajor)
    public var rank: BadgeTokens.Rank = .major {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public var isMajor: Bool {
        get { rank == .major }
        set { rank = newValue ? .major : .minor }
    }

    /// The shape of the badge (not IBInspectable - use isRounded)
    public var shape: BadgeTokens.Shape = .box {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public var isRounded: Bool {
        get { shape == .pill }
        set { shape = newValue ? .pill : .box }
    }

    @IBInspectable
    public var isPulsing: Bool = false {
        didSet { updateConfiguration() }
    }

    // MARK: - Views

    private let hostingController: UIHostingController<AnyView>

    public var prefixView: UIView? {
        didSet { updateConfiguration() }
    }

    public var suffixView: UIView? {
        didSet { updateConfiguration() }
    }

    // MARK: - Initialization

    public override init(frame: CGRect) {
        let swiftUIView = ElevateBadge("", tone: .neutral, rank: .major)
        self.hostingController = UIHostingController(rootView: AnyView(swiftUIView))
        super.init(frame: frame)
        setupHostingController()
    }

    required init?(coder: NSCoder) {
        let swiftUIView = ElevateBadge("", tone: .neutral, rank: .major)
        self.hostingController = UIHostingController(rootView: AnyView(swiftUIView))
        super.init(coder: coder)
        setupHostingController()
    }

    public convenience init(
        label: String,
        tone: BadgeTokens.Tone = .neutral,
        rank: BadgeTokens.Rank = .major,
        shape: BadgeTokens.Shape = .box,
        isPulsing: Bool = false
    ) {
        self.init(frame: .zero)
        self.label = label
        self.tone = tone
        self.rank = rank
        self.shape = shape
        self.isPulsing = isPulsing
        updateConfiguration()
    }

    // MARK: - Setup

    private func setupHostingController() {
        hostingController.view.backgroundColor = .clear
        addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        backgroundColor = .clear
    }

    private func updateConfiguration() {
        let swiftUIView: AnyView

        if let prefix = prefixView, let suffix = suffixView {
            let badge = ElevateBadge(
                label: label,
                tone: tone,
                rank: rank,
                shape: shape,
                isPulsing: isPulsing,
                prefix: { UIViewWrapper(view: prefix) },
                suffix: { UIViewWrapper(view: suffix) }
            )
            swiftUIView = AnyView(badge)
        } else if let prefix = prefixView {
            let badge = ElevateBadge(
                label: label,
                tone: tone,
                rank: rank,
                shape: shape,
                isPulsing: isPulsing,
                prefix: { UIViewWrapper(view: prefix) }
            )
            swiftUIView = AnyView(badge)
        } else if let suffix = suffixView {
            let badge = ElevateBadge(
                label: label,
                tone: tone,
                rank: rank,
                shape: shape,
                isPulsing: isPulsing,
                suffix: { UIViewWrapper(view: suffix) }
            )
            swiftUIView = AnyView(badge)
        } else {
            let badge = ElevateBadge(
                label,
                tone: tone,
                rank: rank,
                shape: shape,
                isPulsing: isPulsing
            )
            swiftUIView = AnyView(badge)
        }

        hostingController.rootView = swiftUIView
    }

    // MARK: - Sizing

    public override var intrinsicContentSize: CGSize {
        hostingController.view.intrinsicContentSize
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        hostingController.sizeThatFits(in: size)
    }
}

// MARK: - UIView Wrapper for SwiftUI

@available(iOS 15, *)
private struct UIViewWrapper: View {
    let view: UIView

    var body: some View {
        UIViewRepresentableWrapper(view: view)
    }
}

@available(iOS 15, *)
private struct UIViewRepresentableWrapper: UIViewRepresentable {
    let view: UIView

    func makeUIView(context: Context) -> UIView {
        view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates needed
    }
}

#endif
