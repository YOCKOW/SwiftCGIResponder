/* *************************************************************************************************
 RFC6265Cookie.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

/// Protocol for cookies defined in [RFC 6265](https://tools.ietf.org/html/rfc6265)
///
/// ## Reference
/// [RFC 6265 #5.3](https://tools.ietf.org/html/rfc6265#section-5.3): Properties are
/// `name`, `value`, `expiry-time`, `domain`, `path`, `creation-time`, `last-access-time`,
/// `persistent-flag`, `host-only-flag`, `secure-only-flag`, and `http-only-flag`
public protocol RFC6265Cookie: Hashable {
  var name: String { get }
  var value: String { get }
  var domain: String { get }
  var path: String { get }
  var creationDate: Date? { get }
  var expiresDate: Date? { get }
  var lastAccessDate: Date? { get }
  var isPersistent: Bool { get }
  var isHostOnly: Bool { get }
  var isSecure: Bool { get }
  var isHTTPOnly: Bool { get }
}

extension HTTPCookie: RFC6265Cookie {
  public var creationDate: Date? {
    return CookieProperties(for:self)?.creationDate
  }
  
  public var lastAccessDate: Date? {
    return nil
  }
  
  public var isPersistent: Bool {
    return !self.isSessionOnly
  }
  
  public var isHostOnly: Bool {
    return false
  }
}
