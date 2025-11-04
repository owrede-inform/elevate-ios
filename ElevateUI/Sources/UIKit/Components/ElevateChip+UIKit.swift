#if os(iOS)
import UIKit
import SwiftUI

/// ELEVATE Chip Component (UIKit)
///
/// UIKit wrapper around SwiftUI Chip implementation.
/// Provides Interface Builder support and UIKit-friendly API.
///
/// **Web Component:** `<elvt-chip>`
/// **API Reference:** `.claude/components/Display/chip.md`
@available(iOS 15, *)
@IBDesignable
public class ElevateUIKitChip: UIControl {

    // MARK: - Properties

    @IBInspectable
    public var label: String = "" {
        didSet { updateConfiguration() }
    }

    /// The visual style of the chip (not IBInspectable - use toneIndex)
    public var tone: ChipTokens.Tone = .neutral {
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
            case .emphasized: return 6
            }
        }
        set {
            tone = [.primary, .secondary, .success, .warning, .danger, .neutral, .emphasized][
                max(0, min(newValue, 6))
            ]
        }
    }

    /// The size of the chip (not IBInspectable - use sizeIndex)
    public var size: ChipTokens.Size = .medium {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public var sizeIndex: Int {
        get {
            switch size {
            case .small: return 0
            case .medium: return 1
            case .large: return 2
            }
        }
        set {
            size = [.small, .medium, .large][max(0, min(newValue, 2))]
        }
    }

    /// The shape of the chip (not IBInspectable - use isRounded)
    public var shape: ChipTokens.Shape = .box {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public var isRounded: Bool {
        get { shape == .pill }
        set { shape = newValue ? .pill : .box }
    }

    @IBInspectable
    public override var isSelected: Bool {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public override var isEnabled: Bool {
        didSet { updateConfiguration() }
    }

    @IBInspectable
    public var removable: Bool = false {
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

    // MARK: - Delegate

    public weak var delegate: ElevateChipDelegate?

    // MARK: - Initialization

    public override init(frame: CGRect) {
        let swiftUIView = ElevateChip("", tone: .neutral, size: .medium)
        self.hostingController = UIHostingController(rootView: AnyView(swiftUIView))
        super.init(frame: frame)
        setupHostingController()
    }

    required init?(coder: NSCoder) {
        let swiftUIView = ElevateChip("", tone: .neutral, size: .medium)
        self.hostingController = UIHostingController(rootView: AnyView(swiftUIView))
        super.init(coder: coder)
        setupHostingController()
    }

    public convenience init(
        label: String,
        tone: ChipTokens.Tone = .neutral,
        size: ChipTokens.Size = .medium,
        shape: ChipTokens.Shape = .box,
        isSelected: Bool = false,
        isDisabled: Bool = false,
        removable: Bool = false
    ) {
        self.init(frame: .zero)
        self.label = label
        self.tone = tone
        self.size = size
        self.shape = shape
        self.isSelected = isSelected
        self.isEnabled = !isDisabled
        self.removable = removable
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

        let handleAction: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.sendActions(for: .touchUpInside)
            self.delegate?.chipDidTap(self)
        }

        let handleRemove: (() -> Void)? = removable ? { [weak self] in
            guard let self = self else { return }
            self.delegate?.chipDidRequestRemove(self)
        } : nil

        let handleEdit: (() -> Void)? = { [weak self] in
            guard let self = self else { return }
            self.delegate?.chipDidRequestEdit(self)
        }

        if let prefix = prefixView, let suffix = suffixView {
            let chip = ElevateChip(
                label: label,
                tone: tone,
                size: size,
                shape: shape,
                isSelected: isSelected,
                isDisabled: !isEnabled,
                removable: removable,
                action: handleAction,
                onRemove: handleRemove,
                onEdit: handleEdit,
                prefix: { UIViewWrapper(view: prefix) },
                suffix: { UIViewWrapper(view: suffix) }
            )
            swiftUIView = AnyView(chip)
        } else if let prefix = prefixView {
            let chip = ElevateChip(
                label: label,
                tone: tone,
                size: size,
                shape: shape,
                isSelected: isSelected,
                isDisabled: !isEnabled,
                removable: removable,
                action: handleAction,
                onRemove: handleRemove,
                onEdit: handleEdit,
                prefix: { UIViewWrapper(view: prefix) }
            )
            swiftUIView = AnyView(chip)
        } else if let suffix = suffixView {
            let chip = ElevateChip(
                label: label,
                tone: tone,
                size: size,
                shape: shape,
                isSelected: isSelected,
                isDisabled: !isEnabled,
                removable: removable,
                action: handleAction,
                onRemove: handleRemove,
                onEdit: handleEdit,
                suffix: { UIViewWrapper(view: suffix) }
            )
            swiftUIView = AnyView(chip)
        } else {
            let chip = ElevateChip(
                label,
                tone: tone,
                size: size,
                shape: shape,
                isSelected: isSelected,
                isDisabled: !isEnabled,
                removable: removable,
                action: handleAction,
                onRemove: handleRemove,
                onEdit: handleEdit
            )
            swiftUIView = AnyView(chip)
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

// MARK: - Delegate Protocol

@available(iOS 15, *)
public protocol ElevateChipDelegate: AnyObject {
    func chipDidTap(_ chip: ElevateUIKitChip)
    func chipDidRequestRemove(_ chip: ElevateUIKitChip)
    func chipDidRequestEdit(_ chip: ElevateUIKitChip)
}

// MARK: - Optional Delegate Methods

@available(iOS 15, *)
public extension ElevateChipDelegate {
    func chipDidTap(_ chip: ElevateUIKitChip) {}
    func chipDidRequestRemove(_ chip: ElevateUIKitChip) {}
    func chipDidRequestEdit(_ chip: ElevateUIKitChip) {}
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
