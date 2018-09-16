/***************************************************************************************************
 ContentTypeTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateContentTypeTests: XCTestCase {
  func testCreation() {
    let contentTypeString = "application/xhtml+xml; charset=UTF-8"
    let contentType = MIMEType(contentTypeString)
    XCTAssertNotNil(contentType)
    
    let contentTypeField = HTTPHeaderField(contentType:contentType!)
    XCTAssertEqual("\(HTTPHeaderFieldName.contentType.rawValue): \(contentTypeString)\r\n", contentTypeField.description)
  }

  func testDelegateSelection() {
    let string = "Content-Type: text/plain; charset=US-ASCII\r\n"
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.ContentType)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateContentTypeTests) -> () -> Void)] = [
    ("testCreation", testCreation),
    ("testDelegateSelection", testDelegateSelection)
  ]
}

