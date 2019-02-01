/* *************************************************************************************************
 HeadElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents "\<head\>...\</head\>"
open class HeadElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "head" }
  
  /// Always `false` because \<head> element must have children.
  open override var isEmpty: Bool { return false }
  
  private var _parent: Element? = nil
  public internal(set) override var parent: Element? {
    get {
      return self._parent
    }
    set {
      if let parent = newValue {
        guard parent is HTMLElement else { fatalError("<head> must be a child of <html>") }
        self._parent = parent
      } else {
        self._parent = nil
      }
    }
  }
  
  public var title: TitleElement? {
    for child in self.children {
      if case let titleElement as TitleElement = child { return titleElement }
    }
    return nil
  }
}
