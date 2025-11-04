import Foundation
import CoreText
#if os(iOS)
import UIKit

/// Font registration utility for ELEVATE design system fonts
///
/// Call `ElevateFontRegistration.registerFonts()` early in your app lifecycle
/// (e.g., in AppDelegate or App struct) to register custom fonts.
@available(iOS 15, *)
public enum ElevateFontRegistration {

    /// Register all ELEVATE custom fonts
    ///
    /// This method should be called once during app initialization,
    /// typically in your AppDelegate's `application(_:didFinishLaunchingWithOptions:)`
    /// or SwiftUI App's `init()`.
    ///
    /// Example usage in SwiftUI:
    /// ```swift
    /// @main
    /// struct MyApp: App {
    ///     init() {
    ///         ElevateFontRegistration.registerFonts()
    ///     }
    ///
    ///     var body: some Scene {
    ///         WindowGroup {
    ///             ContentView()
    ///         }
    ///     }
    /// }
    /// ```
    ///
    /// Example usage in UIKit:
    /// ```swift
    /// @main
    /// class AppDelegate: UIResponder, UIApplicationDelegate {
    ///     func application(_ application: UIApplication,
    ///                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    ///         ElevateFontRegistration.registerFonts()
    ///         return true
    ///     }
    /// }
    /// ```
    public static func registerFonts() {
        let fontNames = [
            // Variable fonts (recommended)
            "InterVariable.ttf",
            "InterVariable-Italic.ttf",
            // Static weight fonts (fallback)
            "Inter-Regular.ttf",
            "Inter-Medium.ttf",
            "Inter-SemiBold.ttf",
            "Inter-Bold.ttf"
        ]

        for fontName in fontNames {
            registerFont(fileName: fontName)
        }
    }

    /// Register a specific font file
    ///
    /// - Parameter fileName: The name of the font file in the Resources/Fonts directory
    private static func registerFont(fileName: String) {
        guard let fontURL = Bundle.module.url(forResource: "Fonts/\(fileName.replacingOccurrences(of: ".ttf", with: ""))",
                                              withExtension: "ttf") else {
            #if DEBUG
            print("⚠️ ElevateUI: Could not find font file: \(fileName)")
            print("   Searched in: \(Bundle.module.bundleURL)")
            #endif
            return
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            #if DEBUG
            print("⚠️ ElevateUI: Could not create data provider for font: \(fileName)")
            #endif
            return
        }

        guard let font = CGFont(fontDataProvider) else {
            #if DEBUG
            print("⚠️ ElevateUI: Could not create font from file: \(fileName)")
            #endif
            return
        }

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            #if DEBUG
            if let error = error?.takeRetainedValue() {
                print("⚠️ ElevateUI: Failed to register font \(fileName): \(error)")
            }
            #endif
        } else {
            #if DEBUG
            print("✅ ElevateUI: Successfully registered font: \(fileName)")
            #endif
        }
    }

    /// Check if Inter fonts are available
    ///
    /// Useful for debugging font registration issues.
    ///
    /// - Returns: Array of available Inter font family names
    public static func availableInterFonts() -> [String] {
        UIFont.familyNames
            .filter { $0.lowercased().contains("inter") }
            .sorted()
    }

    /// List all available Inter font names with their full PostScript names
    ///
    /// Useful for debugging to see exact font names registered.
    ///
    /// - Returns: Dictionary mapping family name to array of font names
    public static func debugInterFonts() -> [String: [String]] {
        var result: [String: [String]] = [:]

        for familyName in UIFont.familyNames.filter({ $0.lowercased().contains("inter") }) {
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            result[familyName] = fontNames
        }

        return result
    }
}

#endif
