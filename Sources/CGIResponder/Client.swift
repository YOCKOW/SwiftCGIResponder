/* *************************************************************************************************
 Client.swift
   © 2017-2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
import Foundation
import NetworkGear
import TemporaryFile
import yProtocols

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
  
  /// Returns an instance of `FormData.Iterator`.
  /// - parameter temporaryDirectory: Temporary directory that will contain uploaded files temporarily
  ///
  /// ## Important notes
  /// * Calling this method more than once will return meaningless iterator.
  /// * The uploaded files may be lost unless copying them to another location,
  ///   because, the temporary directory will be removed at the end of program.
  public func formDataIterator(
    savingUploadedFilesIn temporaryDirectory:TemporaryDirectory
  ) throws -> FormData.Iterator {
    guard
      let clientContentType = self._client.contentType,
      clientContentType.type == .multipart && clientContentType.subtype == "form-data",
      let clientContentTypeParameters = clientContentType.parameters,
      let boundary = clientContentTypeParameters["boundary"], !boundary.isEmpty else
    {
      throw FormData.Iterator.Error.invalidRequest
    }
    
    let clientStringEncoding: String.Encoding = ({
      guard let charset = clientContentTypeParameters["charset"]  else { return .utf8 }
      guard let encoding = String.Encoding(ianaCharacterSetName:charset) else { return .utf8 }
      return encoding
    })()
    
    return try FormData.Iterator(boundary: boundary,
                                 stringEncoding: clientStringEncoding,
                                 temporaryDirectory: temporaryDirectory)
  }
  
  /// Returns hostname of the client's request.
  public var hostname: Domain? {
    return EnvironmentVariables.default["HTTP_HOST"].flatMap{ Domain($0, options: .loose) }
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
  
  /// The value of "REQUEST_URI".
  public var path: String? {
    return EnvironmentVariables.default["REQUEST_URI"]
  }
  
  /// The value of "PATH_INFO".
  public var pathInfo: String? {
    return EnvironmentVariables.default["PATH_INFO"]
  }
  
  internal func _queryItems<FH>(with input: FH) throws -> [URLQueryItem] where FH: FileHandleProtocol {
    func _parse(_ string: String) throws -> [URLQueryItem] {
      func _replaced<S>(_ string: S) -> String where S: StringProtocol {
        return string.replacingOccurrences(of: "+", with: " ")
      }
      
      var result: [URLQueryItem] = []
      let splitted = string.split { $0 == "&" || $0 == ";" }
      for item in splitted {
        let (name_raw, nilable_value_raw) = item.splitOnce(separator:"=")
        guard let name = _replaced(name_raw).removingPercentEncoding else {
          throw NSError(domain: "Invalid name: \(name_raw)", code: -1)
        }
        if let value_raw = nilable_value_raw.map({ _replaced($0) }) {
          guard let value = value_raw.removingPercentEncoding else {
            throw NSError(domain: "Invalid value: \(value_raw)", code: -1)
          }
          result.append(.init(name: name, value: value))
        } else {
          result.append(.init(name: name, value: nil))
        }
      }
      return result
    }
    
    let queryString = self.queryString ?? ""
    var result = try _parse(queryString)
    
    if let method = self.method,
      method == .post,
      let type = self._client.contentType,
      type.type == .application,
      type.subtype == "x-www-form-urlencoded",
      let size = self._client.contentLength,
      size > 0 {
      let inputData = try input.read(upToCount: size)
      if let string = inputData.flatMap({ String(data: $0, encoding: .utf8) }) {
        result.append(contentsOf: try _parse(string))
      }
    }
    
    return result
  }
  
  /// Retuns array of `URLQueryItem` generated from "QUERY_STRING" and
  /// posted data (if content type is "application/x-www-form-urlencoded").
  /// Inadequate items may be returned if other functions have already read the standard input.
  public var queryItems: [URLQueryItem]? {
    return try? self._queryItems(with: _changeableStandardInput)
  }
  
  /// The value of "QUERY_STRING".
  public var queryString: String? {
    return EnvironmentVariables.default["QUERY_STRING"]
  }
  
  /// The User Agent.
  public var userAgent: String? {
    return EnvironmentVariables.default["HTTP_USER_AGENT"]
  }
}
