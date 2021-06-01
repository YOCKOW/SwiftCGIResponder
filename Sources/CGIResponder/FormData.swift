/* *************************************************************************************************
 FormData.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import TemporaryFile
import yExtensions
import yProtocols

private let CR: UInt8 = 0x0D
private let LF: UInt8 = 0x0A
private let HYPHEN: UInt8 = 0x2D

private let TWO_HYPHENS = Data([HYPHEN, HYPHEN])
private let CRLF = Data([CR, LF])

private let BUFFER_SIZE = 16384

private extension HTTPHeader {
  func _canInsertField(named name: HTTPHeaderFieldName) -> Bool {
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
    return (name: name, filename: dispositionParameters[.filename])
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
    return (self._contentType?.parameters?["charset"]).flatMap {
      String.Encoding(ianaCharacterSetName: $0)
    }
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

/// A sequence that represents "multipart/form-data".
/// Iterating items consumes(reads) `stdin`.
public final class FormData: Sequence, IteratorProtocol {
  public typealias Element = Item
  public typealias Iterator = FormData
  
  public enum Error: Swift.Error {
    case base64DecodingFailure
    case invalidBoundary
    case invalidHTTPHeader
    case invalidInput
    case invalidRequest
    case quotedPrintableDecodingFailure
    case tooLongBoundary
    case unexpectedError
  }
  
  // MARK: - FormData.Item
  
  /// Represents each item of contents of "multipart/form-data"
  public struct Item {
    /// Represents a value of the item.
    /// `content` may be expressed by `String`, `URL`, or `TemporaryFile`.
    public struct Value {
      /// Posted data
      public let content: CGIContent
      
      /// The filename tied up with the data.
      public let filename: String?
      
      /// The content type of the data.
      public let contentType: ContentType?
      
      fileprivate init(content: CGIContent, filename: String? = nil, contentType: ContentType? = nil) {
        self.content = content
        self.filename = filename
        self.contentType = contentType
      }
    }
    
    /// A name of the item.
    public let name: String
    
    /// A value of the item.
    public let value: Value
    
    fileprivate init(name: String, value: Value) {
      self.name = name
      self.value = value
    }
  }
  
  // MARK: - Properties of `FormData`
  
  /// Usually this value is `stdin`; You can specify other input for the purpose of debug.
  private var _input: AnyFileHandle! = nil
  
  private var _encoding: String.Encoding! = nil

  private var _boundary: Data! = nil
  private lazy var _boundaryLength: Int = self._boundary.count
  private var _closeBoundary: Data! = nil
  private lazy var _closeBounadryLength: Int = self._closeBoundary.count
  
  private var _temporaryDirectory: TemporaryDirectory! = nil
  
  private var _neverIterate: Bool = false
  
  /// The last error that has occurred when the instance is initialized, or the input is parsed.
  /// Why this property exists is because `func next() -> Element?` that is required by
  /// `IteratorProtocol` cannot throw any errors.
  public fileprivate(set) var error: Swift.Error? = nil
  
  // MARK: End of properties of `FormData` -
  
  /// This initializer must be called from `_FormData`.
  /// `input` will be read to first boundary.
  fileprivate init<FH>(__input input: FH,
                       boundary: String,
                       stringEncoding encoding: String.Encoding,
                       temporaryDirectory: TemporaryDirectory) throws where FH: FileHandleProtocol {
    if boundary.isEmpty {
      throw Error.invalidBoundary
    }
    
    // This should be O(1) because https://swift.org/blog/utf8-string/
    if boundary.utf8.count > 512 {
      throw Error.tooLongBoundary
    }
    
    if temporaryDirectory.isClosed {
      throw CGIResponderError.illegalOperation
    }

    guard let boundaryData = boundary.data(using: encoding) else {
      throw Error.invalidBoundary
    }
    self._boundary = TWO_HYPHENS + boundaryData
    self._closeBoundary = TWO_HYPHENS + boundaryData + TWO_HYPHENS

    self._input = AnyFileHandle(input)
    self._encoding = encoding
    self._temporaryDirectory = temporaryDirectory

    // Skip empty lines and handle first boundary
    while true {
      guard let firstLine = try self._input.read(toByte: LF, upToCount: BUFFER_SIZE) else {
        throw Error.invalidInput
      }
      if firstLine == CRLF { continue }
      guard
        firstLine.count == self._boundaryLength + 2,
        firstLine[self._boundaryLength] == CR,
        firstLine.dropLast(2) == self._boundary
      else {
        throw Error.invalidInput
      }
      break
    }
  }
  
  public func makeIterator() -> FormData {
    return self
  }
  
  public func next() -> Item? {
    if self._neverIterate || self._temporaryDirectory.isClosed { return nil }

    do {
      // Header fields
      var header = HTTPHeader([])
      while true {
        guard let line = try self._input.read(toByte: LF, upToCount: BUFFER_SIZE) else {
          return nil
        }
        if line == CRLF { break } // end of header
        guard
          let headerFieldString = String(data: line, encoding: self._encoding),
          let headerField = HTTPHeaderField(string: headerFieldString),
          header._canInsertField(named: headerField.name)
        else {
          throw Error.invalidHTTPHeader
        }
        header.insert(headerField, removingExistingFields: false)
      }

      guard let (name, filename) = header._name_filename else { throw Error.invalidHTTPHeader }
      let nilableContentType = header._contentType
      let stringEncoding: String.Encoding = header._stringEncoding ?? self._encoding
      let transferEncoding = header._transferEncoding ?? ._7bit

      let temporaryFile = try TemporaryFile(in: self._temporaryDirectory, prefix: "FormData-")

      // Anyway, let's read & write data
      while true {
        guard let data = try self._input.read(toByte: LF, upToCount: BUFFER_SIZE) else {
          return nil
        }
        if data.isEmpty { throw Error.unexpectedError } // data must not be empty because boundary contains "LF"

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
          !dataIsBoundary &&
          _dataIs(self._closeBoundary, length: self._closeBounadryLength, acceptEOF: true)

        if dataIsBoundary || dataIsCloseBoundary {
          // If `data` is boundary,
          // preceding "\r\n" has been already written to the file
          // unless transfer-encoding is base64
          if transferEncoding != .base64 {
            guard try temporaryFile.offset() >= 2 else { throw Error.unexpectedError }
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
          guard let decoded = Data(base64Encoded: data, options: [.ignoreUnknownCharacters]) else {
            throw Error.base64DecodingFailure
          }
          try temporaryFile.write(contentsOf: decoded)
        case .quotedPrintable:
          guard let decoded = Data(quotedPrintableEncoded: data) else {
            throw Error.quotedPrintableDecodingFailure
          }
          try temporaryFile.write(contentsOf: decoded)
        }
      } // end of while-loop (read & write data)

      // if `filename` is nil, regard the data as simple string.
      let value: FormData.Item.Value = try ({
        try temporaryFile.seek(toOffset: 0)
        if filename == nil {
          guard let data = try temporaryFile.readToEnd() else {
            return FormData.Item.Value(content: .string("", encoding: stringEncoding))
          }
          guard let string = String(data: data, encoding: stringEncoding) else {
            throw CGIResponderError.stringConversionFailure
          }
          return FormData.Item.Value(content: .string(string, encoding: stringEncoding))
        } else {
          return FormData.Item.Value(content: .init(temporaryFile: temporaryFile),
                                     filename: filename,
                                     contentType: nilableContentType)
        }
      })()
      return FormData.Item(name: name, value: value)
    } catch {
      self.error = error
      self._neverIterate = true
      return nil
    }
  }
}

private extension FileHandleProtocol {
  var _objectIdentifier: ObjectIdentifier {
    if case let fh as AnyFileHandle = self {
      return fh.objectIdentifier
    } else {
      return .init(self)
    }
  }
}

private var _instances: [ObjectIdentifier: FormData] = [:]
private protocol _FormData {}
extension _FormData {
  init<FH>(_input input: FH,
           boundary: String,
           stringEncoding encoding: String.Encoding,
           temporaryDirectory: TemporaryDirectory) throws where FH: FileHandleProtocol {
    if let instance = _instances[input._objectIdentifier] {
      self = instance as! Self
    } else {
      let newInstance = try FormData(__input: input,
                                     boundary: boundary,
                                     stringEncoding: encoding,
                                     temporaryDirectory: temporaryDirectory)
      _instances[ObjectIdentifier(input)] = newInstance
      self = newInstance as! Self
    }
  }
}

extension FormData: _FormData {
  internal convenience init<FH>(input: FH,
                                boundary: String,
                                stringEncoding encoding: String.Encoding,
                                temporaryDirectory: TemporaryDirectory) throws where FH: FileHandleProtocol {
    try self.init(_input: input,
                  boundary: boundary,
                  stringEncoding: encoding,
                  temporaryDirectory: temporaryDirectory)
  }
}
