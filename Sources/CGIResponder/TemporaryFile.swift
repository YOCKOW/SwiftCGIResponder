/***************************************************************************************************
 TemporaryFile.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # TemporaryFile
 Represents for temporary file.
 
 */
public class TemporaryFile {
  private var fileHandle: FileHandle
  internal private(set) var url: URL
  private weak var temporaryDirectory: TemporaryDirectory!
  
  public private(set) var isClosed: Bool
  
  /// Regard the file at `url` as temporary file.
  private init?(at url:URL) {
    guard url.isFileURL else { return nil }
    guard let fh = try? FileHandle(forUpdating:url) else { return nil }
    self.url = url
    self.fileHandle = fh
    self.isClosed = false
  }
  
  /// Create a temporary file in `temporaryDirectory`.
  /// Its name will be "`prefix`[ random string ]`suffix`".
  /// You can specify `contents` with data.
  public convenience init?(in temporaryDirectory:TemporaryDirectory = .shared,
                           prefix:String = "", suffix:String = "",
                           contents data:Data? = nil) {
    let filename = "\(prefix)\(UUID().uuidString)\(suffix)"
    guard temporaryDirectory.createFile(atRelativePath:filename,
                                        contents:data,
                                        attributes:[.posixPermissions:NSNumber(value:Int16(0o700))])
    else  {
      return nil
    }
    
    let fileURL = temporaryDirectory.url.appendingPathComponent(filename)
    self.init(at:fileURL)
    
    // if `self` is not `nil`
    self.temporaryDirectory = temporaryDirectory
    temporaryDirectory.temporaryFiles.insert(self)
  }
  
  
  /// Close the temporary file. The file will be removed.
  /// Returns `false` if failed to remove the file.
  @discardableResult public func close() -> Bool {
    guard !self.isClosed else { return false }
    
    self.isClosed = true
    self.fileHandle.closeFile()
    self.temporaryDirectory.temporaryFiles.remove(self)
    do {
      try FileManager.default.removeItem(at:self.url)
    } catch {
      warn("Can't remove file at \(self.url.path)")
      return false
    }
    return true
  }
  
  deinit {
    self.close()
  }
}

extension TemporaryFile: Hashable {
  public static func ==(lhs: TemporaryFile, rhs: TemporaryFile) -> Bool {
    return lhs.fileHandle == rhs.fileHandle
  }
  public var hashValue: Int {
    return self.fileHandle.hashValue
  }
}

// like FileHandle...
extension TemporaryFile {
  public var availableData: Data {
    return self.fileHandle.availableData
  }
  
  public var offsetInFile: UInt64 {
    return self.fileHandle.offsetInFile
  }
  
  public func readData(ofLength length: Int) -> Data {
    return self.fileHandle.readData(ofLength:length)
  }
  
  public func readDataToEndOfFile() -> Data {
    return self.fileHandle.readDataToEndOfFile()
  }
  
  public func seek(toFileOffset offset: UInt64) {
    self.fileHandle.seek(toFileOffset:offset)
  }
  
  public func seekToEndOfFile() -> UInt64 {
    return self.fileHandle.seekToEndOfFile()
  }
  
  public func truncateFile(atOffset offset: UInt64) {
    self.fileHandle.truncateFile(atOffset:offset)
  }
  
  public func write(_ data: Data) {
    self.fileHandle.write(data)
  }
}

extension TemporaryFile {
  /// Copy the file to `destination` at which to place the copy of it.
  /// This method calls `FileManager.copyItem(at:to:) throws` internally.
  public func copy(to destination:URL) -> Bool {
    if let _ = try? FileManager.default.copyItem(at:self.url, to:destination) {
      return true
    } else {
      return false
    }
  }
}
