/* *************************************************************************************************
 ETag.swift
   © 2017-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

// This `import` is required for Ubuntu 14.04?
// https://travis-ci.org/YOCKOW/SwiftCGIResponder/builds/430854353
import Foundation

/// # ETag
/// Reporesents a value of ETag
public enum ETag {
  case weak(String)
  case strong(String)
  case any
}

extension ETag {
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
    
    if string.hasPrefix("W/\"") {
      weak = true
      start = string.index(start, offsetBy:3)
    } else {
      guard string.hasPrefix("\"") else { return nil }
      start = string.index(after:start)
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

extension ETag: CustomStringConvertible {
  public var description: String {
    let escape: (String) -> String = { (tag:String) -> String in
      var escaped = ""
      for character in tag {
        if character == "\\" { escaped += "\\\\" }
        else if character == "\"" { escaped += "\\\"" }
        else { escaped.append(character) }
      }
      return escaped
    }
    
    switch self {
    case .weak(let tag):
      return "W/\"" + escape(tag) + "\""
    case .strong(let tag):
      return "\"" + escape(tag) + "\""
    case .any:
      return "*"
    }
  }
}

extension ETag: Equatable {
  public static func ==(lhs:ETag, rhs:ETag) -> Bool {
    switch (lhs, rhs) {
    case (.weak(let lstr), .weak(let rstr)) where lstr == rstr: return true
    case (.strong(let lstr), .strong(let rstr)) where lstr == rstr: return true
    case (.any, .any): return true
    default: return false
    }
  }
}

extension ETag: Hashable {
  public func hash(into hasher:inout Hasher) {
    switch self {
    case .weak(let tag): hasher.combine("weak:" + tag)
    case .strong(let tag): return hasher.combine(tag)
    case .any: hasher.combine("*")
    }
  }
}

infix operator =~: ComparisonPrecedence
extension ETag {
  public static func =~(lhs:ETag, rhs:ETag) -> Bool {
    if lhs == rhs { return true }
    switch (lhs, rhs) {
    case (.weak(let lstr), .strong(let rstr)) where lstr == rstr: return true
    case (.strong(let lstr), .weak(let rstr)) where lstr == rstr: return true
    default: return false
    }
  }
}

extension Sequence where Element == ETag {
  public func contains(_ tag:ETag, weakComparison:Bool = false) -> Bool {
    let predicate:(ETag) -> Bool = weakComparison ? { $0 =~ tag } : { $0 == tag }
    return self.contains(where:predicate)
  }
}

