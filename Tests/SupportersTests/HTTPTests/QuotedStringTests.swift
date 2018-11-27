/* *************************************************************************************************
 QuotedStringTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class QuotedStringTests: XCTestCase {
  func test_quote() {
    XCTAssertEqual("ABC\\DEF"._quotedString, "\"ABC\\\\DEF\"")
    XCTAssertEqual("あ"._quotedString, nil)
  }
  
  func test_unquote() {
    XCTAssertEqual("\"ABC\\\\DEF\""._unquotedString, "ABC\\DEF")
    XCTAssertEqual("\"NOTCLOSED"._unquotedString, nil)
  }
}






