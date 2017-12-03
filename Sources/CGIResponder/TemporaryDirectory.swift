/***************************************************************************************************
 TemporaryDirectory.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # TemporaryDirectory
 Represents for temporary directory.
 
 */
public class TemporaryDirectory {
  public private(set) var url: URL
  public private(set) var isClosed: Bool
  
  private var files:[FileHandle:URL]
  
  public var path: String { return self.url.path }
  
  private init?(directoryAt url:URL) {
    guard url.isLocalDirectory else { return nil }
    self.url = url
    self.isClosed = false
    self.files = [:]
  }
}

extension TemporaryDirectory {
  private static var _list: [String:TemporaryDirectory] = [:]
  
  /// Returns an instance of `TemporaryDirectory`.
  /// It may be existing object if temporary directory has been already created at `url`.
  public static func temporaryDirectory(at url:URL) -> TemporaryDirectory? {
    guard url.isFileURL else { return nil }
    
    let resolvedURL = url.resolvingSymlinksInPath()
    if resolvedURL.isLocalFile { return nil } // not directory
    
    if let tmpDir = _list[resolvedURL.path] {
      return tmpDir
    } else {
      if !resolvedURL.isLocalDirectory {
        // Directory doesn't exist...
        let attributes:[FileAttributeKey:Any] = [.posixPermissions:NSNumber(value:Int16(0o700))]
        do {
          try FileManager.default.createDirectory(at:url,
                                                  withIntermediateDirectories:true,
                                                  attributes:attributes)
        } catch {
          return nil
        }
      }
      let tmpDir = TemporaryDirectory(directoryAt:resolvedURL)
      _list[resolvedURL.path] = tmpDir
      return tmpDir
    }
  }
  
  public static var shared = TemporaryDirectory.temporaryDirectory(at:FileManager.default.temporaryDirectoryURL)!
}

extension TemporaryDirectory {
  /// Create a new temporary directory with random name in `parentDirectory`.
  /// You can specify `prefix` and `suffix` for the directory name.
  public static func temporaryDirectory(in parentDirectory:URL = FileManager.default.temporaryDirectoryURL,
                                        prefix:String = "jp.YOCKOW.SwiftCGIResponder.TemporaryDirectory/",
                                        suffix:String = "") -> TemporaryDirectory? {
    guard parentDirectory.isLocalDirectory else { return nil }
    
    let uuid = UUID()
    let tmpURL = parentDirectory.appendingPathComponent("\(prefix)\(uuid.uuidString)\(suffix)", isDirectory:true)
    
    return TemporaryDirectory.temporaryDirectory(at:tmpURL)
  }
}
