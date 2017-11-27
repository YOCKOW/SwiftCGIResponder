/***************************************************************************************************
 CIPAddress.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Protocol for `CIPv4Address`(a.k.a. `in_addr`) and `CIPv6Address`(a.k.a `in6_addr`)
public protocol CIPAddress: CustomStringConvertible {
  var bytes: [UInt8] { get }
  init?(_ bytes:[UInt8])
  init?(string:String)
}
