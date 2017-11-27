/***************************************************************************************************
 CAddressFamily.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import CoreFoundation

/// Wrapper for `sa_family_t`
public struct CAddressFamily: RawRepresentable {
  public let rawValue: sa_family_t
  public init(rawValue:sa_family_t) { self.rawValue = rawValue }
  public init(rawValue:CInt) { self.rawValue = sa_family_t(rawValue) }
  public static let unspecified = CAddressFamily(rawValue:AF_UNSPEC)
  public static let unix = CAddressFamily(rawValue:AF_UNIX)
  public static let ipv4 = CAddressFamily(rawValue:AF_INET)
  public static let ipv6 = CAddressFamily(rawValue:AF_INET6)
}
