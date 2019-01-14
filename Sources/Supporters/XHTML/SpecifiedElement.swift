/* *************************************************************************************************
 SpecifiedElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class SpecifiedElement: Element {
  internal class var _localName: NoncolonizedName { fatalError("Must be overriden.") }
  
  private var _name: QualifiedName!
  open override var name: QualifiedName {
    get {
      return self._name
    }
    set {
      guard newValue.localName == type(of:self)._localName else {
        fatalError("Local name must be \"\(type(of:self)._localName)\".")
      }
      self._name = newValue
    }
  }
  
  public override init(name:QualifiedName) {
    super.init(name:name)
    self.name = name
  }
}
