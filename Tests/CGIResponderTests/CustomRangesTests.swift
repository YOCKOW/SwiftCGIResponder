/***************************************************************************************************
 CustomRangesTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class CustomRangesTests: XCTestCase {
  func testOverlaps() {
    let leftOpenRange1: LeftOpenRange<Int> = 10<--20
    let leftOpenRange2: LeftOpenRange<Int> = 20<--30
    let leftOpenRange3: LeftOpenRange<Int> = 15<--25
    let openRange1: OpenRange<Int> = 10<-<20
    let openRange2: OpenRange<Int> = 20<-<30
    let openRange3: OpenRange<Int> = 15<-<25
    let closedRange1: ClosedRange<Int> = 10...20
    let closedRange2: ClosedRange<Int> = 20...30
    let closedRange3: ClosedRange<Int> = 15...25
    let range1: Range<Int> = 10..<20
    let range2: Range<Int> = 20..<30
    let range3: Range<Int> = 15..<25
    
    do {
      // LeftOpenRange
      XCTAssertTrue(leftOpenRange1.overlaps(leftOpenRange1))
      XCTAssertFalse(leftOpenRange1.overlaps(leftOpenRange2))
      XCTAssertTrue(leftOpenRange1.overlaps(leftOpenRange3))
      
      XCTAssertTrue(leftOpenRange1.overlaps(openRange1))
      XCTAssertFalse(leftOpenRange1.overlaps(openRange2))
      XCTAssertTrue(leftOpenRange1.overlaps(openRange3))
      
      XCTAssertTrue(leftOpenRange1.overlaps(closedRange1))
      XCTAssertTrue(leftOpenRange1.overlaps(closedRange2))
      XCTAssertTrue(leftOpenRange1.overlaps(closedRange3))
      
      XCTAssertTrue(leftOpenRange1.overlaps(range1))
      XCTAssertTrue(leftOpenRange1.overlaps(range2))
      XCTAssertTrue(leftOpenRange1.overlaps(range3))
    }
    
    do {
      // OpenRange
      XCTAssertTrue(openRange1.overlaps(leftOpenRange1))
      XCTAssertFalse(openRange1.overlaps(leftOpenRange2))
      XCTAssertTrue(openRange1.overlaps(leftOpenRange3))
      
      XCTAssertTrue(openRange1.overlaps(openRange1))
      XCTAssertFalse(openRange1.overlaps(openRange2))
      XCTAssertTrue(openRange1.overlaps(openRange3))
      
      XCTAssertTrue(openRange1.overlaps(closedRange1))
      XCTAssertFalse(openRange1.overlaps(closedRange2))
      XCTAssertTrue(openRange1.overlaps(closedRange3))
      
      XCTAssertTrue(openRange1.overlaps(range1))
      XCTAssertFalse(openRange1.overlaps(range2))
      XCTAssertTrue(openRange1.overlaps(range3))
    }
    
    do {
      // ClosedRange
      XCTAssertTrue(closedRange1.overlaps(leftOpenRange1))
      XCTAssertFalse(closedRange1.overlaps(leftOpenRange2))
      XCTAssertTrue(closedRange1.overlaps(leftOpenRange3))
      
      XCTAssertTrue(closedRange1.overlaps(openRange1))
      XCTAssertFalse(closedRange1.overlaps(openRange2))
      XCTAssertTrue(closedRange1.overlaps(openRange3))
      
      XCTAssertTrue(closedRange1.overlaps(closedRange1))
      XCTAssertTrue(closedRange1.overlaps(closedRange2))
      XCTAssertTrue(closedRange1.overlaps(closedRange3))
      
      XCTAssertTrue(closedRange1.overlaps(range1))
      XCTAssertTrue(closedRange1.overlaps(range2))
      XCTAssertTrue(closedRange1.overlaps(range3))
    }
    
    do {
      // Range
      XCTAssertTrue(range1.overlaps(leftOpenRange1))
      XCTAssertFalse(range1.overlaps(leftOpenRange2))
      XCTAssertTrue(range1.overlaps(leftOpenRange3))
      
      XCTAssertTrue(range1.overlaps(openRange1))
      XCTAssertFalse(range1.overlaps(openRange2))
      XCTAssertTrue(range1.overlaps(openRange3))
      
      XCTAssertTrue(range1.overlaps(closedRange1))
      XCTAssertFalse(range1.overlaps(closedRange2))
      XCTAssertTrue(range1.overlaps(closedRange3))
      
      XCTAssertTrue(range1.overlaps(range1))
      XCTAssertFalse(range1.overlaps(range2))
      XCTAssertTrue(range1.overlaps(range3))
    }
  }
  
  func testPartialRangeGreaterThan() {
    let r1: PartialRangeGreaterThan<Int> = 10<--
    
    XCTAssertFalse(r1.contains(10))
    XCTAssertTrue(r1.contains(11))
    XCTAssertTrue(r1.contains(Int.max))
  }
  
  static var allTests: [(String, (CustomRangesTests) -> () -> Void)] = [
    ("testOverlaps", testOverlaps),
    ("testPartialRangeGreaterThan", testPartialRangeGreaterThan),
  ]
}



