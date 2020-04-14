/* *************************************************************************************************
 ErrorMessageTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest

import Foundation
@testable import CGIResponder
import TemporaryFile

/// Check output of `warn(_: separator: terminator:)`
func checkWarning(_ expected:@autoclosure () -> ErrorMessage,
                  file: StaticString = #file,
                  line: UInt = #line,
                  _ body:() throws -> Void) rethrows -> Void {
  try TemporaryFile {
    let originalStandardError = _changeableStandardError
    _changeableStandardError = .init($0)
    defer { _changeableStandardError = originalStandardError }
    
    try body()
    
    try $0.seek(toOffset: 0)
    guard let data = try $0.readToEnd() else { throw NSError(domain: "Unxpected error.", code: -1) }
    
    let message = String(data:data, encoding:.utf8)!.trimmingCharacters(in:.whitespacesAndNewlines)
    XCTAssertEqual(message, expected().rawValue, file:file, line:line)
  }
}

final class ErrorMessageTests: XCTestCase {
  func test_message() {
    checkWarning("MESSAGE") { warn(message:"MESSAGE") }
  }
}

