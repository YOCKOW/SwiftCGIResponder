/* *************************************************************************************************
 CGIContentOutputStream.swift
   © 2017-2018,2020,2023,2025 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TemporaryFile
import yExtensions
import yProtocols

/// To what `CGIContent` can be given.
/// Inherits from `DataOutputStream`.
public protocol CGIContentOutputStream: DataOutputStream {
  mutating func write(_: CGIContent) throws
}

public protocol CGIContentOutputStreamable: DataOutputStreamable {
  /// Writes a CGI-content of this instance into the given output stream.
  func write<Target>(to target: inout Target) throws where Target: CGIContentOutputStream
}

extension CGIContentOutputStream {
  /// Default implementation.
  /// Write the content represented by `content` to the receiver.
  public mutating func write(_ content: CGIContent) throws {
    func _write<FH>(contentsOf fileHandle: FH) throws where FH: FileHandleProtocol {
      try fileHandle.write(to: &self)
    }
    
    func _write(contentAtPath path: String) throws {
      guard let fh = FileHandle(forReadingAtPath:path) else {
        throw CGIResponderError.illegalOperation
      }
      try _write(contentsOf: fh)
    }
    
    switch content {
    case .none:
      break
    case .data(let data):
      try self.write(contentsOf: data)
    case .fileHandle(let fh):
      try _write(contentsOf: fh)
    case .temporaryFile(let tmp):
      try _write(contentsOf: tmp)
    case .path(let path): 
      try _write(contentAtPath:path)
    case .string(let string, let encoding):
      guard let data = string.data(using:encoding) else {
        throw CGIResponderError.unexpectedError(message:"No data available: \(string)")
      }
      try self.write(contentsOf: data)
    case .url(let url):
      if url.isFileURL {
        try _write(contentAtPath: url.path)
      } else {
        try self.write(contentsOf: try Data(contentsOf:url))
      }
    case .xhtml(let document, let asHTML):
      guard let data = asHTML ? try document.htmlData : document.xhtmlData else {
        throw CGIResponderError.unexpectedError(message: "Cannot generate data of (X)HTML.")
      }
      try self.write(contentsOf: data)
    case .xml(let document, options: let options):
      try self.write(contentsOf: document.xmlData(options: options))
    case .lazy(let closure):
      try self.write(closure())
    case .streamable(let streamable):
      try streamable.write(to: &self)
    }
  }
}

extension AnyFileHandle: CGIContentOutputStream, CGIContentOutputStreamable {}

extension FileHandle: CGIContentOutputStream, CGIContentOutputStreamable {}

extension Data: CGIContentOutputStream, CGIContentOutputStreamable {}

extension InMemoryFile: CGIContentOutputStream, CGIContentOutputStreamable {}

extension TemporaryFile: CGIContentOutputStream, CGIContentOutputStreamable {}

extension HybridTemporaryFile: CGIContentOutputStream, CGIContentOutputStreamable {}
