/***************************************************************************************************
 URL.Host.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension URL {
  /**
   
   # URL.Host
   Wraps the host component of URL
   
   */
  public enum Host: Hashable, CustomStringConvertible {
    case name(Hostname)
    case ipAddress(IPAddress)
    
    public static func ==(lhs:Host, rhs:Host) -> Bool {
      switch (lhs, rhs) {
      case (.name(let lName), .name(let rName)): return lName == rName
      case (.ipAddress(let lIP), .ipAddress(let rIP)): return lIP == rIP
      default: return false
      }
    }
    
    public var hashValue: Int {
      switch self {
      case .name(let name): return name.hashValue
      case .ipAddress(let ip): return ip.hashValue
      }
    }
    
    public var description: String {
      switch self {
      case .name(let name): return name.description
      case .ipAddress(let ip): return ip.description
      }
    }
    
    public init?(string:String) {
      if let ip = IPAddress(string:string) {
        self = .ipAddress(ip)
      } else if let host = Hostname(string) {
        self = .name(host)
      } else {
        return nil
      }
    }
  }
  
  public var hostComponent: Host? {
    guard let host = self.host else { return nil }
    return Host(string:host)
  }
}

