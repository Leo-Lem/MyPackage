// swift-tools-version:5.5

import PackageDescription
import Foundation

//MARK: - defining the library names
enum TargetID: String, CaseIterable {
    case ui = "MySwiftUI",
         dates = "MyDates",
         others = "MyOthers",
         storage = "MyStorage"
    
    var name: String { self.rawValue }
    var tests: String { "\(self.name)Tests" }
}

//MARK: - defining the targets
private let name = "MyPackage"
private let targets: [Target] = [
    .target(.ui, dependencies: [.others, .dates]),
    .target(.others),
    .target(.dates, dependencies: .others),
    .target(.storage)
]

private let testTargets: [Target] = [
    .testTarget(.dates, dependencies: .others)
]

//MARK: - defining the actual package
let package = Package(
    name: name,
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: name, targets: targets.map(\.name))],
    targets: targets + testTargets
)

//MARK: - simpler target declaration
fileprivate extension Target {
    static func target(_ id: TargetID, dependencies: [TargetID] = []) -> Target {
        .target(name: id.name, dependencies: dependencies.map(\.name).map(Dependency.init))
    }
    
    static func testTarget(_ id: TargetID, dependencies: [TargetID] = []) -> Target {
        .testTarget(name: id.tests, dependencies: (dependencies + [id]).map(\.name).map(Dependency.init))
    }
    
    static func target(_ id: TargetID, dependencies: TargetID) -> Target { .target(id, dependencies: [dependencies]) }
    static func testTarget(_ id: TargetID, dependencies: TargetID) -> Target { .testTarget(id, dependencies: [dependencies]) }
}
