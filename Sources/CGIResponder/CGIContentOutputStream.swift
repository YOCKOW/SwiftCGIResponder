/* *************************************************************************************************
 CGIContentOutputStream.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TemporaryFile

/// To what `CGIContent` can be given.
/// Inherits from `DataOutputStream`.
public protocol CGIContentOutputStream: DataOutputStream {
  mutating func write(_:CGIContent) throws
}

extension CGIContentOutputStream {
  private mutating func _write(contentAtPath path:String) throws {
    guard let fh = FileHandle(forReadingAtPath:path) else {
      warn(message:.cannotOpenFileAtPath(path))
      throw CGIResponderError.illegalOperation
    }
    fh.write(to:&self)
  }
  
  /// Default implementation.
  /// Write the content represented by `content` to the receiver.
  public mutating func write(_ content:CGIContent) throws {
    switch content {
    case .data(let data):
      self.write(data)
    case .fileHandle(let fh):
      fh.write(to:&self)
    case .path(let path): 
      try self._write(contentAtPath:path)
    case .string(let string, let encoding):
      guard let data = string.data(using:encoding) else {
        throw CGIResponderError.unexpectedError(message:"No data available: \(string)")
      }
      self.write(data)
    case .temporaryFile(let temporaryFile):
      temporaryFile.write(to:&self)
    case .url(let url):
      if url.isFileURL { try self._write(contentAtPath:url.path) }
      else { self.write(try Data(contentsOf:url)) }
    case .xhtml(let document):
      guard let data = document.xhtmlData else {
        throw CGIResponderError.unexpectedError(message:"Cannot generate data of XHTML.")
      }
      self.write(data)
    case .lazy(let closure):
      try self.write(closure())
    }
  }
}

extension FileHandle: CGIContentOutputStream {}

extension Data: CGIContentOutputStream {}

extension TemporaryFile: CGIContentOutputStream {}
