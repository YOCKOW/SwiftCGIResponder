/***************************************************************************************************
 FileManager+FileExists.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

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
