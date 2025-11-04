#!/bin/bash

# Swift Code Generator Library
# Functions to generate Swift code from parsed design tokens

# Generate ButtonTokens.swift from parsed token data
generate_button_tokens_swift() {
    local token_data="$1"

    cat <<'EOF'
#if os(iOS)
import SwiftUI

@available(iOS 15, *)
public struct ButtonTokens {

    // MARK: - Size Tokens

    public enum Size {
        case small
        case medium
        case large
    }

    // MARK: - Shape Tokens

    public enum Shape {
        case box
        case pill
    }

    // MARK: - Tone Tokens

    public enum Tone {
        case primary
        case secondary
        case success
        case warning
        case danger
        case emphasized
        case subtle
        case neutral
    }

    // MARK: - Color Properties

EOF

    # Extract and generate color properties
    echo "    // Primary Colors"
    for state in default hover active disabled; do
        local fill=$(get_token_value "$token_data" "fill-primary-$state")
        local label=$(get_token_value "$token_data" "label-primary-$state")
        local border=$(get_token_value "$token_data" "border-primary-$state")

        if [ -n "$fill" ]; then
            echo "    public static let fillPrimary${state^}: Color = $fill"
        fi
        if [ -n "$label" ]; then
            echo "    public static let labelPrimary${state^}: Color = $label"
        fi
        if [ -n "$border" ]; then
            echo "    public static let borderPrimary${state^}: Color = $border"
        fi
    done

    cat <<'EOF'

    // MARK: - Size Values

    public static func height(for size: Size) -> CGFloat {
        switch size {
        case .small: return 32.0
        case .medium: return 40.0
        case .large: return 48.0
        }
    }

    public static func horizontalPadding(for size: Size) -> CGFloat {
        switch size {
        case .small: return 12.0
        case .medium: return 16.0
        case .large: return 20.0
        }
    }

    public static func fontSize(for size: Size) -> CGFloat {
        switch size {
        case .small: return 14.0
        case .medium: return 16.0
        case .large: return 18.0
        }
    }

    public static func cornerRadius(for shape: Shape, size: Size) -> CGFloat {
        switch shape {
        case .box: return 4.0
        case .pill: return height(for: size) / 2.0
        }
    }
}

#endif
EOF
}

# Generate ElevateSpacing.swift from parsed spacing tokens
generate_spacing_swift() {
    local token_data="$1"

    cat <<'EOF'
#if os(iOS)
import SwiftUI
import CoreGraphics

@available(iOS 15, *)
public struct ElevateSpacing {

    // MARK: - Distance Scale

EOF

    # Extract spacing values
    for unit in xxs xs s m l xl xxl; do
        local value=$(get_token_value "$token_data" "distance-$unit")
        if [ -n "$value" ]; then
            echo "    public static let distance${unit^^}: CGFloat = $value"
        fi
    done

    cat <<'EOF'

    // MARK: - Convenience Methods

    public static func padding(_ scale: DistanceScale) -> CGFloat {
        switch scale {
        case .xxs: return distanceXXS
        case .xs: return distanceXS
        case .s: return distanceS
        case .m: return distanceM
        case .l: return distanceL
        case .xl: return distanceXL
        case .xxl: return distanceXXL
        }
    }

    public enum DistanceScale {
        case xxs, xs, s, m, l, xl, xxl
    }
}

@available(iOS 15, *)
extension View {
    public func elevatePadding(_ scale: ElevateSpacing.DistanceScale) -> some View {
        self.padding(ElevateSpacing.padding(scale))
    }
}

#endif
EOF
}

# Generate ElevateColors.swift from parsed color tokens
generate_colors_swift() {
    local token_data="$1"

    cat <<'EOF'
#if os(iOS)
import SwiftUI
import UIKit

@available(iOS 15, *)
public struct ElevateColors {

    // MARK: - Action Colors

EOF

    # Extract primary action colors
    echo "    // Primary"
    for variant in default hover active disabled; do
        local strong_fill=$(get_token_value "$token_data" "strong-primary-fill-$variant")
        local strong_label=$(get_token_value "$token_data" "strong-primary-label-$variant")

        if [ -n "$strong_fill" ]; then
            echo "    public static let primaryStrongFill${variant^}: Color = $strong_fill"
        fi
        if [ -n "$strong_label" ]; then
            echo "    public static let primaryStrongLabel${variant^}: Color = $strong_label"
        fi
    done

    # Extract secondary action colors
    echo ""
    echo "    // Secondary"
    for variant in default hover active disabled; do
        local strong_fill=$(get_token_value "$token_data" "strong-secondary-fill-$variant")
        local strong_label=$(get_token_value "$token_data" "strong-secondary-label-$variant")

        if [ -n "$strong_fill" ]; then
            echo "    public static let secondaryStrongFill${variant^}: Color = $strong_fill"
        fi
        if [ -n "$strong_label" ]; then
            echo "    public static let secondaryStrongLabel${variant^}: Color = $strong_label"
        fi
    done

    cat <<'EOF'

    // MARK: - Helper Methods

    public static func actionColor(tone: ButtonTokens.Tone, state: ActionState) -> Color {
        switch (tone, state) {
        case (.primary, .default): return primaryStrongFillDefault
        case (.primary, .hover): return primaryStrongFillHover
        case (.primary, .active): return primaryStrongFillActive
        case (.primary, .disabled): return primaryStrongFillDisabled
        default: return .gray
        }
    }

    public enum ActionState {
        case `default`
        case hover
        case active
        case disabled
    }
}

@available(iOS 15, *)
extension ElevateColors {

    // MARK: - UIKit Color Extensions

    public static var uikitPrimaryDefault: UIColor {
        UIColor(primaryStrongFillDefault)
    }
}

#endif
EOF
}
