/***************************************************************************************************
 Array+URLQueryItemTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class Array_URLQueryItemTests: XCTestCase {
  func testInitialization() {
    let string = "name0=value0&name1=value1&name2=value2"
    let array = Array<URLQueryItem>(string:string)
    XCTAssertNotNil(array)
    XCTAssertEqual(array!.count, 3)
    XCTAssertEqual(array![0], URLQueryItem(name:"name0", value:"value0"))
    XCTAssertEqual(array![1], URLQueryItem(name:"name1", value:"value1"))
    XCTAssertEqual(array![2], URLQueryItem(name:"name2", value:"value2"))
    
    let encodedString = "%E3%81%AA%E3%81%BE%E3%81%880=%E3%81%82%E3%81%9F%E3%81%840;%E3%81%AA%E3%81%BE%E3%81%881=%E3%81%82%E3%81%9F%E3%81%841"
    let decodedItems = Array<URLQueryItem>(string:encodedString)
    XCTAssertNotNil(decodedItems)
    XCTAssertEqual(decodedItems!.count, 2)
    XCTAssertEqual(decodedItems![0], URLQueryItem(name:"なまえ0", value:"あたい0"))
    XCTAssertEqual(decodedItems![1], URLQueryItem(name:"なまえ1", value:"あたい1"))
  }
  
  static var allTests: [(String, (Array_URLQueryItemTests) -> () -> Void)] = [
    ("testInitialization", testInitialization),
  ]
}



