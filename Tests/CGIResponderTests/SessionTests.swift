/* *************************************************************************************************
 SessionTests.swift
   © 2020,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

#if !canImport(Testing)
#warning("SessionTests only run with swift-testing.")
#else
@testable import CGIResponder
import Foundation
import Testing
import TimeSpecification
import yExtensions

actor StringDictionaryFileSystemSessionStorageWrapper {
  private let storage: FileSystemSessionStorage<Dictionary<String, String>>

  private let directoryURL: URL

  init() throws {
    let path = URL.temporaryDirectory.appendingPathComponent(UUID().base32EncodedString(), isDirectory: true)
    try FileManager.default.createDirectory(at: path, withIntermediateDirectories: true)
    self.storage = try .init(directoryAt: path)
    self.directoryURL = storage.directory
  }

  deinit {
    try? FileManager.default.removeItem(at: directoryURL)
  }

  func withStorage<T>(_ body: (FileSystemSessionStorage<Dictionary<String, String>>) throws -> T) throws -> T {
    do {
      let result = try body(storage)
      try storage.removeAllSessions()
      return result
    } catch {
      try storage.removeAllSessions()
      throw error
    }
  }
}

@Suite(.serialized) final class FileSystemSessionStorageTests {
  let storageWrapper: StringDictionaryFileSystemSessionStorageWrapper

  init() throws {
    storageWrapper = try .init()
  }

  @Test func test_URL() async throws {
    let id = try #require(UUID(uuidString: "F2731D96-B94E-48FC-89C0-78E71A405904").map(SessionID.init(uuid:)))
    let expiration = TimeSpecification(seconds: 1234567890, nanoseconds: 987654321)

    try await storageWrapper.withStorage { storage in
      let symLinkURL = storage._symbolicLinkURL(for: id)
      #expect(symLinkURL.standardizedFileURL == storage.idDirectory.appendingPathComponent("6J/ZR/3F/VZJZEPZCOAPDTRUQCZAQ"))

      let sessionURL = storage._sessionFileURL(sessionID: id, expirationTime: expiration)
      #expect(sessionURL.standardizedFileURL == storage.expirationDirectory.appendingPathComponent("P00000029/IO/1D/4_7BF6HC8_6JZR3FVZJZEPZCOAPDTRUQCZAQ"))

      #expect(
        URL(
          fileURLWithPath: storage._relativePathToSessionFileFromSymbolicLink(
            sessionID: id,
            expirationTime: expiration
          ),
          isDirectory: false,
          relativeTo: symLinkURL
        ).standardizedFileURL == sessionURL.standardizedFileURL
      )

      try #expect(storage._sessionID(fromSessionFileURL: sessionURL) == id)
    }
  }
  
  @Test func test_store_remove() async throws {
    try await storageWrapper.withStorage { storage in
      var session = try storage.createSession(
        duration: 9999999.999,
        userInfo: ["key": "value"]
      )
      #expect(try session == storage.session(for: session.id))

      session.userInfo = ["another key": "another value"]
      try storage.storeSession(session)
      #expect(try session == storage.session(for: session.id))

      try storage.removeSession(for: session.id)
      #expect(try storage.session(for: session.id) == nil)

      #expect(
        try FileManager.default.contentsOfDirectory(
          at: storage.idDirectory,
          includingPropertiesForKeys: nil,
          options: .skipsHiddenFiles
        ).isEmpty
      )

      #expect(
        try FileManager.default.contentsOfDirectory(
          at: storage.expirationDirectory,
          includingPropertiesForKeys: nil,
          options: .skipsHiddenFiles
        ).isEmpty
      )
    }
  }
  
  @Test func test_brokenSymlinks() async throws {
    func __isSymlink(_ url: URL) -> Bool {
      guard let attrs = try? FileManager.default.attributesOfItem(atPath: url.path) else { return false }
      if case let type as FileAttributeType = attrs[.type], type == .typeSymbolicLink {
        return true
      }
      return false
    }

    try await storageWrapper.withStorage { storage in
      let session = try storage.createSession(duration: -12345678.9, userInfo: [:])
      let symlinkURL = storage._symbolicLinkURL(for: session.id)
      try storage.removeExpiredSessions(removeSymbolicLinks: false)
      #expect(__isSymlink(symlinkURL))
      try storage.removeBrokenSymbolicLinks()
      #expect(!__isSymlink(symlinkURL))
    }
  }
  
  @Test func test_expiration() async throws {
    try await storageWrapper.withStorage { storage in
      let NUMBER_OF_SESSIONS = 100

      var sessions: [Session<Dictionary<String, String>>] = []
      for ii in 0..<NUMBER_OF_SESSIONS {
        sessions.append(.init(duration: 12345678.9, userInfo: ["Number": "\(ii)"]))
      }

      func __store(_ nn: Int = NUMBER_OF_SESSIONS) throws {
        try sessions[0..<nn].forEach { try storage.storeSession($0) }
      }

      try __store()
      try storage.removeExpiredSessions() // No sessions will be removed.
      for ii in 0..<NUMBER_OF_SESSIONS {
        let session = try #require(try storage.session(for: sessions[ii].id))
        #expect(!session.hasExpired)
      }

      let middleN = NUMBER_OF_SESSIONS / 2

      for ii in 0..<middleN {
        sessions[ii].duration = -100 // past time
      }
      try __store(middleN)
      for ii in 0..<middleN {
        // Not removed yet
        #expect(try storage.sessionExists(for: sessions[ii].id))
      }

      try storage.removeExpiredSessions(removeSymbolicLinks: true)
      for ii in 0..<NUMBER_OF_SESSIONS {
        let id = sessions[ii].id
        if ii < middleN {
          #expect(try storage.sessionExists(for: id) == false, "#\(ii) must be removed.")
        } else {
          #expect(try storage.sessionExists(for: id), "#\(ii) must NOT be removed.")
        }
      }
    }
  }
  
  @Test func test_iterator() async throws {
    let sessions: Set<Session<Dictionary<String, String>>> = [
      .init(duration: 12345678.9, userInfo: ["A": "A"]),
      .init(duration: 12345678.9, userInfo: ["B": "B"]),
      .init(duration: 12345678.9, userInfo: ["C": "C"]),
      .init(duration: 12345678.9, userInfo: ["D": "D"]),
      .init(duration: 12345678.9, userInfo: ["E": "E"]),
    ]

    try await storageWrapper.withStorage { storage in
      try sessions.forEach { try storage.storeSession($0) }
      for session in storage {
        #expect(sessions.contains(session), "Missed: \(session.userInfo.keys.first!)")
      }
    }
  }
  
  @Test func test_manager() async throws {
    try await storageWrapper.withStorage { storage in
      let manager = SessionManager<Dictionary<String, String>>(storage: storage)

      var session = try manager.createSession(duration: 12345678.9, userInfo: ["Use": "Manager"])
      #expect(try manager.sessionExists(for: session.id))
      #expect(try session == manager.session(for: session.id))

      session.duration = -12345678.9
      try manager.storeSession(session)
      try manager.removeExpiredSessions()
      #expect(try manager.session(for: session.id) == nil)
    }
  }
}
#endif
