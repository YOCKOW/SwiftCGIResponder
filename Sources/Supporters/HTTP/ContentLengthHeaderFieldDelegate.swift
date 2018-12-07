/* *************************************************************************************************
 ContentLengthHeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Generates "Content-Length".
public struct ContentLengthHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = UInt
  
  public static var name: HeaderFieldName { return .contentLength }
  public static var type: HeaderField.PresenceType { return .single }
  
  public var source: UInt
  
  public init(_ source: UInt) {
    self.source = source
  }
}
