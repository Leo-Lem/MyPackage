// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "MyPackage",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(name: "MyPackage",
                 targets: [
                    "MyOthers",
                    "MyCustomUI",
                    "MyDates",
                    "MyStorage"
                 ])
    ],
    targets: [
        .target(name: "MyCustomUI", dependencies: ["MyOthers"]),
        .target(name: "MyDates", dependencies: ["MyOthers"]),
        .target(name: "MyStorage"),
        .target(name: "MyOthers")
    ]
)
