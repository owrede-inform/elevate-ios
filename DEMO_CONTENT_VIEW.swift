// Copy this entire file content and paste it into your ContentView.swift in the demo app

import SwiftUI
import ElevateUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: ElevateSpacing.l) {
                Group {
                    Text("ELEVATE Design System")
                        .font(ElevateTypography.displaySmall)
                        .padding(.top, ElevateSpacing.xl)

                    Text("Button Tones")
                        .font(ElevateTypography.headingSmall)
                        .padding(.top, ElevateSpacing.xl)

                    ElevateButton(title: "Primary", tone: .primary) {
                        print("Primary button tapped")
                    }

                    ElevateButton(title: "Secondary", tone: .secondary) {
                        print("Secondary button tapped")
                    }

                    ElevateButton(title: "Success", tone: .success) {
                        print("Success button tapped")
                    }

                    ElevateButton(title: "Warning", tone: .warning) {
                        print("Warning button tapped")
                    }

                    ElevateButton(title: "Danger", tone: .danger) {
                        print("Danger button tapped")
                    }

                    ElevateButton(title: "Emphasized", tone: .emphasized) {
                        print("Emphasized button tapped")
                    }

                    ElevateButton(title: "Subtle", tone: .subtle) {
                        print("Subtle button tapped")
                    }

                    ElevateButton(title: "Neutral", tone: .neutral) {
                        print("Neutral button tapped")
                    }
                }

                Group {
                    Text("Button Sizes")
                        .font(ElevateTypography.headingSmall)
                        .padding(.top, ElevateSpacing.xl)

                    ElevateButton(title: "Small Button", size: .small) {
                        print("Small button tapped")
                    }

                    ElevateButton(title: "Medium Button", size: .medium) {
                        print("Medium button tapped")
                    }

                    ElevateButton(title: "Large Button", size: .large) {
                        print("Large button tapped")
                    }
                }

                Group {
                    Text("Button Shapes")
                        .font(ElevateTypography.headingSmall)
                        .padding(.top, ElevateSpacing.xl)

                    ElevateButton(title: "Default Shape") {
                        print("Default shape button tapped")
                    }

                    ElevateButton(title: "Pill Shape", shape: .pill) {
                        print("Pill shape button tapped")
                    }
                }

                Group {
                    Text("Button States")
                        .font(ElevateTypography.headingSmall)
                        .padding(.top, ElevateSpacing.xl)

                    ElevateButton(title: "Enabled Button") {
                        print("Enabled button tapped")
                    }

                    ElevateButton(title: "Disabled Button", isDisabled: true) {
                        print("This shouldn't print")
                    }
                }
            }
            .padding(ElevateSpacing.l)
        }
    }
}

#Preview {
    ContentView()
}
