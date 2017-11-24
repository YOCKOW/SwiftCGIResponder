/***************************************************************************************************
 EnvironmentVariablesTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class EnvironmentVariablesTests: XCTestCase {
  func testSetAndGet() {
    var env = EnvironmentVariables.default
    env["CGI_RESPONDER_TESTS"] = "YES"
    XCTAssertEqual(env["CGI_RESPONDER_TESTS"], "YES")
  }
  
  static var allTests:[(String, (EnvironmentVariablesTests) -> () -> Void)] = [
    ("testInitialization", testSetAndGet),
  ]
}


