/***************************************************************************************************
 IPAddress.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # IPAddress
 Represents for IP Address
 
 */
public enum IPAddress {
  case v4(UInt8, UInt8, UInt8, UInt8)
  case v6(UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8,
    UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8, UInt8)
  
  /**
   
   - returns:
   .v4 address if the length of bytes is equal to 4,
   .v6 address if the length of bytes is equal to 6,
   nil if otherwise
   
   */
  public init?(bytes:[UInt8]) {
    if bytes.count == 4 {
      self = .v4(bytes[0], bytes[1], bytes[2], bytes[3])
    } else if bytes.count == 16 {
      self = .v6(bytes[0], bytes[1], bytes[2], bytes[3],
                 bytes[4], bytes[5], bytes[6], bytes[7],
                 bytes[8], bytes[9], bytes[10], bytes[11],
                 bytes[12], bytes[13], bytes[14], bytes[15])
    } else {
      return nil
    }
  }
  
  public init?(string:String) {
    if let bytes = ({ (string:String) -> [UInt8]? in
      if let ipv4 = CIPv4Address(string:string) { return ipv4.bytes }
      if let ipv6 = CIPv6Address(string:string) { return ipv6.bytes }
      return nil
    })(string) {
      self.init(bytes:bytes)
    } else {
      return nil
    }
  }
}

extension IPAddress {
  /// Handles IPv4-Mapped Address
  public var isIPv4Mapped: Bool {
    guard case .v6(let bytes) = self else { return false }
    return (
      bytes.0 == 0 && bytes.1 == 0 && bytes.2 == 0 && bytes.3 == 0 &&
        bytes.4 == 0 && bytes.5 == 0 && bytes.6 == 0 && bytes.7 == 0 &&
        bytes.8 == 0 && bytes.9 == 0 && bytes.10 == UInt8(0xff) && bytes.11 == UInt8(0xff)
    )
  }
  public var v4Address: IPAddress? {
    if case .v4 = self { return self }
    guard self.isIPv4Mapped, case .v6(let bytes) = self else { return nil }
    return IPAddress(bytes:[bytes.12, bytes.13, bytes.14, bytes.15])!
  }
}

extension IPAddress: Hashable {
  public static func ==(lhs:IPAddress, rhs:IPAddress) -> Bool {
    switch (lhs, rhs) {
    case (.v4(let lBytes), .v4(let rBytes)): return lBytes == rBytes
    case (.v6(let lBytes), .v6(let rBytes)):
      return (
        lBytes.0 == rBytes.0 &&
          lBytes.1 == rBytes.1 &&
          lBytes.2 == rBytes.2 &&
          lBytes.3 == rBytes.3 &&
          lBytes.4 == rBytes.4 &&
          lBytes.5 == rBytes.5 &&
          lBytes.6 == rBytes.6 &&
          lBytes.7 == rBytes.7 &&
          lBytes.8 == rBytes.8 &&
          lBytes.9 == rBytes.9 &&
          lBytes.10 == rBytes.10 &&
          lBytes.11 == rBytes.11 &&
          lBytes.12 == rBytes.12 &&
          lBytes.13 == rBytes.13 &&
          lBytes.14 == rBytes.14 &&
          lBytes.15 == rBytes.15
      )
    case (.v4, .v6):
      guard let mapped = rhs.v4Address else { return false }
      return lhs == mapped
    case (.v6, .v4):
      guard let mapped = lhs.v4Address else { return false }
      return mapped == rhs
    }
  }
  
  public var hashValue: Int {
    switch self {
    case .v4(var bytes):
      return withUnsafePointer(to:&bytes) {
        return $0.withMemoryRebound(to:Int32.self, capacity:1) {
          return Int($0.pointee)
        }
      }
    case .v6(var bytes):
      if self.isIPv4Mapped { return self.v4Address!.hashValue }
      let nn = 16 / MemoryLayout<Int>.size
      return withUnsafePointer(to:&bytes) {
        return $0.withMemoryRebound(to:Int.self, capacity:nn) {
          var hash: Int = 0
          for ii in 0..<nn { hash ^= $0[ii] }
          return hash
        }
      }
    }
  }
}

extension IPAddress {
  fileprivate var _cIPAddress: CIPAddress {
    switch self {
    case .v4(let bytes):
      return CIPv4Address(bytes)
    case .v6(let bytes):
      return CIPv6Address(bytes)
    }
  }
  fileprivate var _cIPSocketAddress: CIPSocketAddress {
    switch self {
    case .v4:
      return CIPv4SocketAddress(ipAddress:self._cIPAddress as! CIPv4Address)!
    case .v6:
      return CIPv6SocketAddress(ipAddress:self._cIPAddress as! CIPv6Address)!
    }
  }
}

extension IPAddress: CustomStringConvertible {
  public var description: String {
    return self._cIPAddress.description
  }
}
