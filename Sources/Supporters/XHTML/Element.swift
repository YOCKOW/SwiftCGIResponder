/* *************************************************************************************************
 Element.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

/// A type of an element of XHTML.
public protocol Element: Hashable {
  var name: String? { get }
  var localName: String? { get }
  var uri: String? { get }
  
  var stringValue: String? { get set }
  func xmlString(options mask:XMLNode.Options) -> String
}

extension Element {
  public var xmlString: String {
    return self.xmlString(options:.nodeCompactEmptyElement)
  }
}


/// Element that has no children, but some text.
public protocol TextHolderElement: Element {}
extension TextHolderElement {
  public var text: String {
    get {
      guard let text = self.stringValue else { fatalError("There is no text in the element.") }
      return text
    }
    set {
      self.stringValue = newValue
    }
  }
}
