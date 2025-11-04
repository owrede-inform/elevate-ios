// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ElevateUI",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // The main ElevateUI library
        .library(
            name: "ElevateUI",
            targets: ["ElevateUI"]
        ),
    ],
    dependencies: [
        // Add any package dependencies here
    ],
    targets: [
        // The main framework target
        .target(
            name: "ElevateUI",
            dependencies: [],
            path: "ElevateUI/Sources",
            resources: [
                .process("Resources")
            ]
        ),

        // Test target
        .testTarget(
            name: "ElevateUITests",
            dependencies: ["ElevateUI"],
            path: "ElevateUITests"
        ),
    ]
)
