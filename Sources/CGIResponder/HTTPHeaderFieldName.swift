/***************************************************************************************************
 HTTPHeaderFieldName.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 /**
 
 # HTTPHeaderFieldName
 Represents for HTTP Header Field Name
 
 */

import Foundation

public struct HTTPHeaderFieldName: RawRepresentable {
  public let rawValue : String
  fileprivate let lowercasedRawValue : String
  public init?(rawValue:String) {
    if rawValue.isEmpty { return nil }
    guard rawValue.consists(of:.httpHeaderFieldNameAllowed) else { return nil }
    self.rawValue = rawValue
    self.lowercasedRawValue = rawValue.lowercased()
  }
}

extension HTTPHeaderFieldName: Hashable {
  public var hashValue: Int { return self.lowercasedRawValue.hashValue }
  public static func ==(lhs:HTTPHeaderFieldName, rhs:HTTPHeaderFieldName) -> Bool {
    return lhs.lowercasedRawValue == rhs.lowercasedRawValue
  }
}
