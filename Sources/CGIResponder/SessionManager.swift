/* *************************************************************************************************
 SessionManager.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TimeSpecification

private func _mustBeOverridden(function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> Never {
  fatalError("\(function) must be overridden.", file: file, line: line)
}

/// The manager of sessions.
/// You can use any instance of `SessionStorage` to access stored sessions,
/// namely this type can work as a type erasure of `SessionStorage`.
public struct SessionManager<UserInfo>: Sequence where UserInfo: Codable {
  public typealias Element = Session<UserInfo>
  
  private class _StorageBox {
    func createSession(duration: NanosecondTimeInterval, userInfo: UserInfo) throws -> Session<UserInfo> {
      _mustBeOverridden()
    }
    
    func removeAllSessions() throws {
      _mustBeOverridden()
    }
    
    func removeExpiredSessions() throws {
      _mustBeOverridden()
    }
    
    func removeSession(for id: UUID) throws {
      _mustBeOverridden()
    }

    func storeSession(_ session: Session<UserInfo>) throws {
      _mustBeOverridden()
    }

    func session(for id: UUID) throws -> Session<UserInfo>? {
      _mustBeOverridden()
    }
    
    func sessionExists(for id: UUID) throws -> Bool {
      _mustBeOverridden()
    }
    
    func makeIterator() -> AnyIterator<Session<UserInfo>> {
      _mustBeOverridden()
    }
  }
  
  private class _SomeStorage<S>: _StorageBox where S: SessionStorage, S.UserInfo == UserInfo {
    private let _base: S
    
    init(_ base: S) {
      self._base = base
    }
    
    override func createSession(duration: NanosecondTimeInterval, userInfo: UserInfo) throws -> Session<UserInfo> {
      return try self._base.createSession(duration: duration, userInfo: userInfo)
    }
    
    override func removeAllSessions() throws {
      try self._base.removeAllSessions()
    }
    
    override func removeExpiredSessions() throws {
      try self._base.removeExpiredSessions()
    }
    
    override func removeSession(for id: UUID) throws {
      try self._base.removeSession(for: id)
    }

    override func storeSession(_ session: Session<UserInfo>) throws {
      try self._base.storeSession(session)
    }

    override func session(for id: UUID) throws -> Session<UserInfo>? {
      return try self._base.session(for: id)
    }
    
    override func sessionExists(for id: UUID) throws -> Bool {
      return try self._base.sessionExists(for: id)
    }
    
    override func makeIterator() -> AnyIterator<Session<UserInfo>> {
      return AnyIterator(self._base.makeIterator())
    }
  }
  
  private let _box: _StorageBox
  
  public init<S>(storage: S) where S: SessionStorage, S.UserInfo == UserInfo {
    self._box = _SomeStorage<S>(storage)
  }
  
  public func createSession(duration: NanosecondTimeInterval, userInfo: UserInfo) throws -> Session<UserInfo> {
    return try self._box.createSession(duration: duration, userInfo: userInfo)
  }
  
  public func removeAllSessions() throws {
    return try self._box.removeAllSessions()
  }
  
  public func removeExpiredSessions() throws {
    return try self._box.removeExpiredSessions()
  }
  
  public func removeSession(for id: UUID) throws {
    return try self._box.removeSession(for: id)
  }

  public func storeSession(_ session: Session<UserInfo>) throws {
    return try self._box.storeSession(session)
  }

  public func session(for id: UUID) throws -> Session<UserInfo>? {
    return try self._box.session(for: id)
  }
  
  public func sessionExists(for id: UUID) throws -> Bool {
    return try self._box.sessionExists(for: id)
  }
  
  private func _makeIterator() -> AnyIterator<Session<UserInfo>> {
    return self._box.makeIterator()
  }
  
  public struct Iterator: IteratorProtocol {
    public typealias Element = Session<UserInfo>
    
    private var _iterator: AnyIterator<Session<UserInfo>>
    
    fileprivate init(_ manager: SessionManager<UserInfo>) {
      self._iterator = manager._makeIterator()
    }
    
    public func next() -> Session<UserInfo>? {
      return self._iterator.next()
    }
  }
  
  public func makeIterator() -> Iterator {
    return Iterator(self)
  }
}
