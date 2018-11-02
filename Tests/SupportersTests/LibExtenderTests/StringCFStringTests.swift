/* *************************************************************************************************
 StringCFStringTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import LibExtender

final class StringCFStringTests: XCTestCase {
  func test_conversion() {
    let ascii_string = "A"
    XCTAssertEqual(ascii_string, String(ascii_string.coreFoundationString))
    
    let japanese = "日本語"
    XCTAssertEqual(japanese, String(japanese.coreFoundationString))
  }
  
  
  static var allTests = [
    ("test_conversion", test_conversion),
  ]
}




