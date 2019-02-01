/* *************************************************************************************************
 CDATASection.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents CDATA section.
open class CDATASection: Node {
  private var _text: String
  
  open override var xhtmlString: String {
    return "<![CDATA[\(self._text)]]>"
  }
  
  public init?(_ string:String) {
    if string.contains("]]>") { return nil }
    self._text = string
  }
}
