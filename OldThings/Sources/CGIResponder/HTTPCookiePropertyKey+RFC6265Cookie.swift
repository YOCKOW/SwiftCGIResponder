/***************************************************************************************************
 HTTPCookiePropertyKey+RFC6265Cookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Foundation

/// Add some static constants for RFC 6265.
extension HTTPCookiePropertyKey {
  public static let created = HTTPCookiePropertyKey(rawValue:"Created")
  public static let hostOnly = HTTPCookiePropertyKey(rawValue:"HostOnly")
  public static let httpOnly = HTTPCookiePropertyKey(rawValue:"HTTPOnly")
  public static let lastAccessed = HTTPCookiePropertyKey(rawValue:"LastAccessed")
}
