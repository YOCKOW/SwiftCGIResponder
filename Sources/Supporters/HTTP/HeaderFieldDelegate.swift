/* *************************************************************************************************
 HeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// # HeaderFieldDelegate
///
/// Generates a concrete field name and a concreate field value.
/// It is intended to be used by `HeaderField`
open class HeaderFieldDelegate: Hashable {
  public var name: HeaderFieldName
  public var value: HeaderFieldValue
  public var type: HeaderField.PresenceType
  
  /// Returns the Boolean value that indicates whether the receiver is equal to `other` or not.
  public func isEqual(to other:HeaderFieldDelegate) -> Bool {
    return self.name == other.name && self.value == other.value
  }
  
  public static func ==(lhs:HeaderFieldDelegate, rhs:HeaderFieldDelegate) -> Bool {
    return lhs.isEqual(to:rhs)
  }
  
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.name)
    hasher.combine(self.value)
  }
  #else
  public var hashValue:Int {
    return self.name.hashValue ^ self.value.hashValue
  }
  #endif
  
  internal init(_name:HeaderFieldName, _value:HeaderFieldValue, _type:HeaderField.PresenceType) {
    self.name = _name
    self.value = _value
    self.type = _type
  }
}

/// Represents a certain header-field that can be generated from `ValueSource`.
open class SpecifiedHeaderFieldDelegate<ValueSource>: HeaderFieldDelegate
  where ValueSource: HeaderFieldValueConvertible
{
  open class var name: HeaderFieldName {
    return HeaderFieldName(rawValue:"X-CGIResponder-Requires-Concrete-Implementation")!
  }
  
  public final override var name: HeaderFieldName {
    get {
      return Swift.type(of:self).name
    }
    set {
      guard Swift.type(of:self).name == newValue else { fatalError("Name is unchangeable.") }
    }
  }
  
  open var source:ValueSource
  
  public final override var value: HeaderFieldValue {
    get {
      return self.source.httpHeaderFieldValue
    }
    set {
      guard let newSource = ValueSource(httpHeaderFieldValue:newValue) else {
        fatalError("Failed to create an instance of ValueSource from \(newValue.rawValue).")
      }
      self.source = newSource
    }
  }
  
  public override func isEqual(to other:HeaderFieldDelegate) -> Bool {
    guard case let another as SpecifiedHeaderFieldDelegate<ValueSource> = other else { return false }
    return self.source == another.source
  }
  
  #if swift(>=4.2)
  public override func hash(into hasher:inout Hasher) {
    hasher.combine(self.source)
  }
  #else
  public override var hashValue:Int {
    return self.source.hashValue
  }
  #endif
  
  internal init(_ valueSource:ValueSource, type:HeaderField.PresenceType) {
    self.source = valueSource
    
    // name and value are dummy.
    super.init(_name:Swift.type(of:self).name, _value:valueSource.httpHeaderFieldValue, _type:type)
  }
}

/// Header-field delegate whose `type` is always `.single`.
/// One of examples of implementation is `HeaderFieldDelegate.ETag`.
open class SpecifiedSingleHeaderFieldDelegate<ValueSource>: SpecifiedHeaderFieldDelegate<ValueSource>
  where ValueSource: HeaderFieldValueConvertible
{
  public final override var type: HeaderField.PresenceType {
    get {
      return .single
    }
    set {
      guard newValue == .single else { fatalError("Must be .single.") }
    }
  }
  
  public init(_ valueSource:ValueSource) {
    super.init(valueSource, type:.single)
  }
}
