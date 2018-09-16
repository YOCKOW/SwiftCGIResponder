/***************************************************************************************************
 CacheControl.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateCacheControlTests: XCTestCase {
  func testCreation() {
    let cacheControlField = HTTPHeaderField(cacheControlDirectives:[.public, .maxAge(19831003)])
    XCTAssertEqual("\(HTTPHeaderFieldName.cacheControl.rawValue): public, max-age=19831003\r\n",
                   cacheControlField.description)
  }
  
  func testDelegateSelection() {
    let string = "Cache-Control: no-cache, no-store, must-revalidate\r\n"
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.CacheControl)
    
    let delegate = field!.delegate as! HTTPHeaderFieldDelegate.CacheControl
    XCTAssertEqual(delegate.directives[0], .noCache)
    XCTAssertEqual(delegate.directives[1], .noStore)
    XCTAssertEqual(delegate.directives[2], .mustRevalidate)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateCacheControlTests) -> () -> Void)] = [
    ("testCreation", testCreation),
    ("testDelegateSelection", testDelegateSelection)
  ]
}

