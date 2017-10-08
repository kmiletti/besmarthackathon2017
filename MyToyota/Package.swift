// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyToyota",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "MyToyota",
            targets: ["MyToyota"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
         .Package(url: "https://github.com/yannickl/QRCodeReader.swift.git", versions: "8.0.3" ..< Version.max)
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "MyToyota",
            dependencies: []),
        .testTarget(
            name: "MyToyotaTests",
            dependencies: ["MyToyota"]),
    ]
)
