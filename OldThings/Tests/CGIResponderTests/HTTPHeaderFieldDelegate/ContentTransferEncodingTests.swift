/***************************************************************************************************
 ContentTransferEncodingTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateContentTransferEncodingTests: XCTestCase {
  func testCreation() {
    let string = "BASE64"
    let encoding = ContentTransferEncoding(rawValue:string)
    XCTAssertNotNil(encoding)
    
    let field = HTTPHeaderField(contentTransferEncoding:encoding!)
    XCTAssertEqual("\(HTTPHeaderFieldName.contentTransferEncoding.rawValue): \(string.lowercased())\r\n", field.description)
  }

  func testDelegateSelection() {
    let string = "Content-Transfer-Encoding: Quoted-Printable\r\n"
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.ContentTransferEncoding)
    XCTAssertEqual((field!.delegate as! HTTPHeaderFieldDelegate.ContentTransferEncoding).contentTransferEncoding,
                   .quotedPrintable)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateContentTransferEncodingTests) -> () -> Void)] = [
    ("testCreation", testCreation),
    ("testDelegateSelection", testDelegateSelection)
  ]
}

