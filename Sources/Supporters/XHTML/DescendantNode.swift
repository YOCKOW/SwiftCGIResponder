/* *************************************************************************************************
 DescendantNode.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// The node that can be a child of an element.
/// `var xhtmlString: String { get }` must be overriden in child classes.
open class DescendantNode: Node {
  public var xhtmlString: String { fatalError("var xhtmlString:String { get } must be overriden.") }
  
  /// Parent node
  public internal(set) weak var parent: Element? = nil
}
