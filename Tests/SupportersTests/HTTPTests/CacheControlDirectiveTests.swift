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
  
  func test_header() {
    let field = HeaderField(name:.cacheControl, value:"public, max-age=19831003, my-extension=\"my-value\"")
    let set = field.source as? CacheControlDirectiveSet
    XCTAssertNotNil(set)
    XCTAssertEqual(set?.contains(.public), true)
    XCTAssertEqual(set?.contains(.maxAge(19831003)), true)
    XCTAssertEqual(set?.contains(.extension(name:"my-extension", value:"my-value")), true)
    XCTAssertNotEqual(set?.contains(.private), true)
  }
  
  static var allTests = [
    ("test_set", test_set),
  ]
}






