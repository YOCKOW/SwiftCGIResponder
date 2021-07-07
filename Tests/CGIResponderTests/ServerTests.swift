/* *************************************************************************************************
 ServerTests.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

final class ServerTests: XCTestCase {
  func test_hostname() {
    let server = Environment.virtual(variables: .virtual(["SERVER_NAME": "FOO.EXAMPLE.COM"])).server
    XCTAssertEqual(server.hostname, Domain("foo.example.com"))
  }
}
