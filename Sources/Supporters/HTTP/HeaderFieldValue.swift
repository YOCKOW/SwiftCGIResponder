/* *************************************************************************************************
 HeaderFieldValue.swift
   © 2017-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

private func _valid_value(_ value:String) -> Bool {
  return (
    value.consists(of:.httpHeaderFieldValueAllowed) &&
    UnicodeScalarSet.visibleCharacterUnicodeScalars.contains(value.unicodeScalars.first!) &&
    UnicodeScalarSet.visibleCharacterUnicodeScalars.contains(value.unicodeScalars.last!)
  ) ? true : false
}

/**
 
 # HeaderFieldValue
 Represents HTTP Header Field Value
 
 */
public struct HeaderFieldValue: RawRepresentable {
  public let rawValue : String
  public init?(rawValue:String) {
    if !rawValue.isEmpty {
      guard _valid_value(rawValue) else { return nil }
    }
    self.rawValue = rawValue
  }
}

extension HeaderFieldValue: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    guard _valid_value(value) else { fatalError("Invalid string: \(value)") }
    self.init(rawValue:value)!
  }
}

extension HeaderFieldValue: Equatable {}

extension HeaderFieldValue: Hashable {
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.rawValue)
  }
}

