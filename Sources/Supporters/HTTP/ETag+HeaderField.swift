/* *************************************************************************************************
 ETag+HeaderField.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension ETag: HeaderFieldValueConvertible {
  public init?(httpHeaderFieldValue: HeaderFieldValue) {
    self.init(httpHeaderFieldValue.rawValue)
  }
  
  public var httpHeaderFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.description)!
  }
}

/// Generates a header field whose name is "ETag"
public struct ETagHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = ETag
  
  public static var name: HeaderFieldName { return .eTag }
  
  public static var type: HeaderField.PresenceType { return .single }
  
  public var source: ETag
  
  public init(_ source: ETag) {
    self.source = source
  }
}

