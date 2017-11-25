/***************************************************************************************************
 HTTPCookieItem.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # HTTPCookieItem
 Reporesents for a single name-value pair from HTTP Cookie
 
 */
public struct HTTPCookieItem {
  public var name: String
  public var value: String
  
  public init(name:String, value:String) {
    self.name = name
    self.value = value
  }
  
//  public init<Cookie: RFC6265Cookie>(cookie:Cookie) {
//    self.init(name:cookie.name, value:cookie.value)
//  }
  
  public init?(string:String, removingPercentEncoding:Bool = true) {
    guard case let (name, value?) = string.splitOnce(separator:"=") else { return nil }
    
    if removingPercentEncoding {
      guard let decodedName = name.removingPercentEncoding else { return nil }
      guard let decodedValue = value.removingPercentEncoding else { return nil }
      self.init(name:decodedName, value:decodedValue)
    } else {
      self.init(name:String(name), value:String(value))
    }
  }
}

