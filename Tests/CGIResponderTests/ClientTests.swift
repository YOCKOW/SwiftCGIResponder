/* *************************************************************************************************
 ClientTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import CGIResponder

final class ClientTests: XCTestCase {
  func test_cookies() {
    let cookies = "name1=value1; name2=value2; name1=another_value1"
    executeUnderTemporaryEnvironment(["HTTP_COOKIE":cookies]) {
      let items = Client.client.request.cookies()
      XCTAssertNotNil(items)
      XCTAssertEqual(items?[0].name, "name1")
      XCTAssertEqual(items?[0].value, "value1")
      XCTAssertEqual(items?[1].name, "name2")
      XCTAssertEqual(items?[1].value, "value2")
      XCTAssertEqual(items?[2].name, "name1")
      XCTAssertEqual(items?[2].value, "another_value1")
    }
  }
}


