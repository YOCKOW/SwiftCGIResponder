/* *************************************************************************************************
 HeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

public protocol HeaderFieldDelegate {
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

/// Header field whose type is `appendable`.
public protocol AppendableHeaderFieldDelegate: HeaderFieldDelegate {
  associatedtype Element
  
  /// The source that generates the value of the header field.
  var source: ValueSource { get set }
  
  /// Append the element
  mutating func append(_ element:Element)
}

extension AppendableHeaderFieldDelegate
  where ValueSource:RangeReplaceableCollection, ValueSource.Element == Element
{
  public mutating func append(_ element:Element) {
    self.source.append(element)
  }
}
