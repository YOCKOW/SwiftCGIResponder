/***************************************************************************************************
 DataOutputStream.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # DataOutputStream
 Similar with `TextOutputStream`. The only difference is what is given to the stream.
 
 */
public protocol DataOutputStream {
  mutating func write(_: Data)
}

/// `FileHandle` already has `write(_:Data)`
extension FileHandle: DataOutputStream {}

/// Let `Data` conform to `DataOutputStream`
extension Data: DataOutputStream {
  public mutating func write(_ data:Data) { self.append(data) }
}
