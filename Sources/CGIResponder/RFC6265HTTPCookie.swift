/***************************************************************************************************
 RFC6265HTTPCookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # RFC6265HTTPCookie
 Let HTTPCookie conform to RFC6265Cookie...
 HTTPCookie cannot conform to RFC6265Cookie directly...
 
 */
open class RFC6265HTTPCookie: HTTPCookie, RFC6265Cookie {
  public required override init?(properties:[HTTPCookiePropertyKey:Any]) {
    super.init(properties:properties)
  }
  
  public var creationDate: Date? {
    return self.properties?.creationDate
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

