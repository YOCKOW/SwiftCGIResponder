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
public struct AnyElement {
  fileprivate class _Box {
    fileprivate var name: String? { _mustBeOverriden() }
    fileprivate var localName: String? { _mustBeOverriden() }
    fileprivate var uri: String? { _mustBeOverriden() }
    fileprivate var stringValue: String? { get { _mustBeOverriden() } set { _mustBeOverriden() } }
    fileprivate func xmlString(options mask:XMLNode.Options) -> String { _mustBeOverriden() }
    
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
    }
    
    fileprivate class _TextHolder<E>: _Some<E> where E: TextHolderElement {
      
    }
  }
  
  private var _box: _Box
  
  /// Initialize with the given element.
  public init<E>(_ element:E) where E:Element {
    self._box = _Box._Some<E>(element)
  }
  
  /// Initialize with the given element.
  public init<T>(_ element:T) where T:TextHolderElement {
    self._box = _Box._TextHolder<T>(element)
  }
}
