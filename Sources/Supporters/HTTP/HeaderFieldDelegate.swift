/* *************************************************************************************************
 HeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

public protocol HeaderFieldDelegate: Hashable {
  associatedtype ValueSource: HeaderFieldValueConvertible
  
  /// The name of the header field.
  static var name: HeaderFieldName { get }
  
  /// The representation how it can exist in the header.
  static var type: HeaderField.PresenceType { get }
  
  /// The source that generates the value of the header field.
  var source: ValueSource { get }
  
  /// Initializes with an instance of `ValueSource`.
  init(_ source: ValueSource)
}

extension HeaderFieldDelegate {
  /// The value of the header field.
  public var value: HeaderFieldValue {
    return self.source.httpHeaderFieldValue
  }
}

extension HeaderFieldDelegate where ValueSource: Equatable {
  public static func ==(lhs:Self, rhs:Self) -> Bool {
    return lhs.source == rhs.source
  }
}

extension HeaderFieldDelegate where ValueSource: Hashable {
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.source)
  }
  #else
  public var hashValue: Int {
    return self.source.hashValue
  }
  #endif
}

/// Header field whose type is `appendable`.
public protocol AppendableHeaderFieldDelegate: HeaderFieldDelegate {
  associatedtype Element
  
  /// The source that generates the value of the header field.
  var source: ValueSource { get set }
  
  /// The elements contained in the header field.
  var elements: [Element] { get }
  
  /// Append the element
  mutating func append(_ element:Element)
  
  /// Append the elements
  mutating func append<S>(contentsOf elements:S) where S: Sequence, S.Element == Element
}

extension AppendableHeaderFieldDelegate
  where ValueSource:RangeReplaceableCollection, ValueSource.Element == Element
{
  public mutating func append(_ element:Element) {
    self.source.append(element)
  }
  
  public mutating func append<S>(contentsOf elements:S) where S: Sequence, S.Element == Element {
    self.source.append(contentsOf:elements)
  }
}
