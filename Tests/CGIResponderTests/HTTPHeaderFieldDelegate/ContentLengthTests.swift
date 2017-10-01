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
  
  func testDelegateSelection() {
    let string = "Content-Length: 128"
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.ContentLength)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateContentLengthTests) -> () -> Void)] = [
    ("testCreation", testCreation),
  ]
}
