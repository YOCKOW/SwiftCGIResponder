/* *************************************************************************************************
 ServerTests.swift
   © 2020,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
@testable import CGIResponder
import Testing

@Suite final class ServerTests {
  @Test func test_hostname() {
    let server = Environment.virtual(variables: .virtual(["SERVER_NAME": "FOO.EXAMPLE.COM"])).server
    #expect(server.hostname == Domain("foo.example.com"))
  }
}
