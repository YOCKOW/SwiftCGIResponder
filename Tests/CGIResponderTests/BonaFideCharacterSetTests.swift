/***************************************************************************************************
 BonaFideCharacterSetTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class BonaFideCharacterSetTests: XCTestCase {
  func testAlphanumerics() {
    // wmm...
    XCTAssertTrue(BonaFideCharacterSet.alphanumerics.contains("A"))
    XCTAssertTrue(BonaFideCharacterSet.alphanumerics.contains("Ａ"))
  }
  
  func testNewlines() {
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\u{000B}"))
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\r"))
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\n"))
    XCTAssertTrue(BonaFideCharacterSet.newlines.contains("\r\n"))
    XCTAssertFalse(BonaFideCharacterSet.newlines.contains("\u{000E}"))
  }
  
  func testEmojiFlags() {
    XCTAssertTrue(BonaFideCharacterSet.emojiFlags.contains("🇯🇵"))
  }
  
  func testEmojiKeycaps() {
    XCTAssertTrue(BonaFideCharacterSet.emojiKeycaps.contains("3️⃣"))
  }
  
  func testMIMETypeTokens() {
    XCTAssertTrue(BonaFideCharacterSet.mimeTypeTokenAllowed.contains("8"))
    XCTAssertTrue(BonaFideCharacterSet.mimeTypeTokenAllowed.contains("U"))
  }
  
  static var allTests: [(String, (BonaFideCharacterSetTests) -> () -> Void)] = [
    ("testAlphanumerics", testAlphanumerics),
    ("testNewlines", testNewlines),
    ("testEmojiFlags", testEmojiFlags),
    ("testEmojiKeycaps", testEmojiKeycaps),
  ]
}




