/* *************************************************************************************************
 ContentDispositionParameterKey.swift
   © 2018-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents the key for parameter of Content Disposition.
/// It is almost always "filename"
public struct ContentDispositionParameterKey: RawRepresentable {
  public typealias RawValue = String
  public let rawValue: String
  public init(rawValue:String) {
    self.rawValue = rawValue
  }
}

extension ContentDispositionParameterKey: Hashable {
  public static func ==(lhs:ContentDispositionParameterKey, rhs:ContentDispositionParameterKey) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
  
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.rawValue)
  }
}

extension ContentDispositionParameterKey: ExpressibleByStringLiteral {
  public init(stringLiteral string:String) {
    self.init(rawValue:string)
  }
}
