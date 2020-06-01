/* *************************************************************************************************
 SessionStorage.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TimeSpecification
import yExtensions
 
/// A type that represents a container managing the storage of sessions.
public protocol SessionStorage {
  associatedtype UserInfo: Codable

  /// Creates a new session with given arguments.
  func createSession(duration: NanosecondTimeInterval, userInfo: UserInfo) throws -> Session<UserInfo>

  /// Removes all expired sessions that the storage contains.
  func removeExpiredSessions() throws

  /// Removes a session that is identified by `identifier`
  func removeSession(for id: UUID) throws

  /// Saves `session` to the storage.
  func storeSession(_ session: Session<UserInfo>) throws

  /// Returns a session identified by `identifier`.
  func session(for id: UUID) throws -> Session<UserInfo>?
}

/**
 The storage of sessions that uses local file system to manage them.
 
 # Directory Hierarchy
 
 ```
 Specified Directory
  |
  +- id
  |   |
  |   +- XXXX/YYYY/ZZZZ/<symbolic links to session files>
  |   :
  |
  +- expires
      |
      +- TTTT/UUUU/VVVV/<actual files representing sessions>
      :
 
 ```
 
 * "XXXX/YYYY/ZZZZ/..." is generated from Session ID.
 * "TTTT/UUUU/VVVV/..." is generated from Expiration time. It must be sortable.
 
 */
open class FileSystemSessionStorage<UserInfo>: SessionStorage where UserInfo: Codable {
  /// The URL for the directory that contains session files.
  public let directory: URL
  
  private var _idDirectory: URL {
    return URL(fileURLWithPath: "id", isDirectory: true, relativeTo: self.directory)
  }
  
  private var _expiresDirectory: URL {
    return URL(fileURLWithPath: "expires", isDirectory: true, relativeTo: self.directory)
  }
  
  /// Uses the directory at `url` for session storage.
  public init(directoryAt url: URL) throws {
    let url = url.standardizedFileURL
    guard url.isExistingLocalDirectory else {
      throw CocoaError(.fileReadNoSuchFile)
    }
    self.directory = url
  }
  
  
  private func _base32EncodedSessionID(from sessionID: UUID) -> Data {
    return sessionID.base32EncodedData(using: .rfc4648, padding: false)
  }
  
  private let _SLASH: UInt8 = 0x2F
  private let _LOW_LINE: UInt8 = 0x5F
  
  /// If `id` is "00000000-0000-0000-0000-000000000000" then,
  /// returns `"[storage directory]/id/AAAAAA/AAAAAA/AAAAAAA/AAAAAAA"`
  internal func _symbolicLinkURL(for sessionID: UUID) -> URL {
    let base32ID = self._base32EncodedSessionID(from: sessionID)
    assert(base32ID.count == 26)
    
    var relativePathData = Data(capacity: 29)
    relativePathData.append(contentsOf: base32ID[0..<6])
    relativePathData.append(_SLASH)
    relativePathData.append(contentsOf: base32ID[6..<12])
    relativePathData.append(_SLASH)
    relativePathData.append(contentsOf: base32ID[12..<19])
    relativePathData.append(_SLASH)
    relativePathData.append(contentsOf: base32ID[19..<26])
    
    return URL(fileURLWithPath: String(data: relativePathData, encoding: .utf8)!,
               isDirectory: false,
               relativeTo: self._idDirectory)
  }
  
  /// If `id` is "00000000-0000-0000-0000-000000000000"
  /// and `expirationTime` is `1234567890.987654321` then,
  /// returns `"00000029/IO/1D/4_7BF6HC8_AAAAAAAAAAAAAAAAAAAAAAAAAA"`
  private func _sessionFileRelativePathFromExpiresDirectory(sessionID: UUID,
                                                            expirationTime: NanosecondAbsoluteTime) -> String {
    let base32Seconds = expirationTime.seconds.base32EncodedData(using: .triacontakaidecimal,
                                                                 byteOrder: .bigEndian,
                                                                 padding: false)
    let base32Nanoseconds = expirationTime.nanoseconds.base32EncodedData(using: .triacontakaidecimal,
                                                                         byteOrder: .bigEndian,
                                                                         padding: false)
    assert(base32Seconds.count == 13)
    assert(base32Nanoseconds.count == 7)
    
    var relativePathData = Data(capacity: 51)
    relativePathData.append(contentsOf: base32Seconds[0..<8])
    relativePathData.append(_SLASH)
    relativePathData.append(contentsOf: base32Seconds[8..<10])
    relativePathData.append(_SLASH)
    relativePathData.append(contentsOf: base32Seconds[10..<12])
    relativePathData.append(_SLASH)
    relativePathData.append(contentsOf: base32Seconds[12..<13])
    relativePathData.append(_LOW_LINE)
    relativePathData.append(contentsOf: base32Nanoseconds)
    relativePathData.append(_LOW_LINE)
    relativePathData.append(contentsOf: self._base32EncodedSessionID(from: sessionID))
    
    return String(data: relativePathData, encoding: .utf8)!
  }
  
