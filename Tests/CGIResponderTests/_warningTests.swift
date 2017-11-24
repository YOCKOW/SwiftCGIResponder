/***************************************************************************************************
 _warningTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder
import Foundation

/// Check output of `warn(_: separator: terminator:)`
func checkWarning(_ expected:ErrorMessage, _ body:() throws -> Void) rethrows -> Bool {
  let path = NSTemporaryDirectory() + UUID().uuidString
  
  FileManager.default.createFile(atPath:path, contents:nil, attributes:nil)
  
  let tmpFile = FileHandle(forUpdatingAtPath:path)!
  FileHandle.changeableStandardError = tmpFile
  try body()
  FileHandle.changeableStandardError = FileHandle.standardError
  
  tmpFile.seek(toFileOffset:0)
  let data = tmpFile.availableData
  tmpFile.closeFile()
  
  try! FileManager.default.removeItem(atPath:path)
  
  let message = String(data:data, encoding:.utf8)!.trimmingCharacters(in:.whitespacesAndNewlines)
  return message == expected.rawValue
}
