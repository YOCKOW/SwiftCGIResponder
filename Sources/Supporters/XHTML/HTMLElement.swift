/* *************************************************************************************************
 HTMLElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents "<html>...</html>"
open class HTMLElement: Element {
  private var _name: QualifiedName!
  open override var name: QualifiedName {
    get {
      return self._name
    }
    set {
      guard newValue.localName == "html" else { fatalError("Local name must be \"html\".") }
      self._name = newValue
    }
  }
  
  /// Always `false` because HTML element must have children.
  open override var isEmpty: Bool { return false }
  
  open internal(set) weak var document: Document? = nil
  
  public override init(name:QualifiedName) {
    super.init(name:name)
    self.name = name
  }
}
