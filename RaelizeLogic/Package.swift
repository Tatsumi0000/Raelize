// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaelizeLogic",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RaelizeLogic",
            targets: ["RaelizeLogic"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-testing.git", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RaelizeLogic",
            resources: [.copy("Resources")]),
        .testTarget(
            name: "RaelizeLogicTests",
            dependencies: [
                "RaelizeLogic",
                .product(name: "Testing", package: "swift-testing"),
            ]
        ),
    ]
)
