// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let linux = true
#else 
let linux = false
#endif

var targets: [Target] = [
  // Targets are the basic building blocks of a package. A target can define a module or a test suite.
  // Targets can depend on other targets in this package, and on products in packages which this package depends on.
  .target(name:"CGIResponder", dependencies:linux ? ["SR_5986"] : []),
]
if linux {
  targets.append(.target(name:"SR_5986", dependencies:[], path:"Tests/SR-5986"))
}
targets.append(.testTarget(name:"CGIResponderTests", dependencies:linux ? ["CGIResponder", "SR_5986"] : ["CGIResponder"]))


let package = Package(
  name:"CGIResponder",
  products:[
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name:"SwiftCGIResponder", type:.dynamic, targets:["CGIResponder"]),
  ],
  dependencies:[
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets:targets,
  swiftLanguageVersions:[4]
)

