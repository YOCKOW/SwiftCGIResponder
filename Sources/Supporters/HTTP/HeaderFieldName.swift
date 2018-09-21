/* *************************************************************************************************
 HeaderFieldName.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

 /**
 
 # HeaderFieldName
 Represents HTTP Header Field Name
 
 */
public struct HeaderFieldName: RawRepresentable {
  public let rawValue : String
  private let lowercasedRawValue : String
  
  public init?(rawValue:String) {
    if rawValue.isEmpty { return nil }
    guard rawValue.consists(of:.httpHeaderFieldNameAllowed) else { return nil }
    self.rawValue = rawValue
    self.lowercasedRawValue = rawValue.lowercased()
  }
}

extension HeaderFieldName: Equatable {
  public static func ==(lhs:HeaderFieldName, rhs:HeaderFieldName) -> Bool {
    return lhs.lowercasedRawValue == rhs.lowercasedRawValue
  }
}

extension HeaderFieldName: Hashable {
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.lowercasedRawValue)
  }
  #else
  public var hashValue: Int {
    return self.lowercasedRawValue.hashValue
  }
  #endif
}
