/***************************************************************************************************
 AnyIterator+FormDataItem.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/// Extend `AnyIterator` to parse "multipart/form-data"
extension AnyIterator where Element == FormDataItem {
  /// Contents of `source` must be "multipart/form-data".
  /// Although `source` might be usually Standard Input,
  /// you can specify other `FileHandle` for the debug purpose.
  internal init(with source:FileHandle,
                boundary:String,
                stringEncoding encoding:String.Encoding = .utf8,
                temporaryDirectory:TemporaryDirectory) {
    if boundary.isEmpty || temporaryDirectory.isClosed {
      self.init({ return nil })
      return
    }
    
    guard let boundaryData = "--\(boundary)".data(using:encoding) else {
      self.init({ return nil })
      return
    }
    let closeBoundaryData = "--\(boundary)--".data(using:encoding)!
    
    
    let lengthOfBoundary = boundaryData.count
    let lengthOfCloseBoundary = closeBoundaryData.count
    
    let bufferSize: Int = 16384 // no reason
    let CR: UInt8 = 0x0D
    let LF: UInt8 = 0x0A
    
    // Skip empty lines and handle first boundary
    while true {
      let firstLine = source.readData(toByte:LF, maximumLength:bufferSize)
      if firstLine.count == 2 && firstLine[0] == CR { continue }
      guard firstLine.count == lengthOfBoundary + 2 else { self.init({ return nil }); return }
      guard firstLine[lengthOfBoundary] == CR else { self.init({ return nil }); return }
      guard firstLine.dropLast(2) == boundaryData else { self.init({ return nil }); return }
      break
    }
    
    // `neverIterate` will be `true` at the end of data
    var neverIterate: Bool = false
    
    // here starts the body.
    self.init({
      if neverIterate || temporaryDirectory.isClosed { return nil }
      
      var header = HTTPHeader(fields:[])
      // First, handles header fields...
      while true {
        let line = source.readData(toByte:LF, maximumLength:bufferSize)
        if line.count == 2 && line[0] == CR { break } // end of header
        guard let headerFieldString = String(data:line, encoding:encoding) else { return nil }
        guard let headerField = HTTPHeaderField(string:headerFieldString) else { return nil }
        header.set(headerField)
      }
      
      // Check header fields
      
      //// `name` and `filename`
      guard let dispositionField = header.fields(forName:.contentDisposition).first else { return nil }
      let dispositionDelegate = dispositionField.delegate as! SpecifiedHTTPHeaderFieldDelegate.ContentDisposition
      let disposition = dispositionDelegate.contentDisposition
      guard disposition.value == .formData else { return nil }
      guard let dispositionParameters = disposition.parameters else { return nil }
      guard let name = dispositionParameters[.name] else { return nil }
      if name.isEmpty { return nil }
      let filename: String? = dispositionParameters[.filename]
      
      //// `contentType`  `stringEncoding` and `transferEncoding`
      let contentType: MIMEType? = ({
        if let contentTypeField = header.fields(forName:.contentType).first {
          let contentTypeDelegate = contentTypeField.delegate as! SpecifiedHTTPHeaderFieldDelegate.ContentType
          return contentTypeDelegate.contentType
        }
        return nil
      })()
      let stringEncoding: String.Encoding = ({
        if let charset = contentType?.parameters?["charset"] {
          return String.Encoding(ianaCharacterSetName:charset) ?? encoding
        }
        return encoding
      })()
      let transferEncoding: ContentTransferEncoding = ({
        if let transferEncodingField = header.fields(forName:.contentTransferEncoding).first {
          let transferEncodingDelegate = transferEncodingField.delegate as! SpecifiedHTTPHeaderFieldDelegate.ContentTransferEncoding
          return transferEncodingDelegate.contentTransferEncoding
        }
        return ._7bit
      })()
      
      // Create a temporary file
      guard let temporaryFile = TemporaryFile(in:temporaryDirectory, prefix:"FormDataItem-") else {
        warn("\(#function): Could not create a temporary file.")
        return nil
      }
      
      // Anyway, read & write data
      while true {
        let data = source.readData(toByte:LF, maximumLength:bufferSize)
        if data.isEmpty { return nil } // data must not be empty because boundary contains "LF"
        
        let dataIsBoundary: Bool = (
          data.count == lengthOfBoundary + 2 &&
          data[lengthOfBoundary] == CR &&
          data.dropLast(2) == boundaryData
        )
        let dataIsCloseBoundary: Bool = (
          (
            data.count == lengthOfCloseBoundary &&
            data == closeBoundaryData
          ) ||
          (
            data.count == lengthOfCloseBoundary + 2 &&
            data[lengthOfCloseBoundary] == CR &&
            data.dropLast(2) == closeBoundaryData
          )
        )
        
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
            neverIterate = true
          }
          break
        }
        
        // write the data...
        switch transferEncoding {
        case ._7bit, ._8bit, .binary:
          temporaryFile.write(data)
        case .base64:
          guard let decoded = Data(base64Encoded:data, options:[.ignoreUnknownCharacters]) else {
            warn("\(#function): Could not decode BASE64 data.")
            return nil
          }
          temporaryFile.write(decoded)
        case .quotedPrintable:
          guard let decoded = Data(quotedPrintableEncoded:data) else {
            warn("\(#function): Could not decode quoted-printable data.")
            return nil
          }
          temporaryFile.write(decoded)
        }
      } // end of while-loop (read & write data)
      
      // if `filename` is nil, regard the data as simple string.
      guard let value: FormDataItem.Value = ({
        if filename == nil {
          temporaryFile.seek(toFileOffset:0)
          guard let string = String(data:temporaryFile.availableData, encoding:stringEncoding) else {
            warn("\(#function): Could not create string from data.")
            return nil
          }
          return FormDataItem.Value(content:.string(string, encoding:stringEncoding))
        } else {
          return FormDataItem.Value(content:.temporaryFile(temporaryFile),
                                    filename:filename,
                                    contentType:contentType)
        }
      })() else { return nil }
      
      return FormDataItem(name:name, value:value)
    })
  }
}
