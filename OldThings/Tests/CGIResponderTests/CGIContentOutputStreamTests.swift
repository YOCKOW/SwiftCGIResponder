/***************************************************************************************************
 CGIContentOutputStreamTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder
import Foundation

class CGIContentOutputStreamTests: XCTestCase {
  
  func testData() {
    let string = "STRING"
    let content = CGIContent(string:string)
    
    var data = Data()
    XCTAssertNoThrow(try data.write(content))
    XCTAssertEqual(data, string.data(using:.utf8)!)
  }
  
  
  static var allTests: [(String, (CGIContentOutputStreamTests) -> () -> Void)] = [
    ("testData", testData),
  ]
}

