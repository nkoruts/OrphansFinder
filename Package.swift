// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OrphansFinder",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(url: "https://github.com/tuist/XcodeProj.git", from: "9.6.0"),
    ],
    targets: [
        .executableTarget(
            name: "OrphansFinder",
            dependencies: ["XcodeProj"]
        )
    ]
)
