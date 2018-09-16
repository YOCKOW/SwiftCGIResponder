/***************************************************************************************************
 URL+TemporaryDirectory.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension URL {
  /// URL for the temporary directory.
  /// ## note
  /// `var temporaryDirectory: URL { get }` of `FileManager` is implemented on
  /// iOS 10.0+, macOS 10.12+, tvOS 10.0+, and watchOS 3.0+.
  /// And it had not been implemented on non-Darwin until
  /// [PR#1234 of Foundation](https://github.com/apple/swift-corelibs-foundation/pull/1234).
  public static let temporaryDirectory: URL = ({
    #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
      if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
        return FileManager.default.temporaryDirectory
      } else {
        return URL(fileURLWithPath:NSTemporaryDirectory(), isDirectory:true)
      }
    #else
      return URL(fileURLWithPath:NSTemporaryDirectory(), isDirectory:true)
    #endif
  })()
}
