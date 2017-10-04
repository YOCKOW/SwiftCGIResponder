/***************************************************************************************************
 String+UnicodeScalarSetTests.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class StringUnicodeScalarSetTests: XCTestCase {
  func testTrimming() {
    let expected = "ABC DEF GHI JKL"
    let string = "   \t \(expected) \r\n"
    let trimmed = string.trimmingUnicodeScalars(in:.whitespacesAndNewlines)
    XCTAssertEqual(expected, trimmed)
  }
  
  static var allTests: [(String, (StringUnicodeScalarSetTests) -> () -> Void)] = [
    ("testTrimming", testTrimming),
  ]
}


