/* *************************************************************************************************
 CGIResponderTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import CGIResponder

final class CGIResponderTests: XCTestCase {
  func test_contentType() {
    var responder = CGIResponder()
    XCTAssertEqual(responder.contentType, ContentType(type:.application, subtype:"octet-stream"))
    
    let text_utf8_contentType = ContentType(type:.text, subtype:"plain", parameters:["charset":"UTF-8"])!
    responder.contentType = text_utf8_contentType
    XCTAssertEqual(responder.contentType.type, .text)
    XCTAssertEqual(responder.contentType.subtype, "plain")
    XCTAssertEqual(responder.stringEncoding, .utf8)
  }

  static var allTests = [
    ("test_contentType", test_contentType),
  ]
}

