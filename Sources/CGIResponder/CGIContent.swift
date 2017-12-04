/***************************************************************************************************
 CGIContent.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # CGIContent
 Wrapper of content to be output.
 
 */
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
  
  case onCall(() -> CGIContent)
  public init(creator:@escaping () -> CGIContent) { self = .onCall(creator) }
}

extension CGIContent {
  /// `data` is just a content.
  /// `data` should not be `nil`. It must be handled as an error if it is nil.
  public var data: Data? {
    switch self {
    case .data(let data):
      return data
    case .fileHandle(let fileHandle):
      return fileHandle.availableData
    case .path(let path):
      let url = URL(fileURLWithPath:path)
      return try? Data(contentsOf:url)
    case .string(let string, encoding:let encoding):
      return string.data(using:encoding)
    case .temporaryFile(let temporaryFile):
      return temporaryFile.availableData
    case .url(let url):
      return try? Data(contentsOf:url)
    case .onCall(let creator):
      return creator().data
    }
  }
}

extension CGIContent: Equatable {
  /// Let `CGIContent` be Equatable.
  public static func ==(lhs: CGIContent, rhs: CGIContent) -> Bool {
    switch (lhs, rhs) {
    case (.data(let ldata), .data(let rdata)): return ldata == rdata
    case (.fileHandle(let lfh), .fileHandle(let rfh)): return lfh == rfh
    case (.path(let lpath), .path(let rpath)): return CGIContent(url:URL(fileURLWithPath:lpath)) == CGIContent(url:URL(fileURLWithPath:rpath))
    case (.string(let lstring), .string(let rstring)): return lstring == rstring
    case (.temporaryFile(let ltmp), .temporaryFile(let rtmp)): return ltmp == rtmp
    case (.url(let lurl), .url(let rurl)): return lurl.resolvingSymlinksInPath() == rurl.resolvingSymlinksInPath()
    default: return false
    }
  }
}

