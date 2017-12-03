/***************************************************************************************************
 SetCookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class HTTPHeaderFieldDelegateSetCookieTests: XCTestCase {
  func testCreation() {
    let cookie = CGICookie(properties:[
      .name:"name", .value:"value",
      .domain:"example.com", .path:"/"
    ])!
    let cookieField = HTTPHeaderField(setCookie:cookie)
    XCTAssertEqual(
      "\(HTTPHeaderFieldName.setCookie.rawValue): \(cookie.responseHeaderFieldValue()!.rawValue)\r\n",
      cookieField.description
    )
  }
  
  func testDelegateSelection() {
    let string = "Set-Cookie: name=value; Domain=example.com; Path=/; Expires=Thu, 04 Oct 2014 23:59:45 GMT"
    let field = HTTPHeaderField(string:string)
    XCTAssertNotNil(field)
    XCTAssertTrue(field!.delegate is HTTPHeaderFieldDelegate.SetCookie<CGICookie>)
  }
  
  static var allTests: [(String, (HTTPHeaderFieldDelegateSetCookieTests) -> () -> Void)] = [
    ("testCreation", testCreation),
    ("testDelegateSelection", testDelegateSelection)
  ]
}


