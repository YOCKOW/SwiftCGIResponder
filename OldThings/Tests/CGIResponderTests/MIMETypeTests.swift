/***************************************************************************************************
 MIMETypeTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class MIMETypeTests: XCTestCase {
  func testInitialization() {
    let text_plain_string = "text/plain; charset=UTF-8"
    let text_plain_quoted_string = "TEXT/plain; charset=\"UTF-8\";"
    let text_plain = MIMEType(text_plain_string)
    let text_plain2 = MIMEType(text_plain_quoted_string)
    
    XCTAssertNotNil(text_plain)
    XCTAssertEqual(text_plain_string, text_plain!.description)
    XCTAssertNotNil(text_plain2)
    XCTAssertEqual(text_plain!, text_plain2!)
  }
  
  func testPathExtensions() {
    let xhtmlType = MIMEType(pathExtension:.xhtml, parameters:["charset":"UTF-8"])
    XCTAssertNotNil(xhtmlType)
    XCTAssertEqual(xhtmlType!.type, .application)
    XCTAssertEqual(xhtmlType!.tree, nil)
    XCTAssertEqual(xhtmlType!.subtype, "xhtml")
    XCTAssertEqual(xhtmlType!.suffix, .xml)
    XCTAssertEqual(xhtmlType!.parameters!, ["charset":"UTF-8"])
  }
  
  static var allTests:[(String, (MIMETypeTests) -> () -> Void)] = [
    ("testInitialization", testInitialization),
    ("testPathExtensions", testPathExtensions),
  ]
}
