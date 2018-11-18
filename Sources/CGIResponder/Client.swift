/* *************************************************************************************************
 Client.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import HTTP
import Network

/// Represents the client.
public final class Client {
  private init() {}
  public static let client = Client()
}

extension Client {
  /// Returns whether connection is secure or not.
  public var connectionIsSecure: Bool {
    guard let https = EnvironmentVariables.default["HTTPS"] else { return false }
    return https.lowercased() == "on"
  }

  /// Retuns client's content-length if request method is "POST" or something.
  public var contentLength: Int? {
    return Int(EnvironmentVariables.default["CONTENT_LENGTH"] ?? "?")
  }

  /// Retuns client's content-type if request method is "POST" or something.
  public var contentType: ContentType? {
    return ContentType(EnvironmentVariables.default["CONTENT_TYPE"] ?? "?")
  }
  
  /// Returns hostname of the client.
  /// If there is no value for `REMOTE_HOST` in environment variables,
  /// reverse DNS lookup will be tried internally.
  public var hostname: Domain? {
    if let remoteHost = EnvironmentVariables.default["REMOTE_HOST"] {
      return Domain(remoteHost, options:.loose)
    }
    guard let ip = self.ipAddress else { return nil }
    return ip.domain // reverse lookup
  }
  
  /// Returns an instance of `IPAddress` generated from the value of `REMOTE_ADDR`.
  public var ipAddress: IPAddress? {
    return IPAddress(string:EnvironmentVariables.default["REMOTE_ADDR"] ?? "?")
  }
}

extension Client {
  public final class Request {
    private init() {}
    fileprivate static let _request = Request()
  }
  public var request: Request { return ._request }
}

extension Client.Request {
  /// An array of ETags generated from the value of `HTTP_IF_MATCH`
  public var ifMatch: HTTPETagList? {
    guard let ifMatch_string = EnvironmentVariables.default["HTTP_IF_MATCH"] else { return nil }
    return try? HTTPETagList(ifMatch_string)
  }
  
  /// A date generated from the value of `HTTP_IF_MODIFIED_SINCE`
  public var ifModifiedSince: Date? {
    guard let ifModifiedSince_string = EnvironmentVariables.default["HTTP_IF_MODIFIED_SINCE"] else {
      return nil
    }
    return DateFormatter.rfc1123.date(from:ifModifiedSince_string)
  }
  
  /// An array of ETags generated from the value of `HTTP_IF_NONE_MATCH`
  public var ifNoneMatch: HTTPETagList? {
    guard let ifNoneMatch_string = EnvironmentVariables.default["HTTP_IF_NONE_MATCH"] else { return nil }
    return try? HTTPETagList(ifNoneMatch_string)
  }
  
  /// A date generated from the value of `HTTP_IF_UNMODIFIED_SINCE`
  public var ifUnmodifiedSince: Date? {
    guard let ifUnmodifiedSince_string = EnvironmentVariables.default["HTTP_IF_UNMODIFIED_SINCE"] else {
      return nil
    }
    return DateFormatter.rfc1123.date(from:ifUnmodifiedSince_string)
  }
  
  /// An instance of `HTTPMethod` generated from the value of `REQUEST_METHOD`
  public var method: HTTPMethod? {
    return HTTPMethod(rawValue:EnvironmentVariables.default["REQUEST_METHOD"] ?? "?")
  }
  
  /// The User Agent.
  public var userAgent: String? {
    return EnvironmentVariables.default["HTTP_USER_AGENT"]
  }
}
