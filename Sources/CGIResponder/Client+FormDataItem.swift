/***************************************************************************************************
 Client+FormDataItem.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension Client {
  /**
   
   Returns an instance of AnyIterator<FormDataItem>.
   
   - parameter temporaryDirectory: Temporary directory that will contain uploaded files temporarily
   
   ## Important notes
     * Calling this method more than once will return meaningless iterator.
     * The uploaded files may be lost unless copying them to another location, because, the temporary directory will be removed at the end of program.
   
   */
  public func formDataItems(using temporaryDirectory:TemporaryDirectory) -> AnyIterator<FormDataItem> {
    let emptyIterator = AnyIterator<FormDataItem> { return nil }
    
    guard let clientContentType = self.contentType else {
      warn("\(#function): No request content type is specified.")
      return emptyIterator
    }
    guard clientContentType.type == .multipart && clientContentType.subtype == "form-data" else {
      warn("\(#function): Request Content-Type is not `multipart/form-data`")
      return emptyIterator
    }
    guard let clientContentTypeParameters = clientContentType.parameters else {
      warn("\(#function): No parameters in request Content-Type")
      return emptyIterator
    }
    guard let boundary = clientContentTypeParameters["boundary"] else {
      warn("\(#function): No boundary is specified in request Content-Type")
      return emptyIterator
    }
    if boundary.isEmpty {
      warn("\(#function): Boundary is empty")
      return emptyIterator
    }
    
    let clientStringEncoding: String.Encoding = ({
      guard let charset = clientContentTypeParameters["charset"]  else { return .utf8 }
      guard let encoding = String.Encoding(ianaCharacterSetName:charset) else { return .utf8 }
      return encoding
    })()
    
    return AnyIterator<FormDataItem>(
      with:FileHandle.standardInput,
      boundary:boundary,
      stringEncoding:clientStringEncoding,
      temporaryDirectory:temporaryDirectory
    )
  }
}

