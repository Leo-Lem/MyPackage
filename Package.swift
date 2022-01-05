// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "MyPackage",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "MyPackage",
                 targets: [
                    "MyBackend",
                    "MyCustomUI"
                 ])
    ],
    targets: [
        .target(name: "MyCustomUI",
                dependencies: [
                    "MyBackend"
                ]),
        .target(name: "MyBackend")
    ]
)
