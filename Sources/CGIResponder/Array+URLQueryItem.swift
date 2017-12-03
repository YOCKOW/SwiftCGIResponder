/***************************************************************************************************
 Array+URLQueryItem.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # Array<URLQueryItem>
 Make it possible to initialize with string
 
 */
extension Array where Element == URLQueryItem {
  /// Initialize `Array<URLQueryItem>` with `string`
  public init?(string:String) {
    if string.isEmpty { return nil }
    self.init()
    
    // First, replace "+" with " "
    // Separator may be "&" or ";"
    let queryItemStrings = string.replacingOccurrences(of:"+", with:" ").components(separatedBy:BonaFideCharacterSet(charactersIn:"&;"))
    for queryItemString in queryItemStrings {
      let (name_raw, value_raw) = queryItemString.splitOnce(separator:"=")
      guard let name = name_raw.removingPercentEncoding else { continue }
      if value_raw == nil {
        self.append(URLQueryItem(name:name, value:nil))
      } else {
        guard let value = value_raw!.removingPercentEncoding else { continue }
        self.append(URLQueryItem(name:name, value:value))
      }
    }
  }
  
  /// Returns array of values for `name`
  public func values(forName name:String) -> [String?] {
    return self.filter{ $0.name == name }.map{ $0.value }
  }
}
