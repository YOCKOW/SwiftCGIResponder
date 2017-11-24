/***************************************************************************************************
 HTTPETag.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # HTTPETag
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
  public init?(_ string:String) {
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

extension HTTPETag: CustomStringConvertible {
  public var description: String {
    let escape: (String) -> String = {
      $0.replacingOccurrences(of:"\\", with:"\\\\").replacingOccurrences(of:"\"", with:"\\\"")
    }
    switch self {
    case .weak(let string):
      return "W/\"" + escape(string) + "\""
    case .strong(let string):
      return "\"" + escape(string) + "\""
    case .any:
      return "*"
    }
  }
}

extension HTTPETag: Hashable {
  public static func ==(lhs:HTTPETag, rhs:HTTPETag) -> Bool {
    switch (lhs, rhs) {
    case (.weak(let lstr), .weak(let rstr)) where lstr == rstr: return true
    case (.strong(let lstr), .strong(let rstr)) where lstr == rstr: return true
    case (.any, .any): return true
    default: return false
    }
  }
  public var hashValue: Int {
    switch self {
    case .weak(let string): return ~string.hashValue
    case .strong(let string): return string.hashValue
    case .any: return 0
    }
  }
}

infix operator =~: ComparisonPrecedence
extension HTTPETag {
  public static func =~(lhs:HTTPETag, rhs:HTTPETag) -> Bool {
    if lhs == rhs { return true }
    switch (lhs, rhs) {
    case (.weak(let lstr), .strong(let rstr)) where lstr == rstr: return true
    case (.strong(let lstr), .weak(let rstr)) where lstr == rstr: return true
    default: return false
    }
  }
  
  public func matches(in list:Array<HTTPETag>) -> Bool {
    for tag in list {
      if tag == .any || self == tag { return true }
    }
    return false
  }
  
  public func weaklyMatches(in list:Array<HTTPETag>) -> Bool {
    for tag in list {
      if tag == .any || self =~ tag { return true }
    }
    return false
  }
}

