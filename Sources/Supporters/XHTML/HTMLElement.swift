/* *************************************************************************************************
 HTMLElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents "<html>...</html>"
open class HTMLElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "html" }
  
  /// Always `false` because HTML element must have children.
  open override var isEmpty: Bool { return false }
  
  open internal(set) weak var document: Document? = nil
}
