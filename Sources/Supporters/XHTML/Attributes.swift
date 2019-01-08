/* *************************************************************************************************
 Attributes.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents attributes of XHTML Element.
public struct Attributes {
  private var _attributes:[AttributeName:String]
  private var _attributesForLocalName:[NoncolonizedName:[AttributeName:String]]
  
  public init() {
    self._attributes = [:]
    self._attributesForLocalName = [:]
  }
}

extension Attributes {
  public subscript(_ name:AttributeName) -> String? {
    get {
      return self._attributes[name]
    }
    set {
      self._attributes[name] = newValue
      switch name {
      case .defaultNamespaceDeclaration:
        break
      case .userDefinedNamespaceDeclaration(let ncName):
        if self._attributesForLocalName[ncName] == nil {
          self._attributesForLocalName[ncName] = [:]
        }
        self._attributesForLocalName[ncName]![name] = newValue
      case .attributeName(let qName):
        if self._attributesForLocalName[qName.localName] == nil {
          self._attributesForLocalName[qName.localName] = [:]
        }
        self._attributesForLocalName[qName.localName]![name] = newValue
      }
    }
  }
  
  public subscript(localName localName:NoncolonizedName, uri uri:String?) -> String? {
    if let _ = uri {
      fatalError("Unimplemented yet: identifying the URI associated with an attribute.")
    } else {
      return self[.attributeName(QualifiedName(localName:localName))]
    }
  }
}

extension Attributes {
  internal init(_ dictionary:[String:String]) {
    self.init()
    for (key, value) in dictionary {
      guard let name = AttributeName(key) else { continue }
      self[name] = value
    }
  }
}
