/* *************************************************************************************************
 _ExportTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import CGIResponder

import NetworkGear

final class ExportTests: XCTestCase {
  func test_HTTPETag() {
    XCTAssertEqual(HTTPETag("*"), .any)
    XCTAssertEqual(HTTPETag("\"A\""), .strong("A"))
    XCTAssertEqual(HTTPETag("W/\"B\""), .weak("B"))
  }
}

