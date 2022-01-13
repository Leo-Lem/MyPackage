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
                    "MyCustomUI"
                 ])
    ],
    targets: [
        .target(name: "MyCustomUI",
                dependencies: [
                    "MyOthers"
                ]),
        .target(name: "MyOthers")
    ]
)
