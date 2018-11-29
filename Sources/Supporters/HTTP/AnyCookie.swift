/* *************************************************************************************************
 AnyCookie.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

/// A type-erasure for cookies conforming to `RFC6265Cookie`.
public struct AnyCookie: RFC6265Cookie {
  public var name: String
  public var value: String
  public var domain: String
  public var path: String
  public var creationDate: Date?
  public var expiresDate: Date?
  public var lastAccessDate: Date?
  public var isPersistent: Bool
  public var isHostOnly: Bool
  public var isSecure: Bool
  public var isHTTPOnly: Bool
  
  /// Initializes with an instance of `CookieProperties`.
  public init?(properties:CookieProperties) {
    guard let name = properties.name else { return nil }
    self.name = name
    
    guard let value = properties.value else { return nil }
    self.value = value
    
    guard let domain = properties.domain else { return nil }
    self.domain = domain
    
    guard let path = properties.path else { return nil }
    self.path = path
    
    self.creationDate = properties.creationDate
    self.expiresDate = properties.expiresDate
    self.lastAccessDate = properties.lastAccessDate
    self.isPersistent = properties.persistent
    self.isHostOnly = properties.hostOnly
    self.isSecure = properties.secure
    self.isHTTPOnly = properties.httpOnly
  }
  
  public init?<C>(_ cookie:C) where C:RFC6265Cookie {
    self.init(properties:CookieProperties(for:cookie))
  }
}
