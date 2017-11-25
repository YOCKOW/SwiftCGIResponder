/***************************************************************************************************
 HTTPCookieItemTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPCookieItemTests: XCTestCase {
  func testInitialization() {
    let pair = "%E5%90%8D%E5%89%8D=%E5%80%A4"
    let item = HTTPCookieItem(string:pair)
    XCTAssertNotNil(item)
    XCTAssertEqual(item!.name, "名前")
    XCTAssertEqual(item!.value, "値")
  }
  
  static var allTests:[(String, (HTTPCookieItemTests) -> () -> Void)] = [
    ("testInitialization", testInitialization),
  ]
}


