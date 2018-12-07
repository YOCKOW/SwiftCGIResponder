/* *************************************************************************************************
 UInt+HeaderFieldValueConvertible.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension UInt: HeaderFieldValueConvertible {
  public init?(headerFieldValue: HeaderFieldValue) {
    self.init(headerFieldValue.rawValue)
  }
  
  public var headerFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.description)!
  }
}
