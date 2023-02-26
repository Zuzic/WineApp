// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "CantinaAssets",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "CantinaAssets", targets: ["CantinaAssets"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.4.0"),
    ],
    targets: [
        .target(name: "CantinaAssets",
                dependencies: [],
                resources: [
                    .process("Resources"),
                ]
//                plugins: [
//                    .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin"),
//                ]
               ),
    ]
)
