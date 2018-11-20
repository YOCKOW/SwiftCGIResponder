/* *************************************************************************************************
 CacheControlHeaderFieldDelegate.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

/// Represents HTTP Header "Cache-Control"
public struct CacheControlHeaderFieldDelegate: AppendableHeaderFieldDelegate {
  public typealias ValueSource = CacheControlDirectiveSet
  public typealias Element = CacheControlDirective
  
  public static var name: HeaderFieldName { return .cacheControl }
  public static var type: HeaderField.PresenceType { return .appendable }
  
  public var source: CacheControlDirectiveSet
  public var elements: [CacheControlDirective] { return self.source._directives }
  
  public init(_ source:CacheControlDirectiveSet) {
    self.source = source
  }
  
  public mutating func append(_ element: CacheControlDirective) {
    self.source.insert(element)
  }
  
  public mutating func append<S>(contentsOf elements: S)
    where S: Sequence, CacheControlDirective == S.Element
  {
    for element in elements {
      self.source.insert(element)
    }
  }
}
