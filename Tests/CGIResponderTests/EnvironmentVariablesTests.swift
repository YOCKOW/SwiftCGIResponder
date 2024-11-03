/* *************************************************************************************************
 EnvironmentVariablesTests.swift
   © 2017-2018,2020,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class EnvironmentVariablesTests {
  @Test func test_accessor() {
    let env = EnvironmentVariables.default
    env["CGI_RESPONDER_TESTS"] = "YES"
    #expect(env["CGI_RESPONDER_TESTS"] == "YES")

    env["CGI_RESPONDER_TESTS"] = nil
    #expect(env["CGI_RESPONDER_TESTS"] == nil)
  }
}
#else
import XCTest

final class EnvironmentVariablesTests: XCTestCase {
  func test_accessor() {
    let env = EnvironmentVariables.default
    env["CGI_RESPONDER_TESTS"] = "YES"
    XCTAssertEqual(env["CGI_RESPONDER_TESTS"], "YES")
    
    env["CGI_RESPONDER_TESTS"] = nil
    XCTAssertEqual(env["CGI_RESPONDER_TESTS"], nil)
  }
}
#endif
