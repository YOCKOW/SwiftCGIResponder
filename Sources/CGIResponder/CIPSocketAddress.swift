/***************************************************************************************************
 CIPSocketAddress.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Protocol for `CIPv4SocketAddress`(a.k.a. `sockaddr_in`) and `CIPv6SocketAddress`(a.k.a. `sockaddr_in6`)
public protocol CIPSocketAddress: CSocketAddressStructure {
  var size: CSocketAddressSize { get }
  var family: CAddressFamily { get }
  var port: CSocketPort { get }
  var ipAddress: CIPAddress { get }
  init?(ipAddress:CIPAddress, port:CSocketPort)
}
