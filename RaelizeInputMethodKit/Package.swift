// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaelizeInputMethodKit",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "RaelizeInputMethodKit", targets: ["RaelizeInputMethodKit"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.9.2"),
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.6.0"),
        .package(name: "RaelizeLogic", path: "../RaelizeLogic"),
    ],
    targets: [
        .target(
            name: "RaelizeInputMethodKit",
            dependencies: [
                "RaelizeLogic",
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                ),

            ]
        ),
        .testTarget(
            name: "RaelizeInputMethodKitTests",
            dependencies: [
                "RaelizeInputMethodKit",
                "RaelizeLogic",
                .product(name: "Testing", package: "swift-testing"),
            ]),
    ]
)
