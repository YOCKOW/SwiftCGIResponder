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
import yExtensions
import yProtocols

/// Represents the client.
public final class Client {
  fileprivate let _standardInput: AnyFileHandle
  fileprivate let _environmentVariables: EnvironmentVariables
  
  private init<FH>(standardInput: FH, environmentVariables: EnvironmentVariables) where FH: FileHandleProtocol {
    self._standardInput = AnyFileHandle(standardInput)
    self._environmentVariables = environmentVariables
  }
  
  /// The client who is trying to access the server.
  public static let client: Client = Client(standardInput: FileHandle.standardInput,
                                            environmentVariables: EnvironmentVariables.default)
  
  internal static func virtual(environmentVariables: EnvironmentVariables) -> Client {
    return Client(standardInput: FileHandle.standardInput, environmentVariables: environmentVariables)
  }
  
  internal static func virtual<FH>(
    standardInput: FH,
    environmentVariables: EnvironmentVariables) -> Client where FH: FileHandleProtocol {
    return Client(standardInput: standardInput, environmentVariables: environmentVariables)
  }
}

extension Client {
  /// Returns whether connection is secure or not.
  public var connectionIsSecure: Bool {
    guard let https = self._environmentVariables["HTTPS"] else { return false }
    return https.lowercased() == "on"
  }

  /// Retuns client's content-length if request method is "POST" or something.
  public var contentLength: Int? {
    return self._environmentVariables["CONTENT_LENGTH"].flatMap(Int.init)
  }

  /// Retuns client's content-type if request method is "POST" or something.
  public var contentType: ContentType? {
    return self._environmentVariables["CONTENT_TYPE"].flatMap(ContentType.init)
  }
  
  /// Returns hostname of the client.
  /// If there is no value for `REMOTE_HOST` in environment variables,
  /// reverse DNS lookup will be tried internally.
  public var hostname: Domain? {
    if let remoteHost = self._environmentVariables["REMOTE_HOST"] {
      return Domain(remoteHost, options:.loose)
    }
    guard let ip = self.ipAddress else { return nil }
    return ip.domain // reverse lookup
  }
  
  /// Returns an instance of `IPAddress` generated from the value of `REMOTE_ADDR`.
  public var ipAddress: IPAddress? {
    return self._environmentVariables["REMOTE_ADDR"].flatMap(IPAddress.init)
  }
}

extension Client {
  /// Represents the client's request.
  public final class Request {
    fileprivate let _client: Client
    
    fileprivate var _standardInput: AnyFileHandle {
      return self._client._standardInput
    }
    
    fileprivate var _environmentVariables: EnvironmentVariables {
      return self._client._environmentVariables
    }
    
    fileprivate init(_ client: Client) {
      self._client = client
    }
  }
  
  /// The client's request.
  public var request: Request {
    return Request(self)
  }
}

