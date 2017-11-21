/***************************************************************************************************
 HTTPETag.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # ETagValue
 Reporesents for value of ETag
 
 */
public enum HTTPETag {
  case weak(String)
  case strong(String)
  case any
}

extension HTTPETag {
  /// Initialize from `string`
  /// e.g.) "foo", W/"bar"
  public init?(string:String) {
    if string == "*" {
      self = .any
      return
    }
    
    guard string.hasSuffix("\"") else { return nil }
    var weak: Bool = false
    var start: String.Index = string.startIndex
    let end: String.Index = string.index(before:string.endIndex)
    if let range = string.range(of:"W/\"") {
      weak = true
      start = range.upperBound
    } else {
      guard string.hasPrefix("\"") else { return nil }
      start = string.index(after:string.startIndex)
    }
    guard start < end else { return nil }
    
    let tag: Substring = string[start..<end]
    if tag.isEmpty { return nil }
    
    var actualTag: String = ""
    var escaped = false
    for character in tag {
      if !escaped && character == "\\" {
        escaped = true
      } else {
        escaped = false
        actualTag.append(character)
      }
    }
    if escaped { return nil }
    
    if weak {
      self = .weak(actualTag)
    } else {
      self = .strong(actualTag)
    }
  }
}
