/* *************************************************************************************************
 CookieItem.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import LibExtender

/// Represents a single name-value pair for cookie.
public struct CookieItem {
  public private(set) var name: String
  public private(set) var value: String
  
  public init(name:String, value:String) {
    self.name = name
    self.value = value
  }
  
  public init<C: RFC6265Cookie>(from cookie:C) {
    self.init(name:cookie.name, value:cookie.value)
  }
  
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

extension CookieItem {
  internal func _nameAndValue(addingPercentEncoding:Bool = true) -> String? {
    if addingPercentEncoding {
      guard let name = self.name.addingPercentEncoding(withAllowedUnicodeScalars:.httpTokenAllowed)
        else { return nil }
      guard let value = self.value.addingPercentEncoding(withAllowedUnicodeScalars:.cookieValueAllowed)
        else { return nil }
      return "\(name)=\(value)"
    } else {
      return "\(self.name)=\(self.value)"
    }
  }
}
