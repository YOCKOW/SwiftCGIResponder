/* *************************************************************************************************
 ContentDispositionParameterKey.swift
   © 2018 YOCKOW.
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

extension ContentDispositionParameterKey: Hashable {}
