/***************************************************************************************************
 Dictionary+HTTPCookiePropertyKey.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/// Let it easy to access properties of HTTPCookie
extension Dictionary where Key == HTTPCookiePropertyKey, Value == Any {
  private func bool(forKey key:HTTPCookiePropertyKey) -> Bool {
    guard let property = self[key] else { return false }
    if case let boolString as String = property {
      return boolString.uppercased() == "TRUE"
    } else if case let bool as Bool = property {
      return bool
    }
    return false
  }
  
  private func date(forKey key:HTTPCookiePropertyKey) -> Date? {
    guard let property = self[key] else { return nil }
    if case let dateString as String = property {
      return Date(cookieDateString:dateString)
    } else if case let date as Date = property {
      return date
    }
    return nil
  }
  
  private func int(forKey key:HTTPCookiePropertyKey) -> Int? {
    guard let property = self[key] else { return nil }
    if case let intString as String = property {
      return Int(intString)
    } else if case let int as Int = property {
      return int
    }
    return nil
  }
  
  public var name: String? {
    get {
      guard case let name as String = self[HTTPCookiePropertyKey.name] else { return nil }
      return name
    }
    set {
      if let newName = newValue {
        self[HTTPCookiePropertyKey.name] = newName
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.name)
      }
    }
  }
  
  public var value: String? {
    get {
      guard case let value as String = self[HTTPCookiePropertyKey.value] else { return nil }
      return value
    }
    set {
      if let value = newValue {
        self[HTTPCookiePropertyKey.value] = value
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.value)
      }
    }
  }
  
  public var domain: String? {
    get {
      guard case let domain as String = self[HTTPCookiePropertyKey.domain] else { return nil }
      return domain
    }
    set {
      if let newDomain = newValue {
        self[HTTPCookiePropertyKey.domain] = newDomain
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.domain)
      }
    }
  }
  
  public var path: String? {
    get {
      guard case let path as String = self[HTTPCookiePropertyKey.path] else { return nil }
      return path
    }
    set {
      if let newPath = newValue {
        self[HTTPCookiePropertyKey.path] = newPath
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.path)
      }
    }
  }
  
  public var creationDate: Date? {
    get {
      return self.date(forKey:HTTPCookiePropertyKey.created)
    }
    set {
      if let newDate = newValue {
        self[HTTPCookiePropertyKey.created] = newDate
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.created)
      }
    }
  }
  
  public var expiresDate: Date? {
    get {
      return self.date(forKey:HTTPCookiePropertyKey.expires)
    }
    set {
      if let newDate = newValue {
        self[HTTPCookiePropertyKey.expires] = newDate
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.expires)
      }
    }
  }
  
  public var lastAccessDate: Date? {
    get {
      return self.date(forKey:HTTPCookiePropertyKey.lastAccessed)
    }
    set {
      if let newDate = newValue {
        self[HTTPCookiePropertyKey.lastAccessed] = newDate
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.lastAccessed)
      }
    }
  }
  
  public var maximumAge: Int? {
    get {
      return self.int(forKey:HTTPCookiePropertyKey.maximumAge)
    }
    set {
      if let newMaximumAge = newValue {
        self[HTTPCookiePropertyKey.maximumAge] = String(newMaximumAge)
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.maximumAge)
      }
    }
  }
  
  public var persistent: Bool {
    get {
      if case let discardString as String = self[HTTPCookiePropertyKey.discard] {
        return discardString.uppercased() != "TRUE"
      } else {
        return self.maximumAge != nil && self.version < 1
      }
    }
    set {
      if newValue {
        self.removeValue(forKey:HTTPCookiePropertyKey.discard)
      } else {
        self[HTTPCookiePropertyKey.discard] = "TRUE"
      }
    }
  }
  
  public var hostOnly: Bool {
    get {
      return self.bool(forKey:HTTPCookiePropertyKey.hostOnly)
    }
    set {
      if newValue {
        self[HTTPCookiePropertyKey.hostOnly] = "TRUE"
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.hostOnly)
      }
    }
  }
  
  public var secure: Bool {
    get {
      return self.bool(forKey:HTTPCookiePropertyKey.secure)
    }
    set {
      if newValue {
        self[HTTPCookiePropertyKey.secure] = "TRUE"
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.secure)
      }
    }
  }
  
  public var httpOnly: Bool {
    get {
      return self.bool(forKey:HTTPCookiePropertyKey.httpOnly)
    }
    set {
      if newValue {
        self[HTTPCookiePropertyKey.httpOnly] = "TRUE"
      } else {
        self.removeValue(forKey:HTTPCookiePropertyKey.httpOnly)
      }
    }
  }
  
  public var version: Int {
    get {
      if let version = self.int(forKey:HTTPCookiePropertyKey.version) {
        return version
      }
      return 0
    }
    set {
      self[HTTPCookiePropertyKey.version] = String(newValue)
    }
  }
}

