// swift-tools-version: 5.5

import PackageDescription

let package = Package(
    name: "Appliable",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "Appliable",
            targets: ["Appliable"]
        )
    ],
    targets: [
        .target(
            name: "Appliable"
        ),
        .testTarget(
            name: "AppliableTests",
            dependencies: ["Appliable"]
        )
    ]
)
