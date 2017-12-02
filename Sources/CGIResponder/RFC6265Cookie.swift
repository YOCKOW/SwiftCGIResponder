/***************************************************************************************************
 RFC6265Cookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # RFC6265Cookie
 Protocol for cookies defined in RFC 6265
 
 ## Reference
 * [RFC 6265](https://tools.ietf.org/html/rfc6265)
 
 */
public protocol RFC6265Cookie: Hashable {
  // [RFC 6265 #5.3](https://tools.ietf.org/html/rfc6265#section-5.3)
  // name, value, expiry-time, domain, path, creation-time, last-access-time,
  // persistent-flag, host-only-flag, secure-only-flag, and http-only-flag
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
  
  init?(properties:[HTTPCookiePropertyKey:Any])
}

/// Work with `HTTPCookie`
extension RFC6265Cookie {
  public var httpCookie: HTTPCookie {
    var properties: [HTTPCookiePropertyKey:Any] = [
      .name:self.name,
      .value:self.value,
      .domain:self.domain,
      .path:self.path
    ]
    
    // Extended Dictionary in "Dictionary+HTTPCookiePropertyKey.swift"
    properties.creationDate = self.creationDate
    properties.expiresDate = self.expiresDate
    properties.lastAccessDate = self.lastAccessDate
    properties.persistent = self.isPersistent
    properties.hostOnly = self.isHostOnly
    properties.httpOnly = self.isHTTPOnly
    properties.secure = self.isSecure
    
    return HTTPCookie(properties:properties)!
  }
  
  public init?(with httpCookie:HTTPCookie) {
    if let rawProperties = httpCookie.properties {
      self.init(properties:rawProperties)
    } else {
      var properties: [HTTPCookiePropertyKey:Any] = [
        .name:httpCookie.name,
        .value:httpCookie.value,
        .domain:httpCookie.domain,
        .path:httpCookie.path
      ]
      properties.expiresDate = httpCookie.expiresDate
      properties.secure = httpCookie.isSecure
      self.init(properties:properties)
    }
  }
}
