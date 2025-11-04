# Inter Font in ElevateUI

ElevateUI includes the **Inter font family** as specified in the ELEVATE Design System.

## What's Included

### Variable Fonts (Recommended)
- `InterVariable.ttf` - Supports all weights from Thin (100) to Black (900)
- `InterVariable-Italic.ttf` - Italic variant with all weights

### Static Fonts (Fallback)
- `Inter-Regular.ttf` - Weight 400
- `Inter-Medium.ttf` - Weight 500
- `Inter-SemiBold.ttf` - Weight 600
- `Inter-Bold.ttf` - Weight 700

## Font Registration

**Important**: You must register fonts before using ElevateUI typography components.

### SwiftUI App

```swift
import SwiftUI
import ElevateUI

@main
struct MyApp: App {
    init() {
        // Register ELEVATE fonts
        ElevateFontRegistration.registerFonts()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

### UIKit App

```swift
import UIKit
import ElevateUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Register ELEVATE fonts
        ElevateFontRegistration.registerFonts()
        return true
    }
}
```

## Using Typography

Once fonts are registered, use ELEVATE typography styles:

### SwiftUI

```swift
import SwiftUI
import ElevateUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            // Headings
            Text("Display Large")
                .font(ElevateTypography.displayLarge)

            Text("Heading Medium")
                .font(ElevateTypography.headingMedium)

            // Body text
            Text("This is body text using Inter font.")
                .font(ElevateTypography.bodyMedium)

            // Labels
            Text("Label Small")
                .font(ElevateTypography.labelSmall)
        }
    }
}
```

### UIKit

```swift
import UIKit
import ElevateUI

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleLabel = UILabel()
        titleLabel.font = ElevateTypography.UIKit.headingLarge
        titleLabel.text = "Welcome"

        let bodyLabel = UILabel()
        bodyLabel.font = ElevateTypography.UIKit.bodyMedium
        bodyLabel.text = "This text uses Inter font."
    }
}
```

## Available Typography Styles

### Display (Largest)
- `displayLarge` - 57pt, Bold
- `displayMedium` - 45pt, Bold
- `displaySmall` - 36pt, Bold

### Headings
- `headingLarge` - 32pt, Bold
- `headingMedium` - 28pt, Bold
- `headingSmall` - 24pt, SemiBold
- `headingXSmall` - 20pt, SemiBold

### Titles
- `titleLarge` - 22pt, SemiBold
- `titleMedium` - 16pt, SemiBold
- `titleSmall` - 14pt, SemiBold

### Body Text
- `bodyLarge` - 16pt, Regular
- `bodyMedium` - 14pt, Regular (default)
- `bodySmall` - 12pt, Regular

### Labels
- `labelLarge` - 16pt, Medium
- `labelMedium` - 14pt, Medium
- `labelSmall` - 12pt, Medium
- `labelXSmall` - 11pt, Medium

## Debugging Font Issues

If fonts don't appear correctly:

### Check Font Registration

```swift
// List available Inter fonts
let interFonts = ElevateFontRegistration.availableInterFonts()
print("Available Inter fonts: \(interFonts)")

// Get detailed font information
let debugInfo = ElevateFontRegistration.debugInterFonts()
print("Inter font details: \(debugInfo)")
```

### Common Issues

**Problem**: Text appears in San Francisco (system font) instead of Inter
**Solution**:
1. Ensure you called `ElevateFontRegistration.registerFonts()` in your app's initialization
2. Check debug console for font registration warnings (only visible in DEBUG builds)
3. Verify fonts are included in your app bundle

**Problem**: Build warnings about font files
**Solution**: Font files are automatically included by Swift Package Manager via the Resources directory

## Font Fallback

All typography styles include automatic fallback to San Francisco (iOS system font) if Inter fails to load:

```swift
// This pattern is used throughout ElevateTypography
UIFont(name: "Inter", size: 16)?.withWeight(.regular)
    ?? .systemFont(ofSize: 16, weight: .regular)
```

This ensures your app always displays readable text, even if font registration fails.

## License

Inter font is licensed under the **SIL Open Font License 1.1**.

See `ElevateUI/Sources/Resources/Fonts/Inter-LICENSE.txt` for full license text.

### Key Points:
- ✅ Free for commercial use
- ✅ Can be embedded in applications
- ✅ Can be modified and redistributed
- ❌ Cannot be sold by itself

Full license: http://scripts.sil.org/OFL

## About Inter

Inter is designed specifically for computer screens, featuring:
- Optimized for legibility at small sizes
- Tall x-height for improved readability
- Clear distinction between similar characters (1, l, I)
- Variable font technology for precise weight control
- Wide language support

Created by Rasmus Andersson: https://rsms.me/inter/

## Version

**Inter v4.1** (November 2024)

ElevateUI packages the latest stable release of Inter from the official repository.
