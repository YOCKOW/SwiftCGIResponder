/* *************************************************************************************************
 Environment.swift
   © 2017-2021,2023,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import CNetworkGear
import Foundation
import NetworkGear
import TemporaryFile
import yExtensions

/// Represents an abstraction for an environment where the CGI program is executed.
///
/// This class is expected to be used for the purpose of some tests.
public final class Environment {
  /// Represents environment variables.
  public class Variables {
    private var _variables: [String: String]

    fileprivate init(_ variables: [String: String]) {
      _variables = variables
    }

    /// Accesses the environment variable for `name`
    public subscript(_ name: String) -> String? {
      get {
        return self._variables[name]
      }
      set {
        self._variables[name] = newValue
      }
    }

    /// Returns the names of environment variables
    public var names: Dictionary<String, String>.Keys {
      return self._variables.keys
    }

    /// Remove a value for `name`
    @discardableResult public func removeValue(forName name: String) -> String? {
      guard let value = self[name] else { return nil }
      self[name] = nil
      return value
    }

    internal final class _Virtual: Variables {}

    private final class _Process: Variables {
      init() {
        super.init(ProcessInfo.processInfo.environment)
      }

      override subscript(name: String) -> String? {
        get {
          return super[name]
        }
        set {
          let result: CInt = newValue.map({ setenv(name, $0, 1) }) ?? unsetenv(name)
          guard result == 0 else {
            switch errno {
            case EINVAL:
              fatalError("`\(name)` is invalid for environment variable name.")
            case ENOMEM:
              fatalError("Unable to allocate memory for the environment.")
            default:
              fatalError("Unable to set environment variable named \(name).")
            }
          }
          super[name] = newValue
        }
      }
    }

    /// Represents the variable names and their values in the environment
    /// from which the process was launched.
    public static let `default`: Variables = _Process()

    internal static func virtual(_ initialVariables: [String: String]) -> Variables {
      return _Virtual(initialVariables)
    }
  }

  internal let standardInput: AnyFileHandle
  internal let standardOutput: AnyFileHandle
  internal let standardError: AnyFileHandle

  /// Current environment variables.
  public let variables: Variables

  private init<STDIN, STDOUT, STDERR>(
    standardInput: STDIN,
    standardOutput: STDOUT,
    standardError: STDERR,
    variables: Variables
  ) where STDIN: FileHandleProtocol, STDOUT: FileHandleProtocol, STDERR: FileHandleProtocol {
    self.standardInput = AnyFileHandle(standardInput)
    self.standardOutput = AnyFileHandle(standardOutput)
    self.standardError = AnyFileHandle(standardError)
    self.variables = variables
  }
  
  /// Default environment.
  public static let `default`: Environment = .init(
    standardInput: FileHandle.standardInput,
    standardOutput: FileHandle.standardOutput,
    standardError: FileHandle.standardError,
    variables: .default
  )

  internal static func virtual<STDIN, STDOUT, STDERR>(
    standardInput: STDIN,
    standardOutput: STDOUT,
    standardError: STDERR,
    variables: Variables
  ) -> Environment where STDIN: FileHandleProtocol,
                         STDOUT: FileHandleProtocol,
                         STDERR: FileHandleProtocol {
    return .init(
      standardInput: standardInput,
      standardOutput: standardOutput,
      standardError: standardError,
      variables: variables
    )
  }

  internal static func virtual<STDIN, STDOUT>(
    standardInput: STDIN,
    standardOutput: STDOUT,
    variables: Variables
  ) -> Environment where STDIN: FileHandleProtocol, STDOUT: FileHandleProtocol {
    return .init(
      standardInput: standardInput,
      standardOutput: standardOutput,
      standardError: FileHandle.standardError,
      variables: variables
    )
  }

  internal static func virtual<STDIN>(
    standardInput: STDIN,
    variables: Variables
  ) -> Environment where STDIN: FileHandleProtocol {
    return .init(
      standardInput: standardInput,
      standardOutput: FileHandle.standardOutput,
      standardError: FileHandle.standardError,
      variables: variables
    )
  }

  internal static func virtual(variables: Variables) -> Environment {
    return .init(
      standardInput: FileHandle.standardInput,
      standardOutput: FileHandle.standardOutput,
      standardError: FileHandle.standardError,
      variables: variables
    )
  }
}

/// Represents environment variables.
public typealias EnvironmentVariables = Environment.Variables

/// Represents the client.
/// This is a kind of wrapper of the standard input and some environment variables.
public final class Client {
  private let _environment: Environment

  fileprivate init(environment: Environment) {
    _environment = environment
  }

  /// The client who is trying to access the server.
  @available(*, deprecated, message: "Use `Environment.default.client` instead.")
  public static let client: Client = Client(environment: .default)
}

extension Environment {
  /// The client information under this environment.
  public var client: Client {
    return Client(environment: self)
  }
}

extension Client {
  private var _environmentVariables: Environment.Variables {
    return _environment.variables
  }

  /// Returns the Boolean value that indicates whether or not connection is secure.
  public var connectionIsSecure: Bool {
    guard let https = _environmentVariables["HTTPS"] else { return false }
    return https.lowercased() == "on"
  }

  /// Retuns client's content-length if request method is "POST" or something.
  public var contentLength: Int? {
    return _environmentVariables["CONTENT_LENGTH"].flatMap(Int.init)
  }

  /// Retuns client's content-type if request method is "POST" or something.
  public var contentType: ContentType? {
    return _environmentVariables["CONTENT_TYPE"].flatMap(ContentType.init)
  }

  /// Returns hostname of the client.
  /// If there is no value for `REMOTE_HOST` in environment variables,
  /// reverse DNS lookup will be tried internally.
  public var hostname: Domain? {
    if let remoteHost = _environmentVariables["REMOTE_HOST"] {
      return Domain(remoteHost, options:.loose)
    }
    guard let ip = self.ipAddress else { return nil }
    return ip.domain // reverse lookup
  }

  /// Returns an instance of `IPAddress` generated from the value of `REMOTE_ADDR`.
  public var ipAddress: IPAddress? {
    return _environmentVariables["REMOTE_ADDR"].flatMap(IPAddress.init)
  }
}

extension Client {
  /// Represents the client's request.
  public final class Request {
    private let _client: Client

    private var _standardInput: AnyFileHandle {
      return _client._environment.standardInput
    }

    private var _environmentVariables: EnvironmentVariables {
      return _client._environmentVariables
    }

    fileprivate init(client: Client) {
      self._client = client
    }
  }

  /// The client's request.
  public var request: Request {
    return Request(client: self)
  }
}

extension Client.Request {
  /// An array of `HTTPCookieItem`s generated from the value of `HTTP_COOKIE`
  public func cookies(removingPercentEncoding: Bool = true) -> [HTTPCookieItem]? {
    guard let cookiesString = _environmentVariables["HTTP_COOKIE"] else { return nil }

    var result:[HTTPCookieItem] = []


    func __trim(_ string: Substring) -> Substring {
      let isWhitespaceOrNewline = { (character: Character) -> Bool in character.isWhitespace || character.isNewline  }
      guard let firstIndex = string.firstIndex(where: { !isWhitespaceOrNewline($0) }),
            let lastIndex = string.lastIndex(where: { !isWhitespaceOrNewline($0) }) else {
        return ""
      }
      return string[firstIndex...lastIndex]
    }

    let pairStrings = cookiesString.split(separator: ";").map(__trim)
    for pairString in pairStrings {
      guard let item = HTTPCookieItem(
        string: String(pairString),
        removingPercentEncoding: removingPercentEncoding
      ) else {
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
    savingUploadedFilesIn temporaryDirectory: TemporaryDirectory
  ) throws -> FormData {
    guard
      let clientContentType = _client.contentType,
      clientContentType.type == .multipart && clientContentType.subtype == "form-data",
      let clientContentTypeParameters = clientContentType.parameters,
      let boundary = clientContentTypeParameters["boundary"], !boundary.isEmpty
    else {
      throw FormData.Error.invalidRequest
    }

    let clientStringEncoding: String.Encoding = ({
      guard let charset = clientContentTypeParameters["charset"]  else { return .utf8 }
      guard let encoding = String.Encoding(ianaCharacterSetName: charset) else { return .utf8 }
      return encoding
    })()

    return try FormData(input: _standardInput,
                        boundary: boundary,
                        stringEncoding: clientStringEncoding,
                        temporaryDirectory: temporaryDirectory)
  }

  public enum JSONDecodingError: Swift.Error {
    case invalidRequest
    case missingRequestBody
  }

  public static let defaultJSONDecoder: JSONDecoder = .init()

  /// Decode posted JSON.
  ///
  /// - Returns: An instance of `T`
  public func decodeJSON<T>(
    as type: T.Type,
    decoder: JSONDecoder = defaultJSONDecoder
  ) throws -> T where T: Decodable {
    guard let clientContentType = _client.contentType,
          clientContentType.type == .application,
          clientContentType.subtype == "json" else {
      throw JSONDecodingError.invalidRequest
    }
    guard let requestBody = try _standardInput.readToEnd() else {
      throw JSONDecodingError.missingRequestBody
    }
    return try decoder.decode(T.self, from: requestBody)
  }

  /// Returns hostname of the client's request.
  public var hostname: Domain? {
    return _environmentVariables["HTTP_HOST"].flatMap{ Domain($0, options: .loose) }
  }

  /// An array of ETags generated from the value of `HTTP_IF_MATCH`
  public var ifMatch: HTTPETagList? {
    guard let ifMatchString = _environmentVariables["HTTP_IF_MATCH"] else { return nil }
    return try? HTTPETagList(ifMatchString)
  }

  /// A date generated from the value of `HTTP_IF_MODIFIED_SINCE`
  public var ifModifiedSince: Date? {
    return _environmentVariables["HTTP_IF_MODIFIED_SINCE"].flatMap(DateFormatter.rfc1123.date(from:))
  }

  /// An array of ETags generated from the value of `HTTP_IF_NONE_MATCH`
  public var ifNoneMatch: HTTPETagList? {
    guard let ifNoneMatchString = _environmentVariables["HTTP_IF_NONE_MATCH"] else { return nil }
    return try? HTTPETagList(ifNoneMatchString)
  }

  /// A date generated from the value of `HTTP_IF_UNMODIFIED_SINCE`
  public var ifUnmodifiedSince: Date? {
    return _environmentVariables["HTTP_IF_UNMODIFIED_SINCE"].flatMap(DateFormatter.rfc1123.date(from:))
  }

  /// An instance of `HTTPMethod` generated from the value of `REQUEST_METHOD`
  public var method: HTTPMethod? {
    return _environmentVariables["REQUEST_METHOD"].flatMap(HTTPMethod.init)
  }

  /// The value of "REQUEST_URI".
  public var path: String? {
    return _environmentVariables["REQUEST_URI"]
  }

  /// The value of "PATH_INFO".
  public var pathInfo: String? {
    return _environmentVariables["PATH_INFO"]
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
    guard let query = _environmentVariables["QUERY_STRING"] else { return nil }
    if query.isEmpty {
      return self.uri?.last == "?" ? "" : nil
    }
    return query
  }

  /// The value of "HTTP_REFERER".
  public var referer: String? {
    return _environmentVariables["HTTP_REFERER"]
  }

  /// The alias of `var referer: String? { get }`.
  @inlinable
  public var referrer: String? {
    return referer
  }

  /// The value of "REQUEST_URI"
  public var uri: String? {
    return _environmentVariables["REQUEST_URI"]
  }

  /// The User Agent.
  public var userAgent: String? {
    return _environmentVariables["HTTP_USER_AGENT"]
  }
}

/// Represents server (information).
public class Server {
  private let _environment: Environment

  fileprivate init(environment: Environment) {
    _environment = environment
  }

  @available(*, deprecated, message: "Use `Environment.default.server` instead.")
  public static let server = Server(environment: .default)
}

extension Environment {
  /// The server information under this environment.
  public var server: Server {
    return Server(environment: self)
  }
}

extension Server {
  private var _environmentVariables: Environment.Variables {
    return _environment.variables
  }

  /// Returns server's hostname
  public var hostname: Domain? {
    if let serverHost = _environmentVariables["SERVER_NAME"] {
      return Domain(serverHost, options: .loose)
    }
    guard let ip = self.ipAddress else { return nil }
    return ip.domain // reverse lookup
  }

  /// Returns server's IP address.
  public var ipAddress: IPAddress? {
    return _environmentVariables["SERVER_ADDR"].flatMap(IPAddress.init(string:))
  }

  /// Server's port.
  public var port: CSocketPortNumber? {
    return _environmentVariables["SERVER_PORT"].flatMap(CSocketPortNumber.init)
  }

  /// Returns the value of environment variable for "SCRIPT_NAME".
  public var scriptName: String? {
    return _environmentVariables["SCRIPT_NAME"]
  }

  /// Returns string of server software.
  public var software: String? {
    return _environmentVariables["SERVER_SOFTWARE"]
  }
}


