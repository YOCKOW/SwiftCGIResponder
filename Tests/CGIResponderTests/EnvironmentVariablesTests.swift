/* *************************************************************************************************
 EnvironmentVariablesTests.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

class EnvironmentVariablesTests: XCTestCase {
  func test_accessor() {
    let env = EnvironmentVariables.default
    env["CGI_RESPONDER_TESTS"] = "YES"
    XCTAssertEqual(env["CGI_RESPONDER_TESTS"], "YES")
    
    env["CGI_RESPONDER_TESTS"] = nil
    XCTAssertEqual(env["CGI_RESPONDER_TESTS"], nil)
  }
}



