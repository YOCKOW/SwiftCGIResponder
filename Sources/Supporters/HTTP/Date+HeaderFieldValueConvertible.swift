/* *************************************************************************************************
 Date+HeaderFieldValueConvertible.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

extension Date: HeaderFieldValueConvertible {
  public init?(headerFieldValue: HeaderFieldValue) {
    guard let date = DateFormatter.rfc1123.date(from:headerFieldValue.rawValue) else {
      return nil
    }
    self = date
  }
  
  public var headerFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:DateFormatter.rfc1123.string(from:self))!
  }
}
