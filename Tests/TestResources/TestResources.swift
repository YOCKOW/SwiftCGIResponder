/* *************************************************************************************************
 TestResources.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

/// Data provider for tests.
public class TestResources {
  private init() {}
  public static let shared:TestResources = .init()
  
  private let _resourcesDirectory:URL =
    URL(fileURLWithPath:#file).deletingLastPathComponent().appendingPathComponent("Resources")
  
  private var _fileHandles:[String:FileHandle] = [:]
  
  deinit {
    for fileHandle in self._fileHandles.values {
      fileHandle.closeFile()
    }
  }
  
  private func _absolutePath(for relativePath:String) -> URL {
    return _resourcesDirectory.appendingPathComponent(relativePath)
  }
  
  public func fileHandle(at relativePath:String) -> FileHandle? {
    if self._fileHandles[relativePath] == nil {
      self._fileHandles[relativePath] = try? FileHandle(forReadingFrom:self._absolutePath(for:relativePath))
    }
    return self._fileHandles[relativePath]
  }
  
  public func data(for relativePath:String) -> Data? {
    guard let fh = self.fileHandle(at:relativePath) else { return nil }
    fh.seek(toFileOffset:0)
    return fh.availableData
  }
}
