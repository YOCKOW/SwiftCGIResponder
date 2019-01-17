/* *************************************************************************************************
 Element.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
 
open class Element: Node {
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
  
  private var _children: [Node] = []
  public var children: [Node] {
    get {
      return self._children
    }
    set {
      self._children = newValue
      for child in self._children {
        child.parent = self
      }
    }
  }
  
  /// Returns the Boolean value that indicates whether the receiver is an empty-element or not.
  open var isEmpty: Bool {
    return self._children.isEmpty
  }
  
  public init(name:QualifiedName) {
    self.name = name
  }
  
  /// Initialize with `name`, and then add `attributes`.
  public required convenience init(name:QualifiedName, attributes:Attributes?) {
    self.init(name:name)
    self.attributes = attributes
  }
  
  /// Initialize with `name`, and then add `attributes` and `children`.
  public convenience init(name:QualifiedName,
                          attributes:Attributes?,
                          children:[Node])
  {
    self.init(name:name, attributes:attributes)
    self.children = children
  }
  
  open override var xhtmlString: String {
    var result = "<\(self.name.description)"
    
    if let attrs = self.attributes {
      result += " " +
        attrs.map { (name:AttributeName, value:String) -> String in
          return "\(name.description)=\"\(value._addingAmpersandEncoding())\""
        }.joined(separator:" ")
    }
    
    if self.isEmpty {
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
  
  public func append(_ child:Node) {
    child.parent = self
    self._children.append(child)
  }
  
  public func insert(_ child:Node, at index:Int) {
    child.parent = self
    self._children.insert(child, at:index)
  }
  
  public func removeChild(at index:Int) {
    let child = self._children.remove(at:index)
    child.parent = nil
  }
}

extension Element {
  /// Returns URI that specifies namespace for `prefix`.
  public func namespace(for prefix:NoncolonizedName?) -> String? {
    // Don't call `Attributes.namespace(for:)`, or induce infinite loop.
    if let namespace = self._attributes?._namespace(for:prefix) {
      return namespace
    }
    guard let parent = self.parent else { return nil }
    return parent.namespace(for:prefix)
  }
  
  /// Returns URI that specifies namespace for prefix of `qName`.
  public func namespace(for qName:QualifiedName) -> String? {
    return self.namespace(for:qName.prefix)
  }
  
  /// Returns prefix for namespace specified by `uri`.
  /// Returns `Optional<NoncolonizedName>.none` if the namespace is default.
  /// Returns `Optional<Optional<NoncolonizedName>>.none` if there is no namespace specified by `uri`.
  public func prefix(for uri:String) -> NoncolonizedName?? {
    if let prefix = self._attributes?._prefix(for:uri) {
      return prefix
    }
    guard let parent = self.parent else { return Optional<Optional<NoncolonizedName>>.none }
    return parent.prefix(for:uri)
  }
}
