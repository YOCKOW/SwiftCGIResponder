/* *************************************************************************************************
 FormData.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import NetworkGear
import TemporaryFile
import yExtensions
import yProtocols

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
    public enum Error: Swift.Error {
      case invalidBoundary
      case invalidInput
      case invalidRequest
    }
    
    private var _input: AnyFileHandle
    private let _encoding:String.Encoding
    
    private let _boundary:Data
    private var _boundaryLength:Int { return self._boundary.count }
    private let _closeBoundary:Data
    private var _closeBounadryLength:Int { return self._closeBoundary.count }
    
    private let _temporaryDirectory: TemporaryDirectory
    
    private var _bufferSize: Int { return max(16384, self._closeBounadryLength * 2) }
    private var _neverIterate: Bool = false
    
    internal init<FH>(input: FH,
                      boundary: String,
                      stringEncoding encoding: String.Encoding = .utf8,
                      temporaryDirectory: TemporaryDirectory) throws where FH: FileHandleProtocol {
      if boundary.isEmpty {
        throw Error.invalidInput
      }
      if temporaryDirectory.isClosed {
        throw CGIResponderError.illegalOperation
      }
      
      guard let boundaryData = "--\(boundary)".data(using: encoding) else {
        throw Error.invalidBoundary
      }
      self._boundary = boundaryData
      self._closeBoundary = "--\(boundary)--".data(using:encoding)!
      
      self._input = (input as? AnyFileHandle) ?? AnyFileHandle(input)
      self._encoding = encoding
      self._temporaryDirectory = temporaryDirectory
      
      // Skip empty lines and handle first boundary
      while true {
        guard let firstLine = try self._input.read(toByte: LF, upToCount:self._bufferSize) else {
          throw Error.invalidInput
        }
        if firstLine.count == 2 && firstLine[0] == CR { continue }
        guard
          firstLine.count == self._boundaryLength + 2,
          firstLine[self._boundaryLength] == CR,
          firstLine.dropLast(2) == self._boundary
        else {
          throw Error.invalidBoundary
        }
        break
      }
    }
    
    internal init(boundary: String,
                  stringEncoding encoding: String.Encoding = .utf8,
                  temporaryDirectory: TemporaryDirectory) throws {
      try self.init(input: _changeableStandardInput,
                    boundary: boundary,
                    stringEncoding: encoding,
                    temporaryDirectory: temporaryDirectory)
    }
  }
}

public typealias FormDataIterator = FormData.Iterator

private extension HTTPHeader {
  func _canInsertField(named name:HTTPHeaderFieldName) -> Bool {
    let fields = self[name]
    guard let field = fields.first else { return true }
    return field.isAppendable || field.isDuplicable
  }
  
  var _name_filename: (name:String, filename:String?)? {
    guard
      let dispositionField = self[.contentDisposition].first,
      case let disposition as ContentDisposition = dispositionField.source,
      disposition.value == .formData,
      let dispositionParameters = disposition.parameters,
      let name = dispositionParameters[.name],
      !name.isEmpty else
    {
      return nil
    }
    return (name:name, filename:dispositionParameters[.filename])
  }
  
  var _contentType: ContentType? {
    guard
      let contentTypeField = self[.contentType].first,
      case let contentType as ContentType = contentTypeField.source else
    {
      return nil
    }
    return contentType
  }
  
  var _stringEncoding: String.Encoding? {
    guard let charset = self._contentType?.parameters?["charset"] else { return nil }
    return String.Encoding(ianaCharacterSetName:charset)
  }
  
  var _transferEncoding: ContentTransferEncoding? {
    guard
      let transferEncodingField = self[.contentTransferEncoding].first,
      case let transferEncoding as ContentTransferEncoding = transferEncodingField.source else
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
    
    do {
      // Header fields
      var header = HTTPHeader([])
      while true {
        guard let line = try self._input.read(toByte: LF, upToCount: self._bufferSize) else {
          return nil
        }
        if line.count == 2 && line[0] == CR { break } // end of header
        guard let headerFieldString = String(data: line, encoding: self._encoding) else { return nil }
        guard let headerField = HTTPHeaderField(string: headerFieldString) else { return nil }
        if !header._canInsertField(named: headerField.name) { return nil }
        header.insert(headerField, removingExistingFields: false)
      }
      
      guard let (name, filename) = header._name_filename else { return nil }
      let nilableContentType = header._contentType
      let stringEncoding = header._stringEncoding ?? self._encoding
      let transferEncoding = header._transferEncoding ?? ._7bit
      
      let temporaryFile = try TemporaryFile(in: self._temporaryDirectory, prefix: "FormData-")
      
      // Anyway, let's read & write data
      while true {
        guard let data = try self._input.read(toByte: LF, upToCount: self._bufferSize) else {
          return nil
        }
        if data.isEmpty { return nil } // data must not be empty because boundary contains "LF"
        
        func _dataIs(_ boundary: Data, length: Int, acceptEOF: Bool) -> Bool {
          if acceptEOF && data.count == length && data == boundary { return true }
          guard data.count == length + 2 else { return false }
          guard data[length] == CR else { return false }
          guard data.dropLast(2) == boundary else  { return false }
          return true
        }
        
        let dataIsBoundary: Bool =
          _dataIs(self._boundary, length: self._boundaryLength, acceptEOF: false)
        let dataIsCloseBoundary: Bool =
          _dataIs(self._closeBoundary, length: self._closeBounadryLength, acceptEOF: true)
        
        if dataIsBoundary || dataIsCloseBoundary {
          // If `data` is boundary,
          // preceding "\r\n" has been already written to the file
          // unless transfer-encoding is base64
          if transferEncoding != .base64 {
            guard try temporaryFile.offset() >= 2 else { return nil }
            // delete last "\r\n"
            try temporaryFile.truncate(atOffset: temporaryFile.offset() - 2)
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
          try temporaryFile.write(contentsOf: data)
        case .base64:
          guard let decoded = Data(base64Encoded:data, options:[.ignoreUnknownCharacters]) else {
            warn(message: .cannotDecodeBase64)
            return nil
          }
          try temporaryFile.write(contentsOf: decoded)
        case .quotedPrintable:
          guard let decoded = Data(quotedPrintableEncoded:data) else {
            warn(message:.cannotDecodeQuotedPrintable)
            return nil
          }
          try temporaryFile.write(contentsOf: decoded)
        }
      } // end of while-loop (read & write data)
      
      // if `filename` is nil, regard the data as simple string.
      let value: FormData.Item.Value = try ({
        try temporaryFile.seek(toOffset: 0)
        if filename == nil {
          guard let string = try temporaryFile.readToEnd().flatMap({ String(data: $0, encoding: stringEncoding) }) else {
            throw CGIResponderError.stringConversionFailure
          }
          return FormData.Item.Value(content: .string(string, encoding:stringEncoding))
        } else {
          return FormData.Item.Value(content: .init(temporaryFile: temporaryFile),
                                     filename: filename,
                                     contentType: nilableContentType)
        }
      })()
      
      return FormData.Item(name:name, value:value)
    } catch {
      warn(message: .error(error))
      return nil
    }
  }
}
