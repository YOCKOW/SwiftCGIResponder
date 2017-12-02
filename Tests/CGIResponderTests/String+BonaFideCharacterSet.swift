/***************************************************************************************************
 String+BonaFideCharacterSet.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation
import XCTest
@testable import CGIResponder

class String_BonaFideCharacterSetTests: XCTestCase {
  func testAddingPercentEncoding() {
    let set_f = CharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let set_b = BonaFideCharacterSet(charactersIn:"ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    
    let string = "あいうえお"
    
    XCTAssertEqual(string.addingPercentEncoding(withAllowedCharacters:set_f)?.uppercased(),
                   string.addingPercentEncoding(withAllowedCharacters:set_b)?.uppercased())
  }
  
  static var allTests:[(String, (String_BonaFideCharacterSetTests) -> () -> Void)] = [
    ("testAddingPercentEncoding", testAddingPercentEncoding),
  ]
}



