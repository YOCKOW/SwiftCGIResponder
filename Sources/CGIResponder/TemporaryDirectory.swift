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
  private static var _list: [String:TemporaryDirectory] = [:]
  
  internal private(set) var url: URL
  public private(set) var isClosed: Bool
  internal var temporaryFiles:Set<TemporaryFile>
  
  private var path: String { return self.url.path }
  
  /// Regard the directory at `url` as temporary directory.
  private init?(directoryAt url:URL) {
    guard url.isLocalDirectory else { return nil }
    self.url = url
    self.isClosed = false
    self.temporaryFiles = []
  }
  
  /// Remove all temporary files which are
  /// created in `TemporaryFile.init(in:prefix:suffix:contents:)`
  @discardableResult public func removeAllTemporaryFiles() -> Bool {
    var result: UInt8 = 1
    while self.temporaryFiles.count > 0 {
      let file = self.temporaryFiles.first!
      // `file` will be removed from `temporaryFiles` in this method.
      result *= file.close() ? 1 : 0
    }
    return result > 0 ? true : false
  }
  
  /// Close all temporary files in the direcoty. (`removeAllTemporaryFiles()` is called internally.)
  /// The directory itself will be also removed if the directory is empty.
  /// Returns `true` if the directory is removed, otherwise `false`.
  /// ## note
  /// Although the files created in `TemporaryFile.init(in:prefix:suffix:contents:)` will be removed,
  /// **the directory will be NEVER closed if self is equal to .shared.**
  /// In that case, this function returns `true` when `removeAllTemporaryFiles()` returns `true`.
  @discardableResult public func close() -> Bool {
    guard !self.isClosed else { return false }
    
    guard self.removeAllTemporaryFiles() else { return false }
    
    // .shared is never closed.
    if self != .shared {
      self.isClosed = true
      TemporaryDirectory._list.removeValue(forKey:self.url.path)
      
      let manager = FileManager.default
      do {
        // check whether there are no files in the directory
        let urls = try manager.contentsOfDirectory(at:self.url,
                                                   includingPropertiesForKeys:nil,
                                                   options:[])
        guard urls.count == 0 else { return false }
      } catch {
        return false
      }
      guard let _ = try? manager.removeItem(at:self.url) else { return false }
    }
    return true
  }
  
  deinit {
    self.close()
  }
}

extension TemporaryDirectory: Hashable {
  public static func ==(lhs: TemporaryDirectory, rhs: TemporaryDirectory) -> Bool {
    return lhs.path == rhs.path
  }
  public var hashValue: Int { return self.path.hashValue }
}

extension TemporaryDirectory {
  /// Returns an instance of `TemporaryDirectory`.
  /// It may be existing object if temporary directory has been already created at `url`.
  private static func temporaryDirectory(at url:URL) -> TemporaryDirectory? {
    guard url.isFileURL else { return nil }
    
    let resolvedURL = url.resolvingSymlinksInPath()
    if resolvedURL.isLocalFile { return nil } // not directory
    
    if let tmpDir = TemporaryDirectory._list[resolvedURL.path] {
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
      TemporaryDirectory._list[resolvedURL.path] = tmpDir
      return tmpDir
    }
  }
}

extension TemporaryDirectory {
  /// Create a new temporary directory with random name in `parentDirectory`.
  /// You can specify `prefix` and `suffix` for the directory name.
  public static func temporaryDirectory(in parentDirectory:URL = .temporaryDirectory,
                                        prefix:String = "jp.YOCKOW.SwiftCGIResponder.TemporaryDirectory/",
                                        suffix:String = "") -> TemporaryDirectory? {
    guard parentDirectory.isLocalDirectory else { return nil }
    
    let uuid = UUID()
    let tmpURL = parentDirectory.appendingPathComponent("\(prefix)\(uuid.uuidString)\(suffix)", isDirectory:true)
    
    return TemporaryDirectory.temporaryDirectory(at:tmpURL)
  }
}

extension TemporaryDirectory {
  /// Shared Temporary Directory
  public static let shared = TemporaryDirectory.temporaryDirectory(at:.temporaryDirectory)!
  
  /// Temporary directory that may be shared in one program.
  public static let `default` = TemporaryDirectory.temporaryDirectory()!
}

extension TemporaryDirectory {
  /// Create a file in the directory
  internal func createFile(atRelativePath relativePath: String,
                           contents data: Data?,
                           attributes: [FileAttributeKey: Any]? = nil) -> Bool {
    if self.isClosed { return false }
    return FileManager.default.createFile(atPath:self.url.appendingPathComponent(relativePath).path,
                                          contents:data,
                                          attributes:attributes)
  }
}
