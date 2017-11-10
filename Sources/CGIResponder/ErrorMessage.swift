/***************************************************************************************************
 ErrorMessage.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # ErrorMessage
 Internal use for error messages.
 
 */
internal struct ErrorMessage: RawRepresentable {
  let rawValue: String
  init(_ string:String) { self.rawValue = string }
  init(rawValue string:String) { self.init(string) }
}

internal func viewMessage(_ message:ErrorMessage) {
  warn(message.rawValue)
}

extension ErrorMessage: CustomStringConvertible, CustomDebugStringConvertible {
  var description: String {
    return self.rawValue
  }
  var debugDescription: String {
    return self.rawValue
  }
}

extension ErrorMessage {
  static func stringEncodingInconsistency(_ actual:String.Encoding, _ expected:String.Encoding) -> ErrorMessage {
    return ErrorMessage("\(actual) has been passed, although expected encoding is \(expected).")
  }
}
