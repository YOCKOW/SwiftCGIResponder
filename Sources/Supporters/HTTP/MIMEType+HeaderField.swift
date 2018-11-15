/* *************************************************************************************************
 MIMEType+HeaderField.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension MIMEType: HeaderFieldValueConvertible {
  public init?(httpHeaderFieldValue: HeaderFieldValue) {
    self.init(httpHeaderFieldValue.rawValue)
  }
  
  public var httpHeaderFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.description)!
  }
}

/// Generates a header field whose name is "Content-Type"
public struct MIMETypeHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = MIMEType
  
  public static var name: HeaderFieldName { return .contentType }
  
  public static var type: HeaderField.PresenceType { return .single }
  
  public var source: MIMEType
  
  public init(_ source: MIMEType) {
    self.source = source
  }
}

public typealias ContentTypeHeaderFieldDelegate = MIMETypeHeaderFieldDelegate
