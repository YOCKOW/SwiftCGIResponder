/* *************************************************************************************************
 ContentDispositionHeaderField.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension ContentDisposition: HeaderFieldValueConvertible {
  public init?(httpHeaderFieldValue: HeaderFieldValue) {
    self.init(httpHeaderFieldValue.rawValue)
  }
  
  public var httpHeaderFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.description)!
  }
}

/// Represents "Content-Disposition:"
public struct ContentDispositionHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = ContentDisposition
  
  public static let name: HeaderFieldName = .contentDisposition
  public static let type: HeaderField.PresenceType = .single
  
  public var source: ContentDisposition
  
  public init(_ source: ContentDisposition) {
    self.source = source
  }
}
