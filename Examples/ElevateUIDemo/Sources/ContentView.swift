import SwiftUI
import ElevateUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Components").font(ElevateTypography.headingSmall)) {
                    NavigationLink("Buttons", destination: ButtonsView())
                    NavigationLink("Typography", destination: TypographyView())
                    NavigationLink("Colors", destination: ColorsView())
                    NavigationLink("Spacing", destination: SpacingView())
                }

                Section(header: Text("About").font(ElevateTypography.headingSmall)) {
                    VStack(alignment: .leading, spacing: ElevateSpacing.s) {
                        Text("ELEVATE UI")
                            .font(ElevateTypography.titleMedium)
                        Text("Version \(ElevateUI.version)")
                            .font(ElevateTypography.bodySmall)
                            .foregroundColor(ElevateColors.Text.secondary)
                        Text("Design System \(ElevateUI.designSystemVersion)")
                            .font(ElevateTypography.bodySmall)
                            .foregroundColor(ElevateColors.Text.secondary)
                    }
                    .padding(.vertical, ElevateSpacing.s)
                }
            }
            .navigationTitle("ELEVATE UI Demo")
        }
    }
}

struct ButtonsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ElevateSpacing.xl) {
                Group {
                    Text("Button Tones")
                        .font(ElevateTypography.headingMedium)

                    VStack(spacing: ElevateSpacing.m) {
                        ElevateButton(title: "Primary Button", tone: .primary) {
                            print("Primary tapped")
                        }

                        ElevateButton(title: "Secondary Button", tone: .secondary) {
                            print("Secondary tapped")
                        }

                        ElevateButton(title: "Success Button", tone: .success) {
                            print("Success tapped")
                        }

                        ElevateButton(title: "Warning Button", tone: .warning) {
                            print("Warning tapped")
                        }

                        ElevateButton(title: "Danger Button", tone: .danger) {
                            print("Danger tapped")
                        }

                        ElevateButton(title: "Emphasized Button", tone: .emphasized) {
                            print("Emphasized tapped")
                        }

                        ElevateButton(title: "Subtle Button", tone: .subtle) {
                            print("Subtle tapped")
                        }

                        ElevateButton(title: "Neutral Button", tone: .neutral) {
                            print("Neutral tapped")
                        }
                    }
                }

                Group {
                    Text("Button Sizes")
                        .font(ElevateTypography.headingMedium)

                    VStack(spacing: ElevateSpacing.m) {
                        ElevateButton(title: "Small Button", tone: .primary, size: .small) {
                            print("Small tapped")
                        }

                        ElevateButton(title: "Medium Button", tone: .primary, size: .medium) {
                            print("Medium tapped")
                        }

                        ElevateButton(title: "Large Button", tone: .primary, size: .large) {
                            print("Large tapped")
                        }
                    }
                }

                Group {
                    Text("Button Shapes")
                        .font(ElevateTypography.headingMedium)

                    VStack(spacing: ElevateSpacing.m) {
                        ElevateButton(title: "Default Shape", tone: .primary) {
                            print("Default tapped")
                        }

                        ElevateButton(title: "Pill Shape", tone: .primary, shape: .pill) {
                            print("Pill tapped")
                        }
                    }
                }

                Group {
                    Text("Button States")
                        .font(ElevateTypography.headingMedium)

                    VStack(spacing: ElevateSpacing.m) {
                        ElevateButton(title: "Enabled Button", tone: .primary) {
                            print("Enabled tapped")
                        }

                        ElevateButton(title: "Disabled Button", tone: .primary, isDisabled: true) {
                            print("This won't print")
                        }
                    }
                }
            }
            .padding(ElevateSpacing.l)
        }
        .navigationTitle("Buttons")
    }
}

struct TypographyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ElevateSpacing.l) {
                Group {
                    Text("Display Styles")
                        .font(ElevateTypography.headingMedium)

                    Text("Display Large")
                        .font(ElevateTypography.displayLarge)

                    Text("Display Medium")
                        .font(ElevateTypography.displayMedium)

                    Text("Display Small")
                        .font(ElevateTypography.displaySmall)
                }

                Group {
                    Text("Heading Styles")
                        .font(ElevateTypography.headingMedium)

                    Text("Heading Large")
                        .font(ElevateTypography.headingLarge)

                    Text("Heading Medium")
                        .font(ElevateTypography.headingMedium)

                    Text("Heading Small")
                        .font(ElevateTypography.headingSmall)

                    Text("Heading Extra Small")
                        .font(ElevateTypography.headingXSmall)
                }

                Group {
                    Text("Title Styles")
                        .font(ElevateTypography.headingMedium)

                    Text("Title Large")
                        .font(ElevateTypography.titleLarge)

                    Text("Title Medium")
                        .font(ElevateTypography.titleMedium)

                    Text("Title Small")
                        .font(ElevateTypography.titleSmall)
                }

