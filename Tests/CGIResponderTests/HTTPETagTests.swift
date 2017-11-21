/***************************************************************************************************
 HTTPETagTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPETagTests: XCTestCase {
  func testInitialization() {
    XCTAssertNil(HTTPETag("unquoted"))
    XCTAssertEqual(HTTPETag("\"STRONG\""), .strong("STRONG"))
    XCTAssertEqual(HTTPETag("W/\"WEAK\""), .weak("WEAK"))
    XCTAssertEqual(HTTPETag("*"), .any)
  }
  
  func testComparison() {
    XCTAssertTrue(HTTPETag("\"ETag\"")! =~ HTTPETag("W/\"ETag\"")!)
  }
  
  static var allTests:[(String, (HTTPETagTests) -> () -> Void)] = [
    ("testInitialization", testInitialization),
    ("testComparison", testComparison),
  ]
}

