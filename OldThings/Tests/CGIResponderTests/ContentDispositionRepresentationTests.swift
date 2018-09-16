/***************************************************************************************************
 ContentDispositionRepresentationTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder

class ContentDispositionRepresentationTests: XCTestCase {
  func testInitialization() {
    let string = "form-data; name=\"name\"; filename=\"myfile.txt\""
    let disp = ContentDispositionRepresentation(string)
    
    XCTAssertNotNil(disp)
    
    let params = disp!.parameters
    XCTAssertNotNil(params)
    
    let name = params![.name]
    XCTAssertNotNil(name)
    XCTAssertEqual(name!, "name")
    
    let filename = params![.filename]
    XCTAssertNotNil(filename)
    XCTAssertEqual(filename!, "myfile.txt")
  }
  
  static var allTests:[(String, (ContentDispositionRepresentationTests) -> () -> Void)] = [
    ("testInitialization", testInitialization),
  ]
}




