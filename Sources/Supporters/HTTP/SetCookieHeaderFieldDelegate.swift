/* *************************************************************************************************
 SetCookieHeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

/// Represents "Set-Cookie:"
public struct SetCookieHeaderFieldDelegate: HeaderFieldDelegate {
  public struct Cookie: HeaderFieldValueConvertible {
    private var _cookie: AnyCookie
    fileprivate init<C>(_ cookie:C) where C:RFC6265Cookie {
      self._cookie = AnyCookie(cookie)
    }
    
    public init?(headerFieldValue: HeaderFieldValue) {
      guard let properties = CookieProperties(_responseHeaderFieldValue:headerFieldValue) else {
        return nil
      }
      guard let cookie = AnyCookie(properties:properties) else { return nil }
      self.init(cookie)
    }
    
    public var headerFieldValue: HeaderFieldValue {
      return self._cookie.responseHeaderFieldValue()!
    }
  }
  public typealias ValueSource = Cookie
  
  public static var name: HeaderFieldName { return .setCookie }
  public static var type: HeaderField.PresenceType { return .duplicable }
  
  public var source:Cookie
  public init(_ source:Cookie) {
    self.source = source
  }
  
  /// Initialize with `cookie`
  public init<C>(cookie:C) where C:RFC6265Cookie {
    self.init(Cookie(cookie))
  }
}

extension SetCookieHeaderFieldDelegate.Cookie: RFC6265Cookie {
  public var name: String { return self._cookie.name }
  public var value: String { return self._cookie.value }
  public var domain: String { return self._cookie.domain }
  public var path: String { return self._cookie.path }
  public var creationDate: Date? { return self._cookie.creationDate }
  public var expiresDate: Date? { return self._cookie.expiresDate }
  public var lastAccessDate: Date? { return self._cookie.lastAccessDate }
  public var isPersistent: Bool { return self._cookie.isPersistent }
  public var isHostOnly: Bool { return self._cookie.isHostOnly }
  public var isSecure: Bool { return self._cookie.isSecure }
  public var isHTTPOnly: Bool { return self._cookie.isHTTPOnly }
}
