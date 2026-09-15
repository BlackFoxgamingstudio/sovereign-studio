// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SovereignStudio",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "SovereignStudio", targets: ["SovereignStudio"])
    ],
    targets: [
        .executableTarget(
            name: "SovereignStudio",
            path: "Sources/SovereignStudio"
        ),
    ]
)
