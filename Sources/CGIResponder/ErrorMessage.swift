/* *************************************************************************************************
 ErrorMessage.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import LibExtender

public struct ErrorMessage: RawRepresentable {
  public let rawValue: String
  public init(rawValue:String) { self.rawValue = rawValue }
}

public func warn(message:ErrorMessage) {
  warn(message.rawValue)
}

extension ErrorMessage: ExpressibleByStringLiteral {
  public typealias StringLiteralType = String
  public init(stringLiteral value:String) {
    self.init(rawValue:value)
  }
}

extension ErrorMessage: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    return self.rawValue
  }
  
  public var debugDescription: String {
    return self.rawValue
  }
}

extension ErrorMessage {
  internal static func statusCodeInconsistency(_ actual:HTTPStatusCode,
                                               _ expected:HTTPStatusCode) -> ErrorMessage {
    return ErrorMessage(rawValue:
      "The current status code is \(actual), although expected status code is \(expected)."
    )
  }
  
  internal static func stringEncodingInconsistency(_ actual:String.Encoding,
                                                   _ expected:String.Encoding) -> ErrorMessage {
    return ErrorMessage(rawValue:
      "\(actual) has been passed, although expected encoding is \(expected)."
    )
  }
}
