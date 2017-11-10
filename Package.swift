// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(Linux)
let requireSR5986 = true
#else 
let requireSR5986 = false
#endif

var targets: [Target] = []
if requireSR5986 { targets.append(.target(name:"SR_5986", dependencies:[], path:"Sources/SR-5986")) }
targets.append(.target(name:"CGIResponder", dependencies:requireSR5986 ? ["SR_5986"] : []))
targets.append(.testTarget(name:"CGIResponderTests", dependencies:["CGIResponder"]))

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

