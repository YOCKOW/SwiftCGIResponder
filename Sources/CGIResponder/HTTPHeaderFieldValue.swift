/***************************************************************************************************
 HTTPHeaderFieldValue.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 
/**
 
 # HTTPHeaderFieldValue
 Represents for HTTP Header Field Value
 
 */

import Foundation

public struct HTTPHeaderFieldValue: RawRepresentable {
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

extension HTTPHeaderFieldValue: Hashable {
  public var hashValue: Int { return self.rawValue.hashValue }
  public static func ==(lhs:HTTPHeaderFieldValue, rhs:HTTPHeaderFieldValue) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}