                Group {
                    Text("Body Styles")
                        .font(ElevateTypography.headingMedium)

                    Text("Body Large - Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .font(ElevateTypography.bodyLarge)

                    Text("Body Medium - Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .font(ElevateTypography.bodyMedium)

                    Text("Body Small - Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
                        .font(ElevateTypography.bodySmall)
                }

                Group {
                    Text("Label Styles")
                        .font(ElevateTypography.headingMedium)

                    Text("Label Large")
                        .font(ElevateTypography.labelLarge)

                    Text("Label Medium")
                        .font(ElevateTypography.labelMedium)

                    Text("Label Small")
                        .font(ElevateTypography.labelSmall)

                    Text("Label Extra Small")
                        .font(ElevateTypography.labelXSmall)
                }

                Group {
                    Text("Code Styles")
                        .font(ElevateTypography.headingMedium)

                    Text("let code = \"example\"")
                        .font(ElevateTypography.code)

                    Text("let smallCode = \"example\"")
                        .font(ElevateTypography.codeSmall)
                }
            }
            .padding(ElevateSpacing.l)
        }
        .navigationTitle("Typography")
    }
}

struct ColorsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ElevateSpacing.xl) {
                Group {
                    Text("Brand Colors")
                        .font(ElevateTypography.headingMedium)

                    HStack(spacing: ElevateSpacing.m) {
                        ColorSwatch(color: ElevateColors.primary, name: "Primary")
                        ColorSwatch(color: ElevateColors.secondary, name: "Secondary")
                    }
                }

                Group {
                    Text("Semantic Colors")
                        .font(ElevateTypography.headingMedium)

                    HStack(spacing: ElevateSpacing.m) {
                        ColorSwatch(color: ElevateColors.success, name: "Success")
                        ColorSwatch(color: ElevateColors.warning, name: "Warning")
                    }

                    HStack(spacing: ElevateSpacing.m) {
                        ColorSwatch(color: ElevateColors.danger, name: "Danger")
                        ColorSwatch(color: ElevateColors.info, name: "Info")
                    }
                }

                Group {
                    Text("Background Colors")
                        .font(ElevateTypography.headingMedium)

                    VStack(spacing: ElevateSpacing.s) {
                        ColorSwatch(color: ElevateColors.Background.primary, name: "Primary")
                        ColorSwatch(color: ElevateColors.Background.secondary, name: "Secondary")
                        ColorSwatch(color: ElevateColors.Background.tertiary, name: "Tertiary")
                    }
                }

                Group {
                    Text("Text Colors")
                        .font(ElevateTypography.headingMedium)

                    VStack(spacing: ElevateSpacing.s) {
                        ColorSwatch(color: ElevateColors.Text.primary, name: "Primary")
                        ColorSwatch(color: ElevateColors.Text.secondary, name: "Secondary")
                        ColorSwatch(color: ElevateColors.Text.tertiary, name: "Tertiary")
                        ColorSwatch(color: ElevateColors.Text.disabled, name: "Disabled")
                    }
                }
            }
            .padding(ElevateSpacing.l)
        }
        .navigationTitle("Colors")
    }
}

struct ColorSwatch: View {
    let color: Color
    let name: String

    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: ElevateSpacing.BorderRadius.small)
                .fill(color)
                .frame(width: 50, height: 50)

            Text(name)
                .font(ElevateTypography.bodyMedium)

            Spacer()
        }
    }
}

struct SpacingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: ElevateSpacing.xl) {
                Group {
                    Text("Spacing Scale")
                        .font(ElevateTypography.headingMedium)

                    SpacingBar(size: ElevateSpacing.xxs, name: "XXS (2pt)")
                    SpacingBar(size: ElevateSpacing.xs, name: "XS (4pt)")
                    SpacingBar(size: ElevateSpacing.s, name: "S (8pt)")
                    SpacingBar(size: ElevateSpacing.m, name: "M (12pt)")
                    SpacingBar(size: ElevateSpacing.l, name: "L (16pt)")
                    SpacingBar(size: ElevateSpacing.xl, name: "XL (24pt)")
                    SpacingBar(size: ElevateSpacing.xxl, name: "XXL (32pt)")
                    SpacingBar(size: ElevateSpacing.xxxl, name: "XXXL (48pt)")
                }

                Group {
                    Text("Border Radius")
                        .font(ElevateTypography.headingMedium)

                    HStack(spacing: ElevateSpacing.m) {
                        BorderRadiusDemo(radius: ElevateSpacing.BorderRadius.small, name: "Small")
                        BorderRadiusDemo(radius: ElevateSpacing.BorderRadius.medium, name: "Medium")
                        BorderRadiusDemo(radius: ElevateSpacing.BorderRadius.large, name: "Large")
                    }
                }
            }
            .padding(ElevateSpacing.l)
        }
        .navigationTitle("Spacing")
    }
}

struct SpacingBar: View {
    let size: CGFloat
    let name: String

    var body: some View {
        VStack(alignment: .leading, spacing: ElevateSpacing.xs) {
            Text(name)
                .font(ElevateTypography.bodySmall)
                .foregroundColor(ElevateColors.Text.secondary)

            Rectangle()
                .fill(ElevateColors.primary)
                .frame(width: size, height: 24)
        }
    }
}

struct BorderRadiusDemo: View {
    let radius: CGFloat
    let name: String

    var body: some View {
        VStack(spacing: ElevateSpacing.s) {
            RoundedRectangle(cornerRadius: radius)
                .fill(ElevateColors.primary)
                .frame(width: 60, height: 60)

            Text(name)
                .font(ElevateTypography.labelSmall)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
