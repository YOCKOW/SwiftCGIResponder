/* *************************************************************************************************
 ServerTests.swift
   © 2020,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
@testable import CGIResponder

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class ServerTests {
  @Test func test_hostname() {
    let server = Environment.virtual(variables: .virtual(["SERVER_NAME": "FOO.EXAMPLE.COM"])).server
    #expect(server.hostname == Domain("foo.example.com"))
  }
}
#else
import XCTest

final class ServerTests: XCTestCase {
  func test_hostname() {
    let server = Environment.virtual(variables: .virtual(["SERVER_NAME": "FOO.EXAMPLE.COM"])).server
    XCTAssertEqual(server.hostname, Domain("foo.example.com"))
  }
}
#endif
