/***************************************************************************************************
 String+PartialMatch.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 
import XCTest
@testable import CGIResponder

class String_PartialMatchTests: XCTestCase {
  func testMatch() {
    let target1 = "あいうえおかきくけこさしすせそ"
    let target2 = "あいうえおがぎぐげござじずぜぞ"
    
    let part1 = "かきくけこ"
    let part2 = "\u{304B}\u{3099}\u{304E}ぐげご"
    
    XCTAssertFalse(target1.matches(part1))
    XCTAssertTrue(target1.matches(part1, from:target1.index(of:"か")!))
    XCTAssertTrue(target2.matches(part2, from:target2.index(of:"が")!))
  }
  
  static var allTests: [(String, (String_PartialMatchTests) -> () -> Void)] = [
    ("testMatch", testMatch),
  ]
}


