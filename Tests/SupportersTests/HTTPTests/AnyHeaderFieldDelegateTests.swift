/* *************************************************************************************************
 AnyHeaderFieldDelegateTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class AnyHeaderFieldDelegateTests: XCTestCase {
  func test_initializer() {
    let any1 = _AnyHeaderFieldDelegate(ETagHeaderFieldDelegate(ETag("*")!))
    XCTAssertEqual(any1.type, .single)
    XCTAssertEqual(any1.name, .eTag)
    XCTAssertEqual(any1.value, HeaderFieldValue(rawValue:"*")!)
    
    
    var any2 = _AnyHeaderFieldDelegate(IfMatchHeaderFieldDelegate([ETag("\"A\"")!]))
    any2.append(ETag("\"B\"")!)
    XCTAssertEqual(any2.type, .appendable)
    XCTAssertEqual(any2.name, .ifMatch)
    XCTAssertEqual(any2.value, HeaderFieldValue(rawValue:"\"A\", \"B\"")!)
    
    let unspecified = _AnyHeaderFieldDelegate(name:HeaderFieldName(rawValue:"Foo")!,
                                              value:HeaderFieldValue(rawValue:"Bar")!)
    XCTAssertEqual(unspecified.type, .single)
    XCTAssertEqual(unspecified.name, HeaderFieldName(rawValue:"Foo")!)
    XCTAssertEqual(unspecified.value, HeaderFieldValue(rawValue:"Bar")!)
  }
  
  
  static var allTests = [
    ("test_initializer", test_initializer)
  ]
}



