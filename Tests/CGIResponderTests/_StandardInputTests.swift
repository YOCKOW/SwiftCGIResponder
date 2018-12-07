/* *************************************************************************************************
 _StandardInputTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder

import Foundation

func withStandardInput(data:Data, _ body:() throws -> Void) rethrows {
  let path = NSTemporaryDirectory() + UUID().uuidString
  
  _ = FileManager.default.createFile(atPath:path, contents:nil, attributes:nil)
  
  let originalStandardInput = FileHandle._changeableStandardInput
  let tmpFile = FileHandle(forUpdatingAtPath:path)!
  FileHandle._changeableStandardInput = tmpFile
  defer {
    FileHandle._changeableStandardInput = originalStandardInput
  }
  
  tmpFile.write(data)
  tmpFile.seek(toFileOffset:0)
  try body()
}
