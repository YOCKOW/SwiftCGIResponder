/* *************************************************************************************************
 HeaderFieldTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class HeaderFieldTests: XCTestCase {
  func test_name_initialization() {
    XCTAssertNil(HeaderFieldName(rawValue:"Space Not Allowed"))
    XCTAssertNil(HeaderFieldName(rawValue:""))
    XCTAssertNotNil(HeaderFieldName(rawValue:"X-My-Original-HTTP-Header-Field-Name"))
  }
  
  func test_value_initialization() {
    XCTAssertNotNil(HeaderFieldValue(rawValue:"Space and Tab \u{0009} Allowed."))
    XCTAssertNil(HeaderFieldValue(rawValue:"ひらがなは無効です。"))
  }
  
  func test_initialization() {
    let eTag1 = ETag("\"SomeETag\"")!
    let eTag2 = ETag("W/\"SomeWeakETag\"")!
    
    let eTagDelegate = ETagHeaderFieldDelegate(eTag1)
    let eTagField = HeaderField(delegate:eTagDelegate)
    XCTAssertFalse(eTagField.isAppendable)
    XCTAssertFalse(eTagField.isDuplicable)
    XCTAssertEqual(eTagField.name, .eTag)
    XCTAssertEqual(eTagField.value, eTag1.httpHeaderFieldValue)
    
    let ifMatchDelegate = IfMatchHeaderFieldDelegate([eTag1, eTag2])
    let ifMatchField = HeaderField(delegate:ifMatchDelegate)
    XCTAssertTrue(ifMatchField.isAppendable)
    XCTAssertFalse(ifMatchField.isDuplicable)
    XCTAssertEqual(ifMatchField.name, .ifMatch)
    XCTAssertEqual(ifMatchField.value, [eTag1, eTag2].httpHeaderFieldValue)
  }
  
  
  static var allTests = [
    ("test_name_initialization", test_name_initialization),
    ("test_value_initialization", test_value_initialization),
    ("test_initialization", test_initialization),
  ]
}


