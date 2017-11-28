/***************************************************************************************************
 IPAddressTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder

class IPAddressTests: XCTestCase {
  func testStringConversion() {
    let v4String = "127.0.0.1"
    let v6String = "1234:5678:90AB:CDEF:1234:5678:90AB:CDEF"
    let v4MappedString = "::ffff:127.0.0.1"
    
    let v4 = IPAddress(string:v4String)
    XCTAssertNotNil(v4)
    XCTAssertEqual(v4!.description, v4String)
    
    let v6 = IPAddress(string:v6String)
    XCTAssertNotNil(v6)
    XCTAssertEqual(v6!.description.lowercased(), v6String.lowercased())
    
    let v4Mapped = IPAddress(string:v4MappedString)
    XCTAssertNotNil(v4Mapped)
    XCTAssertEqual(v4Mapped!.description.lowercased(), v4MappedString.lowercased())
    
    guard case .v4(let v4Bytes) = v4! else { XCTFail("Not IPv4."); return }
    XCTAssertEqual(v4Bytes.0, 127)
    XCTAssertEqual(v4Bytes.1, 0)
    XCTAssertEqual(v4Bytes.2, 0)
    XCTAssertEqual(v4Bytes.3, 1)
    
    guard case .v6(let v6Bytes) = v6! else { XCTFail("Not IPv6."); return }
    XCTAssertEqual(v6Bytes.0, 0x12)
    XCTAssertEqual(v6Bytes.1, 0x34)
    XCTAssertEqual(v6Bytes.2, 0x56)
    XCTAssertEqual(v6Bytes.3, 0x78)
    XCTAssertEqual(v6Bytes.4, 0x90)
    XCTAssertEqual(v6Bytes.5, 0xAB)
    XCTAssertEqual(v6Bytes.6, 0xCD)
    XCTAssertEqual(v6Bytes.7, 0xEF)
    XCTAssertEqual(v6Bytes.8, 0x12)
    XCTAssertEqual(v6Bytes.9, 0x34)
    XCTAssertEqual(v6Bytes.10, 0x56)
    XCTAssertEqual(v6Bytes.11, 0x78)
    XCTAssertEqual(v6Bytes.12, 0x90)
    XCTAssertEqual(v6Bytes.13, 0xAB)
    XCTAssertEqual(v6Bytes.14, 0xCD)
    XCTAssertEqual(v6Bytes.15, 0xEF)
    
    
    XCTAssertEqual(v4!, v4Mapped!)
  }
  
  func testDNSLookup() {
    // how to test..?
  }
  
  static var allTests: [(String, (IPAddressTests) -> () -> Void)] = [
    ("testStringConversion", testStringConversion),
    ("testDNSLookup", testDNSLookup),
  ]
}

