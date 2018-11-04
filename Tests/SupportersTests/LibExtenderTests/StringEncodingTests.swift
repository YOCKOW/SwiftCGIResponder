/* *************************************************************************************************
 StringEncodingTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import LibExtender

final class StringEncodingTests: XCTestCase {
  func test_IANACharSetName() {
    func check(_ encoding:String.Encoding, _ expected:String, file: StaticString = #file, line: UInt = #line) {
      XCTAssertEqual(encoding.ianaCharacterSetName?.lowercased(), expected.lowercased(),
                     file:file, line:line)
      XCTAssertEqual(encoding, String.Encoding(ianaCharacterSetName:expected),
                     file:file, line:line)
    }
    
    check(.ascii, "US-ASCII")
    check(.iso2022JP, "ISO-2022-JP")
    check(.japaneseEUC, "EUC-JP")
    check(.utf8, "UTF-8")
  }
  
  
  static var allTests = [
    ("test_IANACharSetName", test_IANACharSetName),
  ]
}





