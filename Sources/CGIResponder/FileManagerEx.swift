/***************************************************************************************************
 FileManagerEx.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension FileManager {
  /// Returns URL for the temporary directory.
  /// `FileManager.temporaryDirectory` is implemented on
  ///   iOS 10.0+, macOS 10.12+, tvOS 10.0+, and watchOS 3.0+.
  /// And it had not been implemented on non-Darwin until
  ///   [PR#1234 of Foundation](https://github.com/apple/swift-corelibs-foundation/pull/1234).
  public var temporaryDirectoryURL: URL {
    #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
      if #available(iOS 10.0, macOS 10.12, tvOS 10.0, watchOS 3.0, *) {
        return self.temporaryDirectory
      } else {
        return URL(fileURLWithPath:NSTemporaryDirectory(), isDirectory:true)
      }
    #else
      return URL(fileURLWithPath:NSTemporaryDirectory(), isDirectory:true)
    #endif
  }
}

extension FileManager {
  /// Returns whether file exists at `url` and is directory.
  /// Returns `nil` if `url` is not a file URL.
  internal func fileExists(at url:URL) -> (exists:Bool, isDirectory:Bool)? {
    guard url.isFileURL else { return nil }
    
    var isDir: ObjCBool = false
    guard self.fileExists(atPath:url.path, isDirectory:&isDir) else {
      return (false, false)
    }
    #if os(iOS) || os(macOS) || os(tvOS) || os(watchOS)
    return (true, isDir.boolValue)
    #else
    return (true, Bool(isDir))
    #endif
  }
}