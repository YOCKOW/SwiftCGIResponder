/* *************************************************************************************************
 ServerTests.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

import NetworkGear

final class ServerTests: XCTestCase {
  func test_hostname() {
    let server = Server.virtual(environmentVariables: .virtual(["SERVER_NAME": "FOO.EXAMPLE.COM"]))
    XCTAssertEqual(server.hostname, Domain("foo.example.com"))
  }
}
