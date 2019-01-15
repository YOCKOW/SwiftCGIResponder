/* *************************************************************************************************
 BodyElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Represents "\<body\>...\</body\>"
open class BodyElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "body" }
  
  /// Always `false` because HTML element must have children.
  open override var isEmpty: Bool { return false }
}

