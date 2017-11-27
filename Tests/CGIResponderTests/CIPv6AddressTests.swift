/***************************************************************************************************
 CIPv4AddressTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class CIPv6AddressTests: XCTestCase {
  func testStringConversion() {
    let string = "::ffff:127.0.0.1"
    let address = CIPv6Address(string:string)
    
    XCTAssertNotNil(address)
    XCTAssertEqual(address!.bytes, [0,0,0,0,0,0,0,0,0,0,0xff,0xff,127,0,0,1])
    XCTAssertEqual(address!.description, string)
  }
  
  static var allTests:[(String, (CIPv6AddressTests) -> () -> Void)] = [
    ("testStringConversion", testStringConversion),
  ]
}




