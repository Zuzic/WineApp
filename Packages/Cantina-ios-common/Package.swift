// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CantinaCommon",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "CantinaCommon", targets: ["CantinaCommon"]),
        .library(name: "CantinaLogger", targets: ["CantinaLogger"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver", from: Version(1, 0, 0)),
        .package(url: "https://github.com/weichsel/ZIPFoundation", from: Version(0, 0, 0)),
    ],
    targets: [
        .target(
            name: "CantinaCommon",
            dependencies: ["CantinaLogger"]
        ),
        .target(
            name: "CantinaLogger",
            dependencies: [
                .product(name: "SwiftyBeaver", package: "SwiftyBeaver"),
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
            ]
        ),
    ]
)
