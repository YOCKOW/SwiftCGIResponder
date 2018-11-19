/* *************************************************************************************************
 CacheControlDirectiveTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class CacheControlDirectiveTests: XCTestCase {
  func test_set() {
    let directives = CacheControlDirectiveSet(.public, .maxAge(19831003))
    XCTAssertTrue(directives.contains(.public))
    XCTAssertTrue(directives.contains(sameCaseWith:.maxAge(0)))
  }
  
  static var allTests = [
    ("test_set", test_set),
  ]
}






