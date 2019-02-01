/* *************************************************************************************************
 CGIContent.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import TemporaryFile

/// A content to be output via CGI.
public enum CGIContent {
  case data(Data)
  public init(data:Data) { self = .data(data) }
  
  case fileHandle(FileHandle)
  public init(fileHandle:FileHandle) { self = .fileHandle(fileHandle) }
  
  case path(String)
  public init(fileAtPath path:String) { self = .path(path) }
  
  case string(String, encoding:String.Encoding)
  public init(string:String, encoding:String.Encoding = .utf8) { self = .string(string, encoding:encoding) }
  
  case temporaryFile(TemporaryFile)
  public init(temporaryFile:TemporaryFile) { self = .temporaryFile(temporaryFile) }
  
  case url(URL)
  public init(url:URL) { self = .url(url) }
  
  case xhtml(XHTMLDocument)
  public init(xhtml document:XHTMLDocument) { self = .xhtml(document) }
  
  case lazy(() -> CGIContent)
  public init(creator:@escaping () -> CGIContent) { self = .lazy(creator) }
}

