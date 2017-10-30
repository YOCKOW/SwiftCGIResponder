/***************************************************************************************************
 BonaFideCharacterSetTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class BonaFideCharacterSetTests: XCTestCase {
  func testNewlines() {
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\u{000B}"))
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\r"))
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\n"))
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\r\n"))
    XCTAssertFalse(BonaFideCharacterSet.newlines.contains("\u{000E}"))
  }
  
  static var allTests: [(String, (BonaFideCharacterSetTests) -> () -> Void)] = [
    ("testNewlines", testNewlines),
  ]
}




