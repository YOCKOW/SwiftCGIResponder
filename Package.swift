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
    .package(url:"https://github.com/YOCKOW/SwiftBonaFideCharacterSet.git", from: "1.6.2"),
    .package(url:"https://github.com/YOCKOW/SwiftNetworkGear.git", "0.12.1"..<"2.0.0"),
    .package(url:"https://github.com/YOCKOW/SwiftTemporaryFile.git", from: "3.2.3"),
    .package(url:"https://github.com/YOCKOW/SwiftXHTML.git", from: "0.1.0"),
    .package(url:"https://github.com/YOCKOW/ySwiftExtensions.git", from: "0.10.0"),
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
    .testTarget(
      name: "CGIResponderTests",
      dependencies: [
        "CGIResponder",
        "SwiftNetworkGear",
        "SwiftTemporaryFile",
        "ySwiftExtensions",
      ]
    ),
  ],
  swiftLanguageVersions: [.v4, .v4_2, .v5]
)

import Foundation
if ProcessInfo.processInfo.environment["YOCKOW_USE_LOCAL_PACKAGES"] != nil {
  func localPath(with url: String) -> String {
    guard let url = URL(string: url) else { fatalError("Unexpected URL.") }
    let dirName = url.deletingPathExtension().lastPathComponent
    return "../\(dirName)"
  }
  package.dependencies = package.dependencies.map { .package(path: localPath(with: $0.url)) }
}
