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
  
  func testArray() {
    let pairs = "name=value0; name=value1; name=value2; anotherName=anotherValue "
    let items = Array<HTTPCookieItem>(string:pairs)
    XCTAssertNotNil(items)
    
    let values = items!.values(forName:"name")
    XCTAssertEqual(values[0], "value0")
    XCTAssertEqual(values[1], "value1")
    XCTAssertEqual(values[2], "value2")
    XCTAssertFalse(values.contains("anotherValue"))
  }
  
  static var allTests:[(String, (HTTPCookieItemTests) -> () -> Void)] = [
    ("testInitialization", testInitialization),
    ("testArray", testArray),
  ]
}


