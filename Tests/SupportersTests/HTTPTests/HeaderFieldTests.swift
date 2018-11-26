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
    
    let ifMatchDelegate = IfMatchHeaderFieldDelegate(.list([eTag1, eTag2]))
    let ifMatchField = HeaderField(delegate:ifMatchDelegate)
    XCTAssertTrue(ifMatchField.isAppendable)
    XCTAssertFalse(ifMatchField.isDuplicable)
    XCTAssertEqual(ifMatchField.name, .ifMatch)
    XCTAssertEqual(ifMatchField.value, ETagList.list([eTag1, eTag2]).httpHeaderFieldValue)
  }
  
  func test_delegateSelection() {
    func check_n<D>(_ name:HeaderFieldName, _ value:HeaderFieldValue, _ expected:D.Type,
                  file:StaticString = #file, line:UInt = #line)
      where D:HeaderFieldDelegate
    {
      let field = HeaderField(name:name, value:value)
      guard case _ as _AnyHeaderFieldDelegate._Box._Normal<D> = field._delegate._box else {
        XCTFail("Unexpected delegate", file:file, line:line)
        return
      }
    }
    
    func check_a<D>(_ name:HeaderFieldName, _ value:HeaderFieldValue, _ expected:D.Type,
                  file:StaticString = #file, line:UInt = #line)
      where D:AppendableHeaderFieldDelegate
    {
      let field = HeaderField(name:name, value:value)
      guard case _ as _AnyHeaderFieldDelegate._Box._Appendable<D> = field._delegate._box else {
        XCTFail("Unexpected delegate", file:file, line:line)
        return
      }
    }
    
    check_n(.contentDisposition, "attachment", ContentDispositionHeaderFieldDelegate.self)
    check_n(.eTag, "*", ETagHeaderFieldDelegate.self)
    check_a(.ifMatch, "*", IfMatchHeaderFieldDelegate.self)
  }
  
  func test_contentLengh() {
    let cl = HeaderField(name:.contentLength, value:"1024")
    XCTAssertNotNil(cl.source as? UInt)
    XCTAssertEqual(cl.source as? UInt, 1024)
  }
  
  
  static var allTests = [
    ("test_name_initialization", test_name_initialization),
    ("test_value_initialization", test_value_initialization),
    ("test_initialization", test_initialization),
    ("test_delegateSelection", test_delegateSelection),
    ("test_contentLengh", test_contentLengh),
  ]
}


