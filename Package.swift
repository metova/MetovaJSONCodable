// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "MetovaJSONCodable",
    targets: [
        .target(
            name: "MetovaJSONCodable",
            path: "MetovaJSONCodable"),
        .testTarget(
            name: "MetovaJSONCodableTests",
            dependencies: ["MetovaJSONCodable"],
            path: "MetovaJSONCodableTests"),
    ]
)
