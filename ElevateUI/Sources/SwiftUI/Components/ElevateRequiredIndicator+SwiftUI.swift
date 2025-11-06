#if os(iOS)
import SwiftUI

/// Required indicator for form fields
///
/// **iOS Adaptation Note**: Simple asterisk indicator consistent with iOS form patterns.
/// Unlike ELEVATE web, this is purely visual - form validation handled separately.
///
/// Example:
/// ```swift
/// HStack {
///     Text("Email")
///     ElevateRequiredIndicator()
/// }
/// ```
@available(iOS 15, *)
public struct ElevateRequiredIndicator: View {

    private let size: IndicatorSize

    // MARK: - Initialization

    public init(size: IndicatorSize = .medium) {
        self.size = size
    }

    // MARK: - Body

    public var body: some View {
        Text("*")
            .font(fontSize)
            .foregroundColor(RequiredIndicatorComponentTokens.color)
    }

    // MARK: - Computed Properties

    private var fontSize: Font {
        switch size {
        case .small: return .caption
        case .medium: return .body
        case .large: return .title3
        }
    }
}

// MARK: - Indicator Size

public enum IndicatorSize {
    case small
    case medium
    case large
}

// MARK: - View Extension

@available(iOS 15, *)
extension View {
    /// Add a required indicator to a view
    ///
    /// Example:
    /// ```swift
    /// Text("Email")
    ///     .requiredIndicator()
    /// ```
    public func requiredIndicator(size: IndicatorSize = .medium) -> some View {
        HStack(spacing: 4) {
            self
            ElevateRequiredIndicator(size: size)
        }
    }
}

// MARK: - Previews

#if DEBUG
@available(iOS 15, *)
struct ElevateRequiredIndicator_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Required Indicator Examples")
                .font(.title)

            // Sizes
            VStack(alignment: .leading, spacing: 12) {
                Text("Sizes")
                    .font(.headline)

                HStack {
                    Text("Small")
                    ElevateRequiredIndicator(size: .small)
                }

                HStack {
                    Text("Medium")
                    ElevateRequiredIndicator(size: .medium)
                }

                HStack {
                    Text("Large")
                    ElevateRequiredIndicator(size: .large)
                }
            }

            Divider()

            // In form context
            VStack(alignment: .leading, spacing: 12) {
                Text("Form Example")
                    .font(.headline)

                VStack(alignment: .leading, spacing: 8) {
                    Text("Email")
                        .requiredIndicator()

                    TextField("Enter email", text: .constant(""))
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Password")
                        .requiredIndicator()

                    SecureField("Enter password", text: .constant(""))
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Optional Field")

                    TextField("Enter value", text: .constant(""))
                        .textFieldStyle(.roundedBorder)
                }
            }
        }
        .padding()
    }
}
#endif

#endif
