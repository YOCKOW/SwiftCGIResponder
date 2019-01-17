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
  
  public func isEqual(to another:Node) -> Bool { return self === another }
  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.isEqual(to:rhs)
  }
}

extension Node {
  /// Create an \<body\> element.
  public static func body(name:QualifiedName = "body",
                          attributes:Attributes? = nil,
                          children:[Node] = []) -> Node
  {
    return BodyElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an XHTML comment node.
  /// Fatal error will occur if `text` is invalid for XML comment.
  public static func comment(_ text:String) -> Node {
    guard let comment = Comment(text) else { fatalError("Invalid text for comment.") }
    return comment
  }
  
  /// Create an \<head\> element.
  public static func head(name:QualifiedName = "head",
                          attributes:Attributes? = nil,
                          children:[Node] = []) -> Node
  {
    return HeadElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an \<html\> element.
  public static func html(name:QualifiedName = "html",
                         attributes:Attributes? = nil,
                         children:[Node] = []) -> Node
  {
    return HTMLElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an XHTML text node.
  public static func text(_ text:String) -> Node {
    return Text(text)
  }
  
  /// Create an \<title\> element.
  public static func title(name:QualifiedName = "title",
                           attributes:Attributes? = nil,
                           _ title: String) -> Node
  {
    let titleElement = TitleElement(name:name, attributes:attributes)
    titleElement.title = title
    return titleElement
  }
}
