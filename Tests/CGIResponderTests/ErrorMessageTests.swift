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
import TemporaryFile

/// Check output of `warn(_: separator: terminator:)`
func checkWarning(_ expected:@autoclosure () -> ErrorMessage,
                  file: StaticString = #file,
                  line: UInt = #line,
                  _ body:() throws -> Void) rethrows -> Void {
  try TemporaryFile {
    let originalStandardError = FileHandle._changeableStandardError
    FileHandle._changeableStandardError = $0
    defer { FileHandle._changeableStandardError = originalStandardError }
    
    try body()
    
    $0.seek(toFileOffset: 0)
    let data = $0.availableData
    
    let message = String(data:data, encoding:.utf8)!.trimmingCharacters(in:.whitespacesAndNewlines)
    XCTAssertEqual(message, expected().rawValue, file:file, line:line)
  }
}

final class ErrorMessageTests: XCTestCase {
  func test_message() {
    checkWarning("MESSAGE") { warn(message:"MESSAGE") }
  }
}

