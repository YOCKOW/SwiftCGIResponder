/***************************************************************************************************
 MultirangeTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class MultirangeTests: XCTestCase {
  func testNormalization() {
    let range1: PartialRangeUpTo<Int> = ..<15
    let range2: Range<Int> = 10 ..< 40
    let range3: ClosedRange<Int> = 60 ... 80
    let range4: Range<Int> = 90 ..< 100
    let range5: PartialRangeFrom<Int> = 100...
    
    var set = Multirange<Int>()
    set.insert(range5)
    set.insert(range4)
    set.insert(range3)
    set.insert(range2)
    set.insert(range1)
    
    XCTAssertEqual(set.ranges.count, 3)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(ClosedRange<Int>(60...80)))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(PartialRangeFrom<Int>(90)))
    XCTAssertTrue(set.contains(-100))
    XCTAssertTrue(set.contains(5))
    XCTAssertFalse(set.contains(50))
    XCTAssertTrue(set.contains(70))
    XCTAssertFalse(set.contains(85))
    XCTAssertTrue(set.contains(100))
    XCTAssertTrue(set.contains(1000))
    
    let range6: LeftOpenRange<Int> = 40<--50
    set.insert(range6)
    XCTAssertEqual(set.ranges.count, 4)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(LeftOpenRange<Int>(40<--50)))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(ClosedRange<Int>(60...80)))
    XCTAssertEqual(set.ranges[3], Multirange<Int>.Range(PartialRangeFrom<Int>(90)))
    XCTAssertFalse(set.contains(40))
    XCTAssertTrue(set.contains(41))
    
    let range7: OpenRange<Int> = 50<-<60
    set.insert(range7)
    XCTAssertEqual(set.ranges.count, 3)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(LeftOpenRange<Int>(40<--80)))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(PartialRangeFrom<Int>(90)))
    XCTAssertFalse(set.contains(40))
    XCTAssertTrue(set.contains(55))
    
    let range8: PartialRangeGreaterThan<Int> = 85<--
    set.insert(range8)
    XCTAssertEqual(set.ranges.count, 3)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(LeftOpenRange<Int>(40<--80)))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(PartialRangeGreaterThan<Int>(85)))
    XCTAssertFalse(set.contains(85))
    XCTAssertTrue(set.contains(100))
    XCTAssertTrue(set.contains(Int.max))
    
  }
  
  static var allTests: [(String, (MultirangeTests) -> () -> Void)] = [
    ("testNormalization", testNormalization),
  ]
}


