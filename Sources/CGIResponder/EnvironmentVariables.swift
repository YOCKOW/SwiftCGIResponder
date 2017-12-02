/***************************************************************************************************
 EnvironmentVariables.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # EnvironmentVariables
 Represents for Environment Variables
 
 */
final public class EnvironmentVariables {
  public static let `default` = EnvironmentVariables()
  fileprivate var _environmentVariables: [String:String] = ProcessInfo.processInfo.environment
  private init() {}
  
  /// Get and Set an environment variable for `name`
  public subscript(name:String) -> String? {
    get { return self._environmentVariables[name] }
    set {
      var result : CInt
      if let value = newValue {
        result = setenv(name, value, 1)
        if result == 0 { self._environmentVariables[name] = value }
      } else {
        result = unsetenv(name)
        if result == 0 { self._environmentVariables.removeValue(forKey:name) }
      }
      if result != 0 {
        switch errno {
        case EINVAL:
          warn("`\(name)` is invalid for environment variable name.")
        //throw CGIResponderError.invalidArgument
        case ENOMEM:
          warn("Unable to allocate memory for the environment.")
        //throw CGIResponderError.unexpectedError(message:"Unable to allocate memory for the environment.")
        default:
          warn("Unable to set environment variable named \(name).")
          //throw CGIResponderError.unexpectedError(message:"Unable to set environment variable named \(name).")
        }
      }
    }
  }
  
  /// Just returns keys of environment variables
  public var names: Dictionary<String, String>.Keys {
    return self._environmentVariables.keys
  }
  
  /// Remove a value for `name`
  @discardableResult public func removeValue(forName name:String) -> String? {
    let value = self[name]
    self[name] = nil
    return value
  }
}

extension EnvironmentVariables: Sequence {
  public func makeIterator() -> DictionaryIterator<String,String> {
    return self._environmentVariables.makeIterator()
  }
}


extension EnvironmentVariables {
  /**
   
   ## EnvironmentVariables.Name
   Wrapper for variable's name.
   
   */
  public struct Name: RawRepresentable {
    public let rawValue: String
    public init(rawValue:String) { self.rawValue = rawValue }
  }
}

extension EnvironmentVariables.Name: Hashable {
  public var hashValue: Int { return self.rawValue.hashValue }
  public static func == (lhs:EnvironmentVariables.Name, rhs:EnvironmentVariables.Name) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}

extension EnvironmentVariables.Name {
  public static let contentLength = EnvironmentVariables.Name(rawValue:"CONTENT_LENGTH")
  public static let contentType = EnvironmentVariables.Name(rawValue:"CONTENT_TYPE")
  public static let currentWorkingDirectory = EnvironmentVariables.Name(rawValue:"PWD")
  public static let documentRoot = EnvironmentVariables.Name(rawValue:"DOCUMENT_ROOT")
  public static let gatewayInterface = EnvironmentVariables.Name(rawValue:"GATEWAY_INTERFACE")
  public static let home = EnvironmentVariables.Name(rawValue:"HOME")
  public static let httpAccept = EnvironmentVariables.Name(rawValue:"HTTP_ACCEPT")
  public static let httpAcceptCharacterSet = EnvironmentVariables.Name(rawValue:"HTTP_ACCEPT_CHARSET")
  public static let httpAcceptEncoding = EnvironmentVariables.Name(rawValue:"HTTP_ACCEPT_ENCODING")
  public static let httpAcceptLanguage = EnvironmentVariables.Name(rawValue:"HTTP_ACCEPT_LANGUAGE")
  public static let httpConnection = EnvironmentVariables.Name(rawValue:"HTTP_CONNECTION")
  public static let httpCookie = EnvironmentVariables.Name(rawValue:"HTTP_COOKIE")
  public static let httpHost = EnvironmentVariables.Name(rawValue:"HTTP_HOST")
  public static let httpIfMatch = EnvironmentVariables.Name(rawValue:"HTTP_IF_MATCH")
  public static let httpIfModifiedSince = EnvironmentVariables.Name(rawValue:"HTTP_IF_MODIFIED_SINCE")
  public static let httpIfNoneMatch = EnvironmentVariables.Name(rawValue:"HTTP_IF_NONE_MATCH")
  public static let httpIfUnmodifiedSince = EnvironmentVariables.Name(rawValue:"HTTP_IF_UNMODIFIED_SINCE")
  public static let httpReferrer = EnvironmentVariables.Name(rawValue:"HTTP_REFERER")
  public static let httpUserAgent = EnvironmentVariables.Name(rawValue:"HTTP_USER_AGENT")
  public static let https = EnvironmentVariables.Name(rawValue:"HTTPS")
  public static let path = EnvironmentVariables.Name(rawValue:"PATH")
  public static let pathInfo = EnvironmentVariables.Name(rawValue:"PATH_INFO")
  public static let pathTranslated = EnvironmentVariables.Name(rawValue:"PATH_TRANSLATED")
  public static let queryString = EnvironmentVariables.Name(rawValue:"QUERY_STRING")
  public static let remoteAddress = EnvironmentVariables.Name(rawValue:"REMOTE_ADDR")
  public static let remoteHost = EnvironmentVariables.Name(rawValue:"REMOTE_HOST")
  public static let remotePort = EnvironmentVariables.Name(rawValue:"REMOTE_PORT")
  public static let remoteUser = EnvironmentVariables.Name(rawValue:"REMOTE_USER")
  public static let requestMethod = EnvironmentVariables.Name(rawValue:"REQUEST_METHOD")
  public static let requestURI = EnvironmentVariables.Name(rawValue:"REQUEST_URI")
  public static let scriptFilename = EnvironmentVariables.Name(rawValue:"SCRIPT_FILENAME")
  public static let scriptName = EnvironmentVariables.Name(rawValue:"SCRIPT_NAME")
  public static let serverAddress = EnvironmentVariables.Name(rawValue:"SERVER_ADDR")
  public static let serverAdministrator = EnvironmentVariables.Name(rawValue:"SERVER_ADMIN")
  public static let serverName = EnvironmentVariables.Name(rawValue:"SERVER_NAME")
  public static let serverPort = EnvironmentVariables.Name(rawValue:"SERVER_PORT")
  public static let serverProtocol = EnvironmentVariables.Name(rawValue:"SERVER_PROTOCOL")
  public static let serverSignature = EnvironmentVariables.Name(rawValue:"SERVER_SIGNATURE")
  public static let serverSoftware = EnvironmentVariables.Name(rawValue:"SERVER_SOFTWARE")
}

