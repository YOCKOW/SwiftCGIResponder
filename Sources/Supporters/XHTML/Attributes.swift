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
  
  /// Owner of the attributes.
  public internal(set) weak var element: Element? = nil
  
  public init() {
    self._attributes = [:]
    self._attributesForLocalName = [:]
  }
}

extension Attributes {
  /// Returns the attribute value with the specified `name`.
  public subscript(_ name:AttributeName) -> String? {
    get {
      return self._attributes[name]
    }
    set {
      self._attributes[name] = newValue
      switch name {
      case .defaultNamespace:
        break
      case .userDefinedNamespace(let ncName):
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
  
  internal func _namespace(for qName:QualifiedName) -> String? {
    let attributeName: AttributeName =
      (qName.prefix != nil) ? .userDefinedNamespace(qName.prefix!) : .defaultNamespace
    if let ns = self[attributeName] {
      return ns
    }
    guard let element = self.element else { return nil }
    return element.namespace(for:qName)
  }
  
  /// Returns the attribute value that is identified by a local name and URI.
  public subscript(localName localName:NoncolonizedName, uri uri:String?) -> String? {
    if let namespace = uri {
      guard let list = self._attributesForLocalName[localName] else { return nil }
      for (name, value) in list {
        guard case .attributeName(let qName) = name else { continue }
        if self._namespace(for:qName) == namespace { return value }
      }
      return nil
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

extension Attributes: ExpressibleByDictionaryLiteral {
  public typealias Key = AttributeName
  public typealias Value = String
  public init(dictionaryLiteral elements: (AttributeName, String)...) {
    self.init()
    for element in elements {
      self[element.0] = element.1
    }
  }
}

extension Attributes: Sequence {
  public func makeIterator() -> DictionaryIterator<AttributeName, String> {
    return self._attributes.makeIterator()
  }
}
