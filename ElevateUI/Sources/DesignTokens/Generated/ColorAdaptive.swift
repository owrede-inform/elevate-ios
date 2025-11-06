#if os(iOS)
import SwiftUI
import UIKit

extension Color {
    /// Creates an adaptive color that changes between light and dark mode
    public static func adaptive(light: Color, dark: Color) -> Color {
        return Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
    }

    /// Creates an adaptive color from RGB tuples
    public static func adaptive(
        lightRGB: (red: Double, green: Double, blue: Double, opacity: Double),
        darkRGB: (red: Double, green: Double, blue: Double, opacity: Double)
    ) -> Color {
        let lightColor = Color(red: lightRGB.red, green: lightRGB.green, blue: lightRGB.blue, opacity: lightRGB.opacity)
        let darkColor = Color(red: darkRGB.red, green: darkRGB.green, blue: darkRGB.blue, opacity: darkRGB.opacity)
        return adaptive(light: lightColor, dark: darkColor)
    }
}
#endif
