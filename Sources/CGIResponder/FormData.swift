/* *************************************************************************************************
 FormData.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import LibExtender
import TemporaryFile

public enum FormData {}

extension FormData {
  /// Represents each item of contents of "multipart/form-data"
  public struct Item {
    /// Represents value of item.
    /// `content` may be expressed by `String` or `URL`, so its type is `CGIContent`.
    public struct Value {
      public var content: CGIContent
      public var filename: String?
      public var contentType: ContentType?
      public init(content:CGIContent, filename:String? = nil, contentType:ContentType? = nil) {
        self.content = content
        self.filename = filename
        self.contentType = contentType
      }
    }
    
    public var name: String
    public var value: Value
    public init(name:String, value:Value) {
      self.name = name
      self.value = value
    }
  }
}

public typealias FormDataItem = FormData.Item

private let CR: UInt8 = 0x0D
private let LF: UInt8 = 0x0A
extension FormData {
  /// An iterator that supplies the instances of `FormData.Item`.
  public struct Iterator {
    private let _source:FileHandle
    private let _encoding:String.Encoding
    
    private let _boundary:Data
    private var _boundaryLength:Int { return self._boundary.count }
    private let _closeBoundary:Data
    private var _closeBounadryLength:Int { return self._closeBoundary.count }
    
    private let _temporaryDirectory: TemporaryDirectory
    
    private var _bufferSize: Int { return max(16384, self._closeBounadryLength * 2) }
    private var _neverIterate: Bool = false
    
    internal init?(source:FileHandle = ._changeableStandardInput,
                   boundary:String,
                   stringEncoding encoding:String.Encoding = .utf8,
                   temporaryDirectory:TemporaryDirectory)
    {
      if boundary.isEmpty || temporaryDirectory.isClosed { return nil }
      
      guard let boundaryData = "--\(boundary)".data(using:encoding) else { return nil }
      self._boundary = boundaryData
      self._closeBoundary = "--\(boundary)--".data(using:encoding)!
      
      self._source = source
      self._encoding = encoding
      self._temporaryDirectory = temporaryDirectory
      
      // Skip empty lines and handle first boundary
      while true {
        let firstLine = self._source.readData(toByte:LF, maximumLength:self._bufferSize)
        if firstLine.count == 2 && firstLine[0] == CR { continue }
        guard firstLine.count == self._boundaryLength + 2 else { return nil }
        guard firstLine[self._boundaryLength] == CR else { return nil }
        guard firstLine.dropLast(2) == self._boundary else { return nil }
        break
      }
    }
  }
}

public typealias FormDataIterator = FormData.Iterator

extension HTTPHeader {
  fileprivate func _canInsertField(named name:HTTPHeaderFieldName) -> Bool {
    let fields = self[name]
    guard let field = fields.first else { return true }
    return field.isAppendable || field.isDuplicable
  }
  
  fileprivate var _name_filename: (name:String, filename:String?)? {
    guard
      let dispositionField = self[.contentDisposition].first,
      case let disposition as HTTPContentDisposition = dispositionField.source,
      disposition.value == .formData,
      let dispositionParameters = disposition.parameters,
      let name = dispositionParameters[.name],
      !name.isEmpty else
    {
      return nil
    }
    return (name:name, filename:dispositionParameters[.filename])
  }
  
  fileprivate var _contentType: ContentType? {
    guard
      let contentTypeField = self[.contentType].first,
      case let contentType as ContentType = contentTypeField.source else
    {
      return nil
    }
    return contentType
  }
  
  fileprivate var _stringEncoding: String.Encoding? {
    guard let charset = self._contentType?.parameters?["charset"] else { return nil }
    return String.Encoding(ianaCharacterSetName:charset)
  }
  
  fileprivate var _transferEncoding: HTTPContentTransferEncoding? {
    guard
      let transferEncodingField = self[.contentTransferEncoding].first,
      case let transferEncoding as HTTPContentTransferEncoding = transferEncodingField.source else
    {
      return nil
    }
    return transferEncoding
  }
}

extension FormData.Iterator: IteratorProtocol {
  public typealias Element = FormData.Item
  public mutating func next() -> FormData.Item? {
    if self._neverIterate || self._temporaryDirectory.isClosed { return nil }
    
    // Header fields
    var header = HTTPHeader([])
    while true {
      let line = self._source.readData(toByte:LF, maximumLength:self._bufferSize)
      if line.count == 2 && line[0] == CR { break } // end of header
      guard let headerFieldString = String(data:line, encoding:self._encoding) else { return nil }
      guard let headerField = HTTPHeaderField(string:headerFieldString) else { return nil }
      if !header._canInsertField(named:headerField.name) { return nil }
      header.insert(headerField, removingExistingFields:false)
    }
    
    guard let (name, filename) = header._name_filename else { return nil }
    let nilableContentType = header._contentType
    let stringEncoding = header._stringEncoding ?? self._encoding
    let transferEncoding = header._transferEncoding ?? ._7bit
    
    let temporaryFile = TemporaryFile(in:self._temporaryDirectory, prefix:"FormData-")
    
    // Anyway, let's read & write data
    while true {
      let data = self._source.readData(toByte:LF, maximumLength:self._bufferSize)
      if data.isEmpty { return nil } // data must not be empty because boundary contains "LF"
      
      func _dataIs(_ boundary:Data, length:Int, acceptEOF:Bool) -> Bool {
        if acceptEOF && data.count == length && data == boundary { return true }
        guard data.count == length + 2 else { return false }
        guard data[length] == CR else { return false }
        guard data.dropLast(2) == boundary else  { return false }
        return true
      }
      
      let dataIsBoundary: Bool = _dataIs(self._boundary, length:self._boundaryLength, acceptEOF:false)
      let dataIsCloseBoundary: Bool = _dataIs(self._closeBoundary, length:self._closeBounadryLength, acceptEOF:true)
      
      if dataIsBoundary || dataIsCloseBoundary {
        // If `data` is boundary,
        // preceding "\r\n" has been already written to the file
        // unless transfer-encoding is base64
        if transferEncoding != .base64 {
          guard temporaryFile.offsetInFile >= 2 else { return nil }
          // delete last "\r\n"
          temporaryFile.truncateFile(atOffset:temporaryFile.offsetInFile - 2)
        }
        if dataIsCloseBoundary {
          // end of data
          self._neverIterate = true
        }
        break
      }
      
      // write the data...
      switch transferEncoding {
      case ._7bit, ._8bit, .binary:
        temporaryFile.write(data)
      case .base64:
        guard let decoded = Data(base64Encoded:data, options:[.ignoreUnknownCharacters]) else {
          warn(message:.cannotDecodeBase64)
          return nil
        }
        temporaryFile.write(decoded)
      case .quotedPrintable:
        guard let decoded = Data(quotedPrintableEncoded:data) else {
          warn(message:.cannotDecodeQuotedPrintable)
          return nil
        }
        temporaryFile.write(decoded)
      }
    } // end of while-loop (read & write data)
    
    // if `filename` is nil, regard the data as simple string.
    guard let value: FormData.Item.Value = ({
      if filename == nil {
        temporaryFile.seek(toFileOffset:0)
        guard let string = String(data:temporaryFile.availableData, encoding:stringEncoding) else {
          return nil
        }
        return FormData.Item.Value(content:.string(string, encoding:stringEncoding))
      } else {
        return FormData.Item.Value(content:.temporaryFile(temporaryFile),
                                   filename:filename,
                                   contentType:nilableContentType)
      }
    })() else { return nil }
    
    return FormData.Item(name:name, value:value)
  }
}
