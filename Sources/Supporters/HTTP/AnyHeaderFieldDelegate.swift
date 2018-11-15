/* *************************************************************************************************
 AnyHeaderFieldDelegate.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

private func _mustBeOverriden(file:StaticString = #file, line:UInt = #line) -> Never {
  fatalError("Method must be overridden.", file:file, line:line)
}

/// Type-erasure for `HeaderFieldDelegate`.
internal struct _AnyHeaderFieldDelegate {
  internal class _Box {
    internal var type: HeaderField.PresenceType { _mustBeOverriden() }
    internal var name: HeaderFieldName { _mustBeOverriden() }
    internal var value: HeaderFieldValue { _mustBeOverriden() }
    internal func append<T>(_ element:T) { _mustBeOverriden() }
    internal func append<S>(contentsOf elements:S) { _mustBeOverriden() }
    internal func append(elementsIn box:_Box) { _mustBeOverriden() }
    
    internal class _Normal<Delegate>: _Box where Delegate: HeaderFieldDelegate {
      fileprivate var _base: Delegate
      internal init(_ base:Delegate) {
        self._base = base
      }
      
      internal override var type: HeaderField.PresenceType { return Swift.type(of:self._base).type }
      internal override var name: HeaderFieldName { return Swift.type(of:self._base).name }
      internal override var value: HeaderFieldValue { return self._base.value }
      
      internal override func append<T>(_ element: T) {
        fatalError("\(Delegate.self) does not conform to AppendableHeaderFieldDelegate.")
      }
      
      internal override func append<S>(contentsOf elements:S) {
        fatalError("\(Delegate.self) does not conform to AppendableHeaderFieldDelegate.")
      }
      
      internal override func append(elementsIn box:_Box) {
        fatalError("\(Delegate.self) does not conform to AppendableHeaderFieldDelegate.")
      }
    }
    
    internal class _Appendable<Delegate>: _Normal<Delegate> where Delegate:AppendableHeaderFieldDelegate {
      internal override func append<T>(_ element:T) {
        guard case let concreteElement as Delegate.Element = element else {
          fatalError("Cannot append \(element): The type of \(Delegate.self)'s element must be \(Delegate.Element.self).")
        }
        self._base.append(concreteElement)
      }
      
      internal override func append<S>(contentsOf elements:S) {
        guard case let arrayOfElements as Array<Delegate.Element> = elements else {
          fatalError("The type of \(Delegate.self)'s elements must be \(Delegate.Element.self).")
        }
        self._base.append(contentsOf:arrayOfElements)
      }
      
      internal override func append(elementsIn box:_Box) {
        guard case let concreteBox as _Appendable<Delegate> = box else {
          fatalError("Unmatched delegates: \(box)")
        }
        self.append(contentsOf:concreteBox._base.elements)
      }
    }
    
    internal class _Unspecified: _Box {
      private var _name: HeaderFieldName
      private var _value: HeaderFieldValue
      
      internal override var type: HeaderField.PresenceType { return .single }
      internal override var name: HeaderFieldName { return self._name }
      internal override var value: HeaderFieldValue { return self._value }
      
      internal init(name:HeaderFieldName, value:HeaderFieldValue) {
        self._name = name
        self._value = value
      }
    }
  }
  
  // testable
  internal var _box: _Box
  
  internal var type: HeaderField.PresenceType { return self._box.type }
  internal var name: HeaderFieldName { return self._box.name }
  internal var value: HeaderFieldValue { return self._box.value }
  internal mutating func append<T>(_ element:T) { self._box.append(element) }
  internal mutating func append<S>(contentsOf elements:S) where S:Sequence {
    self._box.append(contentsOf:Array<S.Element>(elements))
  }
  internal mutating func append(elementsIn delegate:_AnyHeaderFieldDelegate) {
    self._box.append(elementsIn:delegate._box)
  }
  
  internal init<D>(_ delegate:D) where D:HeaderFieldDelegate {
    self._box = _Box._Normal<D>(delegate)
  }
  
  internal init<D>(_ delegate:D) where D:AppendableHeaderFieldDelegate {
    self._box = _Box._Appendable<D>(delegate)
  }
  
  internal init(name:HeaderFieldName, value:HeaderFieldValue) {
    self._box = _Box._Unspecified(name:name, value:value)
  }
}
