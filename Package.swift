// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebSwiftUI",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "WebSwiftUI", targets: ["WebSwiftUI"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "WebSwiftUI", path: "WebSwiftUI")
    ]
)
