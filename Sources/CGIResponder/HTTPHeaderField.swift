/***************************************************************************************************
 HTTPHeaderField.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderField
 Represents for each HTTP Header Field
 
 */

public struct HTTPHeaderField {
  public private(set) var delegate: HTTPHeaderFieldDelegate
  public init(delegate: HTTPHeaderFieldDelegate) { self.delegate = delegate }
}

extension HTTPHeaderField: CustomStringConvertible {
  public var description: String {
    return self.delegate.description
  }
}
