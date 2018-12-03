/* *************************************************************************************************
 Client.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
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
    fileprivate weak var _client: Client!
    fileprivate init(_ client:Client) { self._client = client }
  }
  public var request: Request { return Request(self) }
}

extension Client.Request {
  /// An array of `CookieItem`s generated from the value of `HTTP_COOKIE`
  public func cookies(removingPercentEncoding:Bool = true) -> [HTTPCookieItem]? {
    guard let cookies_string = EnvironmentVariables.default["HTTP_COOKIE"] else { return nil }
    
    var result:[HTTPCookieItem] = []
    
    let pair_strings = cookies_string.components(separatedBy:";").map {
      $0.trimmingUnicodeScalars(in:.whitespaces)
    }
    for pair_string in pair_strings {
      guard let item =
        HTTPCookieItem(string:pair_string, removingPercentEncoding:removingPercentEncoding) else
      {
        return nil
      }
      result.append(item)
    }
    return result
  }
  
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
  
  /// Retuns array of `URLQueryItem` generated from "QUERY_STRING" and
  /// posted data (if content type is "application/x-www-form-urlencoded").
  /// Inadequate items may be returned if other functions have already read the standard input.
  public var queryItems: [URLQueryItem]? {
    func _parse(_ string:String) -> [URLQueryItem] {
      var result: [URLQueryItem] = []
      
      // First, replace "+" with " "
      // Separator may be "&" or ";"
      let separator = UnicodeScalarSet(unicodeScalarsIn:"&;")
      let queryItemStrings = string.replacingOccurrences(of:"+", with:" ").components(separatedBy:separator)
      for queryItemString in queryItemStrings {
        let (name_raw, nilable_value_raw) = queryItemString.splitOnce(separator:"=")
        guard let name = name_raw.removingPercentEncoding else { continue }
        if let value_raw = nilable_value_raw {
          guard let value = value_raw.removingPercentEncoding else { continue }
          result.append(URLQueryItem(name:name, value:value))
        } else {
          result.append(URLQueryItem(name:name, value:nil))
        }
      }
      
      return result
    }
    
    guard let queryString = EnvironmentVariables.default["QUERY_STRING"] else {
      return nil
    }
    var result = _parse(queryString)
    
    // Handle Posted Data
    if let method = self.method, method == .post,
      let type = self._client.contentType,
          type.type == .application, type.subtype == "x-www-form-urlencoded",
      let size = self._client.contentLength, size > 0
    {
      let data = FileHandle._changeableStandardInput.readData(ofLength:size)
      if let string = String(data:data, encoding:.utf8) {
        result.append(contentsOf:_parse(string))
      }
    }
    
    return result
  }
  
  /// The User Agent.
  public var userAgent: String? {
    return EnvironmentVariables.default["HTTP_USER_AGENT"]
  }
}
