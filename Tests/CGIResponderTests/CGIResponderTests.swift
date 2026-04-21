/* *************************************************************************************************
 CGIResponderTests.swift
   © 2017-2021,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder
import Foundation
import TemporaryFile
import Testing

let CRLF = "\u{0D}\u{0A}"

private extension CGIResponder {
  mutating func _resetEnvironment(_ newEnvironment: Environment = .virtual(variables: .virtual([:]))) {
    self._environment = newEnvironment
  }
}


@Suite final class CGIResponderTests {
  func test_contentType() {
    var responder = CGIResponder()
    #expect(responder.contentType == ContentType(type:.application, subtype:"octet-stream"))

    let text_utf8_contentType = ContentType(type:.text, subtype:"plain", parameters:["charset":"UTF-8"])!
    responder.contentType = text_utf8_contentType
    #expect(responder.contentType.type == .text)
    #expect(responder.contentType.subtype == "plain")
    #expect(responder.stringEncoding == .utf8)
  }

  @Test func test_expectedStatus_ETag() {
    let eTag: HTTPETag = .strong("ETAG")
    var responder = CGIResponder()

    let HTTP_IF_MATCH = "HTTP_IF_MATCH"
    let HTTP_IF_NONE_MATCH = "HTTP_IF_NONE_MATCH"

    responder.header.insert(HTTPHeaderField.eTag(eTag))
    #expect(responder.expectedStatus == nil)

    responder._resetEnvironment()
    responder._environment.variables[HTTP_IF_MATCH] = #""ETAG""#
    #expect(responder.expectedStatus == nil)
    responder._environment.variables[HTTP_IF_MATCH] = #""OTHER""#
    #expect(responder.expectedStatus == .preconditionFailed)

    responder._resetEnvironment()
    responder._environment.variables[HTTP_IF_NONE_MATCH] = #"W/"ETAG""#
    #expect(responder.expectedStatus == .notModified)
    responder._environment.variables[HTTP_IF_NONE_MATCH] = #"W/"OTHER""#
    #expect(responder.expectedStatus == nil)
  }

  @Test func test_expectedStatus_Date() {
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
    #expect(responder.expectedStatus == nil)

    responder._resetEnvironment()
    responder._environment.variables[HTTP_IF_UNMODIFIED_SINCE] = date_string(date_old)
    #expect(responder.expectedStatus == .preconditionFailed)
    responder._environment.variables[HTTP_IF_UNMODIFIED_SINCE] = date_string(date_base)
    #expect(responder.expectedStatus == nil)
    responder._environment.variables[HTTP_IF_UNMODIFIED_SINCE] = date_string(date_new)
    #expect(responder.expectedStatus == nil)

    responder._resetEnvironment()
    responder._environment.variables[HTTP_IF_MODIFIED_SINCE] = date_string(date_old)
    #expect(responder.expectedStatus == nil)
    responder._environment.variables[HTTP_IF_MODIFIED_SINCE] = date_string(date_base)
    #expect(responder.expectedStatus == .notModified)
    responder._environment.variables[HTTP_IF_MODIFIED_SINCE] = date_string(date_new)
    #expect(responder.expectedStatus == .notModified)
  }

  @Test func test_response() throws {
    var responder = CGIResponder()

    func check(
      _ expectedOutput: String?,
      expectedError: CGIResponderError? = nil,
      sourceLocation: SourceLocation = #_sourceLocation
    ) throws {
      try TemporaryFile {
        var output = $0
        let respond: () throws -> Void = { try responder.respond(to: &output, ignoringError: { _ in false }) }
        if let expectedError = expectedError {
          #expect(throws: expectedError, sourceLocation: sourceLocation) {
            try respond()
          }
        } else {
          #expect(throws: Never.self, sourceLocation: sourceLocation) {
            try respond()
          }
          try output.seek(toOffset:0)
          let data = output.availableData
          #expect(expectedOutput == String(data:data, encoding:.utf8), sourceLocation: sourceLocation)
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

  @Test func test_fallback() throws {
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

    #expect(
      outputString ==
      """
      Status: 404 Not Found\(CRLF)\
      Content-Type: text/plain; charset=utf-8\(CRLF)\
      \(CRLF)\
      Not Found.
      """
    )
  }
}
