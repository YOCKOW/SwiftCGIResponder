/* *************************************************************************************************
 ETagList.swift
   © 2018-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents the list of `ETag`s
public enum ETagList {
  case any
  case list(Array<ETag>)
}

extension ETagList {
  /// Appends a new ETag.
  public mutating func append(_ newETag:ETag) {
    switch self {
    case .any: break
    case .list(var array):
      if array.contains(newETag) { break }
      array.append(newETag)
      self = .list(array)
    }
  }
}

infix operator =~: ComparisonPrecedence
extension ETagList {
  public func contains(_ tag:ETag, weakComparison:Bool = false) -> Bool {
    switch self {
    case .any:
      return true
    case .list(let array):
      let predicate:(ETag) -> Bool = weakComparison ? { $0 =~ tag } : { $0 == tag }
      return array.contains(where:predicate)
    }
  }
}

extension ETagList: Hashable {
  public static func ==(lhs:ETagList, rhs:ETagList) -> Bool {
    switch (lhs, rhs) {
    case (.any, .any): return true
    case (.list(let larray), .list(let rarray)): return larray == rarray
    default: return false
    }
  }
  
  public func hash(into hasher:inout Hasher) {
    switch self {
    case .any: hasher.combine(Int.max)
    case .list(let array): hasher.combine(array)
    }
  }
}

extension ETagList: CustomStringConvertible {
  public var description: String {
    switch self {
    case .any: return "*"
    case .list(let array): return array.map{ $0.description }.joined(separator:", ")
    }
  }
}
