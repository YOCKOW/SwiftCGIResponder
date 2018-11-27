/* *************************************************************************************************
 CookieTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class CookieTests: XCTestCase {
  func test_date() {
    let rfc1123_string = "Mon, 03 Oct 1983 16:21:09 GMT"
    let traditional_string = "Mon, 03-Oct-1983 16:21:09 GMT"
    let incorrect_string = "Mon, 03/Oct/'83 16:21:09 GMT"
    
    let fromRFC1123 = Date(cookieDateString:rfc1123_string)
    let fromTraditional = Date(cookieDateString:traditional_string)
    let fromIncorrect = Date(cookieDateString:incorrect_string)
    
    XCTAssertNotNil(fromRFC1123)
    XCTAssertEqual(fromRFC1123, fromTraditional)
    XCTAssertEqual(fromRFC1123, fromIncorrect)
  }
}





