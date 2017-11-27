/***************************************************************************************************
 CIPv4Address.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import CoreFoundation

/// Extend `CIPv4Address`(a.k.a. `in_addr`)
extension CIPv4Address: CIPAddress {
  public internal(set) var bytes: [UInt8] {
    get {
      var addr = self.s_addr
      return withUnsafePointer(to:&addr) {
        return $0.withMemoryRebound(to:UInt8.self, capacity:4) {
          return [$0[0], $0[1], $0[2], $0[3]]
        }
      }
    }
    set(newBytes) {
      guard newBytes.count == 4 else { fatalError("IPv4 Address is 32-bit wide.") }
      withUnsafeMutablePointer(to:&self.s_addr) {
        $0.withMemoryRebound(to:UInt8.self, capacity:4) {
          for ii in 0..<4 { $0[ii] = newBytes[ii] }
        }
      }
    }
  }
  
  public var description: String {
    var address_p = UnsafeMutablePointer<CChar>.allocate(capacity:Int(INET_ADDRSTRLEN))
    defer { address_p.deallocate(capacity:Int(INET_ADDRSTRLEN)) }
    
    var myself = self
    guard inet_ntop(AF_INET, &myself.s_addr, address_p, CSocketLength(INET_ADDRSTRLEN)) != nil else {
      fatalError("Failed to convert IP address to String")
    }
    return String(utf8String:address_p)!
  }
  
  
  public init(_ bytes:(UInt8, UInt8, UInt8, UInt8)) {
    self.init()
    self.bytes = [bytes.0, bytes.1, bytes.2, bytes.3]
  }
  
  public init?(_ bytes:[UInt8]) {
    guard bytes.count == 4 else { return nil }
    self.init()
    self.bytes = bytes
  }
  
  public init?(string:String) {
    self.init()
    guard inet_pton(AF_INET, string, &self) == 1 else { return nil }
  }
}
