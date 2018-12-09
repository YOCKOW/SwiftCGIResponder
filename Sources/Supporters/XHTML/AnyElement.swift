/* *************************************************************************************************
 AnyElement.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

private func _mustBeOverriden(file:StaticString = #file, line:UInt = #line) -> Never {
  fatalError("Method must be overridden.", file:file, line:line)
}

/// Type-erasure for `Element`.
public struct AnyElement: Element {
  fileprivate class _Box: Hashable {
    fileprivate var name: String? { _mustBeOverriden() }
    fileprivate var localName: String? { _mustBeOverriden() }
    fileprivate var uri: String? { _mustBeOverriden() }
    fileprivate var stringValue: String? { get { _mustBeOverriden() } set { _mustBeOverriden() } }
    fileprivate func xmlString(options mask:XMLNode.Options) -> String { _mustBeOverriden() }
    
    fileprivate func _isEqual(to other:_Box) -> Bool { _mustBeOverriden() }
    fileprivate static func == (lhs: AnyElement._Box, rhs: AnyElement._Box) -> Bool {
      return lhs._isEqual(to:rhs)
    }
    
    #if swift(>=4.2)
    public func hash(into hasher:inout Hasher) { _mustBeOverriden() }
    #else
    public var hashValue: Int { _mustBeOverriden() }
    #endif
    
    fileprivate class _Some<E>: _Box where E: Element {
      fileprivate var _base: E
      fileprivate init(_ base:E) { self._base = base }
      
      fileprivate override var name: String? { return self._base.name }
      fileprivate override var localName: String? { return self._base.localName }
      fileprivate override var uri: String? { return self._base.uri }
      fileprivate override var stringValue: String? {
        get { return self._base.stringValue }
        set { self._base.stringValue = newValue }
      }
      fileprivate override func xmlString(options mask: XMLNode.Options) -> String {
        return self._base.xmlString(options:mask)
      }
      
      fileprivate override func _isEqual(to other: AnyElement._Box) -> Bool {
        guard case let other as _Some<E> = other else { return false }
        return self._base == other._base
      }
      
      #if swift(>=4.2)
      public override func hash(into hasher:inout Hasher) { hasher.combine(self._base) }
      #else
      public var hashValue: Int { return self._base.hashValue }
      #endif
    }
    
    fileprivate class _TextHolder<E>: _Some<E> where E: TextHolderElement {
      
    }
  }
  
  private var _box: _Box
  
  public var name: String? { return self._box.name }
  public var localName: String? { return self._box.localName }
  public var uri: String? { return self._box.uri }
  public var stringValue: String? {
    get { return self._box.stringValue }
    set { self._box.stringValue = newValue }
  }
  public func xmlString(options mask: XMLNode.Options) -> String {
    return self._box.xmlString(options:mask)
  }
  
  public static func == (lhs: AnyElement, rhs: AnyElement) -> Bool {
    return lhs._box == rhs._box
  }
  
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) { hasher.combine(self._box) }
  #else
  public var hashValue: Int { return self._box.hashValue }
  #endif
  
  /// Initialize with the given element.
  public init<E>(_ element:E) where E:Element {
    self._box = _Box._Some<E>(element)
  }
  
  /// Initialize with the given element.
  public init<T>(_ element:T) where T:TextHolderElement {
    self._box = _Box._TextHolder<T>(element)
  }
}
