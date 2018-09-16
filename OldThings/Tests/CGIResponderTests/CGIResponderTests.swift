/***************************************************************************************************
 CGIResponderTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder
import Foundation

class CGIResponderTests: XCTestCase {
  func testContentType() {
    var responder = CGIResponder()
    XCTAssertEqual(responder.contentType, MIMEType(type:.application, subtype:"octet-stream"))
    XCTAssertEqual(responder.stringEncoding, nil)
    
    responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
    XCTAssertEqual(responder.contentType.type, .text)
    XCTAssertEqual(responder.contentType.subtype, "plain")
    XCTAssertEqual(responder.stringEncoding, .utf8)
  }
  
  func testOutput() {
    var output = Data()
    var responder = CGIResponder()
    responder.status = .ok
    responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
    responder.content = .string("Hello, World!\n", encoding:.utf8)
    
    let expected = "Status: \(HTTPStatusCode.ok.rawValue) \(HTTPStatusCode.ok.reasonPhrase)\r\n" +
      "\(HTTPHeaderFieldName.contentType.rawValue): \(MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!.description)\r\n" +
      "\r\n" +
      "Hello, World!\n"
    
    XCTAssertNoThrow(try responder.respond(to:&output))
    XCTAssertEqual(String(data:output, encoding:.utf8), expected)
  }
  
  func testStringEncoding() {
    var output = FileHandle.nullDevice
    var responder = CGIResponder()
    responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"US-ASCII"])!
    responder.content = .string("?", encoding:.utf8)
    
    let expected: ErrorMessage = .stringEncodingInconsistency(.utf8, String.Encoding(ianaCharacterSetName:"US-ASCII")!)
    XCTAssertTrue(try checkWarning(expected){ try responder.respond(to:&output) })
  }
  
  func testExpectedStatus() {
    var output = FileHandle.nullDevice
    
    let eTag1 = HTTPETag.strong("ETag1")
    let eTag2 = HTTPETag.strong("ETag2")
    let theDayBeforeYesterday = Date(timeIntervalSinceNow:TimeInterval(-48 * 60 * 60))
    let yesterday = Date(timeIntervalSinceNow:TimeInterval(-24 * 60 * 60))
    let now = Date()
    
    let env = EnvironmentVariables.default
    
    var responder1 = CGIResponder()
    var responder2 = CGIResponder()
    
    // ETag
    
    //// If-Match
    env[EnvironmentVariables.Name.httpIfMatch.rawValue] = eTag1.description
    responder1.setHTTPHeaderField(HTTPHeaderField(eTag:eTag2))
    XCTAssertEqual(responder1.expectedStatus, .preconditionFailed)
    XCTAssertTrue(try checkWarning(.statusCodeInconsistency(.ok, .preconditionFailed)) {
      try responder1.respond(to:&output)
    })
    
    responder1.setHTTPHeaderField(HTTPHeaderField(eTag:eTag1))
    XCTAssertEqual(responder1.expectedStatus, nil)
    
    env.removeValue(forName:EnvironmentVariables.Name.httpIfMatch.rawValue)
    
    //// If-None-Match
    env[EnvironmentVariables.Name.httpIfNoneMatch.rawValue] = eTag1.description
    XCTAssertEqual(responder1.expectedStatus, .notModified)
    XCTAssertTrue(try checkWarning(.statusCodeInconsistency(.ok, .notModified)) {
      try responder1.respond(to:&output)
    })
    
    env[EnvironmentVariables.Name.httpIfNoneMatch.rawValue] = eTag2.description
    XCTAssertEqual(responder1.expectedStatus, nil)
    
    env.removeValue(forName:EnvironmentVariables.Name.httpIfNoneMatch.rawValue)
    
    // Last-Modified
    
    //// If-Unmofidied-Since
    env[EnvironmentVariables.Name.httpIfUnmodifiedSince.rawValue] = DateFormatter.rfc1123.string(from:yesterday)
    responder2.setHTTPHeaderField(HTTPHeaderField(lastModified:now))
    XCTAssertEqual(responder2.expectedStatus, .preconditionFailed)
    XCTAssertTrue(try checkWarning(.statusCodeInconsistency(.ok, .preconditionFailed)) {
      try responder2.respond(to:&output)
    })
    
    responder2.setHTTPHeaderField(HTTPHeaderField(lastModified:theDayBeforeYesterday))
    XCTAssertEqual(responder2.expectedStatus, nil)
    
    env.removeValue(forName:EnvironmentVariables.Name.httpIfUnmodifiedSince.rawValue)
    
    //// If-Modified-Since
    env[EnvironmentVariables.Name.httpIfModifiedSince.rawValue] = DateFormatter.rfc1123.string(from:yesterday)
    responder2.setHTTPHeaderField(HTTPHeaderField(lastModified:now))
    XCTAssertEqual(responder2.expectedStatus, nil)
    
    responder2.setHTTPHeaderField(HTTPHeaderField(lastModified:theDayBeforeYesterday))
    XCTAssertEqual(responder2.expectedStatus, .notModified)
    XCTAssertTrue(try checkWarning(.statusCodeInconsistency(.ok, .notModified)) {
      try responder2.respond(to:&output)
    })
  }
  
  static var allTests: [(String, (CGIResponderTests) -> () -> Void)] = [
    ("testContentType", testContentType),
    ("testOutput", testOutput),
    ("testStringEncoding", testStringEncoding),
    ("testExpectedStatus", testExpectedStatus),
  ]
}
