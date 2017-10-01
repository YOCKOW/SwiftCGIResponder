/***************************************************************************************************
 HTTPHeaderFieldDelegate.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderFieldDelegate
 Holds an instance of `HTTPHeaderFieldName`, and computes an instance of `HTTPHeaderFieldValue`.
 
 */
open class HTTPHeaderFieldDelegate {
  open var name: HTTPHeaderFieldName
  open var value: HTTPHeaderFieldValue
  public init?(name: HTTPHeaderFieldName, value: HTTPHeaderFieldValue) {
    self.name = name
    self.value = value
  }
}
