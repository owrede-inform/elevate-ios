# ELEVATE iOS UI Kit

A native iOS UI component library based on the ELEVATE Design System. This kit provides SwiftUI and UIKit components styled with ELEVATE design tokens.

## Overview

ELEVATE iOS UI Kit is a port of the [ELEVATE Core UI](https://github.com/inform-elevate/elevate-core-ui) web component library to native iOS. It implements the ELEVATE Design System using native iOS components with consistent styling.

## Features

- **Dual Framework Support**: Components available for both SwiftUI and UIKit
- **Design Token System**: Centralized design tokens for colors, typography, spacing, and more
- **Inter Font Included**: Official ELEVATE typography with Inter font family bundled
- **Theme Support**: Built-in light and dark theme support
- **Native iOS**: Built with native iOS components and patterns
- **Type-Safe**: Leverages Swift's type system for design token access

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.7+

## Inter Font Included

ElevateUI includes the **Inter font family** as specified by the ELEVATE Design System. The font is automatically bundled with the package and ready to use.

**Important**: You must register fonts before using ElevateUI:

```swift
import ElevateUI

@main
struct MyApp: App {
    init() {
        ElevateFontRegistration.registerFonts()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

See [FONTS.md](ElevateUI/FONTS.md) for complete font documentation.

## Installation

### Swift Package Manager

Add the following to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/elevate-ios", from: "0.1.0")
]
```

### CocoaPods

```ruby
pod 'ElevateUI', '~> 0.1.0'
```

## Project Structure

```
elevate-ios/
├── ElevateUI/                    # Main framework
│   └── Sources/
│       ├── DesignTokens/         # Design token definitions
│       │   ├── Colors/           # Color tokens
│       │   ├── Typography/       # Font and text style tokens
│       │   ├── Spacing/          # Spacing and sizing tokens
│       │   └── Components/       # Component-specific tokens
│       ├── SwiftUI/              # SwiftUI components
│       └── UIKit/                # UIKit components
├── ElevateUIExample/             # Example application
└── ElevateUI.xcodeproj           # Xcode project
```

## Usage

### SwiftUI

```swift
import ElevateUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: ElevateSpacing.medium) {
            ElevateButton(
                title: "Primary Button",
                tone: .primary,
                action: { print("Tapped") }
            )

            ElevateButton(
                title: "Success Button",
                tone: .success,
                size: .large,
                action: { print("Tapped") }
            )
        }
    }
}
```

### UIKit

```swift
import ElevateUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let button = ElevateButton(tone: .primary)
        button.setTitle("Primary Button", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        view.addSubview(button)
    }

    @objc func buttonTapped() {
        print("Button tapped")
    }
}
```

## Design Tokens

The library provides centralized design tokens for consistent styling:

### Colors

```swift
// SwiftUI
Text("Hello").foregroundColor(ElevateColors.primary)

// UIKit
label.textColor = ElevateColors.UIKit.primary
```

### Typography

```swift
// SwiftUI
Text("Heading").font(ElevateTypography.headingLarge)

// UIKit
label.font = ElevateTypography.UIKit.headingLarge
```

### Spacing

```swift
// SwiftUI
VStack(spacing: ElevateSpacing.medium) { }

// UIKit
stackView.spacing = ElevateSpacing.medium
```

## Components

### Available Components

- **Buttons**: Primary, secondary, success, warning, danger, emphasized, subtle tones
- **Text Fields**: Input fields with validation states
- **Cards**: Container components with elevation
- **Badges**: Status indicators and labels
- **More coming soon...**

## Development

### Building the Framework

```bash
# Open in Xcode
open ElevateUI.xcodeproj

# Or build from command line
xcodebuild -project ElevateUI.xcodeproj -scheme ElevateUI -configuration Release
```

### Running the Example App

```bash
open ElevateUI.xcodeproj
# Select ElevateUIExample scheme and run
```

## Design System Reference

This library implements the ELEVATE Design System. For the complete design specification, see the [ELEVATE Core UI documentation](https://github.com/inform-elevate/elevate-core-ui).

## Contributing

Contributions are welcome! Please read our contributing guidelines before submitting pull requests.

## License

UNLICENSED - Copyright (c) INFORM ELEVATE

## Related Repositories

- [ELEVATE Core UI](https://github.com/inform-elevate/elevate-core-ui) - Web component library
- [ELEVATE Design Tokens](https://github.com/inform-elevate/elevate-design-tokens) - Design token definitions