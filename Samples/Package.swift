// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import Foundation
import PackageDescription

private let useLocal = ProcessInfo.processInfo.environment["YOCKOW_USE_LOCAL_PACKAGES"] != nil

private let sampleNames: [String] = [
  "WithoutLibrary", // CSR-0000
  "SimpleCGI", // CSR-0001
]

private struct Dependency {
  let packageDependency: Package.Dependency
  let targetDependency: Target.Dependency
  
  init(_ packageDependency: Package.Dependency) {
    guard let name = packageDependency.name else { fatalError("Unexpected Dependency.") }
    if !packageDependency.url.hasPrefix("https://") {
      precondition(name == "CGIResponder")
      self.packageDependency = packageDependency
      self.targetDependency = .product(name: "Swift\(name)", package: name)
      return
    }

    guard let url = URL(string: packageDependency.url) else { fatalError("Unexpected Dependency.") }
    let repoName = url.deletingPathExtension().lastPathComponent

    func __dropSwift(_ string: String) -> String {
      return string.hasPrefix("Swift") ? String(string.dropFirst(5)) : string
    }

    self.packageDependency = useLocal ?
      .package(name: __dropSwift(repoName), path: "../../\(repoName)") : packageDependency
    self.targetDependency = .product(name: repoName, package: __dropSwift(repoName))
  }
}

private let dependencies: [Dependency] = [
  .init(.package(name: "CGIResponder", path: "../")),
  .init(.package(name: "NetworkGear", url: "https://github.com/YOCKOW/SwiftNetworkGear.git", "0.14.4"..<"2.0.0")),
]

private extension Int {
  var _label: String {
    return String(format: "CRS-%04ld", self)
  }
}

private var products: [Product] = []
private var targets: [Target] = [.testTarget(name: "SamplesTests")]
for (ii, name) in sampleNames.enumerated() {
  let label = ii._label
  products.append(.executable(name: label, targets: [label]))
  targets.append(.target(
    name: label,
    dependencies: ii == 0 ? [] : dependencies.map({ $0.targetDependency }),
    path: "Sources/\(label)_\(name)"
  ))
}

let package = Package(
  name: "CGIResponderSamples",
  platforms: [
    .macOS("10.15.4"), // Workaround for https://bugs.swift.org/browse/SR-13859
    .iOS(.v13),
    .watchOS(.v6),
    .tvOS(.v13),
  ],
  products: products,
  dependencies: dependencies.map({ $0.packageDependency }),
  targets: targets
)

