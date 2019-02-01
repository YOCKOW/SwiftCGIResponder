/* *************************************************************************************************
 TextAreaElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<textarea> element.
open class TextAreaElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "textarea" }
  
  open override var isEmpty: Bool { return false }
  
  open var columnCount: Int? {
    get {
      return self.attributes[localName:"cols", uri:nil].flatMap(Int.init)
    }
    set {
      self.attributes[localName:"cols", uri:nil] = newValue.flatMap(String.init)
    }
  }
  
  open var rowCount: Int? {
    get {
      return self.attributes[localName:"rows", uri:nil].flatMap(Int.init)
    }
    set {
      self.attributes[localName:"rows", uri:nil] = newValue.flatMap(String.init)
    }
  }
  
  open var placeholder: String? {
    get {
      return self.attributes[localName:"placeholder", uri:nil]
    }
    set {
      self.attributes[localName:"placeholder", uri:nil] = newValue
    }
  }
}
