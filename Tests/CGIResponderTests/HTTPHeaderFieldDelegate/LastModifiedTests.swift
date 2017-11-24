/***************************************************************************************************
 LastModifiedTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateLastModifiedTests: XCTestCase {
  func testCreation() {
    let date = Date()
    let dateString = DateFormatter.rfc1123.string(from:date)
    let lastModifiedField = HTTPHeaderField(lastModified:date)
    XCTAssertEqual("\(HTTPHeaderFieldName.lastModified.rawValue): \(dateString)\r\n", lastModifiedField.description)
  }
  
  func testDelegateSelection() {
    let string = "Last-Modified: Sat, 08 Jun 2013 05:32:10 GMT"
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.LastModified)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateLastModifiedTests) -> () -> Void)] = [
    ("testCreation", testCreation),
    ("testDelegateSelection", testDelegateSelection)
  ]
}


