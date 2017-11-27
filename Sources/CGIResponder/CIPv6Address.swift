/***************************************************************************************************
 CIPv6Address.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import CoreFoundation

/// Extend `CIPv6Address`(a.k.a. `in6_addr`)
extension CIPv6Address: CIPAddress {
  private var s6_addr: (UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8) {
    get {
      #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
        return self.__u6_addr.__u6_addr8
      #else
        return self.__in6_u.__u6_addr8
      #endif
    }
    set {
      #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
        self.__u6_addr.__u6_addr8 = newValue
      #else
        self.__in6_u.__u6_addr8 = newValue
      #endif
    }
  }
  
  public internal(set) var bytes: [UInt8] {
    get {
      return [
        self.s6_addr.0, self.s6_addr.1, self.s6_addr.2, self.s6_addr.3,
        self.s6_addr.4, self.s6_addr.5, self.s6_addr.6, self.s6_addr.7,
        self.s6_addr.8, self.s6_addr.9, self.s6_addr.10, self.s6_addr.11,
        self.s6_addr.12, self.s6_addr.13, self.s6_addr.14, self.s6_addr.15,
      ]
    }
    set(newBytes) {
      guard newBytes.count == 16 else { fatalError("IPv6 Address is 128-bit wide.") }
      self.s6_addr = (
        newBytes[0], newBytes[1], newBytes[2], newBytes[3],
        newBytes[4], newBytes[5], newBytes[6], newBytes[7],
        newBytes[8], newBytes[9], newBytes[10], newBytes[11],
        newBytes[12], newBytes[13], newBytes[14], newBytes[15]
      )
    }
  }
  
  public var description: String {
    var address_p = UnsafeMutablePointer<CChar>.allocate(capacity:Int(INET6_ADDRSTRLEN))
    defer { address_p.deallocate(capacity:Int(INET6_ADDRSTRLEN)) }
    
    var myself = self
    guard inet_ntop(AF_INET6, &myself.s6_addr, address_p, CSocketLength(INET6_ADDRSTRLEN)) != nil else {
      fatalError("Failed to convert IP address to String")
    }
    return String(utf8String:address_p)!
  }
  
  
  public init(_ bytes:(UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8,UInt8)) {
    self.init()
    self.s6_addr = bytes
  }
  
  public init?(_ bytes:[UInt8]) {
    guard bytes.count == 16 else { return nil }
    self.init()
    self.bytes = bytes
  }
  
  public init?(string:String) {
    self.init()
    guard inet_pton(AF_INET6, string, &self) == 1 else { return nil }
  }
}