  internal func _sessionFileURL(sessionID: UUID, expirationTime: NanosecondAbsoluteTime) -> URL {
    return URL(fileURLWithPath: self._sessionFileRelativePathFromExpiresDirectory(sessionID: sessionID,
                                                                                  expirationTime: expirationTime),
               isDirectory: false,
               relativeTo: self._expiresDirectory)
  }
  
  internal func _relativePathToSessionFileFromSymbolicLink(sessionID: UUID, expirationTime: NanosecondAbsoluteTime) -> String {
    return (
      "../../../../expires/" +
      self._sessionFileRelativePathFromExpiresDirectory(sessionID: sessionID,
                                                        expirationTime: expirationTime)
    )
  }
  
  private func _urlSuite(for session: Session<UserInfo>) -> (symbolicLinkURL: URL, symbolicLinkDestination: String, sessionFileURL: URL) {
    let symlinkURL = self._symbolicLinkURL(for: session.id)
    let dest = self._relativePathToSessionFileFromSymbolicLink(sessionID: session.id,
                                                               expirationTime: session.expirationTime)
    let sessionFileURL = URL(fileURLWithPath: dest,
                             isDirectory: false,
                             relativeTo: symlinkURL)
    return (symbolicLinkURL: symlinkURL,
            symbolicLinkDestination: dest,
            sessionFileURL: sessionFileURL)
  }
  
  internal func _sessionID(fromSessionFileURL url: URL) -> UUID {
    guard let uuid = url.lastPathComponent.split(separator: "_").last.flatMap({ UUID(base32Encoded: $0, version: .rfc4648) }) else {
      fatalError("Unexpected Session File URL.")
    }
    return uuid
  }
  
  private func _createDirectory(at url: URL) throws {
    try FileManager.default.createDirectory(at: url,
                                            withIntermediateDirectories: true,
                                            attributes: [.posixPermissions: NSNumber(0o700)])
  }
  
  private func _createParentDirectory(of url: URL) throws {
    try self._createDirectory(at: url.standardizedFileURL.deletingLastPathComponent())
  }
  
  /// Removes the file at `url` (and its parent directory if it is empty).
  private func _removeFile(at url: URL) throws {
    let manager = FileManager.default
    try manager.removeItem(at: url)
    
    let parent = url.deletingLastPathComponent()
    let contents = try manager.contentsOfDirectory(at: parent,
                                                   includingPropertiesForKeys: nil,
                                                   options: .skipsHiddenFiles)
    if contents.isEmpty {
      try manager.removeItem(at: parent)
    }
  }
  
  open func createSession(duration: NanosecondTimeInterval, userInfo: UserInfo) throws -> Session<UserInfo> {
    let session = Session<UserInfo>(duration: duration, userInfo: userInfo)
    try self.storeSession(session)
    return session
  }
  
  open func removeExpiredSessions() throws {
    fatalError("Unimplemented.")
  }
  
  open func removeSession(for id: UUID) throws {
    let manager = FileManager.default
    let symlinkURL = self._symbolicLinkURL(for: id)
    let dest = try manager.destinationOfSymbolicLink(atPath: symlinkURL.standardizedFileURL.path)
    let sessionFileURL = URL(fileURLWithPath: dest,
                             isDirectory: false,
                             relativeTo: symlinkURL)
    try self._removeFile(at: sessionFileURL)
    try self._removeFile(at: symlinkURL)
  }
  
  open func storeSession(_ session: Session<UserInfo>) throws {
    // Removes old session.
    try? self.removeSession(for: session.id)
    
    let urlSuite = self._urlSuite(for: session)
    
    // Creates sessin file.
    try self._createParentDirectory(of: urlSuite.sessionFileURL)
    try JSONEncoder().encode(session).write(to: urlSuite.sessionFileURL)

    // Creates symbolic link.
    try self._createParentDirectory(of: urlSuite.symbolicLinkURL)
    try FileManager.default.createSymbolicLink(atPath: urlSuite.symbolicLinkURL.standardizedFileURL.path,
                                               withDestinationPath: urlSuite.symbolicLinkDestination)
  }
  
  open func session(for id: UUID) throws -> Session<UserInfo>? {
    let symlinkURL = self._symbolicLinkURL(for: id)
    guard symlinkURL.isExistingLocalFile else { return nil }
    
    let url = self._symbolicLinkURL(for: id).resolvingSymlinksInPath()
    guard url.isExistingLocalFile else {
      // Deletes garbage.
      try? FileManager.default.removeItem(at: symlinkURL)
      return nil
    }
    return try JSONDecoder().decode(Session<UserInfo>.self, from: Data(contentsOf: url))
  }
}
