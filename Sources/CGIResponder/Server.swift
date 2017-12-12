/***************************************************************************************************
 Server.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # Server
 Represents the server.
 
 */
public class Server {
  public static let server = Server()
  private init() {}
}

extension Server {
  /// Returns server's hostname
  public var hostname: Hostname? {
    return EnvironmentVariables.default[.serverName] as! Hostname?
  }
  
  /// Returns server's IP address.
  public var ipAddress: IPAddress? {
    return EnvironmentVariables.default[.serverAddress] as! IPAddress?
  }
  
  /// Returns string of server software.
  public var software: String? {
    return EnvironmentVariables.default[.serverSoftware] as! String?
  }
}

