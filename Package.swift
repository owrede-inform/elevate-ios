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
        // Snapshot testing for visual regression tests
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.15.0")
    ],
    targets: [
        // The main framework target
        .target(
            name: "ElevateUI",
            dependencies: [],
            path: "ElevateUI/Sources",
            exclude: [
                "DesignTokens/USAGE_GUIDE.md"
            ],
            resources: [
                .process("Resources")
            ]
        ),

        // Test target
        .testTarget(
            name: "ElevateUITests",
            dependencies: [
                "ElevateUI",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "ElevateUITests"
        ),
    ]
)
