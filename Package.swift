// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AmrSwiftUI",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "AmrSwiftUI",
            targets: ["AmrSwiftUI"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AmrSwiftUI",
            dependencies: []),
        .testTarget(
            name: "AmrSwiftUITests",
            dependencies: ["AmrSwiftUI"]),
    ]
)
