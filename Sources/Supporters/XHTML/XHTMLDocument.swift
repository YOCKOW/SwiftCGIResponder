/* *************************************************************************************************
 XHTMLDocument.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import LibExtender

/// Represents the XHTML document.
/// This is NOT a subclass of `XMLDocument`, but utilizes it.
public struct Document {
  private var __xmlDocument: XMLDocument!
  private var _xmlDocument: XMLDocument {
    get { return self.__xmlDocument }
    set { self.__xmlDocument = (newValue.copy() as! XMLDocument) }
  }
  
  private init?(_ xmlDocument:XMLDocument) {
    guard
      let localNameOfRootElement = xmlDocument.rootElement()?.localName,
      localNameOfRootElement == "html" else
    {
      return nil
    }
    self._xmlDocument = xmlDocument
  }
  
  /// Initialize with a given string.
  public init?(xmlString string:String, options mask:XMLNode.Options = []) {
    guard let document = try? XMLDocument(xmlString:string, options:mask) else { return nil }
    self.init(document)
  }
  
  /// Create an empty document.
  public init?(version:Version,
               xmlVersion:String = "1.0", stringEncoding encoding:String.Encoding = .utf8,
               options mask:XMLNode.Options = []) {
    guard xmlVersion == "1.0" || xmlVersion == "1.1" else { return nil }
    guard let charset = encoding.ianaCharacterSetName else { return nil }
    guard let doctype = version._documentType else { return nil }
    
    let string =
      "<?xml version=\"\(xmlVersion)\" encoding=\"\(charset)\" ?>\n" +
      "\(doctype)\n" +
      "<html xmlns=\"http://www.w3.org/1999/xhtml\"><head><title></title></head><body></body></html>"
    self.init(xmlString:string, options:mask)
  }
}

// For output.
extension Document {
  public var xmlData: Data {
    return self._xmlDocument.xmlData
  }
  
  public func xmlData(options mask:XMLNode.Options = []) -> Data {
    return self._xmlDocument.xmlData(options:mask)
  }
  
  public var xmlString: String {
    return self._xmlDocument.xmlString
  }
  
  public func xmlString(options mask:XMLNode.Options = []) -> String {
    return self._xmlDocument.xmlString(options:mask)
  }
}
