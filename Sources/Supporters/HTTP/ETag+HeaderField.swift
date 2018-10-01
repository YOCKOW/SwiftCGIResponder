/* *************************************************************************************************
 ETag+HeaderField.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension ETag: HeaderFieldValueConvertible {
  public init?(httpHeaderFieldValue: HeaderFieldValue) {
    self.init(httpHeaderFieldValue.rawValue)
  }
  
  public var httpHeaderFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.description)!
  }
}


#if swift(>=4.1.50)
#else
// Build failed in Swift < 4.1.50
// https://travis-ci.org/YOCKOW/SwiftCGIResponder/builds/432042158
// https://travis-ci.org/YOCKOW/SwiftCGIResponder/builds/432049328
//
// -> Let `Array<ETag>` conform to `Hashable` explicitly
extension Array: Hashable where Element == ETag {
  public var hashValue: Int {
    var hh = 0
    for tag in self {
      hh ^= tag.hashValue
    }
    return hh
  }
}
#endif

extension Array: HeaderFieldValueConvertible where Element == ETag {
  public init?(httpHeaderFieldValue: HeaderFieldValue) {
    do {
      try self.init(string:httpHeaderFieldValue.rawValue)
    } catch {
      return nil
    }
  }
  
  public var httpHeaderFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self.map{ $0.description }.joined(separator:", "))!
  }
}

/// Generates a header field whose name is "ETag"
public struct ETagHeaderFieldDelegate: HeaderFieldDelegate {
  public typealias ValueSource = ETag
  
  public static var name: HeaderFieldName { return .eTag }
  
  public static var type: HeaderField.PresenceType { return .single }
  
  public var source: ETag
  
  public init(_ source: ETag) {
    self.source = source
  }
}

/// Generates a header field whose name is "If-Match"
public struct IfMatchHeaderFieldDelegate: AppendableHeaderFieldDelegate {
  public typealias ValueSource = Array<ETag>
  public typealias Element = ETag
  
  public static var name: HeaderFieldName { return .ifMatch }
  
  public static var type: HeaderField.PresenceType { return .appendable }
  
  public var source: Array<ETag>
  
  public init(_ source: Array<ETag>) {
    self.source = source
  }
}

/// Generates a header field whose name is "If-None-Match"
public struct IfNoneMatchHeaderFieldDelegate: AppendableHeaderFieldDelegate {
  public typealias ValueSource = Array<ETag>
  public typealias Element = ETag
  
  public static var name: HeaderFieldName { return .ifNoneMatch }
  
  public static var type: HeaderField.PresenceType { return .appendable }
  
  public var source: Array<ETag>
  
  public init(_ source: Array<ETag>) {
    self.source = source
  }
}