extension EnvironmentVariables {
  private static let contentTypeConverter: (String) -> MIMEType? = { MIMEType($0) }
  private static let cookieConverter: (String) -> [HTTPCookieItem]? = {
    Array<HTTPCookieItem>(string:$0)
  }
  private static let dateConverter: (String) -> Date? = { DateFormatter.rfc1123.date(from:$0) }
  private static let eTagListConverter: (String) -> [HTTPETag]? = { Array<HTTPETag>(string:$0) }
  private static let fileURLConverter: (String) -> URL? = { URL(fileURLWithPath:$0) }
  private static let hostnameConverter: (String) -> Hostname? = {
    let actualHost:String = ({ (nameAndPort:String) -> String in
      if let indexOfColon = nameAndPort.lastIndex(of:":") {
        return String(nameAndPort[nameAndPort.startIndex ..< indexOfColon])
      } else {
        return nameAndPort
      }
    })($0)
    return Hostname(actualHost)
  }
  private static let ipAddressConverter: (String) -> IPAddress? = { IPAddress(string:$0) }
  private static let intConverter: (String) -> Int? = { Int($0) }
  private static let urlConverter: (String) -> URL? = { URL(string:$0) }
  public static var converters: [EnvironmentVariables.Name:(String) -> Any?] = [
    .contentLength:intConverter,
    .contentType:contentTypeConverter,
    .documentRoot:fileURLConverter,
    .httpCookie:cookieConverter,
    .httpHost:hostnameConverter,
    .httpIfMatch:eTagListConverter,
    .httpIfModifiedSince:dateConverter,
    .httpIfNoneMatch:eTagListConverter,
    .httpIfUnmodifiedSince:dateConverter,
    .httpReferrer:urlConverter,
    .https:{ $0.lowercased() == "on" },
    .path:{ $0.components(separatedBy:":").map{ URL(fileURLWithPath:$0) } },
    .pathTranslated:fileURLConverter,
    .remoteAddress:ipAddressConverter,
    .remoteHost:hostnameConverter,
    .remotePort:intConverter,
    .requestMethod:{ HTTPMethod(rawValue:$0.uppercased()) },
    .scriptFilename:fileURLConverter,
    .serverAddress:ipAddressConverter,
    .serverName:hostnameConverter,
    .serverPort:intConverter
  ]
}

extension EnvironmentVariables {
  /// Get a CONVERTED value of environment variable for `name`
  /// which is an instance of `EnvironmentVariables.Name`.
  public subscript(name:EnvironmentVariables.Name) -> Any? {
    guard let value = self[name.rawValue] else { return nil }
    guard let converter = EnvironmentVariables.converters[name] else { return value }
    return converter(value)
  }
}
