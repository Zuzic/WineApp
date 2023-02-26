// swift-tools-version:5.7
import PackageDescription
let pluginsSettings: [Target.PluginUsage]
#if RELEASE
    pluginsSettings = []
#else
    pluginsSettings = [.plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin"), ]
#endif

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
                ],
                plugins: pluginsSettings
               ),
    ]
)
