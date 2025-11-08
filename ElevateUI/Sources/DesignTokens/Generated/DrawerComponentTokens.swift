#if os(iOS)
import SwiftUI

/// ELEVATE Drawer Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct DrawerComponentTokens {

    // MARK: - Colors

    public static let border_color = Color.adaptive(light: ElevateAliases.Layout.General.border_default, dark: ElevateAliases.Layout.General.border_default)
    public static let fill = Color.adaptive(light: ElevateAliases.Layout.Layer.ground, dark: ElevateAliases.Layout.Layer.ground)
    public static let text_color_default = Color.adaptive(light: ElevateAliases.Action.UnderstatedEmphasized.text_default, dark: ElevateAliases.Action.UnderstatedEmphasized.text_default)

    // MARK: - Dimensions

    public static let border_width: CGFloat = 1.0
    public static let column_maxWidth: CGFloat = 420.0
    public static let column_minWidth: CGFloat = 280.0
    public static let gap: CGFloat = 20.0
    public static let padding_block: CGFloat = 20.0
    public static let padding_inline: CGFloat = 20.0
    public static let row_maxHeight: CGFloat = 360.0
    public static let row_minHeight: CGFloat = 280.0

}
#endif
