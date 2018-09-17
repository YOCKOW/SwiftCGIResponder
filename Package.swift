// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

typealias Supporter = (name:String, requireSR5986Workaround: Bool)
let supporters: [Supporter] = [
  ("HTTP", false),
]

var productTargets: [String] = []
var packageTargets: [Target] = []

for supporter in supporters {
  productTargets.append(supporter.name)
  packageTargets.append(.target(
    name:supporter.name,
    dependencies:(supporter.requireSR5986Workaround ? ["SR-5986"] : []),
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
  dependencies:[
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets:packageTargets,
  swiftLanguageVersions:[4]
)

