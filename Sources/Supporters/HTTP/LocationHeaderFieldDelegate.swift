/* *************************************************************************************************
 LocationHeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

public struct LocationHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = URL
  
  public static var name: HeaderFieldName { return .location }
  
  public static var type: HeaderField.PresenceType { return .single }
  
  public var source: URL
  
  public init(_ source: URL) {
    self.source = source
  }
}
