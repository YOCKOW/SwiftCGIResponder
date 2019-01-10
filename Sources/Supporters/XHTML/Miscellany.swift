/* *************************************************************************************************
 Miscellany.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Represents List of [Misc.](https://www.w3.org/TR/REC-xml/#NT-Misc)
public final class Miscellany: Node {
  private enum _Node {
    case comment(Comment)
    case processingInstruction(ProcessingInstruction)
  }
  
  private var _node: _Node
  
  public var xmlString: String {
    switch self._node {
    case .comment(let comment): return comment.xmlString
    case .processingInstruction(let pi): return pi.xmlString
    }
  }
  
  public init?(_ node:Node) {
    if case let misc as Miscellany = node {
      self._node = misc._node
    } else if case let comment as Comment = node {
      self._node = .comment(comment)
    } else if case let pi as ProcessingInstruction = node {
      self._node = .processingInstruction(pi)
    } else {
      return nil
    }
  }
}
