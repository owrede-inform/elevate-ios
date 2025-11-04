#if canImport(UIKit) && !os(macOS)
import UIKit

/// ELEVATE Button Component (UIKit)
///
/// A button component that follows the ELEVATE design system with support for
/// different tones, sizes, and states.
///
/// Example usage:
/// ```swift
/// let button = ElevateUIKitButton(tone: .primary, size: .medium)
/// button.setTitle("Primary Button", for: .normal)
/// button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
/// ```
///
/// Note: Use `ElevateButton` for SwiftUI. This UIKit version is named `ElevateUIKitButton`
/// to avoid name conflicts in mixed SwiftUI/UIKit projects.
@available(iOS 15.0, *)
@IBDesignable
open class ElevateUIKitButton: UIButton {

    // MARK: - Properties

    /// The button tone/variant
    @IBInspectable
    public var tone: String = "primary" {
        didSet { updateAppearance() }
    }

    /// The button size (small, medium, large)
    @IBInspectable
    public var buttonSize: String = "medium" {
        didSet { updateAppearance() }
    }

    /// The button shape (default, pill)
    @IBInspectable
    public var buttonShape: String = "default" {
        didSet { updateAppearance() }
    }

    private var toneEnum: ButtonTokens.Tone {
        switch tone.lowercased() {
        case "primary": return .primary
        case "secondary": return .secondary
        case "success": return .success
        case "warning": return .warning
        case "danger": return .danger
        case "emphasized": return .emphasized
        case "subtle": return .subtle
        case "neutral": return .neutral
        default: return .primary
        }
    }

    private var sizeEnum: ButtonTokens.Size {
        switch buttonSize.lowercased() {
        case "small": return .small
        case "medium": return .medium
        case "large": return .large
        default: return .medium
        }
    }

    private var shapeEnum: ButtonTokens.Shape {
        switch buttonShape.lowercased() {
        case "pill": return .pill
        default: return .default
        }
    }

    // MARK: - Initialization

    public convenience init(
        tone: ButtonTokens.Tone = .primary,
        size: ButtonTokens.Size = .medium,
        shape: ButtonTokens.Shape = .default
    ) {
        self.init(frame: .zero)
        self.tone = "\(tone)"
        self.buttonSize = "\(size)"
        self.buttonShape = "\(shape)"
        setupButton()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }

    // MARK: - Setup

    private func setupButton() {
        // Set content compression resistance
        setContentCompressionResistancePriority(.required, for: .vertical)
        setContentHuggingPriority(.defaultHigh, for: .horizontal)

        // Add target for touch events
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        updateAppearance()
    }

    private func updateAppearance() {
        let toneColors = toneEnum.colors
        let componentSize = sizeEnum.componentSize

        // Configure colors
        backgroundColor = UIColor(toneColors.background)
        setTitleColor(UIColor(toneColors.text), for: .normal)
        setTitleColor(UIColor(toneColors.textDisabled), for: .disabled)

        // Configure border
        layer.borderWidth = ElevateSpacing.BorderWidth.thin
        layer.borderColor = UIColor(toneColors.border).cgColor
        layer.cornerRadius = shapeEnum.borderRadius

        // Configure size
        heightAnchor.constraint(equalToConstant: componentSize.height).isActive = true
        contentEdgeInsets = UIEdgeInsets(
            top: 0,
            left: componentSize.paddingInline,
            bottom: 0,
            right: componentSize.paddingInline
        )

        // Configure font
        let font: UIFont
        switch sizeEnum {
        case .small:
            font = ElevateTypography.UIKit.labelSmall
        case .medium:
            font = ElevateTypography.UIKit.labelMedium
        case .large:
            font = ElevateTypography.UIKit.labelLarge
        }
        titleLabel?.font = font

        // Accessibility
        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    // MARK: - Touch Handling

    @objc private func touchDown() {
        guard isEnabled else { return }
        let toneColors = toneEnum.colors

        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = UIColor(toneColors.backgroundActive)
            self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
        }
    }

    @objc private func touchUp() {
        guard isEnabled else { return }
        let toneColors = toneEnum.colors

        UIView.animate(withDuration: 0.1) {
            self.backgroundColor = UIColor(toneColors.background)
            self.transform = .identity
        }
    }

    // MARK: - State Changes

    open override var isEnabled: Bool {
        didSet {
            let toneColors = toneEnum.colors
            if isEnabled {
                backgroundColor = UIColor(toneColors.background)
            } else {
                backgroundColor = UIColor(toneColors.backgroundDisabled)
            }
        }
    }

    open override var isHighlighted: Bool {
        didSet {
            let toneColors = toneEnum.colors
            if isHighlighted && isEnabled {
                backgroundColor = UIColor(toneColors.backgroundHover)
            } else if isEnabled {
                backgroundColor = UIColor(toneColors.background)
            }
        }
    }

    // MARK: - Layout

    open override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = shapeEnum.borderRadius
    }

    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let componentSize = sizeEnum.componentSize
        return CGSize(
            width: size.width + (componentSize.paddingInline * 2),
            height: componentSize.height
        )
    }
}
#endif
