/* *************************************************************************************************
 CGIResponderTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import CGIResponder

import Foundation
import HTTP

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
  
  func test_expectedStatus_ETag() {
    let eTag: HTTPETag = .strong("ETAG")
    var responder = CGIResponder()
    
    let HTTP_IF_MATCH = "HTTP_IF_MATCH"
    let HTTP_IF_NONE_MATCH = "HTTP_IF_NONE_MATCH"
    
    responder.header.insert(HTTPHeaderField.eTag(eTag))
    XCTAssertNil(responder.expectedStatus)
    
    executeUnderTemporaryEnvironment([HTTP_IF_MATCH:"\"ETAG\""]) {
      XCTAssertNil(responder.expectedStatus)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_MATCH:"\"OTHER\""]) {
      XCTAssertEqual(responder.expectedStatus, .preconditionFailed)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_NONE_MATCH:"W/\"ETAG\""]) {
      XCTAssertEqual(responder.expectedStatus, .notModified)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_NONE_MATCH:"W/\"OTHER\""]) {
      XCTAssertNil(responder.expectedStatus)
    }
  }
  
  func test_expectedStatus_Date() {
    let date_base = DateFormatter.rfc1123.date(from:"Mon, 03 Oct 1983 16:21:09 GMT")!
    let date_old = date_base - 1000
    let date_new = date_base + 1000
    
    let HTTP_IF_UNMODIFIED_SINCE = "HTTP_IF_UNMODIFIED_SINCE"
    let HTTP_IF_MODIFIED_SINCE = "HTTP_IF_MODIFIED_SINCE"
    
    func date_string(_ date:Date) -> String {
      return DateFormatter.rfc1123.string(from:date)
    }
    
    var responder = CGIResponder()
    responder.header.insert(HTTPHeaderField.lastModified(date_base))
    XCTAssertNil(responder.expectedStatus)
    
    executeUnderTemporaryEnvironment([HTTP_IF_UNMODIFIED_SINCE:date_string(date_old)]) {
      XCTAssertEqual(responder.expectedStatus, .preconditionFailed)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_UNMODIFIED_SINCE:date_string(date_base)]) {
      XCTAssertEqual(responder.expectedStatus, nil)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_UNMODIFIED_SINCE:date_string(date_new)]
    ) {
      XCTAssertEqual(responder.expectedStatus, nil)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_MODIFIED_SINCE:date_string(date_old)]) {
      XCTAssertEqual(responder.expectedStatus, nil)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_MODIFIED_SINCE:date_string(date_base)]) {
      XCTAssertEqual(responder.expectedStatus, .notModified)
    }
    
    executeUnderTemporaryEnvironment([HTTP_IF_MODIFIED_SINCE:date_string(date_new)]) {
      XCTAssertEqual(responder.expectedStatus, .notModified)
    }
  }
  
  static var allTests = [
    ("test_contentType", test_contentType),
    ("test_expectedStatus_ETag", test_expectedStatus_ETag),
    ("test_expectedStatus_Date", test_expectedStatus_Date),
  ]
}

