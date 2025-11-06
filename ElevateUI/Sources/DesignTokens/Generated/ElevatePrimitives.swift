#if os(iOS)
import SwiftUI

/// ELEVATE Design System Primitive Tokens
///
/// Base color palette EXTRACTED from ELEVATE SCSS source.
/// These are raw color values - use Alias or Component tokens instead.
///
/// ⚠️  DO NOT USE DIRECTLY IN COMPONENTS
/// ✅  Use Component Tokens or Alias Tokens instead
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct ElevatePrimitives {

    // MARK: - Color Primitives

    // MARK: Black Scale

    public enum Black {
        public static let _color_black = Color.adaptive(
            lightRGB: (red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.0000, green: 0.0000, blue: 0.0000, opacity: 1.0000)
        )
    }

    // MARK: Blue Scale

    public enum Blue {
        public static let _100 = Color.adaptive(
            lightRGB: (red: 0.7255, green: 0.8588, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.7255, green: 0.8588, blue: 1.0000, opacity: 1.0000)
        )
        public static let _1000 = Color.adaptive(
            lightRGB: (red: 0.0706, green: 0.0706, blue: 0.0745, opacity: 1.0000),
            darkRGB: (red: 0.0706, green: 0.0706, blue: 0.0745, opacity: 1.0000)
        )
        public static let _200 = Color.adaptive(
            lightRGB: (red: 0.5647, green: 0.7765, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.5647, green: 0.7765, blue: 1.0000, opacity: 1.0000)
        )
        public static let _300 = Color.adaptive(
            lightRGB: (red: 0.3725, green: 0.6745, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.3725, green: 0.6745, blue: 1.0000, opacity: 1.0000)
        )
        public static let _400 = Color.adaptive(
            lightRGB: (red: 0.1647, green: 0.5647, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.1647, green: 0.5647, blue: 1.0000, opacity: 1.0000)
        )
        public static let _50 = Color.adaptive(
            lightRGB: (red: 0.9176, green: 0.9569, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.9176, green: 0.9569, blue: 1.0000, opacity: 1.0000)
        )
        public static let _500 = Color.adaptive(
            lightRGB: (red: 0.0000, green: 0.4471, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 0.0000, green: 0.4471, blue: 1.0000, opacity: 1.0000)
        )
        public static let _600 = Color.adaptive(
            lightRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000),
            darkRGB: (red: 0.0431, green: 0.3608, blue: 0.8745, opacity: 1.0000)
        )
        public static let _700 = Color.adaptive(
            lightRGB: (red: 0.1059, green: 0.3137, blue: 0.6510, opacity: 1.0000),
            darkRGB: (red: 0.1059, green: 0.3137, blue: 0.6510, opacity: 1.0000)
        )
        public static let _800 = Color.adaptive(
            lightRGB: (red: 0.1373, green: 0.2588, blue: 0.4588, opacity: 1.0000),
            darkRGB: (red: 0.1373, green: 0.2588, blue: 0.4588, opacity: 1.0000)
        )
        public static let _900 = Color.adaptive(
            lightRGB: (red: 0.1373, green: 0.2000, blue: 0.2941, opacity: 1.0000),
            darkRGB: (red: 0.1373, green: 0.2000, blue: 0.2941, opacity: 1.0000)
        )
        public static let _950 = Color.adaptive(
            lightRGB: (red: 0.1137, green: 0.1294, blue: 0.1608, opacity: 1.0000),
            darkRGB: (red: 0.1137, green: 0.1294, blue: 0.1608, opacity: 1.0000)
        )
    }

    // MARK: Gray Scale

    public enum Gray {
        public static let _100 = Color.adaptive(
            lightRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000),
            darkRGB: (red: 0.8353, green: 0.8510, blue: 0.8824, opacity: 1.0000)
        )
        public static let _1000 = Color.adaptive(
            lightRGB: (red: 0.0667, green: 0.0706, blue: 0.0902, opacity: 1.0000),
            darkRGB: (red: 0.0667, green: 0.0706, blue: 0.0902, opacity: 1.0000)
        )
        public static let _200 = Color.adaptive(
            lightRGB: (red: 0.7451, green: 0.7647, blue: 0.8039, opacity: 1.0000),
            darkRGB: (red: 0.7451, green: 0.7647, blue: 0.8039, opacity: 1.0000)
        )
        public static let _300 = Color.adaptive(
            lightRGB: (red: 0.6392, green: 0.6667, blue: 0.7059, opacity: 1.0000),
            darkRGB: (red: 0.6392, green: 0.6667, blue: 0.7059, opacity: 1.0000)
        )
        public static let _400 = Color.adaptive(
            lightRGB: (red: 0.5333, green: 0.5686, blue: 0.6275, opacity: 1.0000),
            darkRGB: (red: 0.5333, green: 0.5686, blue: 0.6275, opacity: 1.0000)
        )
        public static let _50 = Color.adaptive(
            lightRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000),
            darkRGB: (red: 0.9529, green: 0.9569, blue: 0.9686, opacity: 1.0000)
        )
        public static let _500 = Color.adaptive(
            lightRGB: (red: 0.4392, green: 0.4784, blue: 0.5608, opacity: 1.0000),
            darkRGB: (red: 0.4392, green: 0.4784, blue: 0.5608, opacity: 1.0000)
        )
        public static let _600 = Color.adaptive(
            lightRGB: (red: 0.3647, green: 0.4000, blue: 0.4745, opacity: 1.0000),
            darkRGB: (red: 0.3647, green: 0.4000, blue: 0.4745, opacity: 1.0000)
        )
        public static let _700 = Color.adaptive(
            lightRGB: (red: 0.3020, green: 0.3255, blue: 0.4000, opacity: 1.0000),
            darkRGB: (red: 0.3020, green: 0.3255, blue: 0.4000, opacity: 1.0000)
        )
        public static let _800 = Color.adaptive(
            lightRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000),
            darkRGB: (red: 0.2392, green: 0.2588, blue: 0.3255, opacity: 1.0000)
        )
        public static let _900 = Color.adaptive(
            lightRGB: (red: 0.1843, green: 0.1961, blue: 0.2510, opacity: 1.0000),
            darkRGB: (red: 0.1843, green: 0.1961, blue: 0.2510, opacity: 1.0000)
        )
        public static let _950 = Color.adaptive(
            lightRGB: (red: 0.1216, green: 0.1294, blue: 0.1686, opacity: 1.0000),
            darkRGB: (red: 0.1216, green: 0.1294, blue: 0.1686, opacity: 1.0000)
        )
    }

    // MARK: Green Scale

    public enum Green {
        public static let _100 = Color.adaptive(
            lightRGB: (red: 0.6667, green: 0.9020, blue: 0.7373, opacity: 1.0000),
            darkRGB: (red: 0.6667, green: 0.9020, blue: 0.7373, opacity: 1.0000)
        )
        public static let _1000 = Color.adaptive(
            lightRGB: (red: 0.0627, green: 0.0745, blue: 0.0667, opacity: 1.0000),
            darkRGB: (red: 0.0627, green: 0.0745, blue: 0.0667, opacity: 1.0000)
        )
        public static let _200 = Color.adaptive(
            lightRGB: (red: 0.4588, green: 0.8392, blue: 0.5725, opacity: 1.0000),
            darkRGB: (red: 0.4588, green: 0.8392, blue: 0.5725, opacity: 1.0000)
        )
        public static let _300 = Color.adaptive(
            lightRGB: (red: 0.2235, green: 0.7529, blue: 0.3843, opacity: 1.0000),
            darkRGB: (red: 0.2235, green: 0.7529, blue: 0.3843, opacity: 1.0000)
        )
        public static let _400 = Color.adaptive(
            lightRGB: (red: 0.1922, green: 0.6471, blue: 0.3294, opacity: 1.0000),
            darkRGB: (red: 0.1922, green: 0.6471, blue: 0.3294, opacity: 1.0000)
        )
        public static let _50 = Color.adaptive(
            lightRGB: (red: 0.9020, green: 0.9725, blue: 0.9255, opacity: 1.0000),
            darkRGB: (red: 0.9020, green: 0.9725, blue: 0.9255, opacity: 1.0000)
        )
        public static let _500 = Color.adaptive(
            lightRGB: (red: 0.0706, green: 0.5490, blue: 0.2745, opacity: 1.0000),
            darkRGB: (red: 0.0706, green: 0.5490, blue: 0.2745, opacity: 1.0000)
        )
        public static let _600 = Color.adaptive(
            lightRGB: (red: 0.0196, green: 0.4627, blue: 0.2392, opacity: 1.0000),
            darkRGB: (red: 0.0196, green: 0.4627, blue: 0.2392, opacity: 1.0000)
        )
        public static let _700 = Color.adaptive(
            lightRGB: (red: 0.0196, green: 0.3765, blue: 0.2118, opacity: 1.0000),
            darkRGB: (red: 0.0196, green: 0.3765, blue: 0.2118, opacity: 1.0000)
        )
        public static let _800 = Color.adaptive(
            lightRGB: (red: 0.0431, green: 0.3020, blue: 0.1843, opacity: 1.0000),
            darkRGB: (red: 0.0431, green: 0.3020, blue: 0.1843, opacity: 1.0000)
        )
        public static let _900 = Color.adaptive(
            lightRGB: (red: 0.0627, green: 0.2275, blue: 0.1490, opacity: 1.0000),
            darkRGB: (red: 0.0627, green: 0.2275, blue: 0.1490, opacity: 1.0000)
        )
        public static let _950 = Color.adaptive(
            lightRGB: (red: 0.0745, green: 0.1451, blue: 0.1137, opacity: 1.0000),
            darkRGB: (red: 0.0745, green: 0.1451, blue: 0.1137, opacity: 1.0000)
        )
    }

    // MARK: Orange Scale

    public enum Orange {
        public static let _100 = Color.adaptive(
            lightRGB: (red: 1.0000, green: 0.8275, blue: 0.4745, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 0.8275, blue: 0.4745, opacity: 1.0000)
        )
        public static let _1000 = Color.adaptive(
            lightRGB: (red: 0.1412, green: 0.0431, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.1412, green: 0.0431, blue: 0.0000, opacity: 1.0000)
        )
        public static let _200 = Color.adaptive(
            lightRGB: (red: 1.0000, green: 0.7020, blue: 0.2118, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 0.7020, blue: 0.2118, opacity: 1.0000)
        )
        public static let _300 = Color.adaptive(
            lightRGB: (red: 0.9725, green: 0.5608, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.9725, green: 0.5608, blue: 0.0000, opacity: 1.0000)
        )
        public static let _400 = Color.adaptive(
            lightRGB: (red: 0.8471, green: 0.4706, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.8471, green: 0.4706, blue: 0.0000, opacity: 1.0000)
        )
        public static let _50 = Color.adaptive(
            lightRGB: (red: 1.0000, green: 0.9529, blue: 0.8275, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 0.9529, blue: 0.8275, opacity: 1.0000)
        )
        public static let _500 = Color.adaptive(
            lightRGB: (red: 0.7333, green: 0.3882, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.7333, green: 0.3882, blue: 0.0000, opacity: 1.0000)
        )
        public static let _600 = Color.adaptive(
            lightRGB: (red: 0.6431, green: 0.3020, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.6431, green: 0.3020, blue: 0.0000, opacity: 1.0000)
        )
        public static let _700 = Color.adaptive(
            lightRGB: (red: 0.5569, green: 0.2275, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.5569, green: 0.2275, blue: 0.0000, opacity: 1.0000)
        )
        public static let _800 = Color.adaptive(
            lightRGB: (red: 0.4667, green: 0.1647, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.4667, green: 0.1647, blue: 0.0000, opacity: 1.0000)
        )
        public static let _900 = Color.adaptive(
            lightRGB: (red: 0.3725, green: 0.1098, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.3725, green: 0.1098, blue: 0.0000, opacity: 1.0000)
        )
        public static let _950 = Color.adaptive(
            lightRGB: (red: 0.2510, green: 0.0745, blue: 0.0000, opacity: 1.0000),
            darkRGB: (red: 0.2510, green: 0.0745, blue: 0.0000, opacity: 1.0000)
        )
    }

    // MARK: Red Scale

    public enum Red {
        public static let _100 = Color.adaptive(
            lightRGB: (red: 1.0000, green: 0.8000, blue: 0.8000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 0.8000, blue: 0.8000, opacity: 1.0000)
        )
        public static let _1000 = Color.adaptive(
            lightRGB: (red: 0.0863, green: 0.0667, blue: 0.0667, opacity: 1.0000),
            darkRGB: (red: 0.0863, green: 0.0667, blue: 0.0667, opacity: 1.0000)
        )
        public static let _200 = Color.adaptive(
            lightRGB: (red: 1.0000, green: 0.6745, blue: 0.6745, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 0.6745, blue: 0.6745, opacity: 1.0000)
        )
        public static let _300 = Color.adaptive(
            lightRGB: (red: 1.0000, green: 0.5176, blue: 0.5176, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 0.5176, blue: 0.5176, opacity: 1.0000)
        )
        public static let _400 = Color.adaptive(
            lightRGB: (red: 0.9961, green: 0.3255, blue: 0.3255, opacity: 1.0000),
            darkRGB: (red: 0.9961, green: 0.3255, blue: 0.3255, opacity: 1.0000)
        )
        public static let _50 = Color.adaptive(
            lightRGB: (red: 1.0000, green: 0.9412, blue: 0.9412, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 0.9412, blue: 0.9412, opacity: 1.0000)
        )
        public static let _500 = Color.adaptive(
            lightRGB: (red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.9608, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
        public static let _600 = Color.adaptive(
            lightRGB: (red: 0.8078, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.8078, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
        public static let _700 = Color.adaptive(
            lightRGB: (red: 0.6706, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.6706, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
        public static let _800 = Color.adaptive(
            lightRGB: (red: 0.5451, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.5451, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
        public static let _900 = Color.adaptive(
            lightRGB: (red: 0.4235, green: 0.0039, blue: 0.0039, opacity: 1.0000),
            darkRGB: (red: 0.4235, green: 0.0039, blue: 0.0039, opacity: 1.0000)
        )
        public static let _950 = Color.adaptive(
            lightRGB: (red: 0.2627, green: 0.0549, blue: 0.0549, opacity: 1.0000),
            darkRGB: (red: 0.2627, green: 0.0549, blue: 0.0549, opacity: 1.0000)
        )
    }

    // MARK: Transparent Scale

    public enum Transparent {
    }

    // MARK: White Scale

    public enum White {
        public static let _color_white = Color.adaptive(
            lightRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000),
            darkRGB: (red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 1.0000)
        )
    }

}
#endif
