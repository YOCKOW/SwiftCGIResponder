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
extension Element {
  internal var _xmlElementWrapper: _XMLNodeWrapper<XMLElement> {
    let xmlElement = try! XMLElement(xmlString:self.xmlString)
    return .init(xmlElement)
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


/// Element that may have some children.
public protocol ParentElement: Element {
  mutating func add<E>(child:E) where E:Element
  mutating func insert<E>(child:E, at index:Int) where E:Element
  mutating func removeChild(at index:Int)
  var children: [AnyElement] { get }
  var childCount: Int { get }
}


/// User of `_XMLNodeWrapper`
internal protocol _XMLElementWrapper {
  var _wrapper: _XMLNodeWrapper<XMLElement> { get set }
}
extension _XMLElementWrapper {
  public var name: String? { return self._wrapper[\.name] }
  public var localName: String? { return self._wrapper[\.localName] }
  public var uri: String? { return self._wrapper[\.uri] }
  public var stringValue: String? {
    get { return self._wrapper[\.stringValue] }
    set { self._wrapper[\.stringValue] = newValue }
  }
  public func xmlString(options mask:XMLNode.Options) -> String {
    return self._wrapper.call(getter:XMLElement.xmlString, arguments:mask)
  }
}
extension Element where Self: _XMLElementWrapper {
  internal var _xmlElementWrapper: _XMLNodeWrapper<XMLElement> {
    return self._wrapper
  }
}
