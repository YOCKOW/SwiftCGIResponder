/* *************************************************************************************************
 Node.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// The nodes in the abstract, logical tree structure
/// that represents an XHTML document like `XMLNode`.
open class Node {
  /// The string representation as it would appear in an XHTML document.
  open var xhtmlString: String { return "<!-- `var xhtmlString: String` must be overridden. -->" }
  
  /// The parent node.
  public internal(set) var parent: Element? = nil
}

extension Node {
  /// Create an XHTML comment node.
  /// Fatal error will occur if `text` is invalid for XML comment.
  public static func comment(_ text:String) -> Node {
    guard let comment = Comment(text) else { fatalError("Invalid text for comment.") }
    return comment
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
}
