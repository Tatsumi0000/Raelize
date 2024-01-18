// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RaelizeLogic",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "RaelizeLogic",
            targets: ["RaelizeLogic"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ggerganov/llama.cpp",
            revision: "b1892" // 2024-01-19 latest version
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "RaelizeLogic",
            dependencies: [
                .product(name: "llama", package: "llama.cpp"),
            ],
            path: "./Sources"
        ),
        .testTarget(
            name: "RaelizeLogicTests",
            dependencies: ["RaelizeLogic"]
        ),
    ]
)
