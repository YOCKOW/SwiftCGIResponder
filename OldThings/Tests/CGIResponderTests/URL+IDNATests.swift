/***************************************************************************************************
 URL+IDNATests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class URL_IDNATests: XCTestCase {
  func testConversion() {
    XCTAssertNil(URL.convert(domain:""))
  }
  
  func testInitialization() {
    let string = "http://user:password@ドメインの例。ＪＰ/パス?クエリ=文字列#ハッシュ！"
    
    let url = URL(internationalString:string)
    XCTAssertNotNil(url)
    XCTAssertEqual(url!.user, "user")
    XCTAssertEqual(url!.password, "password")
    XCTAssertEqual(url!.host, "xn--u9jwfoe1dzdq15t.jp")
    XCTAssertEqual(url!.path, "/パス")
    XCTAssertEqual(url!.query, "%E3%82%AF%E3%82%A8%E3%83%AA=%E6%96%87%E5%AD%97%E5%88%97")
    XCTAssertEqual(url!.fragment, "%E3%83%8F%E3%83%83%E3%82%B7%E3%83%A5%EF%BC%81")
  }
  
  static var allTests:[(String, (URL_IDNATests) -> () -> Void)] = [
    ("testConversion", testConversion),
    ("testInitialization", testInitialization),
  ]
}


