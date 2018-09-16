/***************************************************************************************************
 Array+HTTPCookieItem.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # Array<HTTPCookieItem>
 Make it possible to initialize with string
 
 */
extension Array where Element == HTTPCookieItem {
  public init?(string:String, removingPercentEncoding:Bool = true) {
    guard !string.isEmpty else { return nil }
    self.init()
    
    // reference: https://tools.ietf.org/html/rfc6265#section-5.4
    let cookieStrings = string.components(separatedBy:";")
    for keyAndValueString in cookieStrings {
      guard let item = HTTPCookieItem(string:keyAndValueString.trimmingCharacters(in:BonaFideCharacterSet.whitespaces),
                                      removingPercentEncoding:removingPercentEncoding) else {
        return nil
      }
      self.append(item)
    }
  }
  
  public func values(forName name:String) -> [String] {
    return self.filter{ $0.name == name }.map{ $0.value }
  }
}

