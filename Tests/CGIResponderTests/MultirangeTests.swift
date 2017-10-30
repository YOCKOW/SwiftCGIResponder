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
    
    let range6: LeftOpenRange<Int> = 40<..50
    set.insert(range6)
    XCTAssertEqual(set.ranges.count, 4)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(LeftOpenRange<Int>(40<..50)))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(ClosedRange<Int>(60...80)))
    XCTAssertEqual(set.ranges[3], Multirange<Int>.Range(PartialRangeFrom<Int>(90)))
    XCTAssertFalse(set.contains(40))
    XCTAssertTrue(set.contains(41))
    
    let range7: OpenRange<Int> = 50<.<60
    set.insert(range7)
    XCTAssertEqual(set.ranges.count, 3)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(LeftOpenRange<Int>(40<..80)))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(PartialRangeFrom<Int>(90)))
    XCTAssertFalse(set.contains(40))
    XCTAssertTrue(set.contains(55))
    
    let range8: PartialRangeGreaterThan<Int> = 85<..
    set.insert(range8)
    XCTAssertEqual(set.ranges.count, 3)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(PartialRangeUpTo<Int>(40)))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(LeftOpenRange<Int>(40<..80)))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(PartialRangeGreaterThan<Int>(85)))
    XCTAssertFalse(set.contains(85))
    XCTAssertTrue(set.contains(100))
    XCTAssertTrue(set.contains(Int.max))
    
  }
  
  func testSubtraction() {
    var set: Multirange<Int> = [
      Multirange<Int>.Range(..<20),
      Multirange<Int>.Range(30<.<40),
      Multirange<Int>.Range(50<..60),
      Multirange<Int>.Range(70..<80),
      Multirange<Int>.Range(80...),
    ]
    set.subtract(35...55)
    XCTAssertEqual(set.ranges.count, 4)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(..<20))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(30<.<35))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(55<..60))
    XCTAssertEqual(set.ranges[3], Multirange<Int>.Range(70...))
    
    set.subtract(90)
    XCTAssertEqual(set.ranges.count, 5)
    XCTAssertEqual(set.ranges[0], Multirange<Int>.Range(..<20))
    XCTAssertEqual(set.ranges[1], Multirange<Int>.Range(30<.<35))
    XCTAssertEqual(set.ranges[2], Multirange<Int>.Range(55<..60))
    XCTAssertEqual(set.ranges[3], Multirange<Int>.Range(70..<90))
    XCTAssertEqual(set.ranges[4], Multirange<Int>.Range(90<..))
    
    let set2: Multirange<Int> = [
      Multirange<Int>.Range(...10),
      Multirange<Int>.Range(80<..)
    ]
    
    let set3 = set.subtracting(set2)
    
    XCTAssertEqual(set, set)
    XCTAssertNotEqual(set, set3)
    XCTAssertEqual(set3.ranges.count, 4)
    XCTAssertEqual(set3.ranges[0], Multirange<Int>.Range(10<.<20))
    XCTAssertEqual(set3.ranges[1], Multirange<Int>.Range(30<.<35))
    XCTAssertEqual(set3.ranges[2], Multirange<Int>.Range(55<..60))
    XCTAssertEqual(set3.ranges[3], Multirange<Int>.Range(70...80))
    
    XCTAssertEqual(set3.union(set2).subtracting(90), set)
  }
  
  static var allTests: [(String, (MultirangeTests) -> () -> Void)] = [
    ("testNormalization", testNormalization),
    ("testSubtraction", testSubtraction),
  ]
}


