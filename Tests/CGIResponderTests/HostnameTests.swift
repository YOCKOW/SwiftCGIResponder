/***************************************************************************************************
 HostnameTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder

class HostnameTests: XCTestCase {
  func testPublicSuffix() {
    // TODO: append more test cases...
    let list: [(String, String?)] = [
      ("aichi.jp", "aichi.jp"),
      ("愛知.jp", "愛知.jp"),
      ("hoge.yokohama.jp", "hoge.yokohama.jp"),
      ("city.yokohama.jp", "jp")
    ]
    
    for pair in list {
      let hostname = Hostname(pair.0)!
      if let publicSuffix = hostname.publicSuffix {
        XCTAssertNotNil(pair.1)
        XCTAssertEqual(publicSuffix, Hostname(pair.1!)!)
      } else {
        XCTAssertNil(pair.1)
      }
    }
  }
  
  static var allTests: [(String, (HostnameTests) -> () -> Void)] = [
    ("testPublicSuffix", testPublicSuffix),
  ]
}


