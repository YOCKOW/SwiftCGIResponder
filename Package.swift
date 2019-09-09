// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "CGIResponder",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "SwiftCGIResponder", type: .dynamic, targets: ["CGIResponder"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url:"https://github.com/YOCKOW/SwiftBonaFideCharacterSet.git", from:"1.6.0"),
    .package(url:"https://github.com/YOCKOW/SwiftNetworkGear.git", from:"0.10.0"),
    .package(url:"https://github.com/YOCKOW/SwiftTemporaryFile.git", from:"2.2.0"),
    .package(url:"https://github.com/YOCKOW/SwiftXHTML.git", from: "0.1.0-dev20190907"),
    .package(url:"https://github.com/YOCKOW/ySwiftExtensions.git", from:"0.4.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "CGIResponder",
      dependencies: [
        "SwiftBonaFideCharacterSet",
        "SwiftNetworkGear",
        "SwiftTemporaryFile",
        "SwiftXHTML",
        "ySwiftExtensions",
      ]
    ),
    .testTarget(name: "CGIResponderTests",dependencies: ["CGIResponder", "SwiftTemporaryFile"]),
  ],
  swiftLanguageVersions: [.v4, .v4_2, .v5]
)
