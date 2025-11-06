#if os(iOS)
import SwiftUI

/// ELEVATE Paginator Component Tokens
///
/// Complete token set including colors, spacing, and dimensions.
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v4.py to update
@available(iOS 15, *)
public struct PaginatorComponentTokens {

    // MARK: - Colors

    public static let text_color = Color.adaptive(light: ButtonComponentTokens.label_emphasized_default, dark: ButtonComponentTokens.label_emphasized_default)

    // MARK: - Dimensions

    public static let gap_l: CGFloat = 16.0
    public static let gap_m: CGFloat = 12.0
    public static let gap_s: CGFloat = 8.0
    public static let range_padding_inline_start_l: CGFloat = 24.0
    public static let range_padding_inline_start_m: CGFloat = 20.0
    public static let range_padding_inline_start_s: CGFloat = 16.0

}
#endif
