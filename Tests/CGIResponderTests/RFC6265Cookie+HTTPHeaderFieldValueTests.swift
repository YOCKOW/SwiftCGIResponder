/***************************************************************************************************
 RFC6265Cookie+HTTPHeaderFieldValueTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Foundation
import XCTest
@testable import CGIResponder

class RFC6265Cookie_HTTPHeaderFieldValueTests: XCTestCase {
  func testRequestHeaderFieldValue() {
    let propertiesList: Array<[HTTPCookiePropertyKey:Any]> = [
      [.domain:"example.com", .path:"/"],
      [.domain:"example.com", .path:"/", .secure:true],
      [.domain:"example.com", .path:"/a/b", .secure:true],
      [.domain:"example.com", .path:"/", .secure:true, .hostOnly:true],
      [.domain:"example.com", .path:"/", .expires:Date(timeIntervalSinceNow:-100.0)]
    ]
    
    let urlStrings:[String] = [
      "http://example.com/",
      "https://example.com/",
      "http://www.example.com/a/b/c",
      "https://www.example.com/a/b/c"
    ]
    
    let tests: [(Int, Int, Bool)] = [
      // (index of `propertiesList`, index of `urlStrings`, whether field value can be gotten)
      // not all cases
      (0,0,true), (0,1,true), (0,2,true), (0,3,true),
      (1,0,false), (1,1,true), (1,2,false), (1,3,true),
      (2,1,false), (2,3,true),
      (3,1,true), (3,3,false),
      (4,1,false), (4,3,false),
    ]
    
    for ii in 0..<tests.count {
      let test = tests[ii]
      
      var properties = propertiesList[test.0]
      let url = URL(string:urlStrings[test.1])!
      
      properties[.name] = "name"
      properties[.value] = "value"
      
      let cookie = CGICookie(properties:properties)!
      let fieldValue = cookie.requestHeaderFieldValue(for:url)
      
      if !test.2 {
        XCTAssertNil(fieldValue)
      } else {
        let number = "#\(ii): "
        let gotten = fieldValue!.rawValue
        let expected = "name=value"
        XCTAssertEqual(number + gotten, number + expected)
      }
    }
  }
  
  func testResponseHeaderFieldValue() {
    let cookie = CGICookie(properties:[
      .name:"name", .value:"value",
      .domain:"example.com", .path:"/a/b/c",
      .secure:true
    ])!
    let fieldValue = cookie.responseHeaderFieldValue()
    
    XCTAssertNotNil(fieldValue)
    XCTAssertEqual(fieldValue!.rawValue, "name=value; Domain=example.com; Path=/a/b/c; Secure")
    
    let _attr = CGICookie._itemAndAttributes(fromResponseHeaderFieldValue:fieldValue!,
                                             removingPercentEncoding:true)
    XCTAssertNotNil(_attr)
    XCTAssertEqual(_attr!.0.name, "name")
    XCTAssertEqual(_attr!.0.value, "value")
    XCTAssertEqual(_attr!.1["domain"], "example.com")
    XCTAssertEqual(_attr!.1["path"], "/a/b/c")
    XCTAssertNotNil(_attr!.1["secure"])
    XCTAssertNil(_attr!.1["httponly"])
    
    let cookieFromResponseFieldValue = CGICookie(withResponseHeaderFieldValue:fieldValue!,
                                                 for:URL(string:"https://www.example.com/a/b/c/d")!)
    XCTAssertNotNil(cookieFromResponseFieldValue)
    XCTAssertEqual(cookieFromResponseFieldValue!.name, "name")
    XCTAssertEqual(cookieFromResponseFieldValue!.value, "value")
    XCTAssertEqual(cookieFromResponseFieldValue!.domain, "example.com")
    XCTAssertEqual(cookieFromResponseFieldValue!.path, "/a/b/c")
    XCTAssertTrue(cookieFromResponseFieldValue!.isSecure)
    XCTAssertFalse(cookieFromResponseFieldValue!.isHTTPOnly)
  }
  
  static var allTests:[(String, (RFC6265Cookie_HTTPHeaderFieldValueTests) -> () -> Void)] = [
    ("testRequestHeaderFieldValue", testRequestHeaderFieldValue),
    ("testResponseHeaderFieldValue", testResponseHeaderFieldValue),
  ]
}
