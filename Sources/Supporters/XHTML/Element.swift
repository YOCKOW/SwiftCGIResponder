/* *************************************************************************************************
 Element.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
 
open class Element: DescendantNode {
  open var name: QualifiedName
  
  private var _attributes: Attributes? = nil
  public var attributes: Attributes? {
    get {
      return self._attributes
    }
    set {
      if var newAttributes = newValue {
        newAttributes.element = self
        self._attributes = newAttributes
      } else {
        self._attributes = nil
      }
    }
  }
  
  open var children: [DescendantNode] = []
  
  public init(name:QualifiedName) {
    self.name = name
  }
  
  public override var xhtmlString: String {
    var result = "<\(self.name.description)"
    
    if let attrs = self.attributes {
      result += " " +
        attrs.map { (name:AttributeName, value:String) -> String in
          return "\(name.description)=\"\(value._addingAmpersandEncoding())\""
        }.joined(separator:" ")
    }
    
    if self.children.isEmpty {
      result += " />"
    } else {
      result += ">"
      for child in self.children {
        result += child.xhtmlString
      }
      result += "</\(self.name.description)>"
    }
    
    return result
  }
}

extension Element {
  private func _value(for name:AttributeName) -> String? {
    if let attributes = self.attributes, let value = attributes[name] {
      return value
    }
    guard let parent = self.parent else { return nil }
    return parent._value(for:name)
  }
  
  
  public func namespace(for prefix:NoncolonizedName) -> String? {
    return self._value(for:.userDefinedNamespace(prefix))
  }
  
  public func namespace(for name:QualifiedName) -> String? {
    if let prefix = name.prefix {
      if prefix == "xmlns" { return nil }
      return self.namespace(for:prefix)
    }
    return self._value(for:.defaultNamespace)
  }
}
