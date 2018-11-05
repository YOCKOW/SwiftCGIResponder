/* *************************************************************************************************
 ContentDispositionTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class ContentDispositionTests: XCTestCase {
  func test_parser() {
    let attachment = ContentDisposition("attachment; filename=\"myfile.txt\"")
    XCTAssertEqual(attachment.value, .attachment)
    XCTAssertEqual(attachment.parameters?["filename"], "myfile.txt")
    
    
    let formData = ContentDisposition("form-data; name=\"field\"")
    XCTAssertEqual(formData.value, .formData)
    XCTAssertEqual(formData.parameters?["name"], "field")
  }
  
  
  static var allTests = [
    ("test_parser", test_parser)
  ]
}




