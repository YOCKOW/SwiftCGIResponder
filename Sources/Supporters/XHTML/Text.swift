/* *************************************************************************************************
 Text.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents text.
open class Text: Node {
  open var text: String
  public init(_ text:String) {
    self.text = text
  }
  
  open override var xhtmlString: String {
    return self.text._addingAmpersandEncoding()
  }
}
