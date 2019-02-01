/* *************************************************************************************************
 SpecifiedElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class SpecifiedElement: Element {
  /// The local name that the element must have.
  /// This class property must be overridden in child classes.
  open class var localName: NoncolonizedName { fatalError("Must be overriden.") }
  
  private var _name: QualifiedName!
  open override var name: QualifiedName {
    get {
      return self._name
    }
    set {
      guard newValue.localName == type(of:self).localName else {
        fatalError("Local name must be \"\(type(of:self).localName)\".")
      }
      self._name = newValue
    }
  }
  
  public override init(name:QualifiedName) {
    super.init(name:name)
    self.name = name
  }
}
