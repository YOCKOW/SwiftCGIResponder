/* *************************************************************************************************
 CGIContentOutputStream.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TemporaryFile
import yNewAPI
import yProtocols

/// To what `CGIContent` can be given.
/// Inherits from `DataOutputStream`.
public protocol CGIContentOutputStream: DataOutputStream {
  mutating func write(_:CGIContent) throws
}

private extension AnyFileHandle {
  func _write<Target>(to target: inout Target) throws where Target: CGIContentOutputStream {
    let originalOffset = try self.offset()
    
    while true {
      // "try?" causes double-optional value in Swift <5.0
      var nilableData: Data? = nil
      do { nilableData = try self.read(upToCount: 1024) } catch {}
      guard let data = nilableData else { break }
      try target.write(contentsOf: data)
    }
    try self.seek(toOffset: originalOffset)
  }
}

extension CGIContentOutputStream {
  /// Default implementation.
  /// Write the content represented by `content` to the receiver.
  public mutating func write(_ content:CGIContent) throws {
    func _write<FH>(contentsOf fileHandle: FH) throws where FH: FileHandleProtocol {
      let fh = (fileHandle as? AnyFileHandle) ?? AnyFileHandle(fileHandle)
      try fh._write(to: &self)
    }
    
    func _write(contentAtPath path: String) throws {
      guard let fh = FileHandle(forReadingAtPath:path) else {
        warn(message: .cannotOpenFileAtPath(path))
        throw CGIResponderError.illegalOperation
      }
      try _write(contentsOf: AnyFileHandle(fh))
    }
    
    switch content {
    case .none:
      break
    case .data(let data):
      try self.write(contentsOf: data)
    case .fileHandle(let fh):
      try _write(contentsOf: AnyFileHandle(fh))
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
    case .xhtml(let document):
      guard let data = document.xhtmlData else {
        throw CGIResponderError.unexpectedError(message:"Cannot generate data of XHTML.")
      }
      try self.write(contentsOf: data)
    case .lazy(let closure):
      try self.write(closure())
    }
  }
}

extension AnyFileHandle: CGIContentOutputStream {}

extension Data: CGIContentOutputStream {}

extension TemporaryFile: CGIContentOutputStream {}
