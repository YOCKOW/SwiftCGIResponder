/* *************************************************************************************************
 URL+HeaderFieldValueConvertible.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

extension URL: HeaderFieldValueConvertible {
  public init?(headerFieldValue: HeaderFieldValue) {
    self.init(string:headerFieldValue.rawValue)
  }
  
  public var headerFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.absoluteString)!
  }
}
