/* *************************************************************************************************
 CacheControlDirectiveTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class CacheControlDirectiveTests: XCTestCase {
  func test_array() {
    let directives = Array<CacheControlDirective>(string:"public, max-age=19831003")
    XCTAssertTrue(directives == [.public, .maxAge(19831003)])
  }
  
  static var allTests = [
    ("test_array", test_array),
  ]
}






