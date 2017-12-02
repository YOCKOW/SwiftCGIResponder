/***************************************************************************************************
 Client.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # Client
 Represents for the client.
 
 */
public class Client {
  public static let client = Client()
  private init() {}
}

extension Client {
  /// Returns array of instances of `HTTPCookieItem`
  /// generated from `HTTP_COOKIE` of environment variables.
  public var cookies: [HTTPCookieItem]? {
    return EnvironmentVariables.default[.httpCookie] as! [HTTPCookieItem]?
  }
  
  /// Returns hostname of the client.
  /// If there is no value for `REMOTE_HOST`, reverse DNS lookup will be tried internally.
  public var hostname: Hostname? {
    if let remoteHost = EnvironmentVariables.default[.remoteHost] {
      return (remoteHost as! Hostname)
    }
    guard let ip = self.ipAddress else { return nil }
    return ip.hostname // reverse lookup
  }
  
  /// Returns an instance of `IPAddress` generated from the value of `REMOTE_ADDR`.
  public var ipAddress: IPAddress? {
    return EnvironmentVariables.default[.remoteAddress] as! IPAddress?
  }
}
