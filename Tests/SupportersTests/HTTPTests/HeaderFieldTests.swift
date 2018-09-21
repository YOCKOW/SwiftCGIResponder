/* *************************************************************************************************
 HeaderFieldTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class HeaderFieldTests: XCTestCase {
  func test_name_initialization() {
    XCTAssertNil(HeaderFieldName(rawValue:"Space Not Allowed"))
    XCTAssertNil(HeaderFieldName(rawValue:""))
    XCTAssertNotNil(HeaderFieldName(rawValue:"X-My-Original-HTTP-Header-Field-Name"))
  }
  
  func test_value_initialization() {
    XCTAssertNotNil(HeaderFieldValue(rawValue:"Space and Tab \u{0009} Allowed."))
    XCTAssertNil(HeaderFieldValue(rawValue:"ひらがなは無効です。"))
  }
  
  
  static var allTests = [
    ("test_name_initialization", test_name_initialization),
    ("test_value_initialization", test_value_initialization),
  ]
}


