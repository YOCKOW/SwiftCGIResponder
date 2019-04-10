/* *************************************************************************************************
 ErrorMessageTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest

import Foundation
@testable import CGIResponder
@testable import yExtensions

/// Check output of `warn(_: separator: terminator:)`
func checkWarning(_ expected:@autoclosure () -> ErrorMessage,
                  file: StaticString = #file,
                  line: UInt = #line,
                  _ body:() throws -> Void) rethrows -> Void {
  let path = NSTemporaryDirectory() + UUID().uuidString
  
  _ = FileManager.default.createFile(atPath:path, contents:nil, attributes:nil)
  
  let originalStandardError = FileHandle._changeableStandardError
  let tmpFile = FileHandle(forUpdatingAtPath:path)!
  FileHandle._changeableStandardError = tmpFile
  defer {
    FileHandle._changeableStandardError = originalStandardError
    
    tmpFile.seek(toFileOffset:0)
    let data = tmpFile.availableData
    tmpFile.closeFile()
    
    try! FileManager.default.removeItem(atPath:path)
    
    let message = String(data:data, encoding:.utf8)!.trimmingCharacters(in:.whitespacesAndNewlines)
    
    XCTAssertEqual(message, expected().rawValue, file:file, line:line)
  }
  
  try body()
}

final class ErrorMessageTests: XCTestCase {
  func test_message() {
    checkWarning("MESSAGE") { warn(message:"MESSAGE") }
  }
}

