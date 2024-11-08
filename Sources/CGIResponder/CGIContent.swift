/* *************************************************************************************************
 CGIContent.swift
   © 2017-2018,2020,2023-2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
import TemporaryFile
import XHTML
import yExtensions

/// A content to be output via CGI.
public enum CGIContent {
  /// No content will be put out.
  case none
  
  case data(Data)
  public init(data:Data) { self = .data(data) }
  
  case fileHandle(FileHandle)
  public init(fileHandle:FileHandle) { self = .fileHandle(fileHandle) }
  
  case temporaryFile(TemporaryFile)
  public init(temporaryFile: TemporaryFile) { self = .temporaryFile(temporaryFile) }
  
  case path(String)
  public init(fileAtPath path:String) { self = .path(path) }
  
  case string(String, encoding:String.Encoding)
  public init(string:String, encoding:String.Encoding = .utf8) { self = .string(string, encoding:encoding) }
  
  case url(URL)
  public init(url:URL) { self = .url(url) }
  
  case xhtml(XHTMLDocument, asHTML: Bool = false)
  public init(xhtml document: XHTMLDocument, asHTML: Bool = false) { self = .xhtml(document, asHTML: asHTML) }
  
  case xml(XMLDocument, options: XMLNode.Options)
  public init(xml document: XMLDocument, options: XMLNode.Options = []) { self = .xml(document, options: options) }
  
  case lazy(() throws -> CGIContent)
  public init(creator: @escaping () throws -> CGIContent) { self = .lazy(creator) }
}

extension CGIContent {
  /// Determine the content type
  internal var _defaultContentType: ContentType {
    let octetStreamContentType = ContentType(type:.application, subtype:"octet-stream")!
    
    func _parameters(encoding: String.Encoding) -> ContentType.Parameters? {
      guard let charset = encoding.ianaCharacterSetName else { return nil }
      return ["charset": charset]
    }
    
    func _contentType(pathExtension: String,
                      parameters: ContentType.Parameters? = nil) -> ContentType
    {
      return ContentType.PathExtension(rawValue:pathExtension).flatMap {
        ContentType(pathExtension:$0, parameters: parameters)
      } ?? octetStreamContentType
    }
    
    switch self {
    case .path(let path):
      guard
        let indexAfterDot = path.lastIndex(of: ".").flatMap(path.index(after:)),
        indexAfterDot < path.endIndex
        else {
          return octetStreamContentType
      }
      return _contentType(pathExtension: String(path[indexAfterDot..<path.endIndex]))
    case .string(_, encoding: let encoding):
      return ContentType(pathExtension: .txt, parameters: _parameters(encoding: encoding))!
    case .url(let url):
      return _contentType(pathExtension: url.pathExtension)
    case .xhtml(let document, let asHTML):
      let encoding = document.prolog.stringEncoding
      if asHTML {
        return ContentType(pathExtension: .html, parameters: _parameters(encoding: encoding))!
      } else {
        return ContentType(pathExtension: .xhtml, parameters: _parameters(encoding: encoding))!
      }
    case .xml(let document, _):
      if let encodingString = document.characterEncoding,
         let type = ContentType(pathExtension: .xml, parameters: ["charset": encodingString]) {
        return type
      }
      return ContentType(pathExtension: .xml)!
    default:
      return octetStreamContentType
    }
  }
  
  internal var _stringEncoding: String.Encoding? {
    switch self {
    case .string(_, encoding: let encoding):
      return encoding
    case .xhtml(let document, _):
      return document.prolog.stringEncoding
    case .xml(let document, _):
      return document.characterEncoding.flatMap({ String.Encoding(ianaCharacterSetName: $0) })
    default:
      return nil
    }
  }
}
