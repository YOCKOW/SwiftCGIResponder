/* *************************************************************************************************
 String+Constants.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension String {
  internal static let _xhtmlNamespace: String = "http://www.w3.org/1999/xhtml"
  
  internal var _isXHTMLNamespace: Bool {
    return self == ._xhtmlNamespace
  }
}