extension Client.Request {
  /// An array of `CookieItem`s generated from the value of `HTTP_COOKIE`
  public func cookies(removingPercentEncoding:Bool = true) -> [HTTPCookieItem]? {
    guard let cookies_string = self._environmentVariables["HTTP_COOKIE"] else { return nil }
    
    var result:[HTTPCookieItem] = []
    
    let pair_strings = cookies_string.split(separator: ";").map {
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
  
  /// Returns an instance of `FormData`.
  /// - parameter temporaryDirectory: Temporary directory that will contain uploaded files temporarily
  ///
  /// ## Important notes
  /// * Calling this method more than once will return meaningless iterator.
  /// * The uploaded files may be lost unless copying them to another location,
  ///   because, the temporary directory will be removed at the end of program.
  public func formData(
    savingUploadedFilesIn temporaryDirectory:TemporaryDirectory
  ) throws -> FormData {
    guard
      let clientContentType = self._client.contentType,
      clientContentType.type == .multipart && clientContentType.subtype == "form-data",
      let clientContentTypeParameters = clientContentType.parameters,
      let boundary = clientContentTypeParameters["boundary"], !boundary.isEmpty else
    {
      throw FormData.Error.invalidRequest
    }
    
    let clientStringEncoding: String.Encoding = ({
      guard let charset = clientContentTypeParameters["charset"]  else { return .utf8 }
      guard let encoding = String.Encoding(ianaCharacterSetName:charset) else { return .utf8 }
      return encoding
    })()
    
    return try FormData(input: self._standardInput,
                        boundary: boundary,
                        stringEncoding: clientStringEncoding,
                        temporaryDirectory: temporaryDirectory)
  }
  
  /// Returns hostname of the client's request.
  public var hostname: Domain? {
    return self._environmentVariables["HTTP_HOST"].flatMap{ Domain($0, options: .loose) }
  }
  
  /// An array of ETags generated from the value of `HTTP_IF_MATCH`
  public var ifMatch: HTTPETagList? {
    guard let ifMatch_string = self._environmentVariables["HTTP_IF_MATCH"] else { return nil }
    return try? HTTPETagList(ifMatch_string)
  }
  
  /// A date generated from the value of `HTTP_IF_MODIFIED_SINCE`
  public var ifModifiedSince: Date? {
    return self._environmentVariables["HTTP_IF_MODIFIED_SINCE"].flatMap(DateFormatter.rfc1123.date(from:))
  }
  
  /// An array of ETags generated from the value of `HTTP_IF_NONE_MATCH`
  public var ifNoneMatch: HTTPETagList? {
    guard let ifNoneMatch_string = self._environmentVariables["HTTP_IF_NONE_MATCH"] else { return nil }
    return try? HTTPETagList(ifNoneMatch_string)
  }
  
  /// A date generated from the value of `HTTP_IF_UNMODIFIED_SINCE`
  public var ifUnmodifiedSince: Date? {
    return self._environmentVariables["HTTP_IF_UNMODIFIED_SINCE"].flatMap(DateFormatter.rfc1123.date(from:))
  }
  
  /// An instance of `HTTPMethod` generated from the value of `REQUEST_METHOD`
  public var method: HTTPMethod? {
    return self._environmentVariables["REQUEST_METHOD"].flatMap(HTTPMethod.init)
  }
  
  /// The value of "REQUEST_URI".
  public var path: String? {
    return self._environmentVariables["REQUEST_URI"]
  }
  
  /// The value of "PATH_INFO".
  public var pathInfo: String? {
    return self._environmentVariables["PATH_INFO"]
  }
  
  /// Retuns array of `URLQueryItem` generated from "QUERY_STRING" and
  /// posted data (if content type is "application/x-www-form-urlencoded").
  /// Inadequate items may be returned if other functions have already read the standard input.
  public var queryItems: [URLQueryItem]? {
    do {
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
        let inputData = try self._standardInput.read(upToCount: size)
        if let string = inputData.flatMap({ String(data: $0, encoding: .utf8) }) {
          result.append(contentsOf: try _parse(string))
        }
      }
      
      return result
    } catch {
      // TODO: Handle errors in some way.
      return nil
    }
  }
  
  /// The value of "QUERY_STRING".
  public var queryString: String? {
    guard let query = self._environmentVariables["QUERY_STRING"] else { return nil }
    if query.isEmpty {
      return self.uri?.last == "?" ? "" : nil
    }
    return query
  }
  
  /// The value of "HTTP_REFERER".
  public var referer: String? {
    return self._environmentVariables["HTTP_REFERER"]
  }
  
  /// The alias of `var referer: String? { get }`.
  @inlinable
  public var referrer: String? {
    return self.referer
  }
  
  /// The value of "REQUEST_URI"
  public var uri: String? {
    return self._environmentVariables["REQUEST_URI"]
  }
  
  /// The User Agent.
  public var userAgent: String? {
    return self._environmentVariables["HTTP_USER_AGENT"]
  }
}
