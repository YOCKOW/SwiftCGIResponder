/***************************************************************************************************
 CSocketAddress.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Extend `CSocketAddress` (a.k.a. `sockaddr`)
extension CSocketAddress {
  internal static func actualSocketAddress(`for` pointer:UnsafePointer<CSocketAddress>) -> CSocketAddressStructure {
    let family = pointer.pointee.family
    if family == .unix {
      return pointer.withMemoryRebound(to:CUNIXSocketAddress.self, capacity:1) {
        return $0.pointee
      }
    } else if family == .ipv4 {
      return pointer.withMemoryRebound(to:CIPv4SocketAddress.self, capacity:1) {
        return $0.pointee
      }
    } else if family == .ipv6 {
      return pointer.withMemoryRebound(to:CIPv6SocketAddress.self, capacity:1) {
        return $0.pointee
      }
    } else {
      fatalError("Unimplemented family: \(family)")
    }
  }
  
  public var family: CAddressFamily {
    get {
      return CAddressFamily(rawValue:self.sa_family)
    }
  }
  
  public var size: CSocketAddressSize {
    mutating get {
      #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
        return self.sa_len
      #else
        return withUnsafePointer(to:&self) {
          return CSocketAddress.actualSocketAddress(for:$0).size
        }
      #endif
    }
  }
}
