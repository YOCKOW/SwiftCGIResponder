/***************************************************************************************************
 RangeSetTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class RangeSetTests: XCTestCase {
  func testNormalization() {
    let range1: PartialRangeUpTo<Int> = ..<15
    let range2: Range<Int> = 10 ..< 40
    let range3: ClosedRange<Int> = 60 ... 80
    let range4: Range<Int> = 90 ..< 100
    let range5: PartialRangeFrom<Int> = 100...
    
    var set = RangeSet<Int>()
    set.insert(range5)
    set.insert(range4)
    set.insert(range3)
    set.insert(range2)
    set.insert(range1)
    
    XCTAssertEqual(set.elements.count, 3)
    XCTAssertEqual(set.elements[0], RangeSet<Int>.Element(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.elements[1], RangeSet<Int>.Element(ClosedRange<Int>(60...80)))
    XCTAssertEqual(set.elements[2], RangeSet<Int>.Element(PartialRangeFrom<Int>(90)))
    
    XCTAssertTrue(set.contains(-100))
    XCTAssertTrue(set.contains(5))
    XCTAssertFalse(set.contains(50))
    XCTAssertTrue(set.contains(70))
    XCTAssertFalse(set.contains(85))
    XCTAssertTrue(set.contains(100))
    XCTAssertTrue(set.contains(1000))
  }
  
  static var allTests: [(String, (RangeSetTests) -> () -> Void)] = [
    ("testNormalization", testNormalization),
  ]
}


