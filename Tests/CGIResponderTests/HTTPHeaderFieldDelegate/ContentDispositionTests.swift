/***************************************************************************************************
 ContentDispositionTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateContentDispositionTests: XCTestCase {
  func testCreation() {
    let string = "attachment; filename=\"filename.txt\""
    let disposition = ContentDisposition(string)
    XCTAssertNotNil(disposition)
    
    let field = HTTPHeaderField(contentDisposition:disposition!)
    XCTAssertEqual("\(HTTPHeaderFieldName.contentDisposition.rawValue): \(string)\r\n", field.description)
  }

  func testDelegateSelection() {
    let string = "Content-Disposition: attachment; filename=\"filename.txt\"\r\n"
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.ContentDisposition)
    
    XCTAssertEqual((field!.delegate as! HTTPHeaderFieldDelegate.ContentDisposition).contentDisposition.value,
                   .attachment)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateContentDispositionTests) -> () -> Void)] = [
    ("testCreation", testCreation),
    ("testDelegateSelection", testDelegateSelection)
  ]
}

