/***************************************************************************************************
 Client.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # Client
 Represents for the client.
 
 */
public class Client {
  public static let client = Client()
  private init() {}
}

extension Client {
  /// Returns whether connection is secure or not.
  public var connectionIsSecure: Bool {
    guard case let secure as Bool = EnvironmentVariables.default[.https] else { return false }
    return secure
  }
  
  /// Retuns client's content-length if request method is "POST" or something.
  public var contentLength: Int? {
    return EnvironmentVariables.default[.contentLength] as! Int?
  }
  
  /// Retuns client's content-type if request method is "POST" or something.
  public var contentType: MIMEType? {
    return EnvironmentVariables.default[.contentType] as! MIMEType?
  }
  
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
  
  /// Retuns array of `URLQueryItem` generated from "QUERY_STRING" and
  /// posted data (if content type is "application/x-www-form-urlencoded").
  /// Inadequate items may be returned if other functions have already read standard input.
  public var queryItems: [URLQueryItem]? {
    guard case let queryString as String = EnvironmentVariables.default[.queryString] else { return nil }
    var result = Array<URLQueryItem>(string:queryString)
    
    // Handle Posted Data
    if let method = self.requestMethod, method == .post,
      let type = self.contentType, type.type == .application, type.subtype == "x-www-form-urlencoded",
      let size = self.contentLength, size > 0
    {
      let data = FileHandle.standardInput.readData(ofLength:size)
      if let string = String(data:data, encoding:.utf8) {
        let additionals = Array<URLQueryItem>(string:string)
        if result == nil {
          return additionals
        } else if additionals != nil {
          result!.append(contentsOf:additionals!)
        }
      }
    }
    
    return result
  }
  
  /// Returns an instance of `HTTPMethod` generated from the value of `REQUEST_METHOD`
  public var requestMethod: HTTPMethod? {
    return EnvironmentVariables.default[.requestMethod] as! HTTPMethod?
  }
  
  /// Returns user agent.
  public var userAgent: String? {
    return EnvironmentVariables.default[.httpUserAgent] as! String?
  }
}
