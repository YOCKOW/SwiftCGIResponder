// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let packageDependencies:[Package.Dependency] = [
  .package(url:"https://github.com/YOCKOW/SwiftBonaFideCharacterSet.git", from:"1.4.0"),
  .package(url:"https://github.com/YOCKOW/SwiftNetwork.git", from:"0.7.1"),
  .package(url:"https://github.com/YOCKOW/SwiftRanges.git", from: "1.3.2"),
  .package(url:"https://github.com/YOCKOW/SwiftTemporaryFile.git", from:"1.0.2"),
  .package(url:"https://github.com/YOCKOW/SwiftUnicodeSupplement.git", from:"0.4.0"),
]

typealias Supporter = (name:String, dependencies:[Target.Dependency])
let supporters: [Supporter] = [
  (
    "HTTP",
    [
      .byName(name:"SwiftBonaFideCharacterSet"),
      .byName(name:"SwiftNetwork"),
      .byName(name:"SwiftRanges"),
      .byName(name:"SwiftUnicodeSupplement"),
      .target(name:"LibExtender"),
    ]
  ),
  (
    "LibExtender",
    [
      .byName(name:"SwiftUnicodeSupplement"),
    ]
  ),
  (
    "XHTML",
    [
      .byName(name:"SwiftBonaFideCharacterSet"),
      .byName(name:"SwiftRanges"),
      .target(name:"HTTP"),
      .target(name:"LibExtender"),
      .target(name:"TestResources")
    ]
  ),
]

let mainTargetDependencies: [Target.Dependency] = [
  .byName(name:"SwiftNetwork"),
  .byName(name:"SwiftTemporaryFile"),
] + supporters.map {
    .byName(name:$0.name)
}

var productTargets: [String] = []
var packageTargets: [Target] = []

// Main Target
productTargets.append("CGIResponder")
packageTargets.append(.target(
  name:"CGIResponder",
  dependencies:mainTargetDependencies,
  path:"Sources/CGIResponder"
))
packageTargets.append(.testTarget(
  name:"CGIResponderTests",
  dependencies:[.byName(name:"CGIResponder")],
  path:"Tests/CGIResponderTests"
))

// Resources for tests.
productTargets.append("TestResources")
packageTargets.append(.target(
  name:"TestResources",
  path:"Tests/TestResources"
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
  swiftLanguageVersions:[.v4, .v4_2]
)

