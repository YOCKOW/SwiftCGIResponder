/* *************************************************************************************************
 ETagList+HeaderField.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

extension ETagList: HeaderFieldValueConvertible {
  public init?(httpHeaderFieldValue: HeaderFieldValue) {
    try? self.init(httpHeaderFieldValue.rawValue)
  }
  
  public var httpHeaderFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.description)!
  }
}

extension AppendableHeaderFieldDelegate where ValueSource == ETagList, Element == ETag {
  public var elements: Array<ETag> {
    switch self.source {
    case .any: return [.any]
    case .list(let array): return array
    }
  }
  
  public mutating func append(_ element: ETag) {
    self.source.append(element)
  }
  
  public mutating func append<S>(contentsOf elements: S) where S:Sequence, Element == S.Element {
    for etag in elements {
      self.append(etag)
    }
  }
}

/// Generates a header field whose name is "If-Match"
public struct IfMatchHeaderFieldDelegate: AppendableHeaderFieldDelegate {
  public typealias ValueSource = ETagList
  public typealias Element = ETag
  
  public static var name: HeaderFieldName { return .ifMatch }
  
  public static var type: HeaderField.PresenceType { return .appendable }
  
  public var source: ETagList
  
  public init(_ source:ETagList) {
    self.source = source
  }
}

/// Generates a header field whose name is "If-None-Match"
public struct IfNoneMatchHeaderFieldDelegate: AppendableHeaderFieldDelegate {
  public typealias ValueSource = ETagList
  public typealias Element = ETag
  
  public static var name: HeaderFieldName { return .ifNoneMatch }
  
  public static var type: HeaderField.PresenceType { return .appendable }
  
  public var source: ETagList
  
  public init(_ source: ETagList) {
    self.source = source
  }
}
