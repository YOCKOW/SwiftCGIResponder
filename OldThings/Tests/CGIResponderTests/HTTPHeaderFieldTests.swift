/***************************************************************************************************
 HTTPHeaderFieldTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder

class HTTPHeaderFieldTests: XCTestCase {
  func testFieldNameValidation() {
    XCTAssertNil(HTTPHeaderFieldName(rawValue:"Space Not Allowed"))
  }
  
  func testFieldValueValidation() {
    XCTAssertNotNil(HTTPHeaderFieldValue(rawValue:"Space and Tab  Allowed."))
    XCTAssertNil(HTTPHeaderFieldValue(rawValue:"ひらがなは無効です。"))
  }
  
  static var allTests: [(String, (HTTPHeaderFieldTests) -> () -> Void)] = [
    ("testFieldNameValidation", testFieldNameValidation),
    ("testFieldValueValidation", testFieldValueValidation)
    ]
}


