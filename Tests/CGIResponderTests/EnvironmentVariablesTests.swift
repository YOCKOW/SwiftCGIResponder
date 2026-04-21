/* *************************************************************************************************
 EnvironmentVariablesTests.swift
   © 2017-2018,2020,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder
import Testing

@Suite final class EnvironmentVariablesTests {
  @Test func test_accessor() {
    let env = EnvironmentVariables.default
    env["CGI_RESPONDER_TESTS"] = "YES"
    #expect(env["CGI_RESPONDER_TESTS"] == "YES")

    env["CGI_RESPONDER_TESTS"] = nil
    #expect(env["CGI_RESPONDER_TESTS"].isNil)
  }
}
