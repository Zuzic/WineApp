// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "CantinaCore",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "CantinaCore", targets: ["CantinaCore"]),
    ],
    dependencies: [
        .package(path: "../SourceryPlugin"),
    ],
    targets: [
        .target(
            name: "CantinaCore",
            dependencies: [],
            plugins: [
                .plugin(name: "SourceryPlugin", package: "SourceryPlugin"),
            ]
        ),
    ]
)
