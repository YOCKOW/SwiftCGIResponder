/***************************************************************************************************
 ETagTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateETagTests: XCTestCase {
  func testCreation() {
    let eTag = HTTPETag.strong("Strong")
    let eTagField = HTTPHeaderField(eTag:eTag)
    XCTAssertEqual("\(HTTPHeaderFieldName.eTag.rawValue): \(eTag.description)\r\n", eTagField.description)
  }
  
  func testDelegateSelection() {
    let string = "ETag: W/\"weak\""
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.ETag)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateETagTests) -> () -> Void)] = [
    ("testCreation", testCreation),
    ("testDelegateSelection", testDelegateSelection)
  ]
}

