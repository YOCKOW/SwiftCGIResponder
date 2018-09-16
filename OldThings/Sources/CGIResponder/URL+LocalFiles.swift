/***************************************************************************************************
 URL+LocalFiles.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Foundation

extension URL {
  /// Returns `true` if `self` exists and is a directory.
  public var isLocalDirectory: Bool {
    guard let result = FileManager.default.fileExists(at:self) else { return false }
    return result.exists && result.isDirectory
  }
  
  /// Returns `true` if `self` exists and is not a directory.
  public var isLocalFile: Bool {
    guard let result = FileManager.default.fileExists(at:self) else { return false }
    return result.exists && !result.isDirectory
  }
}
