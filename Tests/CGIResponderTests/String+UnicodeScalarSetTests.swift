/***************************************************************************************************
 String+UnicodeScalarSetTests.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation
import XCTest
@testable import CGIResponder

class String_UnicodeScalarSetTests: XCTestCase {
  func testSplitting() {
    let string = "  ABC \tDEF\t \tGHI JKL\t\t"
    let components_f = string.components(separatedBy:Foundation.CharacterSet.whitespaces)
    let components_u = string.components(separatedBy:UnicodeScalarSet.whitespaces)
    XCTAssertEqual(components_f, components_u)
  }
  
  func testTrimming() {
    let expected = "ABC DEF GHI JKL"
    let string = "   \t \(expected) \r\n"
    let trimmed = string.trimmingUnicodeScalars(in:.whitespacesAndNewlines)
    XCTAssertEqual(expected, trimmed)
  }
  
  static var allTests: [(String, (String_UnicodeScalarSetTests) -> () -> Void)] = [
    ("testSplitting", testSplitting),
    ("testTrimming", testTrimming),
  ]
}


