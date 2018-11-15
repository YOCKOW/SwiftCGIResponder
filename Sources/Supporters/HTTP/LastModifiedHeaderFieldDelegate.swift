/* *************************************************************************************************
 LastModifiedHeaderFieldDelegate.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

public struct LastModifiedHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = Date
  
  public static var name: HeaderFieldName { return .lastModified }
  public static var type: HeaderField.PresenceType { return .single }
  
  public var source: Date
  
  public init(_ source: Date) {
    self.source = source
  }
}
