/* *************************************************************************************************
 Comment.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

/// Validate the text.
/// Reference: https://www.w3.org/TR/REC-xml/#sec-comments
private func _validateTextOfComment(_ text:String) -> Bool {
  let scalars = text.unicodeScalars
  var ii = scalars.startIndex
  while true {
    if ii >= scalars.endIndex { break }
    let nextIndex = scalars.index(after:ii)
    
    let scalar = scalars[ii]
    guard UnicodeScalarSet.xmlCharacterScalars.contains(scalar) else { return false }
    if scalar == "-" {
      guard nextIndex < scalars.endIndex else { return false }
      guard scalars[nextIndex] != "-" else { return false }
    }
    
    ii = nextIndex
  }
  return true
}


/// Represents the comment.
public final class Comment: Node {
  /// Parent node.
  public internal(set) weak var parent: Node? = nil
  
  private var _text: String
  
  /// The text of comment.
  public var text: String {
    get {
      return self._text
    }
    set {
      guard _validateTextOfComment(newValue) else { fatalError("Invalid text for comment.") }
      self._text = newValue
    }
  }
  
  public init?(_ text:String) {
    guard _validateTextOfComment(text) else { return nil }
    self._text = text
  }
  
  public var xmlString:String {
    return "<!--\(self.text)-->"
  }
}
