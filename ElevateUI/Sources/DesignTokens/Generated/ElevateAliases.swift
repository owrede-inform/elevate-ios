#if os(iOS)
import SwiftUI

/// ELEVATE Design System Alias Tokens
///
/// Semantic tokens with light/dark mode support.
/// These reference primitive tokens and provide semantic meaning.
///
/// Auto-generated from ELEVATE design tokens
/// DO NOT EDIT MANUALLY - Run scripts/update-design-tokens-v3.py to update
@available(iOS 15, *)
public struct ElevateAliases {

    // MARK: - Alias Tokens

    // MARK: Action

    public enum Action {

        // MARK: Focus

        public enum Focus {
            public static let border_color_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._600
                        )
            public static let border_color_invalid = Color.adaptive(
                            light: ElevatePrimitives.Red._600,
                            dark: ElevatePrimitives.Red._600
                        )
        }

        // MARK: StrongDanger

        public enum StrongDanger {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Red._800,
                            dark: ElevatePrimitives.Red._700
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Red._500,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Red._50,
                            dark: ElevatePrimitives.Red._950
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._600,
                            dark: ElevatePrimitives.Red._600
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Red._900,
                            dark: ElevatePrimitives.Red._800
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Red._700,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._800,
                            dark: ElevatePrimitives.Red._600
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Red._900,
                            dark: ElevatePrimitives.Red._700
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Red._600,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Red._200,
                            dark: ElevatePrimitives.Red._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._700,
                            dark: ElevatePrimitives.Red._600
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Red._950,
                            dark: ElevatePrimitives.Red._900
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Red._800,
                            dark: ElevatePrimitives.Red._700
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._900,
                            dark: ElevatePrimitives.Red._800
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Red._50
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Red._50
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Red._50,
                            dark: ElevatePrimitives.Red._900
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Red._50
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Red._50
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Red._50
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Red._50
                        )
        }

        // MARK: StrongEmphasized

        public enum StrongEmphasized {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._500,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._900,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._100,
                            dark: ElevatePrimitives.Gray._1000
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._900,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._900,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_disabled_deafult = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._900,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Blue._50
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Blue._50
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Blue._50
                        )
        }

        // MARK: StrongNeutral

        public enum StrongNeutral {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._500,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._500,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._100,
                            dark: ElevatePrimitives.Gray._800
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._100,
                            dark: ElevatePrimitives.Gray._800
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._500,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._200
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._200
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._200
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._1000
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._1000
                        )
        }

        // MARK: StrongPrimary

        public enum StrongPrimary {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._800,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._500,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._50,
                            dark: ElevatePrimitives.Blue._950
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._900,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._700,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._800,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._900,
                            dark: ElevatePrimitives.Blue._700
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._200,
                            dark: ElevatePrimitives.Blue._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._700,
                            dark: ElevatePrimitives.Blue._600
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._950,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._800,
                            dark: ElevatePrimitives.Blue._700
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._900,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._50,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Gray._50
                        )
        }

        // MARK: StrongSuccess

        public enum StrongSuccess {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Green._800,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Green._500,
                            dark: ElevatePrimitives.Green._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Green._50,
                            dark: ElevatePrimitives.Green._950
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._600,
                            dark: ElevatePrimitives.Green._600
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Green._900,
                            dark: ElevatePrimitives.Green._900
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Green._700,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._800,
                            dark: ElevatePrimitives.Green._800
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Green._900,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Green._600,
                            dark: ElevatePrimitives.Green._500
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Green._100,
                            dark: ElevatePrimitives.Green._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._700,
                            dark: ElevatePrimitives.Green._600
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Green._950,
                            dark: ElevatePrimitives.Green._900
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Green._800,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._900,
                            dark: ElevatePrimitives.Green._800
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Green._50
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Green._50
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Green._50,
                            dark: ElevatePrimitives.Green._900
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Green._50
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Green._50
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Green._50
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Green._50
                        )
        }

        // MARK: StrongWarning

        public enum StrongWarning {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._700,
                            dark: ElevatePrimitives.Orange._700
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._400,
                            dark: ElevatePrimitives.Orange._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._100,
                            dark: ElevatePrimitives.Orange._950
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._500,
                            dark: ElevatePrimitives.Orange._600
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._800,
                            dark: ElevatePrimitives.Orange._950
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._600,
                            dark: ElevatePrimitives.Orange._500
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._700,
                            dark: ElevatePrimitives.Orange._300
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._600,
                            dark: ElevatePrimitives.Orange._700
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._300,
                            dark: ElevatePrimitives.Orange._500
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._50,
                            dark: ElevatePrimitives.Orange._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._400,
                            dark: ElevatePrimitives.Orange._600
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._700,
                            dark: ElevatePrimitives.Orange._900
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._500,
                            dark: ElevatePrimitives.Orange._700
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._600,
                            dark: ElevatePrimitives.Orange._800
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._1000,
                            dark: ElevatePrimitives.Orange._50
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._900,
                            dark: ElevatePrimitives.Orange._50
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._200,
                            dark: ElevatePrimitives.Orange._900
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._950,
                            dark: ElevatePrimitives.Orange._50
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._800,
                            dark: ElevatePrimitives.Orange._200
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._1000,
                            dark: ElevatePrimitives.Orange._200
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._900,
                            dark: ElevatePrimitives.Orange._200
                        )
        }

        // MARK: UnderstatedDanger

        public enum UnderstatedDanger {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Red._200,
                            dark: ElevatePrimitives.Red._900
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Red._500,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Red._200,
                            dark: ElevatePrimitives.Red._900
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._600,
                            dark: ElevatePrimitives.Red._800
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Red._200,
                            dark: ElevatePrimitives.Red._900
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Red._600,
                            dark: ElevatePrimitives.Red._400
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._500,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Red._300,
                            dark: ElevatePrimitives.Red._950
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Red._50,
                            dark: ElevatePrimitives.Red._800
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Red._50,
                            dark: ElevatePrimitives.Red._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._100,
                            dark: ElevatePrimitives.Red._900
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Red._400,
                            dark: ElevatePrimitives.Red._700
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Red._200,
                            dark: ElevatePrimitives.Red._400
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._300,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Red._500,
                            dark: ElevatePrimitives.Red._900
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Red._600,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Red._300,
                            dark: ElevatePrimitives.Red._300
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._800,
                            dark: ElevatePrimitives.Red._700
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Red._500,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Red._800,
                            dark: ElevatePrimitives.Red._500
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Red._900,
                            dark: ElevatePrimitives.Red._500
                        )
        }

        // MARK: UnderstatedEmphasized

        public enum UnderstatedEmphasized {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._200
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._500,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let border_selected_selected = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._1000
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._100,
                            dark: ElevatePrimitives.Blue._700
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Blue._600
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let text_disabled_disabled = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._400
                        )
        }

        // MARK: UnderstatedNeutral

        public enum UnderstatedNeutral {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let border_disabled_disabled = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._500,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let border_selected_selected = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Gray._800
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._1000
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._100,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Gray._950
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._800
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._600,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._500
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._400
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Gray._1000,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._300
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Gray._900,
                            dark: ElevatePrimitives.Gray._400
                        )
        }

        // MARK: UnderstatedPrimary

        public enum UnderstatedPrimary {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._800,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._500,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._200,
                            dark: ElevatePrimitives.Blue._200
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._700,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._700,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._300,
                            dark: ElevatePrimitives.Blue._1000
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._50,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._100,
                            dark: ElevatePrimitives.Blue._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._100,
                            dark: ElevatePrimitives.Blue._950
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._400,
                            dark: ElevatePrimitives.Blue._950
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._200,
                            dark: ElevatePrimitives.Blue._800
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._300,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._500,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._300,
                            dark: ElevatePrimitives.Blue._300
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._800,
                            dark: ElevatePrimitives.Blue._700
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Blue._500,
                            dark: ElevatePrimitives.Blue._900
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Blue._800,
                            dark: ElevatePrimitives.Blue._500
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Blue._900,
                            dark: ElevatePrimitives.Blue._700
                        )
        }

        // MARK: UnderstatedSuccess

        public enum UnderstatedSuccess {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Green._300,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Green._500,
                            dark: ElevatePrimitives.Green._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Green._200,
                            dark: ElevatePrimitives.Green._100
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._600,
                            dark: ElevatePrimitives.Green._600
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Green._700,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Green._300,
                            dark: ElevatePrimitives.Green._1000
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Green._50,
                            dark: ElevatePrimitives.Green._900
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Green._100,
                            dark: ElevatePrimitives.Green._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._100,
                            dark: ElevatePrimitives.Green._950
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Green._400,
                            dark: ElevatePrimitives.Green._950
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Green._200,
                            dark: ElevatePrimitives.Green._800
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._300,
                            dark: ElevatePrimitives.Green._900
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Green._500,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Green._600,
                            dark: ElevatePrimitives.Green._500
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Green._300,
                            dark: ElevatePrimitives.Green._100
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._800,
                            dark: ElevatePrimitives.Green._600
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Green._500,
                            dark: ElevatePrimitives.Green._300
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Green._800,
                            dark: ElevatePrimitives.Green._300
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Green._900,
                            dark: ElevatePrimitives.Green._300
                        )
        }

        // MARK: UnderstatedWarning

        public enum UnderstatedWarning {
            public static let border_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._200,
                            dark: ElevatePrimitives.Orange._900
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._500,
                            dark: ElevatePrimitives.Orange._500
                        )
            public static let border_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._100,
                            dark: ElevatePrimitives.Orange._950
                        )
            public static let border_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._600,
                            dark: ElevatePrimitives.Orange._700
                        )
            public static let border_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._100,
                            dark: ElevatePrimitives.Orange._950
                        )
            public static let border_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._700,
                            dark: ElevatePrimitives.Orange._500
                        )
            public static let border_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._800,
                            dark: ElevatePrimitives.Orange._300
                        )
            public static let fill_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._300,
                            dark: ElevatePrimitives.Orange._950
                        )
            public static let fill_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._50,
                            dark: ElevatePrimitives.Orange._800
                        )
            public static let fill_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._50,
                            dark: ElevatePrimitives.Orange._950
                        )
            public static let fill_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._100,
                            dark: ElevatePrimitives.Orange._900
                        )
            public static let fill_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._400,
                            dark: ElevatePrimitives.Orange._600
                        )
            public static let fill_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._200,
                            dark: ElevatePrimitives.Orange._700
                        )
            public static let fill_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._300,
                            dark: ElevatePrimitives.Orange._600
                        )
            public static let text_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._400,
                            dark: ElevatePrimitives.Orange._600
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._600,
                            dark: ElevatePrimitives.Orange._400
                        )
            public static let text_disabled_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._200,
                            dark: ElevatePrimitives.Orange._800
                        )
            public static let text_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._800,
                            dark: ElevatePrimitives.Orange._500
                        )
            public static let text_selected_active = Color.adaptive(
                            light: ElevatePrimitives.Orange._400,
                            dark: ElevatePrimitives.Orange._600
                        )
            public static let text_selected_default = Color.adaptive(
                            light: ElevatePrimitives.Orange._800,
                            dark: ElevatePrimitives.Orange._400
                        )
            public static let text_selected_hover = Color.adaptive(
                            light: ElevatePrimitives.Orange._900,
                            dark: ElevatePrimitives.Orange._500
                        )
        }
    }

    // MARK: Content

    public enum Content {

        // MARK: General

        public enum General {
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._900,
                            dark: ElevatePrimitives.Gray._50
                        )
            public static let text_muted = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let text_understated = Color.adaptive(
                            light: ElevatePrimitives.Gray._500,
                            dark: ElevatePrimitives.Gray._300
                        )
        }
    }

    // MARK: Feedback

    public enum Feedback {

        // MARK: General

        public enum General {
            public static let border_danger = Color.adaptive(
                            light: ElevatePrimitives.Red._500,
                            dark: ElevatePrimitives.Red._700
                        )
            public static let border_emphasized = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let border_neutral = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let border_primary = Color.adaptive(
                            light: ElevatePrimitives.Blue._500,
                            dark: ElevatePrimitives.Blue._700
                        )
            public static let border_success = Color.adaptive(
                            light: ElevatePrimitives.Green._500,
                            dark: ElevatePrimitives.Green._700
                        )
            public static let border_warning = Color.adaptive(
                            light: ElevatePrimitives.Orange._300,
                            dark: ElevatePrimitives.Orange._700
                        )
            public static let text_danger = Color.adaptive(
                            light: ElevatePrimitives.Red._500,
                            dark: ElevatePrimitives.Red._300
                        )
            public static let text_emphasized = Color.adaptive(
                            light: ElevatePrimitives.Gray._900,
                            dark: ElevatePrimitives.Gray._100
                        )
            public static let text_neutral = Color.adaptive(
                            light: ElevatePrimitives.Gray._800,
                            dark: ElevatePrimitives.Gray._100
                        )
            public static let text_primary = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._300
                        )
            public static let text_success = Color.adaptive(
                            light: ElevatePrimitives.Green._600,
                            dark: ElevatePrimitives.Green._300
                        )
            public static let text_warning = Color.adaptive(
                            light: ElevatePrimitives.Orange._500,
                            dark: ElevatePrimitives.Orange._300
                        )
        }

        // MARK: Strong

        public enum Strong {
            public static let fill_danger = Color.adaptive(
                            light: ElevatePrimitives.Red._600,
                            dark: ElevatePrimitives.Red._600
                        )
            public static let fill_emphasized = Color.adaptive(
                            light: ElevatePrimitives.Gray._700,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let fill_neutral = Color.adaptive(
                            light: ElevatePrimitives.Gray._200,
                            dark: ElevatePrimitives.Gray._200
                        )
            public static let fill_primary = Color.adaptive(
                            light: ElevatePrimitives.Blue._600,
                            dark: ElevatePrimitives.Blue._600
                        )
            public static let fill_success = Color.adaptive(
                            light: ElevatePrimitives.Green._600,
                            dark: ElevatePrimitives.Green._400
                        )
            public static let fill_warning = Color.adaptive(
                            light: ElevatePrimitives.Orange._200,
                            dark: ElevatePrimitives.Orange._200
                        )
            public static let text_default = Color.adaptive(
                            light: ElevatePrimitives.White._color_white,
                            dark: ElevatePrimitives.White._color_white
                        )
            public static let text_inverted = Color.adaptive(
                            light: ElevatePrimitives.Black._color_black,
                            dark: ElevatePrimitives.Black._color_black
                        )
        }
    }

    // MARK: Layout

    public enum Layout {

        // MARK: General

        public enum General {
            public static let border_accent = Color.adaptive(
                            light: ElevatePrimitives.Gray._300,
                            dark: ElevatePrimitives.Gray._700
                        )
            public static let border_default = Color.adaptive(
                            light: ElevatePrimitives.Gray._100,
                            dark: ElevatePrimitives.Gray._900
                        )
            public static let border_prominent = Color.adaptive(
                            light: ElevatePrimitives.Gray._400,
                            dark: ElevatePrimitives.Gray._600
                        )
            public static let border_subtle = Color.adaptive(
                            light: ElevatePrimitives.Gray._50,
                            dark: ElevatePrimitives.Gray._950
                        )
        }
    }

}
#endif
