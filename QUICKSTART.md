# ELEVATE iOS UI Kit - Quick Start Guide

Get started with ELEVATE iOS UI Kit in minutes!

## Installation

### Option 1: Swift Package Manager (Recommended)

1. In Xcode, go to **File → Add Packages...**
2. Enter the repository URL: `https://github.com/your-org/elevate-ios`
3. Click **Add Package**
4. Select the products you want to add to your target

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/elevate-ios", from: "0.1.0")
]
```

### Option 2: Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/your-org/elevate-ios.git
   ```

2. Open `Package.swift` in Xcode:
   ```bash
   cd elevate-ios
   open Package.swift
   ```

## Your First Component

### SwiftUI

Create a simple view with an ELEVATE button:

```swift
import SwiftUI
import ElevateUI

struct WelcomeView: View {
    var body: some View {
        VStack(spacing: ElevateSpacing.l) {
            Text("Welcome to ELEVATE!")
                .font(ElevateTypography.headingLarge)
                .foregroundColor(ElevateColors.Text.primary)

            ElevateButton(
                title: "Get Started",
                tone: .primary,
                size: .large
            ) {
                print("Button tapped!")
            }
        }
        .padding(ElevateSpacing.xl)
        .background(ElevateColors.Background.primary)
    }
}
```

### UIKit

Create a view controller with an ELEVATE button:

```swift
import UIKit
import ElevateUI

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = ElevateColors.UIKit.Background.primary

        let titleLabel = UILabel()
        titleLabel.text = "Welcome to ELEVATE!"
        titleLabel.font = ElevateTypography.UIKit.headingLarge
        titleLabel.textColor = ElevateColors.UIKit.Text.primary
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let button = ElevateButton(tone: .primary, size: .large)
        button.setTitle("Get Started", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(titleLabel)
        view.addSubview(button)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ElevateSpacing.xl),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: ElevateSpacing.xl),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -ElevateSpacing.xl)
        ])
    }

    @objc func buttonTapped() {
        print("Button tapped!")
    }
}
```

## Using Design Tokens

### Colors

```swift
// SwiftUI
Text("Hello")
    .foregroundColor(ElevateColors.primary)
    .background(ElevateColors.Background.primary)

// UIKit
label.textColor = ElevateColors.UIKit.primary
view.backgroundColor = ElevateColors.UIKit.Background.primary
```

### Typography

```swift
// SwiftUI
Text("Heading")
    .font(ElevateTypography.headingLarge)

// UIKit
label.font = ElevateTypography.UIKit.headingLarge
```

### Spacing

```swift
// SwiftUI
VStack(spacing: ElevateSpacing.medium) {
    // ...
}
.padding(ElevateSpacing.large)

// UIKit
stackView.spacing = ElevateSpacing.medium
view.layoutMargins = UIEdgeInsets(
    top: ElevateSpacing.large,
    left: ElevateSpacing.large,
    bottom: ElevateSpacing.large,
    right: ElevateSpacing.large
)
```

## Button Examples

### Different Tones

```swift
// Primary (brand color)
ElevateButton(title: "Primary", tone: .primary) { }

// Success (positive actions)
ElevateButton(title: "Success", tone: .success) { }

// Warning (cautions)
ElevateButton(title: "Warning", tone: .warning) { }

// Danger (destructive actions)
ElevateButton(title: "Danger", tone: .danger) { }

// Emphasized (high contrast)
ElevateButton(title: "Emphasized", tone: .emphasized) { }

// Subtle (low contrast)
ElevateButton(title: "Subtle", tone: .subtle) { }
```

### Different Sizes

```swift
ElevateButton(title: "Small", size: .small) { }
ElevateButton(title: "Medium", size: .medium) { }
ElevateButton(title: "Large", size: .large) { }
```

### Different Shapes

```swift
ElevateButton(title: "Default", shape: .default) { }
ElevateButton(title: "Pill", shape: .pill) { }
```

### Disabled State

```swift
ElevateButton(title: "Disabled", isDisabled: true) { }
```

## Running the Example App

1. Open `Package.swift` in Xcode
2. Select the `ElevateUIDemo` scheme
3. Choose a simulator or device
4. Press `Cmd + R` to run

The example app showcases all available components, design tokens, and usage patterns.

## Common Patterns

### Form with Validation

```swift
struct LoginForm: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: ElevateSpacing.l) {
            TextField("Email", text: $email)
                .font(ElevateTypography.bodyMedium)
                .padding(ElevateSpacing.m)
                .background(ElevateColors.Surface.primary)
                .cornerRadius(ElevateSpacing.BorderRadius.medium)

            SecureField("Password", text: $password)
                .font(ElevateTypography.bodyMedium)
                .padding(ElevateSpacing.m)
                .background(ElevateColors.Surface.primary)
                .cornerRadius(ElevateSpacing.BorderRadius.medium)

            ElevateButton(
                title: "Log In",
                tone: .primary,
                size: .large,
                isDisabled: email.isEmpty || password.isEmpty
            ) {
                performLogin()
            }
        }
        .padding(ElevateSpacing.xl)
    }

    func performLogin() {
        // Login logic
    }
}
```

### Card Component

```swift
struct InfoCard: View {
    let title: String
    let description: String

    var body: some View {
        VStack(alignment: .leading, spacing: ElevateSpacing.m) {
            Text(title)
                .font(ElevateTypography.titleMedium)
                .foregroundColor(ElevateColors.Text.primary)

            Text(description)
                .font(ElevateTypography.bodyMedium)
                .foregroundColor(ElevateColors.Text.secondary)
        }
        .padding(ElevateSpacing.l)
        .background(ElevateColors.Surface.primary)
        .cornerRadius(ElevateSpacing.BorderRadius.large)
        .elevateElevation(.medium)
    }
}
```

## Next Steps

- **Explore Components**: Run the example app to see all available components
- **Read Documentation**: Check out the full README for detailed API documentation
- **Design System**: Visit the [ELEVATE Core UI Storybook](https://elevate-core-ui.inform-cloud.io) for design guidelines
- **Contributing**: See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines

## Troubleshooting

### Colors Not Showing

Make sure you've imported the framework:
```swift
import ElevateUI
```

### Custom Fonts Not Loading

The framework uses Inter and Roboto Mono fonts. If they're not available, the system will fall back to San Francisco.

### Build Errors

Try cleaning the build folder:
- In Xcode: **Product → Clean Build Folder** (`Cmd + Shift + K`)
- From terminal: `swift package clean`

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/your-org/elevate-ios/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-org/elevate-ios/discussions)
- **Documentation**: [Full README](README.md)

Happy building with ELEVATE! 🚀
