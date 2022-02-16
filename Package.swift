// swift-tools-version:5.5

import PackageDescription
import Foundation

//MARK: - defining the library names
enum TargetID: String, CaseIterable {
    case ui = "MySwiftUI",
         dates = "MyDates",
         others = "MyOthers",
         storage = "MyStorage"
    
    var name: String { rawValue }
    var tests: String { "\(self.name)Tests" }
}

enum SourceID: String, CaseIterable {
    case source
    
    var name: String { rawValue }
}

enum ResourceID: String, CaseIterable {
    case unitPlurals = "localization/Localizable.stringsdict"
    
    var name: String { rawValue }
}

//MARK: - defining the targets
private let name = "MyPackage"
private let targets: [Target] = [
    .target(.ui, dependencies: [.others, .dates], exclude: [.unitPlurals]),
    .target(.others),
    .target(.dates, dependencies: [.others]),
    .target(.storage)
]

private let testTargets: [Target] = [
    .testTarget(.dates, dependencies: [.others])
]

//MARK: - defining the actual package
let package = Package(
    name: name,
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [.library(name: name, targets: targets.map(\.name))],
    targets: targets + testTargets
)

//MARK: - simpler, more robust target declaration
fileprivate extension Target {
    static func target(
        _ id: TargetID,
        dependencies: [TargetID] = [],
        path: String? = nil,
        exclude: [ResourceID] = [],
        sources: [SourceID]? = nil,
        resources: [ResourceID]? = nil
    ) -> Target {
        .target(
            name: id.name,
            dependencies: dependencies.map(\.name).map(Dependency.init),
            path: path,
            exclude: exclude.map(\.name),
            sources: sources?.map(\.name),
            resources: resources?.map(\.name).map { Resource.process($0) }
        )
    }
    
    static func testTarget(
        _ id: TargetID,
        dependencies: [TargetID] = [],
        path: String? = nil,
        exclude: [ResourceID] = [],
        sources: [SourceID]? = nil,
        resources: [ResourceID]? = nil
    ) -> Target {
        .testTarget(
            name: id.tests,
            dependencies: (dependencies + [id]).map(\.name).map(Dependency.init),
            path: path,
            exclude: exclude.map(\.name),
            sources: sources?.map(\.name),
            resources: resources?.map(\.name).map { Resource.process($0) }
        )
    }
}
