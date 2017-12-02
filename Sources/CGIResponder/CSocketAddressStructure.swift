/***************************************************************************************************
 CSocketAddressStructure.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Protocol for `sockaddr_*`
public protocol CSocketAddressStructure {
  var size: CSocketAddressSize { get }
  var family: CAddressFamily { get }
}
