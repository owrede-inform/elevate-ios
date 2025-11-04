#if os(iOS)
import SwiftUI

/// ELEVATE Design System Primitive Tokens
///
/// Base color palette - the foundation of the design system.
/// These are raw color values that should not be used directly in components.
/// Use alias or component tokens instead.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v2.py to update
@available(iOS 15, *)
public struct ElevatePrimitives {

    // MARK: - Color Primitives

    // MARK: Black Scale
    
    public enum Black {
        public static let _color_black = Color(red: 0.0000, green: 0.0000, blue: 0.0000)
    }

    // MARK: Blue Scale
    
    public enum Blue {
        public static let _100 = Color(red: 0.7255, green: 0.8588, blue: 1.0000)
        public static let _1000 = Color(red: 0.0706, green: 0.0706, blue: 0.0745)
        public static let _200 = Color(red: 0.5647, green: 0.7765, blue: 1.0000)
        public static let _300 = Color(red: 0.3725, green: 0.6745, blue: 1.0000)
        public static let _400 = Color(red: 0.1647, green: 0.5647, blue: 1.0000)
        public static let _50 = Color(red: 0.9176, green: 0.9569, blue: 1.0000)
        public static let _500 = Color(red: 0.0000, green: 0.4471, blue: 1.0000)
        public static let _600 = Color(red: 0.0431, green: 0.3608, blue: 0.8745)
        public static let _700 = Color(red: 0.1059, green: 0.3137, blue: 0.6510)
        public static let _800 = Color(red: 0.1373, green: 0.2588, blue: 0.4588)
        public static let _900 = Color(red: 0.1373, green: 0.2000, blue: 0.2941)
        public static let _950 = Color(red: 0.1137, green: 0.1294, blue: 0.1608)
    }

    // MARK: Gray Scale
    
    public enum Gray {
        public static let _100 = Color(red: 0.8353, green: 0.8510, blue: 0.8824)
        public static let _1000 = Color(red: 0.0667, green: 0.0706, blue: 0.0902)
        public static let _200 = Color(red: 0.7451, green: 0.7647, blue: 0.8039)
        public static let _300 = Color(red: 0.6392, green: 0.6667, blue: 0.7059)
        public static let _400 = Color(red: 0.5333, green: 0.5686, blue: 0.6275)
        public static let _50 = Color(red: 0.9529, green: 0.9569, blue: 0.9686)
        public static let _500 = Color(red: 0.4392, green: 0.4784, blue: 0.5608)
        public static let _600 = Color(red: 0.3647, green: 0.4000, blue: 0.4745)
        public static let _700 = Color(red: 0.3020, green: 0.3255, blue: 0.4000)
        public static let _800 = Color(red: 0.2392, green: 0.2588, blue: 0.3255)
        public static let _900 = Color(red: 0.1843, green: 0.1961, blue: 0.2510)
        public static let _950 = Color(red: 0.1216, green: 0.1294, blue: 0.1686)
    }

    // MARK: Green Scale
    
    public enum Green {
        public static let _100 = Color(red: 0.6667, green: 0.9020, blue: 0.7373)
        public static let _1000 = Color(red: 0.0627, green: 0.0745, blue: 0.0667)
        public static let _200 = Color(red: 0.4588, green: 0.8392, blue: 0.5725)
        public static let _300 = Color(red: 0.2235, green: 0.7529, blue: 0.3843)
        public static let _400 = Color(red: 0.1922, green: 0.6471, blue: 0.3294)
        public static let _50 = Color(red: 0.9020, green: 0.9725, blue: 0.9255)
        public static let _500 = Color(red: 0.0706, green: 0.5490, blue: 0.2745)
        public static let _600 = Color(red: 0.0196, green: 0.4627, blue: 0.2392)
        public static let _700 = Color(red: 0.0196, green: 0.3765, blue: 0.2118)
        public static let _800 = Color(red: 0.0431, green: 0.3020, blue: 0.1843)
        public static let _900 = Color(red: 0.0627, green: 0.2275, blue: 0.1490)
        public static let _950 = Color(red: 0.0745, green: 0.1451, blue: 0.1137)
    }

    // MARK: Orange Scale
    
    public enum Orange {
        public static let _100 = Color(red: 1.0000, green: 0.8275, blue: 0.4745)
        public static let _1000 = Color(red: 0.1412, green: 0.0431, blue: 0.0000)
        public static let _200 = Color(red: 1.0000, green: 0.7020, blue: 0.2118)
        public static let _300 = Color(red: 0.9725, green: 0.5608, blue: 0.0000)
        public static let _400 = Color(red: 0.8471, green: 0.4706, blue: 0.0000)
        public static let _50 = Color(red: 1.0000, green: 0.9529, blue: 0.8275)
        public static let _500 = Color(red: 0.7333, green: 0.3882, blue: 0.0000)
        public static let _600 = Color(red: 0.6431, green: 0.3020, blue: 0.0000)
        public static let _700 = Color(red: 0.5569, green: 0.2275, blue: 0.0000)
        public static let _800 = Color(red: 0.4667, green: 0.1647, blue: 0.0000)
        public static let _900 = Color(red: 0.3725, green: 0.1098, blue: 0.0000)
        public static let _950 = Color(red: 0.2510, green: 0.0745, blue: 0.0000)
    }

    // MARK: Red Scale
    
    public enum Red {
        public static let _100 = Color(red: 1.0000, green: 0.8000, blue: 0.8000)
        public static let _1000 = Color(red: 0.0863, green: 0.0667, blue: 0.0667)
        public static let _200 = Color(red: 1.0000, green: 0.6745, blue: 0.6745)
        public static let _300 = Color(red: 1.0000, green: 0.5176, blue: 0.5176)
        public static let _400 = Color(red: 0.9961, green: 0.3255, blue: 0.3255)
        public static let _50 = Color(red: 1.0000, green: 0.9412, blue: 0.9412)
        public static let _500 = Color(red: 0.9608, green: 0.0039, blue: 0.0039)
        public static let _600 = Color(red: 0.8078, green: 0.0039, blue: 0.0039)
        public static let _700 = Color(red: 0.6706, green: 0.0039, blue: 0.0039)
        public static let _800 = Color(red: 0.5451, green: 0.0039, blue: 0.0039)
        public static let _900 = Color(red: 0.4235, green: 0.0039, blue: 0.0039)
        public static let _950 = Color(red: 0.2627, green: 0.0549, blue: 0.0549)
    }

    // MARK: Transparent Scale
    
    public enum Transparent {
        public static let _color_transparent = Color(red: 1.0000, green: 1.0000, blue: 1.0000, opacity: 0.0000)
    }

    // MARK: White Scale
    
    public enum White {
        public static let _color_white = Color(red: 1.0000, green: 1.0000, blue: 1.0000)
    }

}
#endif
