/* *************************************************************************************************
 DictionaryKeyValueParserTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import LibExtender

final class DictionaryKeyValueParserTests: XCTestCase {
  func test_parse() {
    let string = "A=B; C=D; \"\\\"E\\\"\"=\"F\""
    let parsed = Dictionary<String,String>(parsing:string)
    
    XCTAssertEqual(parsed["A"], "B")
    XCTAssertEqual(parsed["C"], "D")
    XCTAssertEqual(parsed["\"E\""], "F")
  }
  
  
  static var allTests = [
    ("test_parse", test_parse),
  ]
}




