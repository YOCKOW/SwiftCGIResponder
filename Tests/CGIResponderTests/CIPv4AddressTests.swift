/***************************************************************************************************
 CIPv4AddressTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class CIPv4AddressTests: XCTestCase {
  func testStringConversion() {
    let string = "127.0.0.1"
    let address = CIPv4Address(string:string)
    
    XCTAssertNotNil(address)
    XCTAssertEqual(address!.bytes, [127,0,0,1])
    XCTAssertEqual(address!.description, string)
  }
  
  static var allTests:[(String, (CIPv4AddressTests) -> () -> Void)] = [
    ("testStringConversion", testStringConversion),
  ]
}




