// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "TDBadgedCell",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "TDBadgedCell",
            targets: ["TDBadgedCell"]
        )
    ],
    targets: [
        .target(
            name: "TDBadgedCell",
            dependencies: [],
            path: "TDBadgedCell",
            sources: ["TDBadgedCell.swift"]
        )
    ],
    swiftLanguageVersions: [.v5]
)
