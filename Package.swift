// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "group-project-the-alien-that-eats-the-carrot",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "group-project-the-alien-that-eats-the-carrot",
            targets: ["group-project-the-alien-that-eats-the-carrot"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "group-project-the-alien-that-eats-the-carrot"),
        .testTarget(
            name: "group-project-the-alien-that-eats-the-carrotTests",
            dependencies: ["group-project-the-alien-that-eats-the-carrot"])
    ]
)
