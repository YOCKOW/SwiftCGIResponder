/* *************************************************************************************************
 HeaderFieldValueTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class HeaderFieldValueTests: XCTestCase {
  func test_initialization() {
    XCTAssertNotNil(HeaderFieldValue(rawValue:"Space and Tab \u{0009} Allowed."))
    XCTAssertNil(HeaderFieldValue(rawValue:"ひらがなは無効です。"))
  }
  
  
  static var allTests = [
    ("test_initialization", test_initialization),
  ]
}


