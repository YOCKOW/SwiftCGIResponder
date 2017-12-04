/***************************************************************************************************
 CGIContentOutputStream.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Foundation

/**
 
 # CGIContentOutputStream
 To what `CGIContent` can be given.
 Adopts `DataOutputStream`.
 
 */
public protocol CGIContentOutputStream: DataOutputStream {
  mutating func write(_:CGIContent) throws
}

extension CGIContentOutputStream {
  /// Default implementation.
  /// In order to conserve memory, implementations for some cases are separated.
  public mutating func write(_ content:CGIContent) throws {
    let writeFH = {(fh:FileHandle, target:inout Self) -> Void  in
      while true {
        let data = fh.readData(ofLength:4096)
        if data.isEmpty { break }
        target.write(data)
      }
    }
    
    let writePath = {(path:String, target:inout Self) -> Void in
      guard let fh = FileHandle(forReadingAtPath:path) else {
        warn("Cannot open file at path: \(path)")
        throw CGIResponderError.illegalOperation
      }
      writeFH(fh, &target)
    }
    
    switch content {
    case .fileHandle(let fh):
      writeFH(fh, &self)
    case .path(let path):
      try writePath(path, &self)
    case .temporaryFile(let temporaryFile):
      writeFH(temporaryFile.fileHandle, &self)
    case .onCall(let creator):
      try self.write(creator())
    case .url(let url):
      if !url.isFileURL { fallthrough }
      try writePath(url.path, &self)
    default:
      guard let data = content.data else {
        throw CGIResponderError.unexpectedError(message:"No data available: \(content)")
      }
      self.write(data)
    }
  }
}

/// Let `FileHandle` comform to `CGIContentOutputStream`.
extension FileHandle: CGIContentOutputStream {}

/// Let `Data` comform to `CGIContentOutputStream`.
extension Data: CGIContentOutputStream {}

