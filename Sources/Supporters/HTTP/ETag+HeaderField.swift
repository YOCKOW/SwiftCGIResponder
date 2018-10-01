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

//extension HeaderFieldDelegate {
//  /// Generates "ETag: [entity tag]"
//  public final class ETag: SpecifiedSingleHeaderFieldDelegate<HTTP.ETag> {
//    public override class var name: HeaderFieldName { return .eTag }
//  }
//
//  /// Generates "If-Match: [list of entity tags]"
//  public final class IfMatch: SpecifiedSingleHeaderFieldDelegate<Array<HTTP.ETag>> {
//    public override class var name: HeaderFieldName { return .ifMatch }
//  }
//
//
//  /// Generates "If-None-Match: [list of entity tags]"
//  public final class IfNoneMatch: SpecifiedSingleHeaderFieldDelegate<Array<HTTP.ETag>> {
//    public override class var name: HeaderFieldName { return .ifNoneMatch }
//  }
//}
//
