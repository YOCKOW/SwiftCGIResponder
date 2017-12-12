/***************************************************************************************************
 CGICookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # CGICookie
 Represents HTTP Cookie.
 It may be better to use `HTTPCookie` of `Foundation` rather than this in some cases...
 
 */
public struct CGICookie: RFC6265Cookie {
  public var name: String
  public var value: String
  public var expiresDate: Date?
  
  fileprivate var _host: URL.Host
  public var domain: String { return self._host.description }
  public var path: String
  
  public var creationDate: Date?
  public var lastAccessDate: Date?
  public var isHostOnly: Bool
  public var isSecure: Bool
  public var isHTTPOnly: Bool
  
  public var isPersistent: Bool {
    guard let expires = self.expiresDate else { return false }
    return expires.timeIntervalSinceNow > 0
  }
  
  // Comform to Hashable
  public var hashValue: Int {
    var hh = 0
    hh ^= self.name.hashValue
    hh ^= self._host.hashValue
    hh ^= self.path.hashValue
    return hh
  }
  public static func ==(lhs:CGICookie, rhs:CGICookie) -> Bool {
    if lhs.name != rhs.name { return false }
    if lhs._host != rhs._host { return false }
    if lhs.path != rhs.path { return false }
    return true
  }
  
  // Conform to RFC6265Cookie
  public init?(properties:[HTTPCookiePropertyKey:Any]) {
    guard let name = properties.name,
      let value = properties.value,
      let domain = properties.domain,
      let path = properties.path else { return nil }
    
    let expires: Date? = ({
      if let maxAge =  properties.maximumAge {
        return Date(timeIntervalSinceNow:TimeInterval(maxAge))
      } else {
        return properties.expiresDate
      }
    })()
    
    self.init(
      name:name,
      value:value,
      domain:domain,
      path:path,
      creationDate:properties.creationDate,
      expiresDate:expires,
      lastAccessDate:properties.lastAccessDate,
      isHostOnly:properties.hostOnly,
      isSecure:properties.secure,
      isHTTPOnly:properties.httpOnly
    )
  }
  
  public init?(name:String,
               value:String,
               domain:String,
               path:String,
               creationDate: Date? = Date(),
               expiresDate: Date? = nil,
               lastAccessDate: Date? = Date(),
               isHostOnly: Bool = false,
               isSecure: Bool = false,
               isHTTPOnly: Bool = false) {
    self.name = name
    self.value = value
    
    guard let host = URL.Host(string:domain.trimmingCharacters(in:BonaFideCharacterSet(charactersIn:"."))) else {
      return nil
    }
    self._host = host
    
    self.path = (path.isEmpty || !path.hasPrefix("/")) ? "/" : path
    
    self.creationDate = creationDate
    self.expiresDate = expiresDate
    self.lastAccessDate = lastAccessDate
    
    self.isHostOnly = isHostOnly
    self.isSecure = isSecure
    self.isHTTPOnly = isHTTPOnly
  }
}


