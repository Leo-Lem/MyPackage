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
                    "MyDates",
                    "MyJSONs",
                    "MyImages",
                    "MyOthers",
                    "MyLayout",
                    "MyCustomUI"
                 ])
    ],
    targets: [
        .target(name: "MyDates"),
        .target(name: "MyJSONs"),
        .target(name: "MyImages"),
        .target(name: "MyOthers"),
        .target(name: "MyLayout"),
        .target(name: "MyCustomUI",
                dependencies: [
                    "MyDates",
                    "MyOthers",
                    "MyLayout"
                ])
    ]
)
