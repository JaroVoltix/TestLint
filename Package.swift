// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tuist-lint",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "tuist-lint",
            targets: ["TuistPluginSwiftLint"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/tuist/ProjectAutomation", .exact("3.17.0")),
        .package(url: "https://github.com/realm/SwiftLint", .exact("0.51.0")),
        .package(url: "https://github.com/nicklockwood/SwiftFormat", .exact("0.50.7")),
        .package(url: "https://github.com/apple/swift-argument-parser.git", .upToNextMinor(from: "1.2.1")),
    ],
    targets: [
        .executableTarget(
            name: "TuistPluginSwiftLint",
            dependencies: [
                "TuistPluginSwiftLintFramework",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .target(
            name: "TuistPluginSwiftLintFramework",
            dependencies: [
                .product(name: "ProjectAutomation", package: "ProjectAutomation"),
                .product(name: "SwiftLintFramework", package: "SwiftLint"),
                .product(name: "SwiftFormat", package: "SwiftFormat")
            ]
        ),
    ]
)
