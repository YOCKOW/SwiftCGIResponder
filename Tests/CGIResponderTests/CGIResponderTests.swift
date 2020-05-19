/* *************************************************************************************************
 CGIResponderTests.swift
   © 2017-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import CGIResponder

import Foundation
import NetworkGear
import TemporaryFile

let CRLF = "\u{0D}\u{0A}"

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
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_MATCH: #""ETAG""#]))
    XCTAssertNil(responder.expectedStatus)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_MATCH: #""OTHER""#]))
    XCTAssertEqual(responder.expectedStatus, .preconditionFailed)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_NONE_MATCH: #"W/"ETAG""#]))
    XCTAssertEqual(responder.expectedStatus, .notModified)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_NONE_MATCH: #"W/"OTHER""#]))
    XCTAssertNil(responder.expectedStatus)
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
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_UNMODIFIED_SINCE: date_string(date_old)]))
    XCTAssertEqual(responder.expectedStatus, .preconditionFailed)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_UNMODIFIED_SINCE:date_string(date_base)]))
    XCTAssertEqual(responder.expectedStatus, nil)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_UNMODIFIED_SINCE:date_string(date_new)]))
    XCTAssertEqual(responder.expectedStatus, nil)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_MODIFIED_SINCE:date_string(date_old)]))
    XCTAssertEqual(responder.expectedStatus, nil)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_MODIFIED_SINCE:date_string(date_base)]))
    XCTAssertEqual(responder.expectedStatus, .notModified)
    
    responder._client = .virtual(environmentVariables: .virtual([HTTP_IF_MODIFIED_SINCE:date_string(date_new)]))
    XCTAssertEqual(responder.expectedStatus, .notModified)
  }
  
  func test_response() throws {
    var responder = CGIResponder()
    
    func check(_ expectedOutput: String?,
               expectedError: CGIResponderError? = nil,
               file: StaticString = #file, line: UInt = #line) throws {
      try TemporaryFile {
        var output = $0
        let respond: () throws -> Void = { try responder.respond(to: &output, ignoringError: { _ in false }) }
        if let expectedError = expectedError {
          do {
            try respond()
            XCTFail("No throw.", file: file, line: line)
          } catch {
            let error = try XCTUnwrap(error as? CGIResponderError)
            XCTAssertEqual(error, expectedError, "Unexpected Error.", file: file, line: line)
            XCTAssertNil(expectedOutput)
          }
        } else {
          XCTAssertNoThrow(try respond(), file: file, line: line)
          try output.seek(toOffset:0)
          let data = output.availableData
          XCTAssertEqual(expectedOutput, String(data:data, encoding:.utf8), file:file, line:line)
        }
      }
    }
    
    responder.status = .ok
    responder.contentType = ContentType(type:.text, subtype:"plain")!
    responder.stringEncoding = .utf8
    responder.content = .init(string:"CGI")
    
    try check(
      "Status: 200 OK\(CRLF)" +
      "Content-Type: text/plain; charset=utf-8\(CRLF)" +
      "\(CRLF)" +
      "CGI"
    )
    
    responder.stringEncoding = .ascii
    try check(
      nil,
      expectedError: .stringEncodingInconsistency(actualEncoding: .utf8, specifiedEncoding: .ascii)
    )
  }
  
  func test_fallback() throws {
    struct _Fallback: CGIFallback {
      var status: HTTPStatusCode
      var fallbackContent: CGIContent
      init(_ error: CGIError) {
        self.status = error.status
        self.fallbackContent = .string(error.localizedDescription, encoding: .utf8)
      }
    }
    
    struct _Error: CGIError {
      var status: HTTPStatusCode = .notFound
      var localizedDescription: String = "Not Found."
    }
    
    let responder = CGIResponder(content: .lazy({ throw _Error() }))
    var output = InMemoryFile()
    responder.respond(to: &output, fallback: { _Fallback($0) })
    
    try output.seek(toOffset: 0)
    let outputString = try output.readToEnd().flatMap({ String(data: $0, encoding: .utf8) })
    
    XCTAssertEqual(
      outputString,
      "Status: 404 Not Found\(CRLF)" +
      "Content-Type: text/plain; charset=utf-8\(CRLF)" +
      "\(CRLF)" +
      "Not Found."
    )
  }
}

