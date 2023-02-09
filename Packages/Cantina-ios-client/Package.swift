// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "CantinaClient",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "CantinaClient", targets: ["CantinaClient"]),
    ],
    dependencies: [
        .package(path: "../SourceryPlugin"),
        .package(path: "../streamscloud-ios-common"),
    ],
    targets: [
        .target(
            name: "CantinaClient",
            dependencies: [
                .product(name: "StreamsCommon", package: "streamscloud-ios-common"),
                .product(name: "StreamsLogger", package: "streamscloud-ios-common"),
            ],
            plugins: [
                .plugin(name: "SourceryPlugin", package: "SourceryPlugin"),
            ]
        ),
    ]
)
