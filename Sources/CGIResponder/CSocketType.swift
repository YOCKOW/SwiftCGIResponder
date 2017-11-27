/***************************************************************************************************
 CSocketType.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import CoreFoundation
import Foundation

/// Wrapper for `__socket_type`
public struct CSocketType: RawRepresentable {
  public let rawValue: CInt
  public init(rawValue:CInt) { self.rawValue = rawValue }
  #if os(Linux)
  public init(rawValue:__socket_type) { self.rawValue = CInt(rawValue.rawValue) }
  #endif
  public static let stream = CSocketType(rawValue:SOCK_STREAM)
  public static let datagram = CSocketType(rawValue:SOCK_DGRAM)
  public static let raw = CSocketType(rawValue:SOCK_RAW)
  public static let reliablyDeliveredMessage = CSocketType(rawValue:SOCK_RDM)
  public static let sequencedPacket = CSocketType(rawValue:SOCK_SEQPACKET)
}
