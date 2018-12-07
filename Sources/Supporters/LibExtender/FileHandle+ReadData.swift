/* *************************************************************************************************
 FileHandle+ReadData.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

extension FileHandle {
  /// Read data until the given `byte` appears.
  public func readData(toByte byte:UInt8, maximumLength:Int = Int.max) -> Data {
    var result = Data()
    for _ in 0..<maximumLength {
      let byteData = self.readData(ofLength:1)
      if byteData.isEmpty { break }
      result.append(byteData)
      if byteData[0] == byte { return result }
    }
    return result
  }
}


