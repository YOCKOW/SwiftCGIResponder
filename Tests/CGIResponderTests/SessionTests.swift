/* *************************************************************************************************
 SessionTests.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

import TimeSpecification
import yExtensions

final class SessionTests: XCTestCase {
  static var storage: FileSystemSessionStorage<Dictionary<String, String>>!
  
  override class func setUp() {
    let path = URL.temporaryDirectory.appendingPathComponent(UUID().base32EncodedString(), isDirectory: true)
    try! FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
    storage = try! .init(directoryAt: path)
  }
  
  override class func tearDown() {
    try? FileManager.default.removeItem(at: storage.directory)
  }
  
  func test_fileSystemSessionStorage_URL() throws {
    let id = try XCTUnwrap(UUID(uuidString: "00000000-0000-0000-0000-000000000000"))
    let expiration = TimeSpecification(seconds: 1234567890, nanoseconds: 987654321)
    
    let symLinkURL = Self.storage._symbolicLinkURL(for: id)
    XCTAssertEqual(symLinkURL.standardizedFileURL,
                   Self.storage.directory.appendingPathComponent("id/AAAAAA/AAAAAA/AAAAAAA/AAAAAAA"))
    
    let sessionURL = Self.storage._sessionFileURL(sessionID: id, expirationTime: expiration)
    XCTAssertEqual(sessionURL.standardizedFileURL,
                   Self.storage.directory.appendingPathComponent("expires/00000029/IO/1D/4_7BF6HC8_AAAAAAAAAAAAAAAAAAAAAAAAAA"))
    
    XCTAssertEqual(
      URL(fileURLWithPath: Self.storage._relativePathToSessionFileFromSymbolicLink(sessionID: id,
                                                                                   expirationTime: expiration),
          isDirectory: false,
          relativeTo: symLinkURL
      ).standardizedFileURL,
      sessionURL.standardizedFileURL
    )
    
    XCTAssertEqual(Self.storage._sessionID(fromSessionFileURL: sessionURL), id)
  }
  
  func test_fileSystemSessionStorage_store_remove() throws {
    var session = try Self.storage.createSession(duration: 9999999.999,
                                                 userInfo: ["key": "value"])
    XCTAssertEqual(session, try Self.storage.session(for: session.id))
    
    session.userInfo = ["another key": "another value"]
    try Self.storage.storeSession(session)
    XCTAssertEqual(session, try Self.storage.session(for: session.id))
    
    try Self.storage.removeSession(for: session.id)
    XCTAssertNil(try Self.storage.session(for: session.id))
    
    XCTAssertTrue(
      try FileManager.default.contentsOfDirectory(at: Self.storage.directory.appendingPathComponent("id"),
                                                  includingPropertiesForKeys: nil,
                                                  options: .skipsHiddenFiles).isEmpty
    )
    
    XCTAssertTrue(
      try FileManager.default.contentsOfDirectory(at: Self.storage.directory.appendingPathComponent("expires"),
                                                  includingPropertiesForKeys: nil,
                                                  options: .skipsHiddenFiles).isEmpty
    )
  }
}

