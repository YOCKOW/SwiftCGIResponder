/***************************************************************************************************
 ContentLengthTests.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateContentLengthTests: XCTestCase {
  func testCreation() {
    let contentLengthField = HTTPHeaderField(contentLength:19831003)
    XCTAssertEqual("\(HTTPHeaderFieldName.contentLength.rawValue): 19831003\r\n", contentLengthField.description)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateContentLengthTests) -> () -> Void)] = [
    ("testCreation", testCreation),
  ]
}