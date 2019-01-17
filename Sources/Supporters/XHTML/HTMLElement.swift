/* *************************************************************************************************
 HTMLElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents "<html>...</html>"
open class HTMLElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "html" }
  
  /// Always `false` because HTML element must have children.
  open override var isEmpty: Bool { return false }
  
  open internal(set) weak var document: Document? = nil
  
  public var head: HeadElement? {
    for child in self.children {
      if case let headElement as HeadElement = child { return headElement }
    }
    return nil
  }
  
  public var body: BodyElement? {
    for child in self.children {
      if case let bodyElement as BodyElement = child { return bodyElement }
    }
    return nil
  }
  
  public override convenience init(name:QualifiedName) {
    self.init(name:name, attributes:[:])
  }
  
  public required init(name:QualifiedName, attributes:Attributes) {
    var attrs = attributes
    if attrs._namespace(for:name) == nil {
      let attrName: AttributeName =
        (name.prefix == nil) ? .defaultNamespace : .userDefinedNamespace(name.prefix!)
      attrs[attrName] = String._xhtmlNamespace
    }
    super.init(name:name)
    self.attributes = attrs
  }
  
  public convenience init(name:QualifiedName, attributes:Attributes, children:[Node]) {
    self.init(name:name, attributes:attributes)
    self.children = children
  }
}
