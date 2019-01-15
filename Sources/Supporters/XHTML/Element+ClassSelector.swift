/* *************************************************************************************************
 Element+ClassSelector.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

extension Element {
  /// The class to select a class that the parser will use to create element instances.
  /// The registered classes will not be used
  /// if the namespace of the QName of the element is not XHTML's.
  public final class ClassSelector {
    private init() {}
    public static let `default`: ClassSelector = .init()
    
    private var _list:[NoncolonizedName:Element.Type] = [
      "body":BodyElement.self,
      "head":HeadElement.self,
      "title":TitleElement.self,
    ]
    
    /// Register `class` for the element whose local name is `localName`.
    public func register(_ class:Element.Type, for localName:NoncolonizedName) {
      self._list[localName] = `class`
    }
    
    internal func _class(for localName:NoncolonizedName) -> Element.Type? {
      return self._list[localName]
    }
  }
}

extension QualifiedName {
  /// Whether the name's namespace is XHTML or not.
  /// **Doesn't consider the parent nodes.**
  fileprivate func _namespaceIsXHTML(with attributes:Attributes?) -> Bool {
    guard let attributes = attributes else { return false }
    guard let ns = attributes._namespace(for:self), ns._isXHTMLNamespace else { return false }
    return true
  }
}



internal protocol _ElementClassSelector {}
extension Element: _ElementClassSelector {}
extension _ElementClassSelector {
  internal init(name:QualifiedName,
                attributes:Attributes?,
                parent:Element?)
  {
    if name.localName == "html" && name._namespaceIsXHTML(with:attributes) {
      self = HTMLElement(name:name, attributes:attributes) as! Self
      return
    }
    
    let namespaceIsXHTML: Bool = ({
      if name._namespaceIsXHTML(with:attributes) {
        return true
      }
      if let ns = parent?.namespace(for:name), ns._isXHTMLNamespace {
        return true
      }
      return false
    })()
    
    if namespaceIsXHTML {
      if let cls = Element.ClassSelector.default._class(for:name.localName) {
        self = cls.init(name:name, attributes:attributes) as! Self
        return
      }
    }
  
    self = Element(name:name, attributes:attributes) as! Self
  }
}
