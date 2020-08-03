/* *************************************************************************************************
 Server.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

/// Represents server (information)
public class Server {
  fileprivate let _environmentVariables: EnvironmentVariables
  
  private init(environmentVariables: EnvironmentVariables) {
    self._environmentVariables = environmentVariables
  }
  
  public static let server = Server(environmentVariables: EnvironmentVariables.default)
  
  internal static func virtual(environmentVariables: EnvironmentVariables) -> Server {
    return Server(environmentVariables: environmentVariables)
  }
}

extension Server {
  /// Returns server's hostname
  public var hostname: Domain? {
    if let serverHost = self._environmentVariables["SERVER_NAME"] {
      return Domain(serverHost, options:.loose)
    }
    guard let ip = self.ipAddress else { return nil }
    return ip.domain // reverse lookup
  }
  
  /// Returns server's IP address.
  public var ipAddress: IPAddress? {
    return self._environmentVariables["SERVER_ADDR"].flatMap(IPAddress.init(string:))
  }
  
  /// Server's port.
  public var port: CSocketPortNumber? {
    return self._environmentVariables["SERVER_PORT"].flatMap(CSocketPortNumber.init)
  }
  
  /// Returns the value of environment variable for "SCRIPT_NAME".
  public var scriptName: String? {
    return self._environmentVariables["SCRIPT_NAME"]
  }
  
  /// Returns string of server software.
  public var software: String? {
    return self._environmentVariables["SERVER_SOFTWARE"]
  }
}


