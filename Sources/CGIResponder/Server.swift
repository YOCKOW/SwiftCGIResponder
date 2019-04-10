/* *************************************************************************************************
 Server.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import NetworkGear

/// Represents server (information)
public class Server {
  private init() {}
  public static let server = Server()
}

extension Server {
  /// Returns server's hostname
  public var hostname: Domain? {
    if let serverHost = EnvironmentVariables.default["SERVER_NAME"] {
      return Domain(serverHost, options:.loose)
    }
    guard let ip = self.ipAddress else { return nil }
    return ip.domain // reverse lookup
  }
  
  /// Returns server's IP address.
  public var ipAddress: IPAddress? {
    return IPAddress(string:EnvironmentVariables.default["SERVER_ADDR"] ?? "?")
  }
  
  /// Server's port.
  public var port: CSocketPortNumber? {
    return CSocketPortNumber(EnvironmentVariables.default["SERVER_PORT"] ?? "?")
  }
  
  /// Returns string of server software.
  public var software: String? {
    return EnvironmentVariables.default["SERVER_SOFTWARE"]
  }
}


