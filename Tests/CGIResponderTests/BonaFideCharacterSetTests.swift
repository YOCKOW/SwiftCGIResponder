/***************************************************************************************************
 BonaFideCharacterSetTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class BonaFideCharacterSetTests: XCTestCase {
  func testOneCharacter() {
    let set = BonaFideCharacterSet(charactersIn:"\r\n")
    XCTAssertFalse(set.contains("\r"))
    XCTAssertFalse(set.contains("\n"))
    XCTAssertTrue(set.contains("\r\n"))
  }
  
  static var allTests: [(String, (BonaFideCharacterSetTests) -> () -> Void)] = [
    ("testOneCharacter", testOneCharacter),
  ]
}




