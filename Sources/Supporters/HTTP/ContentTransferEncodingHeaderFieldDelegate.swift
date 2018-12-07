/* *************************************************************************************************
 ContentTransferEncodingHeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Generate the value of "Content-Transfer-Encoding:"
public struct ContentTransferEncodingHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = ContentTransferEncoding
  
  public static var name: HeaderFieldName { return .contentTransferEncoding }
  public static var type: HeaderField.PresenceType { return .single }
  
  public var source: ContentTransferEncoding
  
  public init(_ source: ContentTransferEncoding) {
    self.source = source
  }
}
