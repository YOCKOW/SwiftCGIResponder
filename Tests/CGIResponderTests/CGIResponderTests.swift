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
    
    let path = NSTemporaryDirectory() + UUID().uuidString
    XCTAssertTrue(FileManager.default.createFile(atPath:path, contents:nil, attributes:nil))
    
    let tmpFile = FileHandle(forUpdatingAtPath:path)!
    FileHandle.changeableStandardError = tmpFile
    XCTAssertNoThrow(try responder.respond(to:&output))
    FileHandle.changeableStandardError = FileHandle.standardError
    
    tmpFile.seek(toFileOffset:0)
    let data = tmpFile.availableData
    tmpFile.closeFile()
    
    let message = String(data:data, encoding:.utf8)!.trimmingCharacters(in:.whitespacesAndNewlines)
    
    XCTAssertEqual(ErrorMessage.stringEncodingInconsistency(.utf8, String.Encoding(ianaCharacterSetName:"US-ASCII")!).rawValue,
                   message)
    
  }
  
  static var allTests: [(String, (CGIResponderTests) -> () -> Void)] = [
    ("testContentType", testContentType),
    ("testOutput", testOutput),
    ("testStringEncoding", testStringEncoding),
  ]
}
