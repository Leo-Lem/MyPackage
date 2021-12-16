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
                    "MyCustomUI",
                    "MyLayout",
                    "MyImages",
                    "MyOthers"
                 ])
    ],
    targets: [
        .target(name: "MyCustomUI",
                dependencies: [
                    "MyOthers",
                    "MyLayout"
                ]),
        .target(name: "MyLayout"),
        .target(name: "MyImages"),
        .target(name: "MyOthers")
    ]
)
