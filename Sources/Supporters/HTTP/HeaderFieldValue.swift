/* *************************************************************************************************
 HeaderFieldValue.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

/**
 
 # HeaderFieldValue
 Represents HTTP Header Field Value
 
 */
public struct HeaderFieldValue: RawRepresentable {
  public let rawValue : String
  public init?(rawValue:String) {
    if !rawValue.isEmpty {
      guard rawValue.consists(of:.httpHeaderFieldValueAllowed) &&
        UnicodeScalarSet.visibleCharacterUnicodeScalars.contains(rawValue.unicodeScalars.first!) &&
        UnicodeScalarSet.visibleCharacterUnicodeScalars.contains(rawValue.unicodeScalars.last!) else {
          return nil
      }
    }
    self.rawValue = rawValue
  }
}

extension HeaderFieldValue: Equatable {}

extension HeaderFieldValue: Hashable {
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.rawValue)
  }
  #else
  public var hashValue: Int {
    return self.rawValue.hashValue
  }
  #endif
}

