/***************************************************************************************************
 Hostname.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # Hostname
 Represents for hostname.
 
 */
public struct Hostname {
  internal let _domainName: String
  public init?(_ string:String) {
    guard let converted = URL.convert(domain:string) else { return nil }
    guard IPAddress(string:converted) == nil else { return nil }
    self._domainName = converted // always lowercased
  }
}

extension Hostname: Hashable {
  public static func ==(lhs:Hostname, rhs:Hostname) -> Bool {
    return lhs._domainName == rhs._domainName
  }
  public var hashValue: Int { return self._domainName.hashValue }
}

extension Hostname: CustomStringConvertible {
  public var description: String { return self._domainName }
}

extension Hostname {
  public var internationalDomainName: String {
    return URL.convert(domain:self._domainName, addingPunycodeEncoding:false)!
  }
}

extension Hostname {
  /// [Domain Matching](https://tools.ietf.org/html/rfc6265#section-5.1.3)
  /// Used by cookies
  public func domainMatches(_ another:Hostname) -> Bool {
    if self._domainName == another._domainName { return true }
    // self._domainName is not an IP Address
    return self._domainName.hasSuffix(".\(another._domainName)")
  }
}

extension Hostname {
  /// DNS Lookup
  public var ipAddresses: [IPAddress] {
    var results: [IPAddress] = []
    
    var hints = CAddressInfo()
    hints.options = .none
    hints.family = .unspecified
    hints.socketType = .stream
    
    var results_pp = UnsafeMutablePointer<UnsafeMutablePointer<CAddressInfo>?>.allocate(capacity:1)
    defer { results_pp.deallocate(capacity:1) }
    
    guard getaddrinfo(self._domainName, "http", &hints, results_pp) == 0 else { return [] }
    defer { freeaddrinfo(results_pp.pointee) }
    
    var info: CAddressInfo? = results_pp.pointee?.pointee // first one
    while true {
      if info == nil { break }
      defer { info = info!.next }
      
      guard let socketAddress = info!.socketAddress else { return [] }
      guard socketAddress is CIPSocketAddress else { return [] }
      guard let ipAddress = IPAddress(bytes:(socketAddress as! CIPSocketAddress).ipAddress.bytes) else { return [] }
      results.append(ipAddress)
    }
    
    return results
  }
}

