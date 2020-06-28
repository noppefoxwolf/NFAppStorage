// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppStorage",
    platforms: [.iOS(SupportedPlatform.IOSVersion.v13), .macOS(SupportedPlatform.MacOSVersion.v10_15), .tvOS(SupportedPlatform.TVOSVersion.v13), .watchOS(SupportedPlatform.WatchOSVersion.v6)],
    products: [
        .library(
            name: "AppStorage",
            targets: ["AppStorage"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AppStorage",
            dependencies: []),
        .testTarget(
            name: "AppStorageTests",
            dependencies: ["AppStorage"]),
    ]
)
