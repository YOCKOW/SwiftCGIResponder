/***************************************************************************************************
 DateFormattersTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder
import Foundation

class DateFormattersTests: XCTestCase {
  func testConversion() {
    let string = "Sat, 08 Jun 2013 05:32:10 GMT"
    let invalid = "?"
    
    XCTAssertNil(DateFormatter.rfc1123.date(from:invalid))
    
    let date = DateFormatter.rfc1123.date(from:string)!
    XCTAssertEqual(DateFormatter.rfc1123.string(from:date), string)
  }
  
  
  static var allTests: [(String, (DateFormattersTests) -> () -> Void)] = [
    ("testConversion", testConversion),
  ]
}


