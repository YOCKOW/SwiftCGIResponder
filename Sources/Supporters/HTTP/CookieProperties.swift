/* *************************************************************************************************
 CookieProperties.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

extension HTTPCookiePropertyKey {
  public static let created = HTTPCookiePropertyKey(rawValue:"Created")
  public static let hostOnly = HTTPCookiePropertyKey(rawValue:"HostOnly")
  public static let httpOnly = HTTPCookiePropertyKey(rawValue:"HTTPOnly")
  public static let lastAccessed = HTTPCookiePropertyKey(rawValue:"LastAccessed")
}

/// Represents properties for cookies. A wrapper of [HTTPCookiePropertyKey:Any]
public struct CookieProperties {
  internal var _properties:[HTTPCookiePropertyKey:Any]
  
  public init(_ properties:[HTTPCookiePropertyKey:Any]) {
    self._properties = properties
  }
  
  public init?(for cookie:HTTPCookie) {
    guard let properties = cookie.properties else { return nil }
    self.init(properties)
  }
  
  public init<C>(for cookie:C) where C: RFC6265Cookie {
    self.init([:])
    
    self.name = cookie.name
    self.value = cookie.value
    self.domain = cookie.domain
    self.path = cookie.path
    self.creationDate = cookie.creationDate
    self.expiresDate = cookie.expiresDate
    self.lastAccessDate = cookie.lastAccessDate
    self.persistent = cookie.isPersistent
    self.hostOnly = cookie.isHostOnly
    self.secure = cookie.isSecure
    self.httpOnly = cookie.isHTTPOnly
  }
}

extension CookieProperties {
  private func _bool(forKey key:HTTPCookiePropertyKey) -> Bool {
    guard let property = self._properties[key] else { return false }
    if case let boolString as String = property {
      return boolString.uppercased() == "TRUE"
    } else if case let bool as Bool = property {
      return bool
    }
    return false
  }
  
  private func _date(forKey key:HTTPCookiePropertyKey) -> Date? {
    guard let property = self._properties[key] else { return nil }
    if case let dateString as String = property {
      return Date(cookieDateString:dateString)
    } else if case let date as Date = property {
      return date
    }
    return nil
  }
  
  private func _int(forKey key:HTTPCookiePropertyKey) -> Int? {
    guard let property = self._properties[key] else { return nil }
    if case let intString as String = property {
      return Int(intString)
    } else if case let int as Int = property {
      return int
    }
    return nil
  }
  
  /// The name of the cookie
  public var name: String? {
    get {
      guard case let name as String = self._properties[.name] else { return nil }
      return name
    }
    set {
      if let newName = newValue {
        self._properties[.name] = newName
      } else {
        self._properties.removeValue(forKey:.name)
      }
    }
  }
  
  /// The value of the cookie
  public var value: String? {
    get {
      guard case let value as String = self._properties[.value] else { return nil }
      return value
    }
    set {
      if let value = newValue {
        self._properties[.value] = value
      } else {
        self._properties.removeValue(forKey:.value)
      }
    }
  }
  
  /// The domain of the cookie
  public var domain: String? {
    get {
      guard case let domain as String = self._properties[.domain] else { return nil }
      return domain
    }
    set {
      if let newDomain = newValue {
        self._properties[.domain] = newDomain
      } else {
        self._properties.removeValue(forKey:.domain)
      }
    }
  }
  
  /// The path for the cookie.
  public var path: String? {
    get {
      guard case let path as String = self._properties[.path] else { return nil }
      return path
    }
    set {
      if let newPath = newValue {
        self._properties[.path] = newPath
      } else {
        self._properties.removeValue(forKey:.path)
      }
    }
  }
  
  /// The creation date of the cookie.
  public var creationDate: Date? {
    get {
      return self._date(forKey:.created)
    }
    set {
      if let newDate = newValue {
        self._properties[.created] = newDate
      } else {
        self._properties.removeValue(forKey:.created)
      }
    }
  }
  
  /// The expiration date for the cookie.
  public var expiresDate: Date? {
    get {
      return self._date(forKey:.expires)
    }
    set {
      if let newDate = newValue {
        self._properties[.expires] = newDate
      } else {
        self._properties.removeValue(forKey:.expires)
      }
    }
  }
  
  /// Last Access date of the cookie.
  public var lastAccessDate: Date? {
    get {
      return self._date(forKey:.lastAccessed)
    }
    set {
      if let newDate = newValue {
        self._properties[.lastAccessed] = newDate
      } else {
        self._properties.removeValue(forKey:.lastAccessed)
      }
    }
  }
  
  /// An integer value stating how long in seconds the cookie should be kept, at most.
  public var maximumAge: Int? {
    get {
      return self._int(forKey:.maximumAge)
    }
    set {
      if let newMaximumAge = newValue {
        self._properties[.maximumAge] = String(newMaximumAge)
      } else {
        self._properties.removeValue(forKey:.maximumAge)
      }
    }
  }
  
  /// A Boolean value indicating whether the cookie is persistent or not.
  public var persistent: Bool {
    get {
      if case let discardString as String = self._properties[.discard] {
        return discardString.uppercased() != "TRUE"
      } else {
        return self.maximumAge != nil && self.version < 1
      }
    }
    set {
      if newValue {
        self._properties.removeValue(forKey:.discard)
      } else {
        self._properties[.discard] = "TRUE"
      }
    }
  }
  
  public var hostOnly: Bool {
    get {
      return self._bool(forKey:.hostOnly)
    }
    set {
      if newValue {
        self._properties[.hostOnly] = "TRUE"
      } else {
        self._properties.removeValue(forKey:.hostOnly)
      }
    }
  }
  
  /// A Boolean value indicating that the cookie should be transmitted only over secure channels.
  public var secure: Bool {
    get {
      return self._bool(forKey:.secure)
    }
    set {
      if newValue {
        self._properties[.secure] = "TRUE"
      } else {
        self._properties.removeValue(forKey:.secure)
      }
    }
  }
  
  /// A Boolean value indicating that the cookie cannot be used from JavaScript.
  public var httpOnly: Bool {
    get {
      return self._bool(forKey:.httpOnly)
    }
    set {
      if newValue {
        self._properties[.httpOnly] = "TRUE"
      } else {
        self._properties.removeValue(forKey:.httpOnly)
      }
    }
  }
  
  /// The version of the cookie.
  public var version: Int {
    get {
      if let version = self._int(forKey:.version) {
        return version
      }
      return 0
    }
    set {
      self._properties[.version] = String(newValue)
    }
  }
}
