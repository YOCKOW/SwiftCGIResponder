// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageDependencies:[Package.Dependency] = [
  .package(url:"https://github.com/YOCKOW/SwiftBonaFideCharacterSet.git", from:"1.2.0"),
  .package(url:"https://github.com/YOCKOW/SwiftRanges", from: "1.3.2"),
  .package(url:"https://github.com/YOCKOW/SwiftUnicodeSupplement.git", from:"0.3.0"),
]

typealias Supporter = (name:String, dependencies:[Target.Dependency])
let supporters: [Supporter] = [
  (
    "HTTP",
    [
      .byName(name:"SwiftBonaFideCharacterSet"),
      .byName(name:"SwiftRanges"),
      .byName(name:"SwiftUnicodeSupplement")
    ]
  ),
]

var productTargets: [String] = []
var packageTargets: [Target] = []

// Main Target
productTargets.append("CGIResponder")
packageTargets.append(.target(
  name:"CGIResponder",
  dependencies:supporters.map { .byName(name:$0.name) },
  path:"Sources/CGIResponder"
))
packageTargets.append(.testTarget(
  name:"CGIResponderTests",
  dependencies:[.byName(name:"CGIResponder")],
  path:"Tests/CGIResponderTests"
))

// Supporters
for supporter in supporters {
  productTargets.append(supporter.name)
  packageTargets.append(.target(
    name:supporter.name,
    dependencies:supporter.dependencies,
    path:"Sources/Supporters/\(supporter.name)"
  ))
  packageTargets.append(.testTarget(
    name:"\(supporter.name)Tests",
    dependencies:[.byName(name:supporter.name)],
    path:"Tests/SupportersTests/\(supporter.name)Tests"
  ))
}

let package = Package(
  name:"CGIResponder",
  products:[
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name:"SwiftCGIResponder",
      type:.dynamic,
      targets:productTargets
    )
  ],
  dependencies:packageDependencies,
  targets:packageTargets,
  swiftLanguageVersions:[4]
)

