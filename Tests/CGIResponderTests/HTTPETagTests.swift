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
  
  func testList() {
    XCTAssertNil(Array<HTTPETag>(string:"\"A\", \"B...?")) // not closed
    
    let list = Array<HTTPETag>(string:"\"A\", \"B\", W/\"C\",  \"D\" ")!
    XCTAssertEqual(list[0], .strong("A"))
    XCTAssertEqual(list[1], .strong("B"))
    XCTAssertEqual(list[2], .weak("C"))
    XCTAssertEqual(list[3], .strong("D"))
  }
  
  static var allTests:[(String, (HTTPETagTests) -> () -> Void)] = [
    ("testInitialization", testInitialization),
    ("testComparison", testComparison),
    ("testList", testList),
  ]
}

