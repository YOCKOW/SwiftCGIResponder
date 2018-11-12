/* *************************************************************************************************
 DataOutputStream.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TemporaryFile

/// Similar with `TextOutputStream`.
/// An instance of `Data` is given to the stream.
public protocol DataOutputStream {
  mutating func write(_: Data)
}

/// Similar with `TextOutputStreamable`.
public protocol DataOutputStreamable {
  func write<Target>(to target:inout Target) where Target: DataOutputStream
}



private protocol _FileHandleConvertible: DataOutputStream, DataOutputStreamable {
  var offsetInFile: UInt64 { get }
  func seek(toFileOffset:UInt64)
  func readData(ofLength:Int) -> Data
}

private let _SIZE_TO_READ = 1024
extension _FileHandleConvertible {
  fileprivate func _write<Target>(to target:inout Target) where Target: DataOutputStream {
    let originalOffset = self.offsetInFile
    defer { self.seek(toFileOffset:originalOffset) }
    
    while true {
      let data = self.readData(ofLength:_SIZE_TO_READ)
      if data.isEmpty { break }
      target.write(data)
    }
  }
}

extension FileHandle: _FileHandleConvertible {}
extension TemporaryFile: _FileHandleConvertible {}

extension FileHandle: DataOutputStream, DataOutputStreamable {
  public func write<Target>(to target:inout Target) where Target: DataOutputStream {
    self._write(to:&target)
  }
}

extension TemporaryFile: DataOutputStream, DataOutputStreamable {
  public func write<Target>(to target:inout Target) where Target: DataOutputStream {
    self._write(to:&target)
  }
}

extension Data: DataOutputStream, DataOutputStreamable {
  public mutating func write(_ data:Data) {
    self.append(data)
  }
  
  public func write<Target>(to target:inout Target) where Target: DataOutputStream {
    target.write(self)
  }
}

