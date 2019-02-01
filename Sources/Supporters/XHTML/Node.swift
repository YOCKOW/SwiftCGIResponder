/* *************************************************************************************************
 Node.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// The nodes in the abstract, logical tree structure
/// that represents an XHTML document like `XMLNode`.
open class Node: Equatable {
  /// The string representation as it would appear in an XHTML document.
  open var xhtmlString: String { return "<!-- `var xhtmlString: String` must be overridden. -->" }
  
  /// The parent node.
  public internal(set) var parent: Element? = nil
  
  public func isEqual(to other:Node) -> Bool { return self === other }
  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.isEqual(to:rhs)
  }
}

extension Node {
  /// Create an \<a\> element.
  public static func a(name:QualifiedName = "a",
                       href:String, text:String,
                       attributes:Attributes = [:]) -> Node
  {
    return AnchorElement(name: name, hypertextReference: href, text: text, attributes: attributes)
  }
  
  /// Create an \<body\> element.
  public static func body(name:QualifiedName = "body",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return BodyElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create a \<br /> element.
  public static func br(name:QualifiedName = "br", attributes:Attributes = [:]) -> Node {
    return LineBreakElement(name: name, attributes: attributes)
  }
  
  /// Create an XHTML comment node.
  /// Fatal error will occur if `text` is invalid for XML comment.
  public static func comment(_ text:String) -> Node {
    guard let comment = Comment(text) else { fatalError("Invalid text for comment.") }
    return comment
  }
  
  public static func form(name:QualifiedName = "form",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return FormElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an \<head\> element.
  public static func head(name:QualifiedName = "head",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return HeadElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an \<html\> element.
  public static func html(name:QualifiedName = "html",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return HTMLElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an \<input\> element.
  public static func input(name:QualifiedName = "input",
                           type:InputElement.TypeValue,
                           nameAttribute:String? = nil,
                           value:String? = nil,
                           attributes:Attributes = [:]) -> Node
  {
    return InputElement(name:name,
                        type:type, nameAttribute:nameAttribute, value:value,
                        attributes:attributes)
  }
  
  /// Create an XHTML text node.
  public static func text(_ text:String) -> Node {
    return Text(text)
  }
  
  /// Create an \<title\> element.
  public static func title(name:QualifiedName = "title",
                           attributes:Attributes = [:],
                           _ title: String) -> Node
  {
    let titleElement = TitleElement(name:name, attributes:attributes)
    titleElement.title = title
    return titleElement
  }
}
