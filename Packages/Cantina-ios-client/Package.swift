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
        .package(url: "https://github.com/Moya/Moya.git", from: "15.0.0"),
        .package(path: "../SourceryPlugin"),
        .package(path: "../streamscloud-ios-common"),
    ],
    targets: [
        .target(
            name: "CantinaClient",
            dependencies: [
                .product(name: "StreamsCommon", package: "streamscloud-ios-common"),
                .product(name: "StreamsLogger", package: "streamscloud-ios-common"),
                .product(name: "CombineMoya", package: "Moya"),
            ],
            plugins: [
                .plugin(name: "SourceryPlugin", package: "SourceryPlugin"),
            ]
        ),
        .testTarget(
            name: "CantinaClientTests",
            dependencies: ["CantinaClient"]
        ),
    ]
)
